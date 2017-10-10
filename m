Received: from eggs.gnu.org ([2001:4830:134:3::10]:60534)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e1iqM-0002MH-0b
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 20:56:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e1iqL-0004VZ-E9
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 20:56:22 -0400
Received: from mail-pf0-x22d.google.com ([2607:f8b0:400e:c00::22d]:53905)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e1iqL-0004Uc-8e
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 20:56:21 -0400
Received: by mail-pf0-x22d.google.com with SMTP id n73so8794260pfg.10
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 17:56:21 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  9 Oct 2017 17:55:50 -0700
Message-Id: <20171010005600.28735-14-richard.henderson@linaro.org>
In-Reply-To: <20171010005600.28735-1-richard.henderson@linaro.org>
References: <20171010005600.28735-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 13/23] translate-all: define and use
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
