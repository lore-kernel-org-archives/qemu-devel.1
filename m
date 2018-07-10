Received: from eggs.gnu.org ([2001:4830:134:3::10]:49143)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fcv47-0003ZU-8Q
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 12:00:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fcv43-0002N3-5j
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 12:00:35 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Jul 2018 17:00:11 +0100
Message-Id: <20180710160013.26559-5-peter.maydell@linaro.org>
In-Reply-To: <20180710160013.26559-1-peter.maydell@linaro.org>
References: <20180710160013.26559-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 4/6] accel/tcg: tb_gen_code(): Create
 single-insn TB for execution from non-RAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>, "Emilio G . Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, KONRAD Frederic <frederic.konrad@adacore.com>

If get_page_addr_code() returns -1, this indicates that there is no RAM
page we can read a full TB from. Instead we must create a TB which
contains a single instruction and which we do not cache, so it is
executed only once.

Since this means we can now have TBs which are not in any page list,
we also need to make tb_phys_invalidate() handle them (by not trying
to remove them from a nonexistent page list).

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 accel/tcg/translate-all.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index d18018fa99d..4c12d94dd13 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1493,7 +1493,7 @@ static void tb_phys_invalidate__locked(TranslationBlock *tb)
  */
 void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr)
 {
-    if (page_addr == -1) {
+    if (page_addr == -1 && tb->page_addr[0] != -1) {
         page_lock_tb(tb);
         do_tb_phys_invalidate(tb, true);
         page_unlock_tb(tb);
@@ -1608,6 +1608,17 @@ tb_link_page(TranslationBlock *tb, tb_page_addr_t phys_pc,
 
     assert_memory_lock();
 
+    if (phys_pc == -1) {
+        /*
+         * If the TB is not associated with a physical RAM page then
+         * it must be a temporary one-insn TB, and we have nothing to do
+         * except fill in the page_addr[] fields.
+         */
+        assert(tb->cflags & CF_NOCACHE);
+        tb->page_addr[0] = tb->page_addr[1] = -1;
+        return tb;
+    }
+
     /*
      * Add the TB to the page list, acquiring first the pages's locks.
      * We keep the locks held until after inserting the TB in the hash table,
@@ -1677,6 +1688,12 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
 
     phys_pc = get_page_addr_code(env, pc);
 
+    if (phys_pc == -1) {
+        /* Generate a temporary TB with 1 insn in it */
+        cflags &= ~CF_COUNT_MASK;
+        cflags |= CF_NOCACHE | 1;
+    }
+
  buffer_overflow:
     tb = tb_alloc(pc);
     if (unlikely(!tb)) {
-- 
2.17.1
