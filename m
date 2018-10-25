Received: from eggs.gnu.org ([2001:4830:134:3::10]:40310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKm-0006hm-EP
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKC-00005n-0Y
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:21:39 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:34579)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFjK6-0008QZ-Qb
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:21:33 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 13:20:25 -0400
Message-Id: <20181025172057.20414-17-cota@braap.org>
In-Reply-To: <20181025172057.20414-1-cota@braap.org>
References: <20181025172057.20414-1-cota@braap.org>
Subject: [Qemu-devel] [RFC 16/48] tcg: add plugin_mask to TB hash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 include/exec/exec-all.h   | 2 ++
 include/exec/tb-hash.h    | 6 ++++--
 include/exec/tb-lookup.h  | 1 +
 accel/tcg/cpu-exec.c      | 6 +++++-
 accel/tcg/translate-all.c | 6 ++++--
 5 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 232e2f8966..a1f60404b6 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -358,6 +358,8 @@ struct TranslationBlock {
     /* Per-vCPU dynamic tracing state used to generate this TB */
     uint32_t trace_vcpu_dstate;
 
+    uint32_t plugin_mask;
+
     struct tb_tc tc;
 
     /* original tb when cflags has CF_NOCACHE */
diff --git a/include/exec/tb-hash.h b/include/exec/tb-hash.h
index 4f3a37d927..37292474b7 100644
--- a/include/exec/tb-hash.h
+++ b/include/exec/tb-hash.h
@@ -59,9 +59,11 @@ static inline unsigned int tb_jmp_cache_hash_func(target_ulong pc)
 
 static inline
 uint32_t tb_hash_func(tb_page_addr_t phys_pc, target_ulong pc, uint32_t flags,
-                      uint32_t cf_mask, uint32_t trace_vcpu_dstate)
+                      uint32_t cf_mask, uint32_t trace_vcpu_dstate,
+                      uint32_t plugin_mask)
 {
-    return qemu_xxhash7(phys_pc, pc, flags, cf_mask, trace_vcpu_dstate);
+    return qemu_xxhash8(phys_pc, pc, flags, cf_mask, trace_vcpu_dstate,
+                        plugin_mask);
 }
 
 #endif
diff --git a/include/exec/tb-lookup.h b/include/exec/tb-lookup.h
index 492cb68289..dd1572f481 100644
--- a/include/exec/tb-lookup.h
+++ b/include/exec/tb-lookup.h
@@ -33,6 +33,7 @@ tb_lookup__cpu_state(CPUState *cpu, target_ulong *pc, target_ulong *cs_base,
                tb->cs_base == *cs_base &&
                tb->flags == *flags &&
                tb->trace_vcpu_dstate == *cpu->trace_dstate &&
+               tb->plugin_mask == *cpu->plugin_mask &&
                (tb_cflags(tb) & (CF_HASH_MASK | CF_INVALID)) == cf_mask)) {
         return tb;
     }
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index d590f1f6c0..27aa3451da 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -287,6 +287,7 @@ struct tb_desc {
     uint32_t flags;
     uint32_t cf_mask;
     uint32_t trace_vcpu_dstate;
+    uint32_t plugin_mask;
 };
 
 static bool tb_lookup_cmp(const void *p, const void *d)
@@ -299,6 +300,7 @@ static bool tb_lookup_cmp(const void *p, const void *d)
         tb->cs_base == desc->cs_base &&
         tb->flags == desc->flags &&
         tb->trace_vcpu_dstate == desc->trace_vcpu_dstate &&
+        tb->plugin_mask == desc->plugin_mask &&
         (tb_cflags(tb) & (CF_HASH_MASK | CF_INVALID)) == desc->cf_mask) {
         /* check next page if needed */
         if (tb->page_addr[1] == -1) {
@@ -330,13 +332,15 @@ TranslationBlock *tb_htable_lookup(CPUState *cpu, target_ulong pc,
     desc.flags = flags;
     desc.cf_mask = cf_mask;
     desc.trace_vcpu_dstate = *cpu->trace_dstate;
+    desc.plugin_mask = *cpu->plugin_mask;
     desc.pc = pc;
     phys_pc = get_page_addr_code(desc.env, pc);
     if (phys_pc == -1) {
         return NULL;
     }
     desc.phys_page1 = phys_pc & TARGET_PAGE_MASK;
-    h = tb_hash_func(phys_pc, pc, flags, cf_mask, *cpu->trace_dstate);
+    h = tb_hash_func(phys_pc, pc, flags, cf_mask, *cpu->trace_dstate,
+                     *cpu->plugin_mask);
     return qht_lookup_custom(&tb_ctx.htable, &desc, h, tb_lookup_cmp);
 }
 
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index db2d28f8d3..3423cf74db 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1129,6 +1129,7 @@ static bool tb_cmp(const void *ap, const void *bp)
         a->flags == b->flags &&
         (tb_cflags(a) & CF_HASH_MASK) == (tb_cflags(b) & CF_HASH_MASK) &&
         a->trace_vcpu_dstate == b->trace_vcpu_dstate &&
+        a->plugin_mask == b->plugin_mask &&
         a->page_addr[0] == b->page_addr[0] &&
         a->page_addr[1] == b->page_addr[1];
 }
@@ -1444,7 +1445,7 @@ static void do_tb_phys_invalidate(TranslationBlock *tb, bool rm_from_page_list)
     /* remove the TB from the hash list */
     phys_pc = tb->page_addr[0] + (tb->pc & ~TARGET_PAGE_MASK);
     h = tb_hash_func(phys_pc, tb->pc, tb->flags, tb_cflags(tb) & CF_HASH_MASK,
-                     tb->trace_vcpu_dstate);
+                     tb->trace_vcpu_dstate, tb->plugin_mask);
     if (!(tb->cflags & CF_NOCACHE) &&
         !qht_remove(&tb_ctx.htable, tb, h)) {
         return;
@@ -1640,7 +1641,7 @@ tb_link_page(TranslationBlock *tb, tb_page_addr_t phys_pc,
 
         /* add in the hash table */
         h = tb_hash_func(phys_pc, tb->pc, tb->flags, tb->cflags & CF_HASH_MASK,
-                         tb->trace_vcpu_dstate);
+                         tb->trace_vcpu_dstate, tb->plugin_mask);
         qht_insert(&tb_ctx.htable, tb, h, &existing_tb);
 
         /* remove TB from the page(s) if we couldn't insert it */
@@ -1712,6 +1713,7 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     tb->cflags = cflags;
     tb->trace_vcpu_dstate = *cpu->trace_dstate;
     tcg_ctx->tb_cflags = cflags;
+    tb->plugin_mask = *cpu->plugin_mask;
 
 #ifdef CONFIG_PROFILER
     /* includes aborted translations because of exceptions */
-- 
2.17.1
