Received: from eggs.gnu.org ([209.51.188.92]:34160)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9eN-0004Pl-Uf
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hL9eI-0006VI-GK
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:04 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36483)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hL9eE-0006Bn-GO
	for qemu-devel@nongnu.org; Mon, 29 Apr 2019 13:01:00 -0400
Received: by mail-wr1-x442.google.com with SMTP id o4so5177805wra.3
	for <qemu-devel@nongnu.org>; Mon, 29 Apr 2019 10:00:42 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id a13sm36896wmj.39.2019.04.29.10.00.40
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 29 Apr 2019 10:00:41 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Apr 2019 17:59:55 +0100
Message-Id: <20190429170030.11323-8-peter.maydell@linaro.org>
In-Reply-To: <20190429170030.11323-1-peter.maydell@linaro.org>
References: <20190429170030.11323-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/42] target/arm: Disable most VFP sysregs for
 M-profile
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The only "system register" that M-profile floating point exposes
via the VMRS/VMRS instructions is FPSCR, and it does not have
the odd special case for rd==15. Add a check to ensure we only
expose FPSCR.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190416125744.27770-5-peter.maydell@linaro.org
---
 target/arm/translate.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 4ea4018e2b8..a9784535069 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3513,12 +3513,27 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                     }
                 }
             } else { /* !dp */
+                bool is_sysreg;
+
                 if ((insn & 0x6f) != 0x00)
                     return 1;
                 rn = VFP_SREG_N(insn);
+
+                is_sysreg = extract32(insn, 21, 1);
+
+                if (arm_dc_feature(s, ARM_FEATURE_M)) {
+                    /*
+                     * The only M-profile VFP vmrs/vmsr sysreg is FPSCR.
+                     * Writes to R15 are UNPREDICTABLE; we choose to undef.
+                     */
+                    if (is_sysreg && (rd == 15 || (rn >> 1) != ARM_VFP_FPSCR)) {
+                        return 1;
+                    }
+                }
+
                 if (insn & ARM_CP_RW_BIT) {
                     /* vfp->arm */
-                    if (insn & (1 << 21)) {
+                    if (is_sysreg) {
                         /* system register */
                         rn >>= 1;
 
@@ -3585,7 +3600,7 @@ static int disas_vfp_insn(DisasContext *s, uint32_t insn)
                     }
                 } else {
                     /* arm->vfp */
-                    if (insn & (1 << 21)) {
+                    if (is_sysreg) {
                         rn >>= 1;
                         /* system register */
                         switch (rn) {
-- 
2.20.1
