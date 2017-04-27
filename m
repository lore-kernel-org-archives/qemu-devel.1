Received: from eggs.gnu.org ([2001:4830:134:3::10]:52077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d3i5q-0003rK-Px
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 08:00:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d3i5o-0001Mm-8U
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 08:00:18 -0400
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:35493)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d3i5o-0001MA-1x
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 08:00:16 -0400
Received: by mail-wr0-x244.google.com with SMTP id g12so3522661wrg.2
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 05:00:15 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu, 27 Apr 2017 13:59:48 +0200
Message-Id: <20170427120006.20564-2-rth@twiddle.net>
In-Reply-To: <20170427120006.20564-1-rth@twiddle.net>
References: <20170427120006.20564-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v5 01/19] target/nios2: Fix 64-bit ilp32
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
