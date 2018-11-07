Received: from eggs.gnu.org ([2001:4830:134:3::10]:56701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gKTMv-0006yo-Tl
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 14:20:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <noring@nocrew.org>) id 1gKTMv-0005Qu-7R
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 14:20:01 -0500
Received: from ste-pvt-msa2.bahnhof.se ([213.80.101.71]:50320)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <noring@nocrew.org>) id 1gKTMu-0005QE-Vp
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 14:20:01 -0500
Date: Wed, 7 Nov 2018 20:19:45 +0100
From: Fredrik Noring <noring@nocrew.org>
Message-ID: <772fb0e8be790e1ab80569425a505890f26f1369.1541616663.git.noring@nocrew.org>
References: <cover.1541616663.git.noring@nocrew.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1541616663.git.noring@nocrew.org>
Subject: [Qemu-devel] [PATCH v2 6/6] target/mips: Guard check_insn with
 INSN_R5900 check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>, "Maciej W. Rozycki" <macro@linux-mips.org>, qemu-devel@nongnu.org

Signed-off-by: Fredrik Noring <noring@nocrew.org>
---
 target/mips/translate.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index c3ed4c21ce..007dfd2975 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -28329,8 +28329,11 @@ static void decode_opc(CPUMIPSState *env, DisasContext *ctx)
         break;
     case OPC_PREF:
         check_insn_opc_removed(ctx, ISA_MIPS32R6);
-        check_insn(ctx, ISA_MIPS4 | ISA_MIPS32 |
-                   INSN_R5900);
+        if (ctx->insn_flags & INSN_R5900) {
+            /* The R5900 implements PREF. */
+        } else {
+            check_insn(ctx, ISA_MIPS4 | ISA_MIPS32);
+        }
         /* Treat as NOP. */
         break;
 
-- 
2.18.1
