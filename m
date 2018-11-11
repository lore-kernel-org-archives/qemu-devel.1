Received: from eggs.gnu.org ([2001:4830:134:3::10]:53246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLzHf-0003Jg-7j
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 18:36:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLzHc-0007Hg-Ld
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 18:36:51 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35491)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gLzHc-0007Fh-9p
	for qemu-devel@nongnu.org; Sun, 11 Nov 2018 18:36:48 -0500
Received: by mail-wr1-x442.google.com with SMTP id z16-v6so7399044wrv.2
	for <qemu-devel@nongnu.org>; Sun, 11 Nov 2018 15:36:46 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 12 Nov 2018 00:36:22 +0100
Message-Id: <20181111233622.8976-12-f4bug@amsat.org>
In-Reply-To: <20181111233622.8976-1-f4bug@amsat.org>
References: <20181111233622.8976-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 11/11] target/mips: Port MIPS64 DCL[Z/O] to
 decodetree
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
 target/mips/insns.decode    | 12 ++++++++++++
 target/mips/translate.inc.c | 12 ++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/target/mips/insns.decode b/target/mips/insns.decode
index 8a1a7acf3a..e256220211 100644
--- a/target/mips/insns.decode
+++ b/target/mips/insns.decode
@@ -2,9 +2,21 @@
 #
 # From:
 # - MIPS32 Architecture For Programmers Volume II-A (Document Number: MD00086)
+# - MIPS64 Architecture For Programmers Volume II-A (Document Number: MD00087)
+
+&rs_rt_rd       rs rt rd
+
+@rs_rt_rd       ...... rs:5  rt:5  rd:5  00000 ......   &rs_rt_rd
 
 ####
 # System Instructions
 ####
 
 synci           000001 ----- 11111 ----------------          >insn=ISA_MIPS32R2
+
+####
+# Special2 Instructions
+####
+
+dclz            011100 ..... ..... ..... ..... 100100   @rs_rt_rd   ?ctx->insn_flags&ISA_MIPS64
+dclo            011100 ..... ..... ..... ..... 100101   @rs_rt_rd   ?ctx->insn_flags&ISA_MIPS64
diff --git a/target/mips/translate.inc.c b/target/mips/translate.inc.c
index f3dcd32f98..90fe868605 100644
--- a/target/mips/translate.inc.c
+++ b/target/mips/translate.inc.c
@@ -18,3 +18,15 @@ static bool trans_synci(DisasContext *dc, arg_synci *a)
     dc->base.is_jmp = DISAS_STOP;
     return true;
 }
+
+static bool trans_dclz(DisasContext *ctx, arg_rs_rt_rd *a)
+{
+    gen_cl(ctx, OPC_DCLZ, a->rd, a->rs);
+    return true;
+}
+
+static bool trans_dclo(DisasContext *ctx, arg_rs_rt_rd *a)
+{
+    gen_cl(ctx, OPC_DCLO, a->rd, a->rs);
+    return true;
+}
-- 
2.17.2
