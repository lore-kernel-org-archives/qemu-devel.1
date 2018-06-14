Received: from eggs.gnu.org ([2001:4830:134:3::10]:36975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTXyd-00071B-1o
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:32:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fTXyb-0005pU-Tc
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:32:10 -0400
Received: from mail-pg0-x232.google.com ([2607:f8b0:400e:c05::232]:44099)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fTXyb-0005ol-NG
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 15:32:09 -0400
Received: by mail-pg0-x232.google.com with SMTP id p21-v6so3354716pgd.11
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 12:32:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 14 Jun 2018 09:31:38 -1000
Message-Id: <20180614193147.29680-10-richard.henderson@linaro.org>
In-Reply-To: <20180614193147.29680-1-richard.henderson@linaro.org>
References: <20180614193147.29680-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/18] translate-all: work page-by-page in
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
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

So that we pass a same-page range to tb_invalidate_phys_page_range,
instead of always passing an end address that could be on a different
page.

As discussed with Peter Maydell on the list [1], tb_invalidate_phys_page_range
doesn't actually do much with 'end', which explains why we have never
hit a bug despite going against what the comment on top of
tb_invalidate_phys_page_range requires:

> * Invalidate all TBs which intersect with the target physical address range
> * [start;end[. NOTE: start and end must refer to the *same* physical page.

The appended honours the comment, which avoids confusion.

While at it, rework the loop into a for loop, which is less error prone
(e.g. "continue" won't result in an infinite loop).

[1] https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg09165.html

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index b9c36a3e45..f32904d4a3 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1375,10 +1375,14 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
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
2.17.1
