Received: from eggs.gnu.org ([208.118.235.92]:57100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gc72f-00085X-5V
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 06:08:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gc72c-0001vP-2r
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 06:08:01 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:54667 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gc72b-0001oB-LE
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 06:07:57 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 26 Dec 2018 12:06:21 +0100
Message-Id: <1545822388-10911-14-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1545822388-10911-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1545822388-10911-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v5 13/20] disas: nanoMIPS: Rename the decoder
 of 'gpr3' gpr encoding type
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

Rename the decoder of 'gpr3' gpr encoding type in nanoMIPS
disassembler.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 disas/nanomips.cpp | 96 +++++++++++++++++++++++++++---------------------------
 disas/nanomips.h   |  2 +-
 2 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
index 115c347..44d520a 100644
--- a/disas/nanomips.cpp
+++ b/disas/nanomips.cpp
@@ -295,7 +295,7 @@ uint64 NMD::renumber_registers(uint64 index, uint64 *register_list,
  * decode sections so they are based on the encode, the equivalent decode
  * functions need writing eventually.
  */
-uint64 NMD::encode_gpr3(uint64 d)
+uint64 NMD::decode_gpr_gpr3(uint64 d)
 {
     static uint64 register_list[] = { 16, 17, 18, 19,  4,  5,  6,  7 };
     return renumber_registers(d, register_list,
@@ -380,14 +380,14 @@ int64 NMD::neg_copy(int64 d)
 /* strange wrapper around  gpr3 */
 uint64 NMD::encode_rs3_and_check_rs3_ge_rt3(uint64 d)
 {
-return encode_gpr3(d);
+return decode_gpr_gpr3(d);
 }
 
 
 /* strange wrapper around  gpr3 */
 uint64 NMD::encode_rs3_and_check_rs3_lt_rt3(uint64 d)
 {
-    return encode_gpr3(d);
+    return decode_gpr_gpr3(d);
 }
 
 
@@ -1934,7 +1934,7 @@ std::string NMD::ADDIU_R1_SP_(uint64 instruction)
     uint64 u_value = extract_u_5_4_3_2_1_0__s2(instruction);
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
 
-    std::string rt3 = GPR(encode_gpr3(rt3_value));
+    std::string rt3 = GPR(decode_gpr_gpr3(rt3_value));
     std::string u = IMMEDIATE(copy(u_value));
 
     return img::format("ADDIU %s, $%d, %s", rt3, 29, u);
@@ -1956,8 +1956,8 @@ std::string NMD::ADDIU_R2_(uint64 instruction)
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
 
-    std::string rt3 = GPR(encode_gpr3(rt3_value));
-    std::string rs3 = GPR(encode_gpr3(rs3_value));
+    std::string rt3 = GPR(decode_gpr_gpr3(rt3_value));
+    std::string rs3 = GPR(decode_gpr_gpr3(rs3_value));
     std::string u = IMMEDIATE(copy(u_value));
 
     return img::format("ADDIU %s, %s, %s", rt3, rs3, u);
@@ -2237,9 +2237,9 @@ std::string NMD::ADDU_16_(uint64 instruction)
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
     uint64 rd3_value = extract_rd3_3_2_1(instruction);
 
-    std::string rt3 = GPR(encode_gpr3(rt3_value));
-    std::string rs3 = GPR(encode_gpr3(rs3_value));
-    std::string rd3 = GPR(encode_gpr3(rd3_value));
+    std::string rt3 = GPR(decode_gpr_gpr3(rt3_value));
+    std::string rs3 = GPR(decode_gpr_gpr3(rs3_value));
+    std::string rd3 = GPR(decode_gpr_gpr3(rd3_value));
 
     return img::format("ADDU %s, %s, %s", rd3, rs3, rt3);
 }
@@ -2495,8 +2495,8 @@ std::string NMD::AND_16_(uint64 instruction)
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
 
-    std::string rt3 = GPR(encode_gpr3(rt3_value));
-    std::string rs3 = GPR(encode_gpr3(rs3_value));
+    std::string rt3 = GPR(decode_gpr_gpr3(rt3_value));
+    std::string rs3 = GPR(decode_gpr_gpr3(rs3_value));
 
     return img::format("AND[16] %s, %s", rs3, rt3);
 }
@@ -2541,8 +2541,8 @@ std::string NMD::ANDI_16_(uint64 instruction)
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
     uint64 eu_value = extract_eu_3_2_1_0(instruction);
 
-    std::string rt3 = GPR(encode_gpr3(rt3_value));
-    std::string rs3 = GPR(encode_gpr3(rs3_value));
+    std::string rt3 = GPR(decode_gpr_gpr3(rt3_value));
+    std::string rs3 = GPR(decode_gpr_gpr3(rs3_value));
     std::string eu = IMMEDIATE(encode_eu_from_u_andi16(eu_value));
 
     return img::format("ANDI[16] %s, %s, %s", rt3, rs3, eu);
@@ -2876,7 +2876,7 @@ std::string NMD::BEQC_16_(uint64 instruction)
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
 
     std::string rs3 = GPR(encode_rs3_and_check_rs3_lt_rt3(rs3_value));
-    std::string rt3 = GPR(encode_gpr3(rt3_value));
+    std::string rt3 = GPR(decode_gpr_gpr3(rt3_value));
     std::string u = ADDRESS(encode_u_from_address(u_value), 2);
 
     return img::format("BEQC %s, %s, %s", rs3, rt3, u);
@@ -2946,7 +2946,7 @@ std::string NMD::BEQZC_16_(uint64 instruction)
     int64 s_value = extract_s__se7_0_6_5_4_3_2_1_s1(instruction);
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
 
-    std::string rt3 = GPR(encode_gpr3(rt3_value));
+    std::string rt3 = GPR(decode_gpr_gpr3(rt3_value));
     std::string s = ADDRESS(encode_s_from_address(s_value), 2);
 
     return img::format("BEQZC %s, %s", rt3, s);
@@ -3162,7 +3162,7 @@ std::string NMD::BNEC_16_(uint64 instruction)
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
 
     std::string rs3 = GPR(encode_rs3_and_check_rs3_ge_rt3(rs3_value));
-    std::string rt3 = GPR(encode_gpr3(rt3_value));
+    std::string rt3 = GPR(decode_gpr_gpr3(rt3_value));
     std::string u = ADDRESS(encode_u_from_address(u_value), 2);
 
     return img::format("BNEC %s, %s, %s", rs3, rt3, u);
@@ -3232,7 +3232,7 @@ std::string NMD::BNEZC_16_(uint64 instruction)
     int64 s_value = extract_s__se7_0_6_5_4_3_2_1_s1(instruction);
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
 
-    std::string rt3 = GPR(encode_gpr3(rt3_value));
+    std::string rt3 = GPR(decode_gpr_gpr3(rt3_value));
     std::string s = ADDRESS(encode_s_from_address(s_value), 2);
 
     return img::format("BNEZC %s, %s", rt3, s);
@@ -7782,9 +7782,9 @@ std::string NMD::LB_16_(uint64 instruction)
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
     uint64 u_value = extract_u_1_0(instruction);
 
-    std::string rt3 = GPR(encode_gpr3(rt3_value));
+    std::string rt3 = GPR(decode_gpr_gpr3(rt3_value));
     std::string u = IMMEDIATE(copy(u_value));
-    std::string rs3 = GPR(encode_gpr3(rs3_value));
+    std::string rs3 = GPR(decode_gpr_gpr3(rs3_value));
 
     return img::format("LB %s, %s(%s)", rt3, u, rs3);
 }
@@ -7900,9 +7900,9 @@ std::string NMD::LBU_16_(uint64 instruction)
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
     uint64 u_value = extract_u_1_0(instruction);
 
-    std::string rt3 = GPR(encode_gpr3(rt3_value));
+    std::string rt3 = GPR(decode_gpr_gpr3(rt3_value));
     std::string u = IMMEDIATE(copy(u_value));
-    std::string rs3 = GPR(encode_gpr3(rs3_value));
+    std::string rs3 = GPR(decode_gpr_gpr3(rs3_value));
 
     return img::format("LBU %s, %s(%s)", rt3, u, rs3);
 }
@@ -8374,9 +8374,9 @@ std::string NMD::LH_16_(uint64 instruction)
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
     uint64 u_value = extract_u_2_1__s1(instruction);
 
-    std::string rt3 = GPR(encode_gpr3(rt3_value));
+    std::string rt3 = GPR(decode_gpr_gpr3(rt3_value));
     std::string u = IMMEDIATE(copy(u_value));
-    std::string rs3 = GPR(encode_gpr3(rs3_value));
+    std::string rs3 = GPR(decode_gpr_gpr3(rs3_value));
 
     return img::format("LH %s, %s(%s)", rt3, u, rs3);
 }
@@ -8492,9 +8492,9 @@ std::string NMD::LHU_16_(uint64 instruction)
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
     uint64 u_value = extract_u_2_1__s1(instruction);
 
-    std::string rt3 = GPR(encode_gpr3(rt3_value));
+    std::string rt3 = GPR(decode_gpr_gpr3(rt3_value));
     std::string u = IMMEDIATE(copy(u_value));
-    std::string rs3 = GPR(encode_gpr3(rs3_value));
+    std::string rs3 = GPR(decode_gpr_gpr3(rs3_value));
 
     return img::format("LHU %s, %s(%s)", rt3, u, rs3);
 }
@@ -8705,7 +8705,7 @@ std::string NMD::LI_16_(uint64 instruction)
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
     uint64 eu_value = extract_eu_6_5_4_3_2_1_0(instruction);
 
-    std::string rt3 = GPR(encode_gpr3(rt3_value));
+    std::string rt3 = GPR(decode_gpr_gpr3(rt3_value));
     std::string eu = IMMEDIATE(encode_eu_from_s_li16(eu_value));
 
     return img::format("LI %s, %s", rt3, eu);
@@ -8942,9 +8942,9 @@ std::string NMD::LW_16_(uint64 instruction)
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
     uint64 u_value = extract_u_3_2_1_0__s2(instruction);
 
-    std::string rt3 = GPR(encode_gpr3(rt3_value));
+    std::string rt3 = GPR(decode_gpr_gpr3(rt3_value));
     std::string u = IMMEDIATE(copy(u_value));
-    std::string rs3 = GPR(encode_gpr3(rs3_value));
+    std::string rs3 = GPR(decode_gpr_gpr3(rs3_value));
 
     return img::format("LW %s, %s(%s)", rt3, u, rs3);
 }
@@ -9011,7 +9011,7 @@ std::string NMD::LW_GP16_(uint64 instruction)
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
     uint64 u_value = extract_u_6_5_4_3_2_1_0__s2(instruction);
 
-    std::string rt3 = GPR(encode_gpr3(rt3_value));
+    std::string rt3 = GPR(decode_gpr_gpr3(rt3_value));
     std::string u = IMMEDIATE(copy(u_value));
 
     return img::format("LW %s, %s($%d)", rt3, u, 28);
@@ -9460,9 +9460,9 @@ std::string NMD::LWXS_16_(uint64 instruction)
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
     uint64 rd3_value = extract_rd3_3_2_1(instruction);
 
-    std::string rd3 = GPR(encode_gpr3(rd3_value));
-    std::string rs3 = GPR(encode_gpr3(rs3_value));
-    std::string rt3 = IMMEDIATE(encode_gpr3(rt3_value));
+    std::string rd3 = GPR(decode_gpr_gpr3(rd3_value));
+    std::string rs3 = GPR(decode_gpr_gpr3(rs3_value));
+    std::string rt3 = IMMEDIATE(decode_gpr_gpr3(rt3_value));
 
     return img::format("LWXS %s, %s(%s)", rd3, rs3, rt3);
 }
@@ -11437,8 +11437,8 @@ std::string NMD::NOT_16_(uint64 instruction)
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
 
-    std::string rt3 = GPR(encode_gpr3(rt3_value));
-    std::string rs3 = GPR(encode_gpr3(rs3_value));
+    std::string rt3 = GPR(decode_gpr_gpr3(rt3_value));
+    std::string rs3 = GPR(decode_gpr_gpr3(rs3_value));
 
     return img::format("NOT[16] %s, %s", rt3, rs3);
 }
@@ -11457,8 +11457,8 @@ std::string NMD::OR_16_(uint64 instruction)
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
 
-    std::string rs3 = GPR(encode_gpr3(rs3_value));
-    std::string rt3 = GPR(encode_gpr3(rt3_value));
+    std::string rs3 = GPR(decode_gpr_gpr3(rs3_value));
+    std::string rt3 = GPR(decode_gpr_gpr3(rt3_value));
 
     return img::format("OR[16] %s, %s", rs3, rt3);
 }
@@ -12736,7 +12736,7 @@ std::string NMD::SB_16_(uint64 instruction)
 
     std::string rtz3 = GPR(encode_gpr3_store(rtz3_value));
     std::string u = IMMEDIATE(copy(u_value));
-    std::string rs3 = GPR(encode_gpr3(rs3_value));
+    std::string rs3 = GPR(decode_gpr_gpr3(rs3_value));
 
     return img::format("SB %s, %s(%s)", rtz3, u, rs3);
 }
@@ -13582,7 +13582,7 @@ std::string NMD::SH_16_(uint64 instruction)
 
     std::string rtz3 = GPR(encode_gpr3_store(rtz3_value));
     std::string u = IMMEDIATE(copy(u_value));
-    std::string rs3 = GPR(encode_gpr3(rs3_value));
+    std::string rs3 = GPR(decode_gpr_gpr3(rs3_value));
 
     return img::format("SH %s, %s(%s)", rtz3, u, rs3);
 }
@@ -14338,8 +14338,8 @@ std::string NMD::SLL_16_(uint64 instruction)
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
     uint64 shift3_value = extract_shift3_2_1_0(instruction);
 
-    std::string rt3 = GPR(encode_gpr3(rt3_value));
-    std::string rs3 = GPR(encode_gpr3(rs3_value));
+    std::string rt3 = GPR(decode_gpr_gpr3(rt3_value));
+    std::string rs3 = GPR(decode_gpr_gpr3(rs3_value));
     std::string shift3 = IMMEDIATE(encode_shift3_from_shift(shift3_value));
 
     return img::format("SLL %s, %s, %s", rt3, rs3, shift3);
@@ -14642,8 +14642,8 @@ std::string NMD::SRL_16_(uint64 instruction)
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
     uint64 shift3_value = extract_shift3_2_1_0(instruction);
 
-    std::string rt3 = GPR(encode_gpr3(rt3_value));
-    std::string rs3 = GPR(encode_gpr3(rs3_value));
+    std::string rt3 = GPR(decode_gpr_gpr3(rt3_value));
+    std::string rs3 = GPR(decode_gpr_gpr3(rs3_value));
     std::string shift3 = IMMEDIATE(encode_shift3_from_shift(shift3_value));
 
     return img::format("SRL %s, %s, %s", rt3, rs3, shift3);
@@ -14960,9 +14960,9 @@ std::string NMD::SUBU_16_(uint64 instruction)
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
     uint64 rd3_value = extract_rd3_3_2_1(instruction);
 
-    std::string rd3 = GPR(encode_gpr3(rd3_value));
-    std::string rs3 = GPR(encode_gpr3(rs3_value));
-    std::string rt3 = GPR(encode_gpr3(rt3_value));
+    std::string rd3 = GPR(decode_gpr_gpr3(rd3_value));
+    std::string rs3 = GPR(decode_gpr_gpr3(rs3_value));
+    std::string rt3 = GPR(decode_gpr_gpr3(rt3_value));
 
     return img::format("SUBU %s, %s, %s", rd3, rs3, rt3);
 }
@@ -15156,7 +15156,7 @@ std::string NMD::SW_16_(uint64 instruction)
 
     std::string rtz3 = GPR(encode_gpr3_store(rtz3_value));
     std::string u = IMMEDIATE(copy(u_value));
-    std::string rs3 = GPR(encode_gpr3(rs3_value));
+    std::string rs3 = GPR(decode_gpr_gpr3(rs3_value));
 
     return img::format("SW %s, %s(%s)", rtz3, u, rs3);
 }
@@ -16258,8 +16258,8 @@ std::string NMD::XOR_16_(uint64 instruction)
     uint64 rt3_value = extract_rt3_9_8_7(instruction);
     uint64 rs3_value = extract_rs3_6_5_4(instruction);
 
-    std::string rs3 = GPR(encode_gpr3(rs3_value));
-    std::string rt3 = GPR(encode_gpr3(rt3_value));
+    std::string rs3 = GPR(decode_gpr_gpr3(rs3_value));
+    std::string rt3 = GPR(decode_gpr_gpr3(rt3_value));
 
     return img::format("XOR[16] %s, %s", rs3, rt3);
 }
diff --git a/disas/nanomips.h b/disas/nanomips.h
index f1ecab9..ec750cc 100644
--- a/disas/nanomips.h
+++ b/disas/nanomips.h
@@ -105,7 +105,7 @@ private:
 
     uint64 renumber_registers(uint64 index, uint64 *register_list,
                               size_t register_list_size);
-    uint64 encode_gpr3(uint64 d);
+    uint64 decode_gpr_gpr3(uint64 d);
     uint64 encode_gpr3_store(uint64 d);
     uint64 encode_rd1_from_rd(uint64 d);
     uint64 encode_gpr4_zero(uint64 d);
-- 
2.7.4
