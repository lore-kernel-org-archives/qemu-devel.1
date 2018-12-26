Received: from eggs.gnu.org ([208.118.235.92]:56972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gc72S-0007vh-TZ
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 06:07:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gc72R-0001oj-QH
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 06:07:48 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:54664 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gc72R-0001o5-F5
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 06:07:47 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 26 Dec 2018 12:06:20 +0100
Message-Id: <1545822388-10911-13-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1545822388-10911-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1545822388-10911-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v5 12/20] disas: nanoMIPS: Clean up handling of
 16-bit logic instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Clean up handling of 16-bit logic nanoMIPS instructions:

  - AND[16]
  - ANDI[16]
  - NOR[16]
  - NOT[16]
  - OR[16]
  - XOR[16]

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 disas/nanomips.cpp | 55 ++++++++++++++++++++++++------------------------------
 1 file changed, 24 insertions(+), 31 deletions(-)

diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
index 72e2266..115c347 100644
--- a/disas/nanomips.cpp
+++ b/disas/nanomips.cpp
@@ -2483,13 +2483,12 @@ std::string NMD::ALUIPC(uint64 instruction)
 
 
 /*
- * AND[16] rt3, rs3 -
+ * AND[16] rt3, rs3 - Write logical OR of registers rs3 and rt3 to register rt3
  *
  *  5432109876543210
- *  101100
+ *  010100      1000
  *    rt3 ---
  *       rs3 ---
- *           eu ----
  */
 std::string NMD::AND_16_(uint64 instruction)
 {
@@ -2499,7 +2498,7 @@ std::string NMD::AND_16_(uint64 instruction)
     std::string rt3 = GPR(encode_gpr3(rt3_value));
     std::string rs3 = GPR(encode_gpr3(rs3_value));
 
-    return img::format("AND %s, %s", rs3, rt3);
+    return img::format("AND[16] %s, %s", rs3, rt3);
 }
 
 
@@ -2528,10 +2527,10 @@ std::string NMD::AND_32_(uint64 instruction)
 
 
 /*
- * ANDI rt, rs, u -
+ * ANDI rt, rs, u - Write logical AND of register rs3 and immediate eu to rt3
  *
  *  5432109876543210
- *  101100
+ *  111100
  *    rt3 ---
  *       rs3 ---
  *           eu ----
@@ -2546,7 +2545,7 @@ std::string NMD::ANDI_16_(uint64 instruction)
     std::string rs3 = GPR(encode_gpr3(rs3_value));
     std::string eu = IMMEDIATE(encode_eu_from_u_andi16(eu_value));
 
-    return img::format("ANDI %s, %s, %s", rt3, rs3, eu);
+    return img::format("ANDI[16] %s, %s, %s", rt3, rs3, eu);
 }
 
 
@@ -11426,14 +11425,12 @@ std::string NMD::NOR(uint64 instruction)
 
 
 /*
- * ADDQH_R.W rd, rt, rs - Add Fractional Words And Shift Right to Halve Results
+ * NOT[16] rt3, rs3 - Write logical inversion of register rs3 to register rt3
  *
- *   3         2         1
- *  10987654321098765432109876543210
- *  001000               00010001101
- *     rt -----
- *          rs -----
- *               rd -----
+ *  5432109876543210
+ *  010100      0000
+ *    rt3 ---
+ *       rs3 ---
  */
 std::string NMD::NOT_16_(uint64 instruction)
 {
@@ -11443,19 +11440,17 @@ std::string NMD::NOT_16_(uint64 instruction)
     std::string rt3 = GPR(encode_gpr3(rt3_value));
     std::string rs3 = GPR(encode_gpr3(rs3_value));
 
-    return img::format("NOT %s, %s", rt3, rs3);
+    return img::format("NOT[16] %s, %s", rt3, rs3);
 }
 
 
 /*
- * ADDQH_R.W rd, rt, rs - Add Fractional Words And Shift Right to Halve Results
+ * OR[16] rs3, rt3 - Write logical OR of registers rs3 and rt3 to register rt3
  *
- *   3         2         1
- *  10987654321098765432109876543210
- *  001000               00010001101
- *     rt -----
- *          rs -----
- *               rd -----
+ *  5432109876543210
+ *  010100      1100
+ *    rt3 ---
+ *       rs3 ---
  */
 std::string NMD::OR_16_(uint64 instruction)
 {
@@ -11465,7 +11460,7 @@ std::string NMD::OR_16_(uint64 instruction)
     std::string rs3 = GPR(encode_gpr3(rs3_value));
     std::string rt3 = GPR(encode_gpr3(rt3_value));
 
-    return img::format("OR %s, %s", rs3, rt3);
+    return img::format("OR[16] %s, %s", rs3, rt3);
 }
 
 
@@ -16251,14 +16246,12 @@ std::string NMD::WRPGPR(uint64 instruction)
 
 
 /*
- * ADDQH_R.W rd, rt, rs - Add Fractional Words And Shift Right to Halve Results
+ * XOR[16] rs3, rt3 - Write logical XOR of registers rs3 and rt3 to register rt3
  *
- *   3         2         1
- *  10987654321098765432109876543210
- *  001000               00010001101
- *     rt -----
- *          rs -----
- *               rd -----
+ *  5432109876543210
+ *  010100      0100
+ *    rt3 ---
+ *       rs3 ---
  */
 std::string NMD::XOR_16_(uint64 instruction)
 {
@@ -16268,7 +16261,7 @@ std::string NMD::XOR_16_(uint64 instruction)
     std::string rs3 = GPR(encode_gpr3(rs3_value));
     std::string rt3 = GPR(encode_gpr3(rt3_value));
 
-    return img::format("XOR %s, %s", rs3, rt3);
+    return img::format("XOR[16] %s, %s", rs3, rt3);
 }
 
 
-- 
2.7.4
