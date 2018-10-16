Received: from eggs.gnu.org ([2001:4830:134:3::10]:33305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <xiao.w.wang@intel.com>) id 1gCPRw-0006QB-Gh
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:31:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <xiao.w.wang@intel.com>) id 1gCPRp-0008E1-Le
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:31:52 -0400
Received: from mga02.intel.com ([134.134.136.20]:31552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <xiao.w.wang@intel.com>)
	id 1gCPRp-0008CI-DG
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:31:45 -0400
From: Xiao Wang <xiao.w.wang@intel.com>
Date: Tue, 16 Oct 2018 21:23:25 +0800
Message-Id: <20181016132327.121839-1-xiao.w.wang@intel.com>
Subject: [Qemu-devel] [RFC 0/2] vhost-vfio: introduce mdev based HW vhost
 backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jasowang@redhat.com, mst@redhat.com, alex.williamson@redhat.com
Cc: qemu-devel@nongnu.org, tiwei.bie@intel.com, cunming.liang@intel.com, xiaolong.ye@intel.com, zhihong.wang@intel.com, dan.daly@intel.com, Xiao Wang <xiao.w.wang@intel.com>

What's this
===========
Following the patch (vhost: introduce mdev based hardware vhost backend)
https://lwn.net/Articles/750770/, which defines a generic mdev device for
vhost data path acceleration (aliased as vDPA mdev below), this patch set
introduces a new net client type: vhost-vfio.

Currently we have 2 types of vhost backends in QEMU: vhost kernel (tap)
and vhost-user (e.g. DPDK vhost), in order to have a kernel space HW vhost
acceleration framework, the vDPA mdev device works as a generic configuring
channel. It exposes to user space a non-vendor-specific configuration
interface for setting up a vhost HW accelerator, based on this, this patch
set introduces a third vhost backend called vhost-vfio.

How does it work
================
The vDPA mdev defines 2 BAR regions, BAR0 and BAR1. BAR0 is the main
device interface, vhost messages can be written to or read from this
region following below format. All the regular vhost messages about vring
addr, negotiated features, etc., are written to this region directly.

struct vhost_vfio_op {
	__u64 request;
	__u32 flags;
	/* Flag values: */
#define VHOST_VFIO_NEED_REPLY 0x1 /* Whether need reply */
	__u32 size;
	union {
		__u64 u64;
		struct vhost_vring_state state;
		struct vhost_vring_addr addr;
		struct vhost_memory memory;
	} payload;
};

BAR1 is defined to be a region of doorbells, QEMU can use this region as
host notifier for virtio. To optimize virtio notify, vhost-vfio trys to
mmap the corresponding page on BAR1 for each queue and leverage EPT to let
guest virtio driver kick vDPA device doorbell directly. For virtio 0.95
case in which we cannot set host notifier memory region, QEMU will help to
relay the notify to vDPA device.

Note: EPT mapping requires each queue's notify address locates at the
beginning of a separate page, parameter "page-per-vq=on" could help.

For interrupt setting, vDPA mdev device leverages existing VFIO API to
enable interrupt config in user space. In this way, KVM's irqfd for virtio
can be set to mdev device by QEMU using ioctl().

vhost-vfio net client will set up a vDPA mdev device which is specified
by a "sysfsdev" parameter, during the net client init, the device will be
opened and parsed using VFIO API, the VFIO device fd and device BAR region
offset will be kept in a VhostVFIO structure, this initialization provides
a channel to configure vhost information to the vDPA device driver.

To do later
===========
1. The net client initialization uses raw VFIO API to open vDPA mdev
device, it's better to provide a set of helpers in hw/vfio/common.c
to help vhost-vfio initialize device easily.

2. For device DMA mapping, QEMU passes memory region info to mdev device
and let kernel parent device driver program IOMMU. This is a temporary
implementation, for future when IOMMU driver supports mdev bus, we
can use VFIO API to program IOMMU directly for parent device.
Refer to the patch (vfio/mdev: IOMMU aware mediated device):
https://lkml.org/lkml/2018/10/12/225

Vhost-vfio usage
================
# Query the number of available mdev instances
$ cat /sys/class/mdev_bus/0000:84:00.3/mdev_supported_types/ifcvf_vdpa-vdpa_virtio/available_instances

# Create a mdev instance
$ echo $UUID > /sys/class/mdev_bus/0000:84:00.3/mdev_supported_types/ifcvf_vdpa-vdpa_virtio/create

# Launch QEMU with a virtio-net device
    qemu-system-x86_64 -cpu host -enable-kvm \
    <snip>
    -mem-prealloc \
    -netdev type=vhost-vfio,sysfsdev=/sys/bus/mdev/devices/$UUID,id=mynet\
    -device virtio-net-pci,netdv=mynet,page-per-vq=on \

-------- END --------

Xiao Wang (2):
  vhost-vfio: introduce vhost-vfio net client
  vhost-vfio: implement vhost-vfio backend

 hw/net/vhost_net.c                |  56 ++++-
 hw/vfio/common.c                  |   3 +-
 hw/virtio/Makefile.objs           |   2 +-
 hw/virtio/vhost-backend.c         |   3 +
 hw/virtio/vhost-vfio.c            | 501 ++++++++++++++++++++++++++++++++++++++
 hw/virtio/vhost.c                 |  15 ++
 include/hw/virtio/vhost-backend.h |   7 +-
 include/hw/virtio/vhost-vfio.h    |  35 +++
 include/hw/virtio/vhost.h         |   2 +
 include/net/vhost-vfio.h          |  17 ++
 linux-headers/linux/vhost.h       |   9 +
 net/Makefile.objs                 |   1 +
 net/clients.h                     |   3 +
 net/net.c                         |   1 +
 net/vhost-vfio.c                  | 327 +++++++++++++++++++++++++
 qapi/net.json                     |  22 +-
 16 files changed, 996 insertions(+), 8 deletions(-)
 create mode 100644 hw/virtio/vhost-vfio.c
 create mode 100644 include/hw/virtio/vhost-vfio.h
 create mode 100644 include/net/vhost-vfio.h
 create mode 100644 net/vhost-vfio.c

-- 
2.15.1
