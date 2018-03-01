Received: from eggs.gnu.org ([2001:4830:134:3::10]:58801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1erNrP-0004IW-Qs
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:03:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1erNrO-0007Rv-UQ
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 08:02:59 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu,  1 Mar 2018 14:01:51 +0100
Message-Id: <20180301130201.24666-18-cohuck@redhat.com>
In-Reply-To: <20180301130201.24666-1-cohuck@redhat.com>
References: <20180301130201.24666-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL v2 17/27] s390x/tcg: fix disabling/enabling DAT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, rth@twiddle.net, agraf@suse.de, david@redhat.com, thuth@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Currently, all memory accesses go via the MMU of the address space
(primary, secondary, ...). This is bad, because we don't flush the TLB
when disabling/enabling DAT. So we could add a tlb flush. However it
is easier to simply select the MMU we already have in place for real
memory access.

All we have to do is point at the right MMU and allow to execute these
pages.

Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180213161240.19891-1-david@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
[CH: get rid of tabs]
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu.h        |  7 ++++++-
 target/s390x/mmu_helper.c |  2 +-
 target/s390x/translate.c  | 10 +++++++---
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 09ec8a9b76..d4641663ef 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -312,11 +312,12 @@ extern const struct VMStateDescription vmstate_s390_cpu;
 
 #define FLAG_MASK_PSW_SHIFT     31
 #define FLAG_MASK_PER           (PSW_MASK_PER    >> FLAG_MASK_PSW_SHIFT)
+#define FLAG_MASK_DAT           (PSW_MASK_DAT    >> FLAG_MASK_PSW_SHIFT)
 #define FLAG_MASK_PSTATE        (PSW_MASK_PSTATE >> FLAG_MASK_PSW_SHIFT)
 #define FLAG_MASK_ASC           (PSW_MASK_ASC    >> FLAG_MASK_PSW_SHIFT)
 #define FLAG_MASK_64            (PSW_MASK_64     >> FLAG_MASK_PSW_SHIFT)
 #define FLAG_MASK_32            (PSW_MASK_32     >> FLAG_MASK_PSW_SHIFT)
-#define FLAG_MASK_PSW		(FLAG_MASK_PER | FLAG_MASK_PSTATE \
+#define FLAG_MASK_PSW           (FLAG_MASK_PER | FLAG_MASK_DAT | FLAG_MASK_PSTATE \
                                 | FLAG_MASK_ASC | FLAG_MASK_64 | FLAG_MASK_32)
 
 /* Control register 0 bits */
@@ -340,6 +341,10 @@ extern const struct VMStateDescription vmstate_s390_cpu;
 
 static inline int cpu_mmu_index(CPUS390XState *env, bool ifetch)
 {
+    if (!(env->psw.mask & PSW_MASK_DAT)) {
+        return MMU_REAL_IDX;
+    }
+
     switch (env->psw.mask & PSW_MASK_ASC) {
     case PSW_ASC_PRIMARY:
         return MMU_PRIMARY_IDX;
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index f477cc006a..23fb2e7501 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -544,7 +544,7 @@ int mmu_translate_real(CPUS390XState *env, target_ulong raddr, int rw,
 {
     const bool lowprot_enabled = env->cregs[0] & CR0_LOWPROT;
 
-    *flags = PAGE_READ | PAGE_WRITE;
+    *flags = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
     if (is_low_address(raddr & TARGET_PAGE_MASK) && lowprot_enabled) {
         /* see comment in mmu_translate() how this works */
         *flags |= PAGE_WRITE_INV;
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index b470d691d3..5aea3bbca6 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -252,13 +252,17 @@ static inline uint64_t ld_code4(CPUS390XState *env, uint64_t pc)
 
 static int get_mem_index(DisasContext *s)
 {
+    if (!(s->tb->flags & FLAG_MASK_DAT)) {
+        return MMU_REAL_IDX;
+    }
+
     switch (s->tb->flags & FLAG_MASK_ASC) {
     case PSW_ASC_PRIMARY >> FLAG_MASK_PSW_SHIFT:
-        return 0;
+        return MMU_PRIMARY_IDX;
     case PSW_ASC_SECONDARY >> FLAG_MASK_PSW_SHIFT:
-        return 1;
+        return MMU_SECONDARY_IDX;
     case PSW_ASC_HOME >> FLAG_MASK_PSW_SHIFT:
-        return 2;
+        return MMU_HOME_IDX;
     default:
         tcg_abort();
         break;
-- 
2.13.6
