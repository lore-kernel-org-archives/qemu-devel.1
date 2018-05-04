Received: from eggs.gnu.org ([2001:4830:134:3::10]:38401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fETSY-0008Vn-Jd
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:40:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fETSV-0004nw-HJ
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:40:46 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:39186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fETSV-0004nI-Cd
	for qemu-devel@nongnu.org; Fri, 04 May 2018 01:40:43 -0400
Received: by mail-pg0-x241.google.com with SMTP id e1-v6so3378237pga.6
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 22:40:43 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  3 May 2018 22:40:24 -0700
Message-Id: <20180504054030.24527-8-richard.henderson@linaro.org>
In-Reply-To: <20180504054030.24527-1-richard.henderson@linaro.org>
References: <20180504054030.24527-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 07/13] target/openrisc: Convert dec_mac
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stafford Horne <shorne@gmail.com>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/translate.c  | 55 ++++++++++++++++++--------------------------
 target/openrisc/insns.decode |  5 ++++
 2 files changed, 27 insertions(+), 33 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index 90520b0805..8ca01e1a33 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -971,39 +971,32 @@ static bool trans_l_mtspr(DisasContext *dc, arg_l_mtspr *a, uint32_t insn)
     return true;
 }
 
-static void dec_mac(DisasContext *dc, uint32_t insn)
+static bool trans_l_mac(DisasContext *dc, arg_ab *a, uint32_t insn)
 {
-    uint32_t op0;
-    uint32_t ra, rb;
-    op0 = extract32(insn, 0, 4);
-    ra = extract32(insn, 16, 5);
-    rb = extract32(insn, 11, 5);
+    LOG_DIS("l.mac r%d, r%d\n", a->a, a->b);
+    gen_mac(dc, cpu_R[a->a], cpu_R[a->b]);
+    return true;
+}
 
-    switch (op0) {
-    case 0x0001:    /* l.mac */
-        LOG_DIS("l.mac r%d, r%d\n", ra, rb);
-        gen_mac(dc, cpu_R[ra], cpu_R[rb]);
-        break;
+static bool trans_l_msb(DisasContext *dc, arg_ab *a, uint32_t insn)
+{
+    LOG_DIS("l.msb r%d, r%d\n", a->a, a->b);
+    gen_msb(dc, cpu_R[a->a], cpu_R[a->b]);
+    return true;
+}
 
-    case 0x0002:    /* l.msb */
-        LOG_DIS("l.msb r%d, r%d\n", ra, rb);
-        gen_msb(dc, cpu_R[ra], cpu_R[rb]);
-        break;
+static bool trans_l_macu(DisasContext *dc, arg_ab *a, uint32_t insn)
+{
+    LOG_DIS("l.mac r%d, r%d\n", a->a, a->b);
+    gen_macu(dc, cpu_R[a->a], cpu_R[a->b]);
+    return true;
+}
 
-    case 0x0003:    /* l.macu */
-        LOG_DIS("l.macu r%d, r%d\n", ra, rb);
-        gen_macu(dc, cpu_R[ra], cpu_R[rb]);
-        break;
-
-    case 0x0004:    /* l.msbu */
-        LOG_DIS("l.msbu r%d, r%d\n", ra, rb);
-        gen_msbu(dc, cpu_R[ra], cpu_R[rb]);
-        break;
-
-    default:
-        gen_illegal_exception(dc);
-        break;
-   }
+static bool trans_l_msbu(DisasContext *dc, arg_ab *a, uint32_t insn)
+{
+    LOG_DIS("l.msb r%d, r%d\n", a->a, a->b);
+    gen_msbu(dc, cpu_R[a->a], cpu_R[a->b]);
+    return true;
 }
 
 static void dec_logic(DisasContext *dc, uint32_t insn)
@@ -1506,10 +1499,6 @@ static void disas_openrisc_insn(DisasContext *dc, OpenRISCCPU *cpu)
         dec_compi(dc, insn);
         break;
 
-    case 0x31:
-        dec_mac(dc, insn);
-        break;
-
     case 0x32:
         dec_float(dc, insn);
         break;
diff --git a/target/openrisc/insns.decode b/target/openrisc/insns.decode
index 20f035f488..7240c6fb77 100644
--- a/target/openrisc/insns.decode
+++ b/target/openrisc/insns.decode
@@ -125,3 +125,8 @@ l_divu          111000 d:5 a:5 b:5   - 11 ---- 1010
 
 l_muld          111000 ----- a:5 b:5 - 11 ---- 0111
 l_muldu         111000 ----- a:5 b:5 - 11 ---- 1100
+
+l_mac           110001 ----- a:5 b:5 ------- 0001
+l_macu          110001 ----- a:5 b:5 ------- 0011
+l_msb           110001 ----- a:5 b:5 ------- 0010
+l_msbu          110001 ----- a:5 b:5 ------- 0100
-- 
2.14.3
