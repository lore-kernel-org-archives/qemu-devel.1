Received: from eggs.gnu.org ([2001:4830:134:3::10]:44667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1ceduV-0003A4-4D
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 03:29:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1ceduQ-0000dk-6H
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 03:28:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56922
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1ceduP-0000dW-Vp
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 03:28:54 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v1H8DcSX035407
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 03:28:53 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28ngt931td-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 03:28:52 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Fri, 17 Feb 2017 03:28:52 -0500
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Date: Fri, 17 Feb 2017 09:28:33 +0100
Message-Id: <20170217082844.89466-1-bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH RFC v3 00/11] basic channel IO passthrough
 infrastructure based on vfio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, wkywang@linux.vnet.ibm.com

The patch series introduce a basic channel I/O passthrough
infrastructure based on vfio.
- Focus on supporting dasd-eckd(cu_type/dev_type = 0x3990/0x3390) as
  the target device. 
- Support new qemu parameters in the style of:
    -machine s390-ccw-virtio(,s390-squash-mcss=on|off) \
    -device vfio-ccw,sysfsdev=$MDEV_PATH
  We want to support real (i.e. not virtual) channel devices even for
  guests that do not support MCSS-E (where guests may see devices from
  any channel subsystem image at once). As all virtio-ccw devices are in
  css 0xfe (and show up in the default css 0 for guests not activating
  MCSS-E), we need an option to squash e.g. passed-through channel devices
  from their real css (0-3, or 0 for hosts not activating MCSS-E) into
  the default css, that is what the new machine option s390-squash-css is
  added.

Build and install:
1. kernel configuration
  CONFIG_S390_CCW_IOMMU=m
  CONFIG_VFIO=m
  CONFIG_VFIO_MDEV=m
  CONFIG_VFIO_MDEV_DEVICE=m
  CONFIG_VFIO_CCW=m
2. modules required
  modprobe vfio.ko
  modprobe mdev.ko
  modprobe vfio_mdev.ko
  modprobe vfio_iommu_type1.ko
  modprobe vfio_ccw.ko
3. find a subchannel(0.0."%schid") of a DASD-ECKD device and bind it to
  vfio_ccw driver
  #find the dasd you can use with lsdasd on your host. e.g.:
  devno="7e52"
  schid="16ca"
  #unbind the ccw device from the subchannel
  echo 0.0."$devno" > /sys/bus/ccw/devices/0.0."$devno"/driver/unbind
  #unbind the subchannel from io_subchannel driver
  echo 0.0."$schid" > /sys/bus/css/devices/0.0."$schid"/driver/unbind
  #bind the subchannel with vfio_ccw driver
  echo 0.0."$schid" > /sys/bus/css/drivers/vfio_ccw/bind
4. create a mediated device
  #generate a uuid with uuidgen. e.g.:
  uuid="6dfd3ec5-e8b3-4e18-a6fe-57bc9eceb920"
  echo "$uuid" > \
  /sys/bus/css/devices/0.0."$schid"/mdev_supported_types/vfio_ccw-io/create
5. pass-through this device to a vm
  -M s390-ccw-virtio,s390-squash-css=on \
  -device vfio-ccw,sysfsdev=/sys/bus/mdev/devices/$uuid \
  ... ...

Change log:

v2 -> v3:
1. Move vfio_ccw.h to uapi.
2. Adopt the vfio-ccw cmdline interface as vfio-pci with mdev devices.
3. Rename s390-map-css to s390-squash-mcss (patch 2), and update devno
   generation method (patch 5).
4. Patch 7: correct the validation of num_regions.
5. Patch 8: correct the validation of num_irqs.

v1 -> v2:
1. Rebase the implementation to the mdev framework approach.
2. Use pread and pwrite on an I/O region to issue I/O requests and
   receive results.

Dong Jia Shi (4):
  s390x/css: realize css_create_sch
  s390x/css: device support for s390-ccw passthrough
  vfio/ccw: get io region info
  vfio/ccw: update sense data if a unit check is pending

Xiao Feng Ren (7):
  vfio: linux-headers update for vfio-ccw
  s390x/css: add s390-squash-mcss machine option
  s390x/css: realize css_sch_build_schib
  vfio/ccw: vfio based subchannel passthrough driver
  vfio/ccw: get irqs info and set the eventfd fd
  s390x/css: introduce and realize ccw-request callback
  s390x/css: ccw translation infrastructure

 default-configs/s390x-softmmu.mak  |   1 +
 hw/s390x/Makefile.objs             |   1 +
 hw/s390x/css-bridge.c              |   2 +
 hw/s390x/css.c                     | 290 ++++++++++++++++++++++--
 hw/s390x/s390-ccw.c                | 137 ++++++++++++
 hw/s390x/s390-ccw.h                |  39 ++++
 hw/s390x/s390-virtio-ccw.c         |  35 ++-
 hw/s390x/virtio-ccw.c              |   7 +-
 hw/vfio/Makefile.objs              |   1 +
 hw/vfio/ccw.c                      | 442 +++++++++++++++++++++++++++++++++++++
 include/hw/s390x/css-bridge.h      |   1 +
 include/hw/s390x/css.h             |  67 +++---
 include/hw/s390x/s390-virtio-ccw.h |   1 +
 include/hw/vfio/vfio-common.h      |   1 +
 linux-headers/linux/vfio.h         |  17 ++
 linux-headers/linux/vfio_ccw.h     |  28 +++
 qemu-options.hx                    |   6 +-
 target/s390x/cpu.h                 |  10 +
 target/s390x/ioinst.c              |   9 +
 19 files changed, 1047 insertions(+), 48 deletions(-)
 create mode 100644 hw/s390x/s390-ccw.c
 create mode 100644 hw/s390x/s390-ccw.h
 create mode 100644 hw/vfio/ccw.c
 create mode 100644 linux-headers/linux/vfio_ccw.h

-- 
2.8.4
