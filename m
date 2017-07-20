Received: from eggs.gnu.org ([2001:4830:134:3::10]:60253)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dY1qO-00016c-Qk
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 23:09:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dY1qK-0005rJ-3T
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 23:09:40 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52761)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dY1qJ-0005qh-Vr
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 23:09:36 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed, 19 Jul 2017 23:09:09 -0400
Message-Id: <1500520169-23367-24-git-send-email-cota@braap.org>
In-Reply-To: <1500520169-23367-1-git-send-email-cota@braap.org>
References: <1500520169-23367-1-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 23/43] exec-all: introduce TB_PAGE_ADDR_FMT
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
---
 include/exec/exec-all.h   | 2 ++
 accel/tcg/translate-all.c | 3 +--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 0af0485..00f7da8 100644
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
 
 /* DisasContext is_jmp field values
diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index c1cd258..c4c23f9 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1194,8 +1194,7 @@ static inline void tb_alloc_page(TranslationBlock *tb,
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
2.7.4
