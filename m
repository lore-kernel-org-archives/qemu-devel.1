Received: from eggs.gnu.org ([2001:4830:134:3::10]:58862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e20EW-0000hu-Gl
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 15:30:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e20EP-00054P-A2
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 15:30:23 -0400
Received: from mail-pf0-x235.google.com ([2607:f8b0:400e:c00::235]:53300)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e20EO-00054C-St
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 15:30:21 -0400
Received: by mail-pf0-x235.google.com with SMTP id n73so11596349pfg.10
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 12:30:20 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 10 Oct 2017 12:29:53 -0700
Message-Id: <20171010193003.28857-11-richard.henderson@linaro.org>
In-Reply-To: <20171010193003.28857-1-richard.henderson@linaro.org>
References: <20171010193003.28857-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL v2 10/20] exec-all: bring tb->invalid into
 tb->cflags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

This gets rid of a hole in struct TranslationBlock.

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h   | 3 +--
 include/exec/tb-lookup.h  | 2 +-
 accel/tcg/cpu-exec.c      | 4 ++--
 accel/tcg/translate-all.c | 3 +--
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index a9a8bb6f83..3135aaf4c9 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -314,12 +314,11 @@ struct TranslationBlock {
 #define CF_NOCACHE     0x10000 /* To be freed after execution */
 #define CF_USE_ICOUNT  0x20000
 #define CF_IGNORE_ICOUNT 0x40000 /* Do not generate icount code */
+#define CF_INVALID     0x80000 /* TB is stale. Setters must acquire tb_lock */
 
     /* Per-vCPU dynamic tracing state used to generate this TB */
     uint32_t trace_vcpu_dstate;
 
-    uint16_t invalid;
-
     void *tc_ptr;    /* pointer to the translated code */
     uint8_t *tc_search;  /* pointer to search data */
     /* original tb when cflags has CF_NOCACHE */
diff --git a/include/exec/tb-lookup.h b/include/exec/tb-lookup.h
index 9d32cb0c6e..436b6d5ecf 100644
--- a/include/exec/tb-lookup.h
+++ b/include/exec/tb-lookup.h
@@ -35,7 +35,7 @@ tb_lookup__cpu_state(CPUState *cpu, target_ulong *pc, target_ulong *cs_base,
                tb->cs_base == *cs_base &&
                tb->flags == *flags &&
                tb->trace_vcpu_dstate == *cpu->trace_dstate &&
-               !atomic_read(&tb->invalid))) {
+               !(atomic_read(&tb->cflags) & CF_INVALID))) {
         return tb;
     }
     tb = tb_htable_lookup(cpu, *pc, *cs_base, *flags);
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index f8a1d68db7..9cd809d607 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -294,7 +294,7 @@ static bool tb_cmp(const void *p, const void *d)
         tb->cs_base == desc->cs_base &&
         tb->flags == desc->flags &&
         tb->trace_vcpu_dstate == desc->trace_vcpu_dstate &&
-        !atomic_read(&tb->invalid)) {
+        !(atomic_read(&tb->cflags) & CF_INVALID)) {
         /* check next page if needed */
         if (tb->page_addr[1] == -1) {
             return true;
@@ -412,7 +412,7 @@ static inline TranslationBlock *tb_find(CPUState *cpu,
             tb_lock();
             acquired_tb_lock = true;
         }
-        if (!tb->invalid) {
+        if (!(tb->cflags & CF_INVALID)) {
             tb_add_jump(last_tb, tb_exit, tb);
         }
     }
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index a7c1d4e3f2..ed65d68709 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1073,7 +1073,7 @@ void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr)
 
     assert_tb_locked();
 
-    atomic_set(&tb->invalid, true);
+    atomic_set(&tb->cflags, tb->cflags | CF_INVALID);
 
     /* remove the TB from the hash list */
     phys_pc = tb->page_addr[0] + (tb->pc & ~TARGET_PAGE_MASK);
@@ -1269,7 +1269,6 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tb->flags = flags;
     tb->cflags = cflags;
     tb->trace_vcpu_dstate = *cpu->trace_dstate;
-    tb->invalid = false;
 
 #ifdef CONFIG_PROFILER
     tcg_ctx.tb_count1++; /* includes aborted translations because of
-- 
2.13.6
