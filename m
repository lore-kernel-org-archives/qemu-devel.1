Received: from eggs.gnu.org ([2001:4830:134:3::10]:46427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1d6SbO-00029e-Dt
	for qemu-devel@nongnu.org; Thu, 04 May 2017 22:04:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1d6SbK-000478-Dr
	for qemu-devel@nongnu.org; Thu, 04 May 2017 22:04:14 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42164)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1d6SbK-00046c-5q
	for qemu-devel@nongnu.org; Thu, 04 May 2017 22:04:10 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4523afl022350
	for <qemu-devel@nongnu.org>; Thu, 4 May 2017 22:04:08 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a8f8uj243-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 04 May 2017 22:04:07 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Thu, 4 May 2017 22:04:06 -0400
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Date: Fri,  5 May 2017 04:03:39 +0200
Message-Id: <20170505020352.8984-1-bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v7 00/13] basic channel IO passthrough
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
Cc: bjsdjshi@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, eric.auger@redhat.com

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
v6 -> v7:
1. Patch #6:
   Use error_setg_errno as possible.
   Use local Error variable as possible.
   Free @sch when error out.
2. Patch #7:
   Use local Error variable as possible.
   Remove vfio_ccw_put_group.
3. Patch #8:
   Use local Error variable as possible.
   Free @info when error out.
4. Patch #9:
   Use error_setg_errno as possible.
   Use local Error variable as possible.
5. Patch #10:
   Move handle_request from device to class.
   Generate channel-check for information transfer error.
   Improve pread logic.

v5 -> v6:
1. Rebase against git://github.com/cohuck/qemu s390-next.
2. Patch #6: correct error message: -vfio-ccw --> -device vfio-ccw
3. Patch #7:
   Rewrite vfio_ccw_get_group by:
     - removing unnecessary checking of path existance;
     - removing useless 'path' variable;
   Fix a typo: s/operationis/operations/
   In vfio_ccw_unrealize, move cdc->unrealize to the end.

v4 -> v5:
1. Rebase to git://github.com/cohuck/qemu s390-next.
2. New patch #1: update-linux-headers.
3. Patch #6: update s390_ccw_realize according to the new code base.
4. New patch #13: add maintainer for vfio-ccw.

v3 -> v4:
1. Adjustments of the s-o-b chains for some patches.

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

Dong Jia Shi (8):
  update-linux-headers: update for vfio-ccw
  vfio: linux-headers update for vfio-ccw
  s390x/css: realize css_create_sch
  s390x/css: device support for s390-ccw passthrough
  vfio/ccw: get io region info
  vfio/ccw: get irqs info and set the eventfd fd
  vfio/ccw: update sense data if a unit check is pending
  MAINTAINERS: Add vfio-ccw maintainer

Xiao Feng Ren (5):
  s390x/css: add s390-squash-mcss machine option
  s390x/css: realize css_sch_build_schib
  vfio/ccw: vfio based subchannel passthrough driver
  s390x/css: introduce and realize ccw-request callback
  s390x/css: ccw translation infrastructure

 MAINTAINERS                        |   5 +
 default-configs/s390x-softmmu.mak  |   1 +
 hw/s390x/Makefile.objs             |   1 +
 hw/s390x/css-bridge.c              |   2 +
 hw/s390x/css.c                     | 291 +++++++++++++++++++++++--
 hw/s390x/s390-ccw.c                | 150 +++++++++++++
 hw/s390x/s390-ccw.h                |  39 ++++
 hw/s390x/s390-virtio-ccw.c         |  33 ++-
 hw/s390x/virtio-ccw.c              |   7 +-
 hw/vfio/Makefile.objs              |   1 +
 hw/vfio/ccw.c                      | 436 +++++++++++++++++++++++++++++++++++++
 include/hw/s390x/css-bridge.h      |   1 +
 include/hw/s390x/css.h             |  67 +++---
 include/hw/s390x/s390-virtio-ccw.h |   1 +
 include/hw/vfio/vfio-common.h      |   1 +
 linux-headers/linux/vfio.h         |  17 ++
 linux-headers/linux/vfio_ccw.h     |  28 +++
 qemu-options.hx                    |   6 +-
 scripts/update-linux-headers.sh    |   2 +-
 target/s390x/cpu.h                 |  10 +
 target/s390x/ioinst.c              |   9 +
 21 files changed, 1059 insertions(+), 49 deletions(-)
 create mode 100644 hw/s390x/s390-ccw.c
 create mode 100644 hw/s390x/s390-ccw.h
 create mode 100644 hw/vfio/ccw.c
 create mode 100644 linux-headers/linux/vfio_ccw.h

-- 
2.10.2
