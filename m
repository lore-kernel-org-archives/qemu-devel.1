Received: from eggs.gnu.org ([2001:4830:134:3::10]:60094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dORMI-0001Zr-EK
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:23:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dORMH-0007qq-Gj
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:58 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:33652)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dORMH-0007qU-DM
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:57 -0400
Received: by mail-qk0-x244.google.com with SMTP id p21so6827487qke.0
	for <qemu-devel@nongnu.org>; Fri, 23 Jun 2017 09:22:57 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Fri, 23 Jun 2017 09:22:34 -0700
Message-Id: <20170623162241.8964-9-rth@twiddle.net>
In-Reply-To: <20170623162241.8964-1-rth@twiddle.net>
References: <20170623162241.8964-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 08/15] target/s390x: Implement execution-hint
 insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

Reviewed-by: Aurelien Jarno <aurelien@aurel32.net>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/s390x/insn-data.def | 9 +++++++++
 target/s390x/translate.c   | 5 ++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
index 0555686..8e3f7db 100644
--- a/target/s390x/insn-data.def
+++ b/target/s390x/insn-data.def
@@ -134,6 +134,15 @@
     D(0x8500, BRXLE,   RSI,   Z,   0, 0, 0, 0, bx32, 0, 1)
     D(0xec44, BRXHG,   RIE_e, Z,   0, 0, 0, 0, bx64, 0, 0)
     D(0xec45, BRXHLE,  RIE_e, Z,   0, 0, 0, 0, bx64, 0, 1)
+/* BRANCH PREDICTION PRELOAD */
+    /* ??? Format is SMI, but implemented as NOP, so we need no fields.  */
+    C(0xc700, BPP,     E,     EH,  0, 0, 0, 0, 0, 0)
+/* BRANCH PREDICTION RELATIVE PRELOAD */
+    /* ??? Format is MII, but implemented as NOP, so we need no fields.  */
+    C(0xc500, BPRP,    E,     EH,  0, 0, 0, 0, 0, 0)
+/* NEXT INSTRUCTION ACCESS INTENT */
+    /* ??? Format is IE, but implemented as NOP, so we need no fields.  */
+    C(0xb2fa, NIAI,    E,     EH,  0, 0, 0, 0, 0, 0)
 
 /* CHECKSUM */
     C(0xb241, CKSM,    RRE,   Z,   r1_o, ra2, new, r1_32, cksm, 0)
diff --git a/target/s390x/translate.c b/target/s390x/translate.c
index 5275c77..06d5600 100644
--- a/target/s390x/translate.c
+++ b/target/s390x/translate.c
@@ -5443,6 +5443,7 @@ enum DisasInsnEnum {
 #define FAC_LPP         S390_FEAT_SET_PROGRAM_PARAMETERS /* load-program-parameter */
 #define FAC_DAT_ENH     S390_FEAT_DAT_ENH
 #define FAC_E2          S390_FEAT_EXTENDED_TRANSLATION_2
+#define FAC_EH          S390_FEAT_STFLE_49 /* execution-hint */
 #define FAC_LZRB        S390_FEAT_STFLE_53 /* load-and-zero-rightmost-byte */
 
 static const DisasInsn insn_info[] = {
@@ -5556,7 +5557,7 @@ static const DisasInsn *extract_insn(CPUS390XState *env, DisasContext *s,
     case 0x80: /* S */
     case 0x82: /* S */
     case 0x93: /* S */
-    case 0xb2: /* S, RRF, RRE */
+    case 0xb2: /* S, RRF, RRE, IE */
     case 0xb3: /* RRE, RRD, RRF */
     case 0xb9: /* RRE, RRF */
     case 0xe5: /* SSE, SIL */
@@ -5572,6 +5573,8 @@ static const DisasInsn *extract_insn(CPUS390XState *env, DisasContext *s,
     case 0xcc: /* RIL */
         op2 = (insn << 12) >> 60;
         break;
+    case 0xc5: /* MII */
+    case 0xc7: /* SMI */
     case 0xd0 ... 0xdf: /* SS */
     case 0xe1: /* SS */
     case 0xe2: /* SS */
-- 
2.9.4
