Received: from eggs.gnu.org ([2001:4830:134:3::10]:46289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I79-0000TZ-FH
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I78-0000Oz-E8
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:43 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:43320)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7I78-0000OZ-7Y
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:42 -0400
Received: by mail-wm0-x242.google.com with SMTP id m72so15236131wmc.0
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 02:36:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 25 Oct 2017 11:35:35 +0200
Message-Id: <20171025093535.10175-52-richard.henderson@linaro.org>
In-Reply-To: <20171025093535.10175-1-richard.henderson@linaro.org>
References: <20171025093535.10175-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PULL 51/51] translate-all: exit from
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
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

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

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Message-Id: <1508445114-4717-1-git-send-email-cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 5724149289..34c5e28d07 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1079,7 +1079,9 @@ void tb_phys_invalidate(TranslationBlock *tb, tb_page_addr_t page_addr)
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
2.13.6
