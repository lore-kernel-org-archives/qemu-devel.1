Received: from eggs.gnu.org ([2001:4830:134:3::10]:54534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1f7n01-0005DU-Ej
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 15:07:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <akrowiak@linux.vnet.ibm.com>) id 1f7mzw-0005DZ-BM
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 15:07:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55074)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <akrowiak@linux.vnet.ibm.com>)
	id 1f7mzw-0005CO-3S
	for qemu-devel@nongnu.org; Sun, 15 Apr 2018 15:07:36 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w3FJ3tBH098634
	for <qemu-devel@nongnu.org>; Sun, 15 Apr 2018 15:07:34 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hc14yjxsh-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sun, 15 Apr 2018 15:07:34 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <akrowiak@linux.vnet.ibm.com>;
	Sun, 15 Apr 2018 15:07:33 -0400
From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Date: Sun, 15 Apr 2018 15:07:19 -0400
Message-Id: <1523819244-29954-1-git-send-email-akrowiak@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4 0/5] s390x: vfio-ap: guest dedicated crypto
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
Cc: qemu-s390x@nongnu.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, david@redhat.com, bjsdjshi@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, eskultet@redhat.com, berrange@redhat.com, alex.williamson@redhat.com, eric.auger@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, agraf@suse.de, rth@twiddle.net, akrowiak@linux.vnet.ibm.com

This patch series is the QEMU counterpart to the KVM/kernel support for 
guest dedicated crypto adapters. The KVM/kernel model is built on the 
VFIO mediated device framework and provides the infrastructure for 
granting exclusive guest access to crypto devices installed on the linux 
host. This patch series introduces a new QEMU command line option, QEMU 
object model and CPU model features to exploit the KVM/kernel model.

See the detailed specifications for AP virtualization provided by this 
patch set in docs/vfio-ap.txt for a more complete discussion of the 
design introduced by this patch series.

Note: This series implements the minimal viable product (MVP) and does not
      provide support for hot plug/unplug, migration, or VSIE. The goal
      of the MVP model is to solidify a base upon which these additional 
      features will be built.

v3 => v4 Change log:
===================
* Made vfio-ap device unpluggable for now
* Renamed command line CPU model feature for QCI: qci=on -> apqci=on
* Removed call to KVM_S390_VM_CRYPTO_INTERPRET_AP ioctl - ioctl was 
  removed from kernel and AP instruction interpretation is set from the
  VFIO device driver
* Added check to ensure only one vfio-ap device can be configured per 
  guest
* Removed AP instruction interception handlers: AP instructions will be 
  interpreted by default if AP facilities are installed to handle the case
  where feature ap=on and no vfio-ap device is configured for the guest.

Tony Krowiak (5):
  linux-headers: linux header updates for AP support
  s390x/ap: base Adjunct Processor (AP) object
  s390x/cpumodel: Set up CPU model for AP device support
  s390x/vfio: ap: Introduce VFIO AP device
  s390: doc: detailed specifications for AP virtualization

 default-configs/s390x-softmmu.mak |    1 +
 docs/vfio-ap.txt                  |  649 +++++++++++++++++++++++++++++++++++++
 hw/s390x/Makefile.objs            |    1 +
 hw/s390x/ap-device.c              |   39 +++
 hw/vfio/Makefile.objs             |    1 +
 hw/vfio/ap.c                      |  191 +++++++++++
 include/hw/s390x/ap-device.h      |   38 +++
 include/hw/vfio/vfio-common.h     |    1 +
 linux-headers/asm-s390/kvm.h      |    2 +
 linux-headers/linux/vfio.h        |    2 +
 target/s390x/cpu_features.c       |    3 +
 target/s390x/cpu_features_def.h   |    3 +
 target/s390x/cpu_models.c         |    2 +
 target/s390x/gen-features.c       |    3 +
 target/s390x/kvm.c                |    1 +
 ui/keycodemapdb                   |    2 +-
 16 files changed, 938 insertions(+), 1 deletions(-)
 create mode 100644 docs/vfio-ap.txt
 create mode 100644 hw/s390x/ap-device.c
 create mode 100644 hw/vfio/ap.c
 create mode 100644 include/hw/s390x/ap-device.h
