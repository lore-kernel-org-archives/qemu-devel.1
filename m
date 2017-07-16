Received: from eggs.gnu.org ([2001:4830:134:3::10]:46219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmb-0001Av-Iy
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dWpmW-0008NP-Uj
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:49 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:48403)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dWpmW-0008N9-Qr
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 16:04:44 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Sun, 16 Jul 2017 16:04:08 -0400
Message-Id: <1500235468-15341-26-git-send-email-cota@braap.org>
In-Reply-To: <1500235468-15341-1-git-send-email-cota@braap.org>
References: <1500235468-15341-1-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 25/45] translate-all: define and use
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
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 accel/tcg/translate-all.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index c8fa86a..aaf3993 100644
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
@@ -1197,9 +1203,9 @@ static inline void tb_alloc_page(TranslationBlock *tb,
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
