Received: from eggs.gnu.org ([2001:4830:134:3::10]:38397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fa1Ks-0004dz-Q1
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:05:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fa1Kp-0005OF-A3
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:05:54 -0400
Received: from mail-pf0-x229.google.com ([2607:f8b0:400e:c00::229]:43876)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fa1Kp-0005O1-2C
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:05:51 -0400
Received: by mail-pf0-x229.google.com with SMTP id y8-v6so7719193pfm.10
	for <qemu-devel@nongnu.org>; Mon, 02 Jul 2018 09:05:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  2 Jul 2018 09:05:41 -0700
Message-Id: <20180702160546.31969-2-richard.henderson@linaro.org>
In-Reply-To: <20180702160546.31969-1-richard.henderson@linaro.org>
References: <20180702160546.31969-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 1/6] translate-all: fix locking of TBs whose two
 pages share the same physical page
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

Commit 0b5c91f ("translate-all: use per-page locking in !user-mode",
2018-06-15) introduced per-page locking. It assumed that the physical
pages corresponding to a TB (at most two pages) are always distinct,
which is wrong. For instance, an xtensa test provided by Max Filippov
is broken by the commit, since the test maps two virtual pages
to the same physical page:

	virt1: 7fff, virt2: 8000
	phys1 6000fff, phys2 6000000

Fix it by removing the assumption from page_lock_pair.
If the two physical page addresses are equal, we only lock
the PageDesc once. Note that the two callers of page_lock_pair,
namely page_unlock_tb and tb_link_page, are also updated so that
we do not try to unlock the same PageDesc twice.

Fixes: 0b5c91f74f3c83a36f37740969df8c775c997e69
Reported-by: Max Filippov <jcmvbkbc@gmail.com>
Tested-by: Max Filippov <jcmvbkbc@gmail.com>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Message-Id: <1529944302-14186-1-git-send-email-cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 32 +++++++++++++++++++++++++-------
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index e8228bf3e6..170b95793f 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -669,9 +669,15 @@ static inline void page_lock_tb(const TranslationBlock *tb)
 
 static inline void page_unlock_tb(const TranslationBlock *tb)
 {
-    page_unlock(page_find(tb->page_addr[0] >> TARGET_PAGE_BITS));
+    PageDesc *p1 = page_find(tb->page_addr[0] >> TARGET_PAGE_BITS);
+
+    page_unlock(p1);
     if (unlikely(tb->page_addr[1] != -1)) {
-        page_unlock(page_find(tb->page_addr[1] >> TARGET_PAGE_BITS));
+        PageDesc *p2 = page_find(tb->page_addr[1] >> TARGET_PAGE_BITS);
+
+        if (p2 != p1) {
+            page_unlock(p2);
+        }
     }
 }
 
@@ -850,22 +856,34 @@ static void page_lock_pair(PageDesc **ret_p1, tb_page_addr_t phys1,
                            PageDesc **ret_p2, tb_page_addr_t phys2, int alloc)
 {
     PageDesc *p1, *p2;
+    tb_page_addr_t page1;
+    tb_page_addr_t page2;
 
     assert_memory_lock();
-    g_assert(phys1 != -1 && phys1 != phys2);
-    p1 = page_find_alloc(phys1 >> TARGET_PAGE_BITS, alloc);
+    g_assert(phys1 != -1);
+
+    page1 = phys1 >> TARGET_PAGE_BITS;
+    page2 = phys2 >> TARGET_PAGE_BITS;
+
+    p1 = page_find_alloc(page1, alloc);
     if (ret_p1) {
         *ret_p1 = p1;
     }
     if (likely(phys2 == -1)) {
         page_lock(p1);
         return;
+    } else if (page1 == page2) {
+        page_lock(p1);
+        if (ret_p2) {
+            *ret_p2 = p1;
+        }
+        return;
     }
-    p2 = page_find_alloc(phys2 >> TARGET_PAGE_BITS, alloc);
+    p2 = page_find_alloc(page2, alloc);
     if (ret_p2) {
         *ret_p2 = p2;
     }
-    if (phys1 < phys2) {
+    if (page1 < page2) {
         page_lock(p1);
         page_lock(p2);
     } else {
@@ -1623,7 +1641,7 @@ tb_link_page(TranslationBlock *tb, tb_page_addr_t phys_pc,
         tb = existing_tb;
     }
 
-    if (p2) {
+    if (p2 && p2 != p) {
         page_unlock(p2);
     }
     page_unlock(p);
-- 
2.17.1
