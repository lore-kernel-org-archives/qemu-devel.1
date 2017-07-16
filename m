Received: from eggs.gnu.org ([2001:4830:134:3::10]:46135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmZ-0001Al-Fi
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmU-0008H2-Mu
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:47 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:48619)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dWpmU-0008G6-IB
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:42 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun, 16 Jul 2017 16:03:53 -0400
Message-Id: <1500235468-15341-11-git-send-email-cota@braap.org>
In-Reply-To: <1500235468-15341-1-git-send-email-cota@braap.org>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH v2 10/45] translate-all: guarantee that tb_hash
 only holds valid TBs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>

This gets rid of the need to check the tb->invalid bit during lookups.

After this change we do not need atomics to operate on tb->invalid: setting
and checking its value is serialised with tb_lock.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/cpu-exec.c      | 3 +--
 accel/tcg/translate-all.c | 8 ++++++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index c4c289b..9b5ce13 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -292,8 +292,7 @@ static bool tb_cmp(const void *p, const void *d)
         tb->page_addr[0] == desc->phys_page1 &&
         tb->cs_base == desc->cs_base &&
         tb->flags == desc->flags &&
-        tb->trace_vcpu_dstate == desc->trace_vcpu_dstate &&
-        !atomic_read(&tb->invalid)) {
+        tb->trace_vcpu_dstate == desc->trace_vcpu_dstate) {
         /* check next page if needed */
         if (tb->page_addr[1] == -1) {
             return true;
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index a124181..6d4c05f 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1073,13 +1073,17 @@ void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr)
 
     assert_tb_locked();
 
-    atomic_set(&tb->invalid, true);
-
     /* remove the TB from the hash list */
     phys_pc = tb->page_addr[0] + (tb->pc & ~TARGET_PAGE_MASK);
     h = tb_hash_func(phys_pc, tb->pc, tb->flags, tb->trace_vcpu_dstate);
     qht_remove(&tcg_ctx.tb_ctx.htable, tb, h);
 
+    /*
+     * Mark the TB as invalid *after* it's been removed from tb_hash, which
+     * eliminates the need to check this bit on lookups.
+     */
+    tb->invalid = true;
+
     /* remove the TB from the page list */
     if (tb->page_addr[0] != page_addr) {
         p = page_find(tb->page_addr[0] >> TARGET_PAGE_BITS);
-- 
2.7.4
