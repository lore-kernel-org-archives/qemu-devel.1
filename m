Received: from eggs.gnu.org ([2001:4830:134:3::10]:53250)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLzHf-0003Jh-7r
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 18:36:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLzHc-0007Ho-MQ
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 18:36:51 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38601)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLzHc-0007EL-9Q
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 18:36:48 -0500
Received: by mail-wr1-x443.google.com with SMTP id e3-v6so7396487wrs.5
	for <qemu-devel@nongnu.org>; Sun, 11 Nov 2018 15:36:44 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 12 Nov 2018 00:36:20 +0100
Message-Id: <20181111233622.8976-10-f4bug@amsat.org>
In-Reply-To: <20181111233622.8976-1-f4bug@amsat.org>
References: <20181111233622.8976-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 09/11] target/mips: Port SYNCI to decodetree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Peer Adelt <peer.adelt@hni.uni-paderborn.de>, Richard Henderson <rth@twiddle.net>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 target/mips/insns.decode    | 8 ++++++++
 target/mips/translate.c     | 6 ------
 target/mips/translate.inc.c | 7 +++++++
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/target/mips/insns.decode b/target/mips/insns.decode
index 7fbf21cbb9..8a1a7acf3a 100644
--- a/target/mips/insns.decode
+++ b/target/mips/insns.decode
@@ -1,2 +1,10 @@
 # MIPS32/MIPS64 Instruction Set
 #
+# From:
+# - MIPS32 Architecture For Programmers Volume II-A (Document Number: MD00086)
+
+####
+# System Instructions
+####
+
+synci           000001 ----- 11111 ----------------          >insn=ISA_MIPS32R2
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 560325c563..760cca8262 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -27948,12 +27948,6 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
             check_insn(ctx, ISA_MIPS32R6);
             generate_exception_end(ctx, EXCP_RI);
             break;
-        case OPC_SYNCI:
-            check_insn(ctx, ISA_MIPS32R2);
-            /* Break the TB to be able to sync copied instructions
-               immediately */
-            ctx->base.is_jmp = DISAS_STOP;
-            break;
         case OPC_BPOSGE32:    /* MIPS DSP branch */
 #if defined(TARGET_MIPS64)
         case OPC_BPOSGE64:
diff --git a/target/mips/translate.inc.c b/target/mips/translate.inc.c
index 69fe78ac89..f3dcd32f98 100644
--- a/target/mips/translate.inc.c
+++ b/target/mips/translate.inc.c
@@ -11,3 +11,10 @@
 
 /* Include the auto-generated decoder.  */
 #include "decode.inc.c"
+
+static bool trans_synci(DisasContext *dc, arg_synci *a)
+{
+    /* Break the TB to be able to sync copied instructions immediately */
+    dc->base.is_jmp = DISAS_STOP;
+    return true;
+}
-- 
2.17.2
