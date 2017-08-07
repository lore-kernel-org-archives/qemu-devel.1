Received: from eggs.gnu.org ([2001:4830:134:3::10]:47819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1derpN-0005yg-LH
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:53:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1derpI-0005jq-5a
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:52:53 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:53669)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1derpI-0005jP-07
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 19:52:48 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon,  7 Aug 2017 19:52:30 -0400
Message-Id: <1502149958-23381-15-git-send-email-cota@braap.org>
In-Reply-To: <1502149958-23381-1-git-send-email-cota@braap.org>
References: <1502149958-23381-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH 14/22] translate-all: work page-by-page in
 tb_invalidate_phys_range_1
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

So that we pass a same-page range to tb_invalidate_phys_page_range,
instead of always passing an end address that could be on a different
page.

As discussed with Peter Maydell on the list, tb_invalidate_phys_page_range
doesn't actually do much with 'end', which explains why we have never
hit a bug despite going against what the comment on top of
tb_invalidate_phys_page_range requires:

> * Invalidate all TBs which intersect with the target physical address range
> * [start;end[. NOTE: start and end must refer to the *same* physical page.

The appended honours the comment, which avoids confusion.

While at it, rework the loop into a for loop, which is less error prone
(e.g. "continue" won't result in an infinite loop).

Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/translate-all.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 64d099b..e8f663f 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1372,10 +1372,14 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
  */
 static void tb_invalidate_phys_range_1(tb_page_addr_t start, tb_page_addr_t end)
 {
-    while (start < end) {
-        tb_invalidate_phys_page_range(start, end, 0);
-        start &= TARGET_PAGE_MASK;
-        start += TARGET_PAGE_SIZE;
+    tb_page_addr_t next;
+
+    for (next = (start & TARGET_PAGE_MASK) + TARGET_PAGE_SIZE;
+         start < end;
+         start = next, next += TARGET_PAGE_SIZE) {
+        tb_page_addr_t bound = MIN(next, end);
+
+        tb_invalidate_phys_page_range(start, bound, 0);
     }
 }
 
-- 
2.7.4
