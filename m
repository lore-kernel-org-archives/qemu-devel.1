Received: from eggs.gnu.org ([2001:4830:134:3::10]:35487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVbXy-00054w-7V
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:40:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dVbXv-0002Fq-5a
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:40:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55707
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dVbXu-0002Fg-Vs
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 06:40:35 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6DAdi62049738
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 06:40:34 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bp61fk0r0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 06:40:34 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 13 Jul 2017 11:40:32 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 13 Jul 2017 12:40:27 +0200
In-Reply-To: <1499942429-55449-1-git-send-email-borntraeger@de.ibm.com>
References: <1499942429-55449-1-git-send-email-borntraeger@de.ibm.com>
Message-Id: <1499942429-55449-2-git-send-email-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH/s390-next 1/3] s390x: initialize cpu firstly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, Cornelia Huck <cohuck@redhat.com>, Yi Min Zhao <zyimin@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: Yi Min Zhao <zyimin@linux.vnet.ibm.com>

By initializing the CPU firstly, we are able to retrieve and use the
CPU model features when initializing other subsystem or devices.

Signed-off-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Reviewed-by: Pierre Morel<pmorel@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/s390x/s390-virtio-ccw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index e086cb5..23e9658 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -122,6 +122,9 @@ static void ccw_init(MachineState *machine)
     s390_sclp_init();
     s390_memory_init(machine->ram_size);
 
+    /* init CPUs */
+    s390_init_cpus(machine);
+
     s390_flic_init();
 
     /* get a BUS */
@@ -138,9 +141,6 @@ static void ccw_init(MachineState *machine)
     /* register hypercalls */
     virtio_ccw_register_hcalls();
 
-    /* init CPUs */
-    s390_init_cpus(machine);
-
     if (kvm_enabled()) {
         kvm_s390_enable_css_support(s390_cpu_addr2state(0));
     }
-- 
2.7.4
