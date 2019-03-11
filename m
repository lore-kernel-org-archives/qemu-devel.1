Received: from eggs.gnu.org ([209.51.188.92]:38270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.brankovic@rt-rk.com>) id 1h3MXR-0005P6-U6
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 11:08:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.brankovic@rt-rk.com>) id 1h3MXR-0007WS-2k
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 11:08:25 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:55615 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.brankovic@rt-rk.com>)
	id 1h3MXQ-0006lh-NN
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 11:08:25 -0400
From: Stefan Brankovic <stefan.brankovic@rt-rk.com>
Date: Mon, 11 Mar 2019 16:07:10 +0100
Message-Id: <1552316831-14098-2-git-send-email-stefan.brankovic@rt-rk.com>
In-Reply-To: <1552316831-14098-1-git-send-email-stefan.brankovic@rt-rk.com>
References: <1552316831-14098-1-git-send-email-stefan.brankovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 1/2] target/tilegx: Implement emulation of
 TILEGX instructions V1CMPLEU and V1CMPLTU
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

Implement emulation of TILEGX instruction V1CMPLEU and V1CMPLTU
using TCG front end operations.

Signed-off-by: Stefan Brankovic <stefan.brankovic@rt-rk.com>
---
 target/tilegx/translate.c | 62 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 58 insertions(+), 4 deletions(-)

diff --git a/target/tilegx/translate.c b/target/tilegx/translate.c
index f201150..396c33e 100644
--- a/target/tilegx/translate.c
+++ b/target/tilegx/translate.c
@@ -491,6 +491,56 @@ static TileExcp gen_specill(DisasContext *dc, unsigned dest, unsigned srca,
     return gen_signal(dc, signo, sigcode, mnemonic);
 }
 
+static void gen_v1cmpleu(TCGv tdest, TCGv tsrca, TCGv tsrcb)
+{
+    TCGv_64 t_sa = tcg_temp_new();
+    TCGv_64 t_sb = tcg_temp_new();
+    TCGv_64 t_d = tcg_temp_new();
+    int64_t mask = 0xffULL;
+    int64_t mask1 = 0x1ULL;
+    int i;
+
+    tcg_gen_movi_i64(tdest, 0x0ULL);
+    for (i = 0; i < 8; i++) {
+        tcg_gen_andi_i64(t_sa, tsrca, mask);
+        tcg_gen_andi_i64(t_sb, tsrcb, mask);
+        tcg_gen_setcond_i64(TCG_COND_LEU, t_d, t_sa, t_sb);
+        tcg_gen_andi_i64(t_d, t_d, mask1);
+        tcg_gen_or_i64(tdest, tdest, t_d);
+        mask = mask << 8;
+        mask1 = mask1 << 8;
+    }
+
+    tcg_temp_free(t_sa);
+    tcg_temp_free(t_sb);
+    tcg_temp_free(t_d);
+}
+
+static void gen_v1cmpltu(TCGv tdest, TCGv tsrca, TCGv tsrcb)
+{
+    TCGv_64 t_sa = tcg_temp_new();
+    TCGv_64 t_sb = tcg_temp_new();
+    TCGv_64 t_d = tcg_temp_new();
+    int64_t mask = 0xffULL;
+    int64_t mask1 = 0x1ULL;
+    int i;
+
+    tcg_gen_movi_i64(tdest, 0x0ULL);
+    for (i = 0; i < 8; i++) {
+        tcg_gen_andi_i64(t_sa, tsrca, mask);
+        tcg_gen_andi_i64(t_sb, tsrcb, mask);
+        tcg_gen_setcond_i64(TCG_COND_LTU, t_d, t_sa, t_sb);
+        tcg_gen_andi_i64(t_d, t_d, mask1);
+        tcg_gen_or_i64(tdest, tdest, t_d);
+        mask = mask << 8;
+        mask1 = mask1 << 8;
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
@@ -1247,12 +1297,8 @@ static TileExcp gen_rrr_opcode(DisasContext *dc, unsigned opext,
         break;
     case OE_RRR(V1CMPLES, 0, X0):
     case OE_RRR(V1CMPLES, 0, X1):
-    case OE_RRR(V1CMPLEU, 0, X0):
-    case OE_RRR(V1CMPLEU, 0, X1):
     case OE_RRR(V1CMPLTS, 0, X0):
     case OE_RRR(V1CMPLTS, 0, X1):
-    case OE_RRR(V1CMPLTU, 0, X0):
-    case OE_RRR(V1CMPLTU, 0, X1):
         return TILEGX_EXCP_OPCODE_UNIMPLEMENTED;
     case OE_RRR(V1CMPNE, 0, X0):
     case OE_RRR(V1CMPNE, 0, X1):
@@ -1260,6 +1306,14 @@ static TileExcp gen_rrr_opcode(DisasContext *dc, unsigned opext,
         gen_v1cmpne0(tdest);
         mnemonic = "v1cmpne";
         break;
+    case OE_RRR(V1CMPLEU, 0, X0):
+    case OE_RRR(V1CMPLEU, 0, X1):
+        gen_v1cmpleu(tdest, tsrca, tsrcb);
+        break;
+    case OE_RRR(V1CMPLTU, 0, X0):
+    case OE_RRR(V1CMPLTU, 0, X1):
+        gen_v1cmpltu(tdest, tsrca, tsrcb);
+        break;
     case OE_RRR(V1DDOTPUA, 0, X0):
     case OE_RRR(V1DDOTPUSA, 0, X0):
     case OE_RRR(V1DDOTPUS, 0, X0):
-- 
2.7.4
