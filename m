Received: from eggs.gnu.org ([2001:4830:134:3::10]:42666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBy-0003JV-SB
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBv-0001ME-PT
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44731
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKBv-0001Lz-Ip
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:35 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0hbIa135977
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:35 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27bdm3s0uu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:34 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:46:34 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:30 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-37-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 36/67] ppc/kvm: Mark 64kB page size support as
 disabled if not available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: Thomas Huth <thuth@redhat.com>

QEMU currently refuses to start with KVM-PR and only prints out

	qemu: fatal: Unknown MMU model 851972

when being started there. This is because commit 4322e8ced5aaac719
("ppc: Fix 64K pages support in full emulation") introduced a new
POWERPC_MMU_64K bit to indicate support for this page size, but
it never gets cleared on KVM-PR if the host kernel does not support
this. Thus we've got to turn off this bit in the mmu_model for KVM-PR.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
(cherry picked from commit 0d594f5565837fe2886a8aa307ef8abb65eab8f7)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target-ppc/kvm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/target-ppc/kvm.c b/target-ppc/kvm.c
index f26a141..5680f8b 100644
--- a/target-ppc/kvm.c
+++ b/target-ppc/kvm.c
@@ -429,6 +429,7 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
     CPUPPCState *env = &cpu->env;
     long rampagesize;
     int iq, ik, jq, jk;
+    bool has_64k_pages = false;
 
     /* We only handle page sizes for 64-bit server guests for now */
     if (!(env->mmu_model & POWERPC_MMU_64)) {
@@ -472,6 +473,9 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
                                      ksps->enc[jk].page_shift)) {
                 continue;
             }
+            if (ksps->enc[jk].page_shift == 16) {
+                has_64k_pages = true;
+            }
             qsps->enc[jq].page_shift = ksps->enc[jk].page_shift;
             qsps->enc[jq].pte_enc = ksps->enc[jk].pte_enc;
             if (++jq >= PPC_PAGE_SIZES_MAX_SZ) {
@@ -486,6 +490,9 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
     if (!(smmu_info.flags & KVM_PPC_1T_SEGMENTS)) {
         env->mmu_model &= ~POWERPC_MMU_1TSEG;
     }
+    if (!has_64k_pages) {
+        env->mmu_model &= ~POWERPC_MMU_64K;
+    }
 }
 #else /* defined (TARGET_PPC64) */
 
-- 
1.9.1
