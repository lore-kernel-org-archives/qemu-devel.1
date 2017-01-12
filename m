Received: from eggs.gnu.org ([2001:4830:134:3::10]:36233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cRZlM-000072-CR
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 02:25:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cRZlH-0005OD-SF
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 02:25:32 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52594)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1cRZlH-0005Nw-Ia
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 02:25:27 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0C7O4MA129480
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 02:25:25 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27wxnwn18p-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 02:25:24 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Thu, 12 Jan 2017 00:25:24 -0700
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Date: Thu, 12 Jan 2017 08:25:01 +0100
Message-Id: <20170112072513.98411-1-bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH RFC v2 00/12] basic channel IO passthrough
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
   "-machine s390-ccw-virtio(,s390-map-css=on|off) ... 
    -device vfio-ccw,id=xx,hostid=xx(,guestid=xx),mdevid=xx".
  We want to support real (i.e. not virtual) channel devices even for
  guests that do not support MCSS-E (where guests may see devices from
  any channel subsystem image at once). As all virtio-ccw devices are in
  css 0xfe (and show up in the default css 0 for guests not activating
  MCSS-E), we need an option to map e.g. passed-through channel devices
  from their real css (0-3, or 0 for hosts not activating MCSS-E) into
  the default css, that is what the new machine option s390-map-css is
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
  -M s390-ccw-virtio,s390-map-css=on \
  -device vfio-ccw,id=pass0, \
          hostid=0.0."$schid",guestid=0.0.1234, \
          mdevid="$uuid" \
  ... ...

Change log:

v1 -> v2:
1. Rebase the implementation to the mdev framework approach.
2. Use pread and pwrite on an I/O region to issue I/O requests and
   receive results.

Dong Jia Shi (4):
  update-linux-headers: add asm-s390/vfio_ccw.h
  s390x/css: realize css_create_sch
  vfio/ccw: get io region info
  vfio/ccw: update sense data if a unit check is pending

Xiao Feng Ren (8):
  vfio: linux-headers update for vfio-ccw
  s390x/css: add s390-map-css machine option
  s390x/css: realize css_sch_build_schib
  s390x/css: device support for s390-ccw passthrough
  vfio/ccw: vfio based subchannel passthrough driver
  vfio/ccw: get irqs info and set the eventfd fd
  s390x/css: introduce and realize ccw-request callback
  s390x/css: ccws translation infrastructure

 default-configs/s390x-softmmu.mak            |   1 +
 hw/s390x/Makefile.objs                       |   1 +
 hw/s390x/css-bridge.c                        |   3 +
 hw/s390x/css.c                               | 283 ++++++++++++++++-
 hw/s390x/s390-ccw.c                          | 132 ++++++++
 hw/s390x/s390-ccw.h                          |  39 +++
 hw/s390x/s390-virtio-ccw.c                   |  23 ++
 hw/s390x/virtio-ccw.c                        |   1 +
 hw/vfio/Makefile.objs                        |   1 +
 hw/vfio/ccw.c                                | 443 +++++++++++++++++++++++++++
 include/hw/s390x/css-bridge.h                |   1 +
 include/hw/s390x/css.h                       |  57 +++-
 include/hw/s390x/s390-virtio-ccw.h           |   1 +
 include/hw/vfio/vfio-common.h                |   1 +
 include/standard-headers/asm-s390/vfio_ccw.h |  28 ++
 linux-headers/linux/vfio.h                   |  17 +
 qemu-options.hx                              |   6 +-
 scripts/update-linux-headers.sh              |   1 +
 target-s390x/cpu.h                           |  10 +
 target-s390x/ioinst.c                        |   9 +
 20 files changed, 1029 insertions(+), 29 deletions(-)
 create mode 100644 hw/s390x/s390-ccw.c
 create mode 100644 hw/s390x/s390-ccw.h
 create mode 100644 hw/vfio/ccw.c
 create mode 100644 include/standard-headers/asm-s390/vfio_ccw.h

-- 
2.8.4
