Received: from eggs.gnu.org ([2001:4830:134:3::10]:47558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1diH0d-0006Pk-JG
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 05:22:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1diH0c-0000Cm-LU
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 05:22:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44356)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1diH0c-0000CE-FA
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 05:22:34 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu, 17 Aug 2017 11:22:17 +0200
Message-Id: <20170817092225.4264-3-david@redhat.com>
In-Reply-To: <20170817092225.4264-1-david@redhat.com>
References: <20170817092225.4264-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 for-2.11 02/10] target/s390x: move
 cpu_mmu_idx_to_asc() to excp_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com

Only used in that file.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.h         | 14 --------------
 target/s390x/excp_helper.c | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 3e798ef..6567cfa 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -393,20 +393,6 @@ static inline int cpu_mmu_index(CPUS390XState *env, bool ifetch)
     }
 }
 
-static inline uint64_t cpu_mmu_idx_to_asc(int mmu_idx)
-{
-    switch (mmu_idx) {
-    case MMU_PRIMARY_IDX:
-        return PSW_ASC_PRIMARY;
-    case MMU_SECONDARY_IDX:
-        return PSW_ASC_SECONDARY;
-    case MMU_HOME_IDX:
-        return PSW_ASC_HOME;
-    default:
-        abort();
-    }
-}
-
 static inline void cpu_get_tb_cpu_state(CPUS390XState* env, target_ulong *pc,
                                         target_ulong *cs_base, uint32_t *flags)
 {
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index d183377..db86259 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -68,6 +68,20 @@ int s390_cpu_handle_mmu_fault(CPUState *cs, vaddr address,
 
 #else /* !CONFIG_USER_ONLY */
 
+static inline uint64_t cpu_mmu_idx_to_asc(int mmu_idx)
+{
+    switch (mmu_idx) {
+    case MMU_PRIMARY_IDX:
+        return PSW_ASC_PRIMARY;
+    case MMU_SECONDARY_IDX:
+        return PSW_ASC_SECONDARY;
+    case MMU_HOME_IDX:
+        return PSW_ASC_HOME;
+    default:
+        abort();
+    }
+}
+
 int s390_cpu_handle_mmu_fault(CPUState *cs, vaddr orig_vaddr,
                               int rw, int mmu_idx)
 {
-- 
2.9.4
