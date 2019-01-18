Received: from eggs.gnu.org ([209.51.188.92]:42854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbN-0002gH-Sk
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbJ-0007Gx-Lp
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:33 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42001)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkVbC-00077f-O5
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:26 -0500
Received: by mail-wr1-x444.google.com with SMTP id q18so15389535wrx.9
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 06:58:15 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	e27sm92094561wra.67.2019.01.18.06.58.13 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 18 Jan 2019 06:58:13 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 14:57:22 +0000
Message-Id: <20190118145805.6852-7-peter.maydell@linaro.org>
In-Reply-To: <20190118145805.6852-1-peter.maydell@linaro.org>
References: <20190118145805.6852-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 06/49] target/arm: Add SCTLR bits through ARMv8.5
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Post v8.4 bits taken from SysReg_v85_xml-00bet8.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190108223129.5570-3-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h | 45 +++++++++++++++++++++++++++++++++------------
 1 file changed, 33 insertions(+), 12 deletions(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 8b891bbc308..843d5936ead 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -991,12 +991,15 @@ void pmccntr_sync(CPUARMState *env);
 #define SCTLR_A       (1U << 1)
 #define SCTLR_C       (1U << 2)
 #define SCTLR_W       (1U << 3) /* up to v6; RAO in v7 */
-#define SCTLR_SA      (1U << 3)
+#define SCTLR_nTLSMD_32 (1U << 3) /* v8.2-LSMAOC, AArch32 only */
+#define SCTLR_SA      (1U << 3) /* AArch64 only */
 #define SCTLR_P       (1U << 4) /* up to v5; RAO in v6 and v7 */
+#define SCTLR_LSMAOE_32 (1U << 4) /* v8.2-LSMAOC, AArch32 only */
 #define SCTLR_SA0     (1U << 4) /* v8 onward, AArch64 only */
 #define SCTLR_D       (1U << 5) /* up to v5; RAO in v6 */
 #define SCTLR_CP15BEN (1U << 5) /* v7 onward */
 #define SCTLR_L       (1U << 6) /* up to v5; RAO in v6 and v7; RAZ in v8 */
+#define SCTLR_nAA     (1U << 6) /* when v8.4-LSE is implemented */
 #define SCTLR_B       (1U << 7) /* up to v6; RAZ in v7 */
 #define SCTLR_ITD     (1U << 7) /* v8 onward */
 #define SCTLR_S       (1U << 8) /* up to v6; RAZ in v7 */
@@ -1004,35 +1007,53 @@ void pmccntr_sync(CPUARMState *env);
 #define SCTLR_R       (1U << 9) /* up to v6; RAZ in v7 */
 #define SCTLR_UMA     (1U << 9) /* v8 onward, AArch64 only */
 #define SCTLR_F       (1U << 10) /* up to v6 */
-#define SCTLR_SW      (1U << 10) /* v7 onward */
-#define SCTLR_Z       (1U << 11)
+#define SCTLR_SW      (1U << 10) /* v7, RES0 in v8 */
+#define SCTLR_Z       (1U << 11) /* in v7, RES1 in v8 */
+#define SCTLR_EOS     (1U << 11) /* v8.5-ExS */
 #define SCTLR_I       (1U << 12)
-#define SCTLR_V       (1U << 13)
+#define SCTLR_V       (1U << 13) /* AArch32 only */
+#define SCTLR_EnDB    (1U << 13) /* v8.3, AArch64 only */
 #define SCTLR_RR      (1U << 14) /* up to v7 */
 #define SCTLR_DZE     (1U << 14) /* v8 onward, AArch64 only */
 #define SCTLR_L4      (1U << 15) /* up to v6; RAZ in v7 */
 #define SCTLR_UCT     (1U << 15) /* v8 onward, AArch64 only */
 #define SCTLR_DT      (1U << 16) /* up to ??, RAO in v6 and v7 */
 #define SCTLR_nTWI    (1U << 16) /* v8 onward */
-#define SCTLR_HA      (1U << 17)
+#define SCTLR_HA      (1U << 17) /* up to v7, RES0 in v8 */
 #define SCTLR_BR      (1U << 17) /* PMSA only */
 #define SCTLR_IT      (1U << 18) /* up to ??, RAO in v6 and v7 */
 #define SCTLR_nTWE    (1U << 18) /* v8 onward */
 #define SCTLR_WXN     (1U << 19)
 #define SCTLR_ST      (1U << 20) /* up to ??, RAZ in v6 */
-#define SCTLR_UWXN    (1U << 20) /* v7 onward */
-#define SCTLR_FI      (1U << 21)
-#define SCTLR_U       (1U << 22)
+#define SCTLR_UWXN    (1U << 20) /* v7 onward, AArch32 only */
+#define SCTLR_FI      (1U << 21) /* up to v7, v8 RES0 */
+#define SCTLR_IESB    (1U << 21) /* v8.2-IESB, AArch64 only */
+#define SCTLR_U       (1U << 22) /* up to v6, RAO in v7 */
+#define SCTLR_EIS     (1U << 22) /* v8.5-ExS */
 #define SCTLR_XP      (1U << 23) /* up to v6; v7 onward RAO */
+#define SCTLR_SPAN    (1U << 23) /* v8.1-PAN */
 #define SCTLR_VE      (1U << 24) /* up to v7 */
 #define SCTLR_E0E     (1U << 24) /* v8 onward, AArch64 only */
 #define SCTLR_EE      (1U << 25)
 #define SCTLR_L2      (1U << 26) /* up to v6, RAZ in v7 */
 #define SCTLR_UCI     (1U << 26) /* v8 onward, AArch64 only */
-#define SCTLR_NMFI    (1U << 27)
-#define SCTLR_TRE     (1U << 28)
-#define SCTLR_AFE     (1U << 29)
-#define SCTLR_TE      (1U << 30)
+#define SCTLR_NMFI    (1U << 27) /* up to v7, RAZ in v7VE and v8 */
+#define SCTLR_EnDA    (1U << 27) /* v8.3, AArch64 only */
+#define SCTLR_TRE     (1U << 28) /* AArch32 only */
+#define SCTLR_nTLSMD_64 (1U << 28) /* v8.2-LSMAOC, AArch64 only */
+#define SCTLR_AFE     (1U << 29) /* AArch32 only */
+#define SCTLR_LSMAOE_64 (1U << 29) /* v8.2-LSMAOC, AArch64 only */
+#define SCTLR_TE      (1U << 30) /* AArch32 only */
+#define SCTLR_EnIB    (1U << 30) /* v8.3, AArch64 only */
+#define SCTLR_EnIA    (1U << 31) /* v8.3, AArch64 only */
+#define SCTLR_BT0     (1ULL << 35) /* v8.5-BTI */
+#define SCTLR_BT1     (1ULL << 36) /* v8.5-BTI */
+#define SCTLR_ITFSB   (1ULL << 37) /* v8.5-MemTag */
+#define SCTLR_TCF0    (3ULL << 38) /* v8.5-MemTag */
+#define SCTLR_TCF     (3ULL << 40) /* v8.5-MemTag */
+#define SCTLR_ATA0    (1ULL << 42) /* v8.5-MemTag */
+#define SCTLR_ATA     (1ULL << 43) /* v8.5-MemTag */
+#define SCTLR_DSSBS   (1ULL << 44) /* v8.5 */
 
 #define CPTR_TCPAC    (1U << 31)
 #define CPTR_TTA      (1U << 20)
-- 
2.20.1
