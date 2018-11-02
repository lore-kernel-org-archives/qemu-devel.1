Received: from eggs.gnu.org ([2001:4830:134:3::10]:39575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gIWj3-0001qh-BE
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 06:30:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1gIWj0-0004FJ-ED
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 06:30:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41242
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1gIWip-000490-MX
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 06:30:39 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wA2ATEoe065808
	for <qemu-devel@nongnu.org>; Fri, 2 Nov 2018 06:30:30 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2ngj4j72ga-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 06:30:29 -0400
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Fri, 2 Nov 2018 10:30:27 -0000
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Fri,  2 Nov 2018 11:30:16 +0100
Message-Id: <1541154621-22423-1-git-send-email-pmorel@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v1 0/5] s390x/vfio: VFIO-AP interrupt control
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

The S390 APQP/AQIC instruction can be intercepted by the host
to configure the AP queues interruption handling for and handle
the ISC used by the host and the guest and the indicator address.

This patch series define the AQIC feature in the cpumodel,
extend the APDevice type for per queue interrupt handling,
intercept the APQP/AQIC instruction, uses the S390 adapter interface
to setup the adapter and use a VFIO ioctl to let the VFIO-AP
driver handle the host instruction associated with the intercepted
guest instruction.

This patch serie can be tested with the Linux/KVM patch series
for the VFIO-AP driver: "s390: vfio: ap: Using GISA for AP Interrupt"

Pierre Morel (5):
  s390x/vfio: ap: Linux uapi VFIO place holder
  s390x/cpumodel: Set up CPU model for AQIC interception
  s390x/vfio: ap: Definition for AP Adapter type
  s390x/vfio: ap: Intercepting AP Queue Interrupt Control
  s390x/vfio: ap: Implementing AP Queue Interrupt Control

 hw/vfio/ap.c                    | 100 ++++++++++++++++++++++++++++++++
 include/hw/s390x/ap-device.h    |  55 ++++++++++++++++++
 include/hw/s390x/css.h          |   1 +
 linux-headers/linux/vfio.h      |  22 +++++++
 target/s390x/cpu_features.c     |   1 +
 target/s390x/cpu_features_def.h |   1 +
 target/s390x/cpu_models.c       |   1 +
 target/s390x/kvm.c              |  20 +++++++
 8 files changed, 201 insertions(+)

-- 
2.17.0
