Received: from eggs.gnu.org ([2001:4830:134:3::10]:59380)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gPrxa-0007eQ-VL
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:36:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gPrxW-0008Rf-31
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:36:11 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32908
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1gPrxU-0008MQ-DS
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:36:05 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wAMGYFIE103075
	for <qemu-devel@nongnu.org>; Thu, 22 Nov 2018 11:36:03 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2nwya82357-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 22 Nov 2018 11:36:02 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Thu, 22 Nov 2018 16:36:01 -0000
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Thu, 22 Nov 2018 17:35:49 +0100
Message-Id: <1542904555-1136-1-git-send-email-pmorel@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v2 0/6] s390x/vfio: VFIO-AP interrupt control
 interception
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: borntraeger@de.ibm.com
Cc: cohuck@redhat.com, agraf@suse.de, rth@twiddle.net, david@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com, mst@redhat.com, eric.auger@redhat.com, akrowiak@linux.ibm.com, pasic@linux.ibm.com

This series has 3 different type of patches:

The first two:
  s390x/vfio: ap: Finding the AP bridge
  s390x/vfio: ap: Use the APdevice as a child of the APBus

Are dealing with the QEMU Object Model and how we retrieve the
AP devices from instruction interception.
A lifting of the AP bridge, bus and device was necessary to
ease the process and allow future extensions.

The third one is a place holder to ease reviewing:
  s390x/vfio: ap: Linux uapi VFIO place holder

The last three are really dealing with PQAP/AQIC instruction
interception and associate IOCTL calls to the VFIO AP device
driver.
  s390x/cpumodel: Set up CPU model for AQIC interception
  s390x/vfio: ap: Definition for AP Adapter type
  s390x/vfio: ap: Implementing AP Queue Interrupt Control

The S390 APQP/AQIC instruction is intercepted by the host
to configure the AP queues interruption redirection.
It retrieves the ISC used by the host and the one used
by the guest and setup the indicator address.

This patch series
- define the AQIC feature in the cpumodel,
- extend the APDevice type for per card and queue interrupt handling,
- intercept the APQP/AQIC instruction, uses the S390 adapter interface
  to setup the adapter 
- and use a VFIO ioctl to let the VFIO-AP driver handle the host
  instruction associated with the intercepted guest instruction.

This patch serie can be tested with the Linux/KVM patch series
for the VFIO-AP driver: "s390: vfio: ap: Using GISA for AP Interrupt"


Pierre Morel (6):
  s390x/vfio: ap: Finding the AP bridge
  s390x/vfio: ap: Use the APdevice as a child of the APBus
  s390x/vfio: ap: Linux uapi VFIO place holder
  s390x/cpumodel: Set up CPU model for AQIC interception
  s390x/vfio: ap: Definition for AP Adapter type
  s390x/vfio: ap: Implementing AP Queue Interrupt Control

 hw/s390x/ap-bridge.c            |  12 ++++
 hw/s390x/ap-device.c            |  22 +++++++
 hw/vfio/ap.c                    | 131 +++++++++++++++++++++++++++++++++++++---
 include/hw/s390x/ap-bridge.h    |   1 +
 include/hw/s390x/ap-device.h    |  65 ++++++++++++++++++++
 include/hw/s390x/css.h          |   1 +
 linux-headers/linux/vfio.h      |  25 ++++++++
 target/s390x/cpu_features.c     |   1 +
 target/s390x/cpu_features_def.h |   1 +
 target/s390x/cpu_models.c       |   1 +
 target/s390x/gen-features.c     |   1 +
 target/s390x/kvm.c              |  31 ++++++++++
 12 files changed, 282 insertions(+), 10 deletions(-)

-- 
2.7.4

Changelog from v1:
- legitimate "Huh" from Conny on global lead me to reconsider
  the QOM for AP Device, BUS and Bridge and remove globals
- squash patches for kvm.c and hw/vfio/ap.c
  (Conny) so related changes are easier to see
- modified the UAPI (Also comes from Linux)
- suppressed complicated structures to integer conversions
  and use masks to avoid endianess considerations,
  I did not change anything for endianess since we get all
  from the registers, AFAIU we do not need to.
  Tell me if I am wrong (I know you will :) )
- simplified the implementation of the ioctl

Tested with according Linux patch.
Take care that the UAPI changed betwen V1 and V2!
and do NOT use with the older version.
