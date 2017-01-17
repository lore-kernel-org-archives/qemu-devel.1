Received: from eggs.gnu.org ([2001:4830:134:3::10]:48900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cTPZe-000292-8x
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:57:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1cTPZa-00084F-V7
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:57:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44069)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1cTPZa-00083Z-MD
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 03:56:58 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v0H8tsQ0119107
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 03:56:57 -0500
Received: from e06smtp06.uk.ibm.com (e06smtp06.uk.ibm.com [195.75.94.102])
	by mx0a-001b2d01.pphosted.com with ESMTP id 281eu7k1hv-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 03:56:57 -0500
Received: from localhost
	by e06smtp06.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 17 Jan 2017 08:56:54 -0000
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Tue, 17 Jan 2017 09:56:36 +0100
In-Reply-To: <20170117085645.4267-1-cornelia.huck@de.ibm.com>
References: <20170117085645.4267-1-cornelia.huck@de.ibm.com>
Message-Id: <20170117085645.4267-4-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PULL 03/12] s390x/kvm: use kvm_gsi_routing_enabled in
 flic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, jfrei@linux.vnet.ibm.com, qemu-devel@nongnu.org, Fei Li <sherrylf@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Fei Li <sherrylf@linux.vnet.ibm.com>

Let's use kvm_gsi_routing_enabled() to check if kvm supports
KVM_CAP_IRQ_ROUTING in order to avoid a needless ioctl invocation.

Signed-off-by: Fei Li <sherrylf@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/intc/s390_flic_kvm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/intc/s390_flic_kvm.c b/hw/intc/s390_flic_kvm.c
index 21ac2e2dcd..c313166fbe 100644
--- a/hw/intc/s390_flic_kvm.c
+++ b/hw/intc/s390_flic_kvm.c
@@ -201,7 +201,7 @@ static int kvm_s390_register_io_adapter(S390FLICState *fs, uint32_t id,
         .addr = (uint64_t)&adapter,
     };
 
-    if (!kvm_check_extension(kvm_state, KVM_CAP_IRQ_ROUTING)) {
+    if (!kvm_gsi_routing_enabled()) {
         /* nothing to do */
         return 0;
     }
@@ -226,7 +226,7 @@ static int kvm_s390_io_adapter_map(S390FLICState *fs, uint32_t id,
     KVMS390FLICState *flic = KVM_S390_FLIC(fs);
     int r;
 
-    if (!kvm_check_extension(kvm_state, KVM_CAP_IRQ_ROUTING)) {
+    if (!kvm_gsi_routing_enabled()) {
         /* nothing to do */
         return 0;
     }
-- 
2.11.0
