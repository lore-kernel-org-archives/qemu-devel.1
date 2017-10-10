Received: from eggs.gnu.org ([2001:4830:134:3::10]:60523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e1iqL-0002LH-5P
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 20:56:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e1iqK-0004Tb-7o
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 20:56:21 -0400
Received: from mail-pf0-x235.google.com ([2607:f8b0:400e:c00::235]:43662)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e1iqK-0004TE-2D
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 20:56:20 -0400
Received: by mail-pf0-x235.google.com with SMTP id d2so12283029pfh.0
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 17:56:19 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  9 Oct 2017 17:55:49 -0700
Message-Id: <20171010005600.28735-13-richard.henderson@linaro.org>
In-Reply-To: <20171010005600.28735-1-richard.henderson@linaro.org>
References: <20171010005600.28735-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 12/23] exec-all: introduce TB_PAGE_ADDR_FMT
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

And fix the following warning when DEBUG_TB_INVALIDATE is enabled
in translate-all.c:

  CC      mipsn32-linux-user/accel/tcg/translate-all.o
/data/src/qemu/accel/tcg/translate-all.c: In function ‘tb_alloc_page’:
/data/src/qemu/accel/tcg/translate-all.c:1201:16: error: format ‘%lx’ expects argument of type ‘long unsigned int’, but argument 2 has type ‘tb_page_addr_t {aka unsigned int}’ [-Werror=format=]
         printf("protecting code page: 0x" TARGET_FMT_lx "\n",
                ^
cc1: all warnings being treated as errors
/data/src/qemu/rules.mak:66: recipe for target 'accel/tcg/translate-all.o' failed
make[1]: *** [accel/tcg/translate-all.o] Error 1
Makefile:328: recipe for target 'subdir-mipsn32-linux-user' failed
make: *** [subdir-mipsn32-linux-user] Error 2
cota@flamenco:/data/src/qemu/build ((18f3fe1...) *$)$

Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/exec/exec-all.h   | 2 ++
 accel/tcg/translate-all.c | 3 +--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 3135aaf4c9..79f8041811 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -31,8 +31,10 @@
    type.  */
 #if defined(CONFIG_USER_ONLY)
 typedef abi_ulong tb_page_addr_t;
+#define TB_PAGE_ADDR_FMT TARGET_ABI_FMT_lx
 #else
 typedef ram_addr_t tb_page_addr_t;
+#define TB_PAGE_ADDR_FMT RAM_ADDR_FMT
 #endif
 
 #include "qemu/log.h"
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 799b027e79..90b3eed9c6 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1193,8 +1193,7 @@ static inline void tb_alloc_page(TranslationBlock *tb,
         mprotect(g2h(page_addr), qemu_host_page_size,
                  (prot & PAGE_BITS) & ~PAGE_WRITE);
 #ifdef DEBUG_TB_INVALIDATE
-        printf("protecting code page: 0x" TARGET_FMT_lx "\n",
-               page_addr);
+        printf("protecting code page: 0x" TB_PAGE_ADDR_FMT "\n", page_addr);
 #endif
     }
 #else
-- 
2.13.6
