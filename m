Received: from eggs.gnu.org ([208.118.235.92]:38532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gf6UL-0004n8-9S
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:09:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gf6UJ-0007zW-6u
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:08:57 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:46257 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gf6UI-0007eq-TD
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 12:08:55 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu,  3 Jan 2019 18:08:04 +0100
Message-Id: <1546535297-11040-32-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1546535297-11040-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1546535297-11040-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v3 31/44] disas: nanoMIPS: Rename the decoder of
 'gpr4.zero' gpr encoding type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Rename the decoder of 'gpr4.zero' gpr encoding type in nanoMIPS
disassembler.

Reviewed-by: Aleksandar Rikalo <arikalo@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 disas/nanomips.cpp | 10 +++++-----
 disas/nanomips.h   |  2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
index a086f65..66b1223 100644
--- a/disas/nanomips.cpp
+++ b/disas/nanomips.cpp
@@ -397,7 +397,7 @@ uint64 NMD::encode_rd1_from_rd(uint64 d)
 }
 
 
-uint64 NMD::encode_gpr4_zero(uint64 d)
+uint64 NMD::decode_gpr_gpr4_zero(uint64 d)
 {
     static uint64 register_list[] = {  8,  9, 10,  0,  4,  5,  6,  7,
                                       16, 17, 18, 19, 20, 21, 22, 23 };
@@ -10395,7 +10395,7 @@ std::string NMD::MOVE_BALC(uint64 instruction)
     int64 s_value = extract_s__se21_0_20_to_1_s1(instruction);
 
     std::string rd1 = GPR(encode_rd1_from_rd(rd1_value));
-    std::string rtz4 = GPR(encode_gpr4_zero(rtz4_value));
+    std::string rtz4 = GPR(decode_gpr_gpr4_zero(rtz4_value));
     std::string s = ADDRESS(encode_s_from_address(s_value), 4);
 
     return img::format("MOVE.BALC %s, %s, %s", rd1, rtz4, s);
@@ -10421,8 +10421,8 @@ std::string NMD::MOVEP(uint64 instruction)
     std::string rd2 = GPR(encode_rd2_reg1(rd2_value));
     std::string re2 = GPR(encode_rd2_reg2(rd2_value));
     /* !!!!!!!!!! - no conversion function */
-    std::string rsz4 = GPR(encode_gpr4_zero(rsz4_value));
-    std::string rtz4 = GPR(encode_gpr4_zero(rtz4_value));
+    std::string rsz4 = GPR(decode_gpr_gpr4_zero(rsz4_value));
+    std::string rtz4 = GPR(decode_gpr_gpr4_zero(rtz4_value));
 
     return img::format("MOVEP %s, %s, %s, %s", rd2, re2, rsz4, rtz4);
     /* hand edited */
@@ -15288,7 +15288,7 @@ std::string NMD::SW_4X4_(uint64 instruction)
     uint64 rs4_value = extract_rs4_4_2_1_0(instruction);
     uint64 u_value = extract_u_3_8__s2(instruction);
 
-    std::string rtz4 = GPR(encode_gpr4_zero(rtz4_value));
+    std::string rtz4 = GPR(decode_gpr_gpr4_zero(rtz4_value));
     std::string u = IMMEDIATE(copy(u_value));
     std::string rs4 = GPR(decode_gpr_gpr4(rs4_value));
 
diff --git a/disas/nanomips.h b/disas/nanomips.h
index 109b131..c1d3a3b 100644
--- a/disas/nanomips.h
+++ b/disas/nanomips.h
@@ -108,7 +108,7 @@ private:
     uint64 decode_gpr_gpr3(uint64 d);
     uint64 decode_gpr_gpr3_src_store(uint64 d);
     uint64 encode_rd1_from_rd(uint64 d);
-    uint64 encode_gpr4_zero(uint64 d);
+    uint64 decode_gpr_gpr4_zero(uint64 d);
     uint64 decode_gpr_gpr4(uint64 d);
     uint64 encode_rd2_reg1(uint64 d);
     uint64 encode_rd2_reg2(uint64 d);
-- 
2.7.4
