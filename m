Received: from eggs.gnu.org ([2001:4830:134:3::10]:56700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gJsod-0007No-0u
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 23:18:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gJsoY-0007Dg-DQ
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 23:18:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40328)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gJsoY-0007C5-3w
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 23:18:06 -0500
References: <20181016132327.121839-1-xiao.w.wang@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <2e010e02-f7a2-d009-ac7a-fdc266f99254@redhat.com>
Date: Tue, 6 Nov 2018 12:17:48 +0800
MIME-Version: 1.0
In-Reply-To: <20181016132327.121839-1-xiao.w.wang@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 0/2] vhost-vfio: introduce mdev based HW
 vhost backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Wang <xiao.w.wang@intel.com>, mst@redhat.com, alex.williamson@redhat.com
Cc: qemu-devel@nongnu.org, tiwei.bie@intel.com, cunming.liang@intel.com, xiaolong.ye@intel.com, zhihong.wang@intel.com, dan.daly@intel.com


On 2018/10/16 =E4=B8=8B=E5=8D=889:23, Xiao Wang wrote:
> What's this
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Following the patch (vhost: introduce mdev based hardware vhost backend=
)
> https://lwn.net/Articles/750770/, which defines a generic mdev device f=
or
> vhost data path acceleration (aliased as vDPA mdev below), this patch s=
et
> introduces a new net client type: vhost-vfio.


Thanks a lot for a such interesting series. Some generic questions:


If we consider to use software backend (e.g vhost-kernel or a rely of=20
virito-vhost-user or other cases) as well in the future, maybe=20
vhost-mdev is better which mean it does not tie to VFIO anyway.


>
> Currently we have 2 types of vhost backends in QEMU: vhost kernel (tap)
> and vhost-user (e.g. DPDK vhost), in order to have a kernel space HW vh=
ost
> acceleration framework, the vDPA mdev device works as a generic configu=
ring
> channel.


Does "generic" configuring channel means dpdk will also go for this way?=20
E.g it will have a vhost mdev pmd?


>   It exposes to user space a non-vendor-specific configuration
> interface for setting up a vhost HW accelerator,


Or even a software translation layer on top of exist hardware.


> based on this, this patch
> set introduces a third vhost backend called vhost-vfio.
>
> How does it work
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> The vDPA mdev defines 2 BAR regions, BAR0 and BAR1. BAR0 is the main
> device interface, vhost messages can be written to or read from this
> region following below format. All the regular vhost messages about vri=
ng
> addr, negotiated features, etc., are written to this region directly.


If I understand this correctly, the mdev was not used for passed through=20
to guest directly. So what's the reason of inventing a PCI like device=20
here? I'm asking since:

- vhost protocol is transport indepedent, we should consider to support=20
transport other than PCI. I know we can even do it with the exist design=20
but it looks rather odd if we do e.g ccw device with a PCI like mediated=20
device.

- can we try to reuse vhost-kernel ioctl? Less API means less bugs and=20
code reusing. E.g virtio-user can benefit from the vhost kernel ioctl=20
API almost with no changes I believe.


>
> struct vhost_vfio_op {
> 	__u64 request;
> 	__u32 flags;
> 	/* Flag values: */
> #define VHOST_VFIO_NEED_REPLY 0x1 /* Whether need reply */
> 	__u32 size;
> 	union {
> 		__u64 u64;
> 		struct vhost_vring_state state;
> 		struct vhost_vring_addr addr;
> 		struct vhost_memory memory;
> 	} payload;
> };
>
> BAR1 is defined to be a region of doorbells, QEMU can use this region a=
s
> host notifier for virtio. To optimize virtio notify, vhost-vfio trys to
> mmap the corresponding page on BAR1 for each queue and leverage EPT to =
let
> guest virtio driver kick vDPA device doorbell directly. For virtio 0.95
> case in which we cannot set host notifier memory region, QEMU will help=
 to
> relay the notify to vDPA device.
>
> Note: EPT mapping requires each queue's notify address locates at the
> beginning of a separate page, parameter "page-per-vq=3Don" could help.


I think qemu should prepare a fallback for this if page-per-vq is off.


>
> For interrupt setting, vDPA mdev device leverages existing VFIO API to
> enable interrupt config in user space. In this way, KVM's irqfd for vir=
tio
> can be set to mdev device by QEMU using ioctl().
>
> vhost-vfio net client will set up a vDPA mdev device which is specified
> by a "sysfsdev" parameter, during the net client init, the device will =
be
> opened and parsed using VFIO API, the VFIO device fd and device BAR reg=
ion
> offset will be kept in a VhostVFIO structure, this initialization provi=
des
> a channel to configure vhost information to the vDPA device driver.
>
> To do later
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> 1. The net client initialization uses raw VFIO API to open vDPA mdev
> device, it's better to provide a set of helpers in hw/vfio/common.c
> to help vhost-vfio initialize device easily.
>
> 2. For device DMA mapping, QEMU passes memory region info to mdev devic=
e
> and let kernel parent device driver program IOMMU. This is a temporary
> implementation, for future when IOMMU driver supports mdev bus, we
> can use VFIO API to program IOMMU directly for parent device.
> Refer to the patch (vfio/mdev: IOMMU aware mediated device):
> https://lkml.org/lkml/2018/10/12/225


As Steve mentioned in the KVM forum. It's better to have at least one=20
sample driver e.g virtio-net itself.

Then it would be more convenient for the reviewer to evaluate the whole=20
stack.

Thanks


>
> Vhost-vfio usage
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> # Query the number of available mdev instances
> $ cat /sys/class/mdev_bus/0000:84:00.3/mdev_supported_types/ifcvf_vdpa-=
vdpa_virtio/available_instances
>
> # Create a mdev instance
> $ echo $UUID > /sys/class/mdev_bus/0000:84:00.3/mdev_supported_types/if=
cvf_vdpa-vdpa_virtio/create
>
> # Launch QEMU with a virtio-net device
>      qemu-system-x86_64 -cpu host -enable-kvm \
>      <snip>
>      -mem-prealloc \
>      -netdev type=3Dvhost-vfio,sysfsdev=3D/sys/bus/mdev/devices/$UUID,i=
d=3Dmynet\
>      -device virtio-net-pci,netdv=3Dmynet,page-per-vq=3Don \
>
> -------- END --------
>
> Xiao Wang (2):
>    vhost-vfio: introduce vhost-vfio net client
>    vhost-vfio: implement vhost-vfio backend
>
>   hw/net/vhost_net.c                |  56 ++++-
>   hw/vfio/common.c                  |   3 +-
>   hw/virtio/Makefile.objs           |   2 +-
>   hw/virtio/vhost-backend.c         |   3 +
>   hw/virtio/vhost-vfio.c            | 501 +++++++++++++++++++++++++++++=
+++++++++
>   hw/virtio/vhost.c                 |  15 ++
>   include/hw/virtio/vhost-backend.h |   7 +-
>   include/hw/virtio/vhost-vfio.h    |  35 +++
>   include/hw/virtio/vhost.h         |   2 +
>   include/net/vhost-vfio.h          |  17 ++
>   linux-headers/linux/vhost.h       |   9 +
>   net/Makefile.objs                 |   1 +
>   net/clients.h                     |   3 +
>   net/net.c                         |   1 +
>   net/vhost-vfio.c                  | 327 +++++++++++++++++++++++++
>   qapi/net.json                     |  22 +-
>   16 files changed, 996 insertions(+), 8 deletions(-)
>   create mode 100644 hw/virtio/vhost-vfio.c
>   create mode 100644 include/hw/virtio/vhost-vfio.h
>   create mode 100644 include/net/vhost-vfio.h
>   create mode 100644 net/vhost-vfio.c
>
