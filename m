Received: from eggs.gnu.org ([2001:4830:134:3::10]:47779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1derpM-0005yT-N7
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:52:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1derpH-0005jL-Nk
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:52:52 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:43949)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1derpH-0005ir-IR
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:52:47 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon,  7 Aug 2017 19:52:27 -0400
Message-Id: <1502149958-23381-12-git-send-email-cota@braap.org>
In-Reply-To: <1502149958-23381-1-git-send-email-cota@braap.org>
References: <1502149958-23381-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 11/22] translate-all: exit from
 tb_phys_invalidate if qht_remove fails
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

Groundwork for supporting parallel TCG generation.

Once tb_lock goes away, it is conceivable that two (or more) threads
might race while invalidating the same TB. We currently do not
check for this, which means we would wrongly invalidate the same TB
more than once.

Fix this by using qht_remove as the synchronization point; if it fails,
that means the TB has already been invalidated, and therefore there
is nothing left to do in tb_phys_invalidate.

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/translate-all.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 8e5e5b2..0e3d223 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1061,7 +1061,9 @@ void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr)
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
