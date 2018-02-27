Received: from eggs.gnu.org ([2001:4830:134:3::10]:46082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1eqhQl-0001AO-U4
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:44:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1eqhQi-0006by-Pd
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:44:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51370)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.vnet.ibm.com>)
	id 1eqhQi-0006Zu-Hy
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 10:44:36 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1RFhJTU082274
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 10:44:32 -0500
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2gd9wbs0gd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 10:44:32 -0500
Received: from localhost
	by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.vnet.ibm.com>;
	Tue, 27 Feb 2018 10:44:31 -0500
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Tue, 27 Feb 2018 10:44:14 -0500
Message-Id: <1519746259-27710-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v2 0/5] s390x: vfio-ap: guest dedicated crypto
 adapters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net, Tony Krowiak <akrowiak@linux.vnet.ibm.com>

This patch series is the QEMU counterpart to the KVM/kernel support for 
guest dedicated crypto adapters. The KVM/kernel model is built on the 
VFIO mediated device framework and provides the infrastructure for 
granting exclusive guest access to crypto devices installed on the linux 
host. This patch series introduces a new QEMU command line option, QEMU 
object model and CPU model features to exploit the KVM/kernel model.

See the detailed specifications for AP virtualization provided by this 
patch set in docs/vfio-ap.txt for a more complete discussion of the 
design introduced by this patch series.

v1 -> v2 Change log:
===================
* Removed unnecessary S390APMatrixDevice, S390APMatrixDeviceClass 
* Removed ioctl to configure the AP matrix for the guest: letting the
  vfio_ap device driver's 'open' callback configure the AP matrix
  for the guest
* Removed masks from object model: Unnecessary at this point because they 
  are not currently used 
* Renamed:
  * VFIOAPMatrixDevice to VFIOAPDevice
  * VFIOAPMatrixDeviceClass to VFIOAPDeviceClass
  * APMatrixDevice to APDevice
  * APMatrixDeviceClass to APDeviceClass
  * ap-matrix.c to ap.c (in hw/vfio)
  * ap-matrix-device.c to ap-device.c (in hw/s390x)
  * ap-matrix-device.h to ap-device.h (in include/hw/s390x)
* Added CPU model feature for AP facilities installed on guest and 
  facilities features for QCI Instructions Available (STFLE.12) and AP 
  Facilities Test facility installed (STFLE.15).

Tony Krowiak (5):
  s390x/ap: base Adjunct Processor (AP) object
  s390x/vfio: ap: VFIO: linux header updates
  s390x/vfio: ap: Introduce VFIO AP device
  s390x/cpumodel: Set up CPU model for AP device support
  s390: doc: detailed specifications for AP virtualization

 default-configs/s390x-softmmu.mak |    1 +
 docs/vfio-ap.txt                  |  540 +++++++++++++++++++++++++++++++++++++
 hw/s390x/Makefile.objs            |    1 +
 hw/s390x/ap-device.c              |   38 +++
 hw/vfio/Makefile.objs             |    1 +
 hw/vfio/ap.c                      |  176 ++++++++++++
 include/hw/s390x/ap-device.h      |   38 +++
 include/hw/vfio/vfio-common.h     |    1 +
 linux-headers/asm-s390/kvm.h      |    1 +
 linux-headers/linux/vfio.h        |    2 +
 target/s390x/cpu_features.c       |    3 +
 target/s390x/cpu_features_def.h   |    3 +
 target/s390x/cpu_models.c         |   12 +
 target/s390x/gen-features.c       |    3 +
 target/s390x/kvm.c                |    6 +
 15 files changed, 826 insertions(+), 0 deletions(-)
 create mode 100644 docs/vfio-ap.txt
 create mode 100644 hw/s390x/ap-device.c
 create mode 100644 hw/vfio/ap.c
 create mode 100644 include/hw/s390x/ap-device.h
