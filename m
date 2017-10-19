Received: from eggs.gnu.org ([2001:4830:134:3::10]:40053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e5HU2-0002BA-7q
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 16:32:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1e5HTx-0007gK-HP
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 16:32:02 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:48085)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1e5HTx-0007fw-AJ
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 16:31:57 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 19 Oct 2017 16:31:54 -0400
Message-Id: <1508445114-4717-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH] translate-all: exit from tb_phys_invalidate if
 qht_remove fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>

Two or more threads might race while invalidating the same TB. We currently
do not check for this at all despite taking tb_lock, which means we would
wrongly invalidate the same TB more than once. This bug has actually been
hit by users: I recently saw a report on IRC, although I have yet to see
the corresponding test case.

Fix this by using qht_remove as the synchronization point; if it fails,
that means the TB has already been invalidated, and therefore there
is nothing left to do in tb_phys_invalidate.

Note that this solution works now that we still have tb_lock, and will
continue working once we remove tb_lock.

Signed-off-by: Emilio G. Cota <cota@braap.org>

---
This patch applies on top of the "[PATCH v6 00/50] tcg tb_lock removal" series:
https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg03612.html
---
 accel/tcg/translate-all.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index ac8dfe6..2fe8b14 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1081,7 +1081,9 @@ void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr)
     phys_pc = tb->page_addr[0] + (tb->pc & ~TARGET_PAGE_MASK);
     h = tb_hash_func(phys_pc, tb->pc, tb->flags, tb->cflags & CF_HASH_MASK,
                      tb->trace_vcpu_dstate);
-    qht_remove(&tb_ctx.htable, tb, h);
+    if (!qht_remove(&tb_ctx.htable, tb, h)) {
+        return;
+    }
 
     /* remove the TB from the page list */
     if (tb->page_addr[0] != page_addr) {
-- 
2.7.4
