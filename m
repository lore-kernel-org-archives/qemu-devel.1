Received: from eggs.gnu.org ([2001:4830:134:3::10]:59339)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d5dO8-0001cK-OM
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:23:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d5dO7-0001SD-Ow
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:23:08 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:32951)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d5dO7-0001Rn-KB
	for qemu-devel@nongnu.org; Tue, 02 May 2017 15:23:07 -0400
Received: by mail-qk0-x243.google.com with SMTP id o85so22939885qkh.0
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 12:23:07 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue,  2 May 2017 12:22:36 -0700
Message-Id: <20170502192300.2124-2-rth@twiddle.net>
In-Reply-To: <20170502192300.2124-1-rth@twiddle.net>
References: <20170502192300.2124-1-rth@twiddle.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v6 01/25] target/nios2: Fix 64-bit ilp32
 compilation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org

Avoid a "cast from pointer to integer of different size" warning
by using the proper host type.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/nios2/translate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index cfec479..2f3c2e5 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -164,7 +164,7 @@ static void gen_goto_tb(DisasContext *dc, int n, uint32_t dest)
     if (use_goto_tb(dc, dest)) {
         tcg_gen_goto_tb(n);
         tcg_gen_movi_tl(dc->cpu_R[R_PC], dest);
-        tcg_gen_exit_tb((tcg_target_long)tb + n);
+        tcg_gen_exit_tb((uintptr_t)tb + n);
     } else {
         tcg_gen_movi_tl(dc->cpu_R[R_PC], dest);
         tcg_gen_exit_tb(0);
-- 
2.9.3
