Received: from eggs.gnu.org ([208.118.235.92]:56955)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gc72S-0007v0-5i
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 06:07:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gc72Q-0001nW-Bj
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 06:07:48 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:54633 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gc72Q-0001n2-0k
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 06:07:46 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed, 26 Dec 2018 12:06:19 +0100
Message-Id: <1545822388-10911-12-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1545822388-10911-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1545822388-10911-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v5 11/20] disas: nanoMIPS: Clean up handling of
 48-bit instructions
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

Clean up handling of 48-bit nanoMIPS instructions:

  - ADDIU[48]
  - ADDIU[GP48]
  - ADDIUPC[48]
  - LI[48]
  - LWPC[48]
  - SWPC[48]

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 disas/nanomips.cpp | 70 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 36 insertions(+), 34 deletions(-)

diff --git a/disas/nanomips.cpp b/disas/nanomips.cpp
index e7f6975..72e2266 100644
--- a/disas/nanomips.cpp
+++ b/disas/nanomips.cpp
@@ -1812,13 +1812,14 @@ std::string NMD::ADDIU_32_(uint64 instruction)
 
 
 /*
+ * ADDIU[48] rt, imm - Add Immediate (Untrapped) (rs = rt)
  *
- *
- *   3         2         1
- *  10987654321098765432109876543210
- *  001000          0010000100111111
+ *         4         3         2         1
+ *  765432109876543210987654321098765432109876543210
+ *  011000     00001
  *     rt -----
- *          rs -----
+ *          s[15:0] ----------------
+ *                         s[31:16] ----------------
  */
 std::string NMD::ADDIU_48_(uint64 instruction)
 {
@@ -1833,13 +1834,14 @@ std::string NMD::ADDIU_48_(uint64 instruction)
 
 
 /*
+ * ADDIU[GP48] rt, imm - Add Immediate (Untrapped) (rs = 28)
  *
- *
- *   3         2         1
- *  10987654321098765432109876543210
- *  001000          0010000100111111
+ *         4         3         2         1
+ *  765432109876543210987654321098765432109876543210
+ *  011000     00010
  *     rt -----
- *          rs -----
+ *          s[15:0] ----------------
+ *                         s[31:16] ----------------
  */
 std::string NMD::ADDIU_GP48_(uint64 instruction)
 {
@@ -2005,14 +2007,14 @@ std::string NMD::ADDIUPC_32_(uint64 instruction)
 
 
 /*
+ * ADDIUPC[48] rt, imm - Add Immediate (Untrapped) to PC
  *
- *
- *   3         2         1
- *  10987654321098765432109876543210
- *  001000               x1110000101
+ *         4         3         2         1
+ *  765432109876543210987654321098765432109876543210
+ *  011000     00011
  *     rt -----
- *          rs -----
- *               rd -----
+ *          s[15:0] ----------------
+ *                         s[31:16] ----------------
  */
 std::string NMD::ADDIUPC_48_(uint64 instruction)
 {
@@ -8712,14 +8714,14 @@ std::string NMD::LI_16_(uint64 instruction)
 
 
 /*
+ * LI[48] rt, s - Load Immediate
  *
- *
- *   3         2         1
- *  10987654321098765432109876543210
- *  001000               x1110000101
+ *         4         3         2         1
+ *  765432109876543210987654321098765432109876543210
+ *  011000     00000
  *     rt -----
- *          rs -----
- *               rd -----
+ *          s[15:0] ----------------
+ *                         s[31:16] ----------------
  */
 std::string NMD::LI_48_(uint64 instruction)
 {
@@ -9280,14 +9282,14 @@ std::string NMD::LWM(uint64 instruction)
 
 
 /*
+ * LWPC[48] rt, address - Load Word PC relative
  *
- *
- *   3         2         1
- *  10987654321098765432109876543210
- *  001000               x1110000101
+ *         4         3         2         1
+ *  765432109876543210987654321098765432109876543210
+ *  011000     01011
  *     rt -----
- *          rs -----
- *               rd -----
+ *          s[15:0] ----------------
+ *                         s[31:16] ----------------
  */
 std::string NMD::LWPC_48_(uint64 instruction)
 {
@@ -15496,14 +15498,14 @@ std::string NMD::SWM(uint64 instruction)
 
 
 /*
- * ADDQH_R.W rd, rt, rs - Add Fractional Words And Shift Right to Halve Results
+ * SWPC[48] rt, address - Load Word PC relative
  *
- *   3         2         1
- *  10987654321098765432109876543210
- *  001000               00010001101
+ *         4         3         2         1
+ *  765432109876543210987654321098765432109876543210
+ *  011000     01111
  *     rt -----
- *          rs -----
- *               rd -----
+ *          s[15:0] ----------------
+ *                         s[31:16] ----------------
  */
 std::string NMD::SWPC_48_(uint64 instruction)
 {
-- 
2.7.4
