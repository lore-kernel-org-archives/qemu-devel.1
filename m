Received: from eggs.gnu.org ([2001:4830:134:3::10]:58877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e20EW-0000jx-Lr
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 15:30:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e20EV-00055t-Ek
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 15:30:28 -0400
Received: from mail-pf0-x22b.google.com ([2607:f8b0:400e:c00::22b]:45681)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e20EV-00054y-8n
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 15:30:27 -0400
Received: by mail-pf0-x22b.google.com with SMTP id d28so3569521pfe.2
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 12:30:24 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 10 Oct 2017 12:29:56 -0700
Message-Id: <20171010193003.28857-14-richard.henderson@linaro.org>
In-Reply-To: <20171010193003.28857-1-richard.henderson@linaro.org>
References: <20171010193003.28857-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL v2 13/20] translate-all: define and use
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
Cc: peter.maydell@linaro.org, "Emilio G. Cota" <cota@braap.org>

From: "Emilio G. Cota" <cota@braap.org>

This gets rid of an ifdef check while ensuring that the debug code
is compiled, which prevents bit rot.

Suggested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 accel/tcg/translate-all.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 90b3eed9c6..6b853b329c 100644
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
@@ -1192,9 +1198,9 @@ static inline void tb_alloc_page(TranslationBlock *tb,
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
2.13.6
