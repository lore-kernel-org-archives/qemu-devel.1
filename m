Received: from eggs.gnu.org ([209.51.188.92]:34199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1h3Qb0-000408-5O
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:28:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <svens@stackframe.org>) id 1h3QPI-0007WL-6B
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:16:17 -0400
Received: from smtp.duncanthrax.net ([2001:470:70c5:1111::170]:56175)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <svens@stackframe.org>)
	id 1h3QPH-0007SX-L5
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 15:16:16 -0400
From: Sven Schnelle <svens@stackframe.org>
Date: Mon, 11 Mar 2019 20:15:52 +0100
Message-Id: <20190311191602.25796-2-svens@stackframe.org>
In-Reply-To: <20190311191602.25796-1-svens@stackframe.org>
References: <20190311191602.25796-1-svens@stackframe.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 01/11] target/hppa: fix overwriting source reg
 in addb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Sven Schnelle <svens@stackframe.org>, Richard Henderson <rth@twiddle.net>

When one of the source registers is the same as the destination register,
the source register gets overwritten with the destionation value before
do_add_sv() is called, which leads to unexpection condition matches.

Signed-off-by: Sven Schnelle <svens@stackframe.org>
---
 target/hppa/translate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index dc5636fe94..7001c2eb80 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -3033,7 +3033,7 @@ static bool do_addb(DisasContext *ctx, unsigned r, TCGv_reg in1,
     DisasCond cond;
 
     in2 = load_gpr(ctx, r);
-    dest = dest_gpr(ctx, r);
+    dest = tcg_temp_new();
     sv = NULL;
     cb_msb = NULL;
 
@@ -3049,6 +3049,8 @@ static bool do_addb(DisasContext *ctx, unsigned r, TCGv_reg in1,
     }
 
     cond = do_cond(c * 2 + f, dest, cb_msb, sv);
+    save_gpr(ctx, r, dest);
+    tcg_temp_free(dest);
     return do_cbranch(ctx, disp, n, &cond);
 }
 
-- 
2.20.1
