Received: from eggs.gnu.org ([2001:4830:134:3::10]:57159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fveF9-0006nz-OL
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 03:53:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fveF9-0003Qv-0P
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 03:53:23 -0400
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Fri, 31 Aug 2018 00:53:09 -0700
Message-Id: <20180831075309.22454-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH] target/xtensa: fix FPU2000 bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>, qemu-stable@nongnu.org

- FPU2000 defines rfr and wfr opcodes, not rfr.s and wfr.s;
- movcond.s uses incorrect operand in tcg_gen_movcond: in case the
  condition is not satisfied it must not change its argument 0.

Fixes: c04e1692e3aa ("target/xtensa: extract FPU2000 opcode
translators")
Cc: qemu-stable@nongnu.org
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/translate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index d22cdcdb1634..25399058a0db 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -4706,7 +4706,7 @@ static void translate_movcond_s(DisasContext *dc, const uint32_t arg[],
 
         tcg_gen_movcond_i32(par[0], cpu_FR[arg[0]],
                             cpu_R[arg[2]], zero,
-                            cpu_FR[arg[1]], cpu_FR[arg[2]]);
+                            cpu_FR[arg[1]], cpu_FR[arg[0]]);
         tcg_temp_free(zero);
     }
 }
@@ -4867,7 +4867,7 @@ static const XtensaOpcodeOps fpu2000_ops[] = {
         .translate = translate_compare_s,
         .par = (const uint32_t[]){COMPARE_OLT},
     }, {
-        .name = "rfr.s",
+        .name = "rfr",
         .translate = translate_rfr_s,
     }, {
         .name = "round.s",
@@ -4921,7 +4921,7 @@ static const XtensaOpcodeOps fpu2000_ops[] = {
         .translate = translate_ftoi_s,
         .par = (const uint32_t[]){float_round_to_zero, true},
     }, {
-        .name = "wfr.s",
+        .name = "wfr",
         .translate = translate_wfr_s,
     },
 };
-- 
2.11.0
