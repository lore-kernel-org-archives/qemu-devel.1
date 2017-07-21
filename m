Received: from eggs.gnu.org ([2001:4830:134:3::10]:39990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dYNoj-0003sX-WA
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 22:37:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dYNog-0007S1-U6
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 22:37:26 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:56925)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1dYNog-0007R7-N9
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 22:37:22 -0400
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Fri, 21 Jul 2017 03:37:02 +0100
Message-ID: <1500604635-15027-2-git-send-email-yongbok.kim@imgtec.com>
In-Reply-To: <1500604635-15027-1-git-send-email-yongbok.kim@imgtec.com>
References: <1500604635-15027-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PULL 01/14] target/mips: Fix MIPS64 MFC0 UserLocal on
 BE host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, James Hogan <james.hogan@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>, Petar Jovanovic <petar.jovanovic@imgtec.com>

From: James Hogan <james.hogan@imgtec.com>

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
Reviewed-by: Yongbok Kim <yongbok.kim@imgtec.com>
Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
---
 target/mips/translate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index 1fd18e9..db6e5b5 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -5144,8 +5144,9 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
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
2.7.4
