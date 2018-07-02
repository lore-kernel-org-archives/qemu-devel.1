Received: from eggs.gnu.org ([2001:4830:134:3::10]:58278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fa6th-0000uP-Lg
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 18:02:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1fa6tc-00062l-SK
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 18:02:13 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Mon,  2 Jul 2018 18:02:07 -0400
Message-Id: <1530568927-4738-1-git-send-email-cota@braap.org>
Subject: [Qemu-devel] [PATCH] target/ppc: set is_jmp on
 ppc_tr_breakpoint_check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-ppc@nongnu.org

The use of GDB breakpoints was broken by b0c2d52 ("target/ppc: convert
to TranslatorOps", 2018-02-16).

Fix it by setting is_jmp, so that we break from the translation loop
as originally intended.

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
(I'll send this to qemu-stable (for 2.12) once it's on master.)
---
 target/ppc/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 3a215a1..99c2731 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7314,6 +7314,7 @@ static bool ppc_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cs,
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
     gen_debug_exception(ctx);
+    dcbase->is_jmp = DISAS_NORETURN;
     /* The address covered by the breakpoint must be included in
        [tb->pc, tb->pc + tb->size) in order to for it to be
        properly cleared -- thus we increment the PC here so that
-- 
2.7.4
