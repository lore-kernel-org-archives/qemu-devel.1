Received: from eggs.gnu.org ([2001:4830:134:3::10]:34785)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dIjoI-0002gW-7d
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 18:52:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bobby.prani@gmail.com>) id 1dIjoF-0000hk-QS
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 18:52:18 -0400
Received: from mail-yw0-x241.google.com ([2607:f8b0:4002:c05::241]:33361)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bobby.prani@gmail.com>)
	id 1dIjoF-0000hZ-M1
	for qemu-devel@nongnu.org; Wed, 07 Jun 2017 18:52:15 -0400
Received: by mail-yw0-x241.google.com with SMTP id y64so1307631ywe.0
	for <qemu-devel@nongnu.org>; Wed, 07 Jun 2017 15:52:15 -0700 (PDT)
From: Pranith Kumar <bobby.prani@gmail.com>
Date: Wed,  7 Jun 2017 18:52:11 -0400
Message-Id: <20170607225212.23714-3-bobby.prani@gmail.com>
In-Reply-To: <20170607225212.23714-1-bobby.prani@gmail.com>
References: <20170607225212.23714-1-bobby.prani@gmail.com>
Subject: [Qemu-devel] [RFC PATCH 2/3] tcg/aarch64: Introdue LDR (literal)
 for aarch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: alex.bennee@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net

Signed-off-by: Pranith Kumar <bobby.prani@gmail.com>
---
 tcg/aarch64/tcg-target.inc.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tcg/aarch64/tcg-target.inc.c b/tcg/aarch64/tcg-target.inc.c
index ab0a8caa03..e488aacadb 100644
--- a/tcg/aarch64/tcg-target.inc.c
+++ b/tcg/aarch64/tcg-target.inc.c
@@ -269,6 +269,8 @@ typedef enum {
     I3207_BLR       = 0xd63f0000,
     I3207_RET       = 0xd65f0000,
 
+    /* Load literal for loading the address at pc-relative offset */
+    I3305_LDR       = 0x58000000,
     /* Load/store register.  Described here as 3.3.12, but the helper
        that emits them can transform to 3.3.10 or 3.3.13.  */
     I3312_STRB      = 0x38000000 | LDST_ST << 22 | MO_8 << 30,
@@ -388,6 +390,11 @@ static inline uint32_t tcg_in32(TCGContext *s)
 #define tcg_out_insn(S, FMT, OP, ...) \
     glue(tcg_out_insn_,FMT)(S, glue(glue(glue(I,FMT),_),OP), ## __VA_ARGS__)
 
+static void tcg_out_insn_3305(TCGContext *s, AArch64Insn insn, int imm19, TCGReg rt)
+{
+    tcg_out32(s, insn | (imm19 & 0x7ffff) << 5 | rt);
+}
+
 static void tcg_out_insn_3201(TCGContext *s, AArch64Insn insn, TCGType ext,
                               TCGReg rt, int imm19)
 {
-- 
2.13.0
