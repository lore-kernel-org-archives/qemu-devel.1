Received: from eggs.gnu.org ([2001:4830:134:3::10]:58443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dYXU1-000419-71
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:56:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1dYXTz-0002QC-0j
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:56:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1dYXTy-0002Pf-R0
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 08:56:38 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri, 21 Jul 2017 14:56:07 +0200
Message-Id: <20170721125609.11117-5-david@redhat.com>
In-Reply-To: <20170721125609.11117-1-david@redhat.com>
References: <20170721125609.11117-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 4/6] target/s390x: move wrap_address to cpu.h
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

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.h        | 14 ++++++++++++++
 target/s390x/mem_helper.c | 14 --------------
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 4f7c6b7..13df41c 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -409,6 +409,20 @@ static inline uint64_t cpu_mmu_idx_to_asc(int mmu_idx)
     }
 }
 
+static inline uint64_t wrap_address(CPUS390XState *env, uint64_t a)
+{
+    if (!(env->psw.mask & PSW_MASK_64)) {
+        if (!(env->psw.mask & PSW_MASK_32)) {
+            /* 24-Bit mode */
+            a &= 0x00ffffff;
+        } else {
+            /* 31-Bit mode */
+            a &= 0x7fffffff;
+        }
+    }
+    return a;
+}
+
 static inline void cpu_get_tb_cpu_state(CPUS390XState* env, target_ulong *pc,
                                         target_ulong *cs_base, uint32_t *flags)
 {
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index cdc78aa..369d291 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -110,20 +110,6 @@ static inline void cpu_stsize_data_ra(CPUS390XState *env, uint64_t addr,
     }
 }
 
-static inline uint64_t wrap_address(CPUS390XState *env, uint64_t a)
-{
-    if (!(env->psw.mask & PSW_MASK_64)) {
-        if (!(env->psw.mask & PSW_MASK_32)) {
-            /* 24-Bit mode */
-            a &= 0x00ffffff;
-        } else {
-            /* 31-Bit mode */
-            a &= 0x7fffffff;
-        }
-    }
-    return a;
-}
-
 static void fast_memset(CPUS390XState *env, uint64_t dest, uint8_t byte,
                         uint32_t l, uintptr_t ra)
 {
-- 
2.9.4
