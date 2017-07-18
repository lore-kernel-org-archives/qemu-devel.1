Received: from eggs.gnu.org ([2001:4830:134:3::10]:46804)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dXR7F-0003qo-4f
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:56:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dXR7D-0005AE-Fp
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:56:37 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:4475)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <James.Hogan@imgtec.com>) id 1dXR7D-0005A3-AF
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 07:56:35 -0400
From: James Hogan <james.hogan@imgtec.com>
Date: Tue, 18 Jul 2017 12:55:46 +0100
Message-ID: <ffb745754ddd4f389935cfb2ad4b6f3e560a2655.1500378931.git-series.james.hogan@imgtec.com>
In-Reply-To: <cover.34f8428dbbcaa0611cef759667d281ae508ac91d.1500378931.git-series.james.hogan@imgtec.com>
References: <cover.34f8428dbbcaa0611cef759667d281ae508ac91d.1500378931.git-series.james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 1/14] target/mips: Fix MIPS64 MFC0 UserLocal on
 BE host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: qemu-devel@nongnu.org, James Hogan <james.hogan@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>, Petar Jovanovic <petar.jovanovic@imgtec.com>

Using MFC0 to read CP0_UserLocal uses tcg_gen_ld32s_tl, however
CP0_UserLocal is a target_ulong. On a big endian host with a MIPS64
target this reads and sign extends the more significant half of the
64-bit register.

Fix this by using ld_tl to load the whole target_ulong and ext32s_tl to
sign extend it, as done for various other target_ulong COP0 registers.

Fixes: d279279e2b5c ("target-mips: implement UserLocal Register")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Petar Jovanovic <petar.jovanovic@imgtec.com>
---
Changes in v2:
- New patch.
---
 target/mips/translate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 3022f349cb2a..556aba969a12 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -5138,8 +5138,9 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
             goto cp0_unimplemented;
         case 2:
             CP0_CHECK(ctx->ulri);
-            tcg_gen_ld32s_tl(arg, cpu_env,
-                             offsetof(CPUMIPSState, active_tc.CP0_UserLocal));
+            tcg_gen_ld_tl(arg, cpu_env,
+                          offsetof(CPUMIPSState, active_tc.CP0_UserLocal));
+            tcg_gen_ext32s_tl(arg, arg);
             rn = "UserLocal";
             break;
         default:
-- 
git-series 0.8.10
