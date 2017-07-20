Received: from eggs.gnu.org ([2001:4830:134:3::10]:60251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dY1qO-00016b-MI
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 23:09:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dY1qK-0005rV-F1
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 23:09:40 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40609)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dY1qK-0005rF-BI
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 23:09:36 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 19 Jul 2017 23:09:10 -0400
Message-Id: <1500520169-23367-25-git-send-email-cota@braap.org>
In-Reply-To: <1500520169-23367-1-git-send-email-cota@braap.org>
References: <1500520169-23367-1-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 24/43] translate-all: define and use
 DEBUG_TB_INVALIDATE_GATE
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

This gets rid of an ifdef check while ensuring that the debug code
is compiled, which prevents bit rot.

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/translate-all.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index c4c23f9..962e9b3 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -65,6 +65,12 @@
 /* make various TB consistency checks */
 /* #define DEBUG_TB_CHECK */
 
+#ifdef DEBUG_TB_INVALIDATE
+#define DEBUG_TB_INVALIDATE_GATE 1
+#else
+#define DEBUG_TB_INVALIDATE_GATE 0
+#endif
+
 #ifdef DEBUG_TB_FLUSH
 #define DEBUG_TB_FLUSH_GATE 1
 #else
@@ -1193,9 +1199,9 @@ static inline void tb_alloc_page(TranslationBlock *tb,
           }
         mprotect(g2h(page_addr), qemu_host_page_size,
                  (prot & PAGE_BITS) & ~PAGE_WRITE);
-#ifdef DEBUG_TB_INVALIDATE
-        printf("protecting code page: 0x" TB_PAGE_ADDR_FMT "\n", page_addr);
-#endif
+        if (DEBUG_TB_INVALIDATE_GATE) {
+            printf("protecting code page: 0x" TB_PAGE_ADDR_FMT "\n", page_addr);
+        }
     }
 #else
     /* if some code is already present, then the pages are already
-- 
2.7.4
