Received: from eggs.gnu.org ([2001:4830:134:3::10]:57931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1flEab-0000vg-Tm
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:28:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1flEaX-00034T-W0
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:28:29 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:57056 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.markovic@rt-rk.com>)
	id 1flEaX-000341-OR
	for qemu-devel@nongnu.org; Thu, 02 Aug 2018 10:28:25 -0400
From: Stefan Markovic <stefan.markovic@rt-rk.com>
Date: Thu,  2 Aug 2018 16:16:14 +0200
Message-Id: <1533219424-7627-28-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1533219424-7627-1-git-send-email-stefan.markovic@rt-rk.com>
References: <1533219424-7627-1-git-send-email-stefan.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v6 27/77] target/mips: Add emulation of
 nanoMIPS instructions MOVE.P and MOVE.PREV
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com, arikalo@wavecomp.com

From: Yongbok Kim <yongbok.kim@mips.com>

Add emulation of nanoMIPS instructions MOVE.P and MOVE.PREV.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 target/mips/translate.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index e320a4c..65af99f 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -17177,8 +17177,39 @@ static int decode_nanomips_opc(CPUMIPSState *env, DisasContext *ctx)
         }
         break;
     case NM_MOVEP:
-        break;
     case NM_MOVEPREV:
+        {
+            static const int gpr2reg1[] = {4, 5, 6, 7};
+            static const int gpr2reg2[] = {5, 6, 7, 8};
+            int re;
+            int rd2 = extract32(ctx->opcode, 3, 1) << 1 |
+                      extract32(ctx->opcode, 8, 1);
+            int r1 = gpr2reg1[rd2];
+            int r2 = gpr2reg2[rd2];
+            int r3 = extract32(ctx->opcode, 4, 1) << 3 |
+                     extract32(ctx->opcode, 0, 3);
+            int r4 = extract32(ctx->opcode, 9, 1) << 3 |
+                     extract32(ctx->opcode, 5, 3);
+            TCGv t0 = tcg_temp_new();
+            TCGv t1 = tcg_temp_new();
+            if (op == NM_MOVEP) {
+                rd = r1;
+                re = r2;
+                rs = decode_gpr_gpr4_zero(r3);
+                rt = decode_gpr_gpr4_zero(r4);
+            } else {
+                rd = decode_gpr_gpr4(r3);
+                re = decode_gpr_gpr4(r4);
+                rs = r1;
+                rt = r2;
+            }
+            gen_load_gpr(t0, rs);
+            gen_load_gpr(t1, rt);
+            tcg_gen_mov_tl(cpu_gpr[rd], t0);
+            tcg_gen_mov_tl(cpu_gpr[re], t1);
+            tcg_temp_free(t0);
+            tcg_temp_free(t1);
+        }
         break;
     default:
         return decode_nanomips_32_48_opc(env, ctx);
-- 
1.9.1
