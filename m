Received: from eggs.gnu.org ([209.51.188.92]:38268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.brankovic@rt-rk.com>) id 1h3MXR-0005Oz-RU
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 11:08:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.brankovic@rt-rk.com>) id 1h3MXQ-0007WF-Sv
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 11:08:25 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:55665 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.brankovic@rt-rk.com>)
	id 1h3MXQ-0006lj-HC
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 11:08:24 -0400
From: Stefan Brankovic <stefan.brankovic@rt-rk.com>
Date: Mon, 11 Mar 2019 16:07:11 +0100
Message-Id: <1552316831-14098-3-git-send-email-stefan.brankovic@rt-rk.com>
In-Reply-To: <1552316831-14098-1-git-send-email-stefan.brankovic@rt-rk.com>
References: <1552316831-14098-1-git-send-email-stefan.brankovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 2/2] target/tilegx: Implement emulation of
 TILEGX instructions V2CMPLEU and V2CMPLTU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org, laurent@vivier.eu, cota@braap.org

Implement emulation of TILEGX instruction V2CMPLEU and V2CMPLTU
using TCG front end operations.

Signed-off-by: Stefan Brankovic <stefan.brankovic@rt-rk.com>
---
 target/tilegx/translate.c | 62 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 58 insertions(+), 4 deletions(-)

diff --git a/target/tilegx/translate.c b/target/tilegx/translate.c
index 396c33e..6e0dc44 100644
--- a/target/tilegx/translate.c
+++ b/target/tilegx/translate.c
@@ -541,6 +541,56 @@ static void gen_v1cmpltu(TCGv tdest, TCGv tsrca, TCGv tsrcb)
     tcg_temp_free(t_d);
 }
 
+static void gen_v2cmpleu(TCGv tdest, TCGv tsrca, TCGv tsrcb)
+{
+    TCGv_64 t_sa = tcg_temp_new();
+    TCGv_64 t_sb = tcg_temp_new();
+    TCGv_64 t_d = tcg_temp_new();
+    int64_t mask = 0xffffULL;
+    int64_t mask1 = 0x1ULL;
+    int i;
+
+    tcg_gen_movi_i64(tdest, 0x0ULL);
+    for (i = 0; i < 4; i++) {
+        tcg_gen_andi_i64(t_sa, tsrca, mask);
+        tcg_gen_andi_i64(t_sb, tsrcb, mask);
+        tcg_gen_setcond_i64(TCG_COND_LEU, t_d, t_sa, t_sb);
+        tcg_gen_andi_i64(t_d, t_d, mask1);
+        tcg_gen_or_i64(tdest, tdest, t_d);
+        mask = mask << 16;
+        mask1 = mask1 << 16;
+    }
+
+    tcg_temp_free(t_sa);
+    tcg_temp_free(t_sb);
+    tcg_temp_free(t_d);
+}
+
+static void gen_v2cmpltu(TCGv tdest, TCGv tsrca, TCGv tsrcb)
+{
+    TCGv_64 t_sa = tcg_temp_new();
+    TCGv_64 t_sb = tcg_temp_new();
+    TCGv_64 t_d = tcg_temp_new();
+    int64_t mask = 0xffffULL;
+    int64_t mask1 = 0x1ULL;
+    int i;
+
+    tcg_gen_movi_i64(tdest, 0x0ULL);
+    for (i = 0; i < 4; i++) {
+        tcg_gen_andi_i64(t_sa, tsrca, mask);
+        tcg_gen_andi_i64(t_sb, tsrcb, mask);
+        tcg_gen_setcond_i64(TCG_COND_LTU, t_d, t_sa, t_sb);
+        tcg_gen_andi_i64(t_d, t_d, mask1);
+        tcg_gen_or_i64(tdest, tdest, t_d);
+        mask = mask << 16;
+        mask1 = mask1 << 16;
+    }
+
+    tcg_temp_free(t_sa);
+    tcg_temp_free(t_sb);
+    tcg_temp_free(t_d);
+}
+
 static TileExcp gen_rr_opcode(DisasContext *dc, unsigned opext,
                               unsigned dest, unsigned srca, uint64_t bundle)
 {
@@ -1390,17 +1440,21 @@ static TileExcp gen_rrr_opcode(DisasContext *dc, unsigned opext,
     case OE_RRR(V2CMPEQ, 0, X1):
     case OE_RRR(V2CMPLES, 0, X0):
     case OE_RRR(V2CMPLES, 0, X1):
-    case OE_RRR(V2CMPLEU, 0, X0):
-    case OE_RRR(V2CMPLEU, 0, X1):
     case OE_RRR(V2CMPLTS, 0, X0):
     case OE_RRR(V2CMPLTS, 0, X1):
-    case OE_RRR(V2CMPLTU, 0, X0):
-    case OE_RRR(V2CMPLTU, 0, X1):
     case OE_RRR(V2CMPNE, 0, X0):
     case OE_RRR(V2CMPNE, 0, X1):
     case OE_RRR(V2DOTPA, 0, X0):
     case OE_RRR(V2DOTP, 0, X0):
         return TILEGX_EXCP_OPCODE_UNIMPLEMENTED;
+    case OE_RRR(V2CMPLEU, 0, X0):
+    case OE_RRR(V2CMPLEU, 0, X1):
+        gen_v2cmpleu(tdest, tsrca, tsrcb);
+        break;
+    case OE_RRR(V2CMPLTU, 0, X0):
+    case OE_RRR(V2CMPLTU, 0, X1):
+        gen_v2cmpltu(tdest, tsrca, tsrcb);
+        break;
     case OE_RRR(V2INT_H, 0, X0):
     case OE_RRR(V2INT_H, 0, X1):
         gen_helper_v2int_h(tdest, tsrca, tsrcb);
-- 
2.7.4
