Received: from eggs.gnu.org ([2001:4830:134:3::10]:39976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faEKa-0002vV-8Z
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:58:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1faEKY-000761-5o
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 01:58:28 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue,  3 Jul 2018 15:58:02 +1000
Message-Id: <20180703055804.13449-34-david@gibson.dropbear.id.au>
In-Reply-To: <20180703055804.13449-1-david@gibson.dropbear.id.au>
References: <20180703055804.13449-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 33/35] target/ppc: set is_jmp on
 ppc_tr_breakpoint_check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, "Emilio G. Cota" <cota@braap.org>, David Gibson <david@gibson.dropbear.id.au>

From: "Emilio G. Cota" <cota@braap.org>

The use of GDB breakpoints was broken by b0c2d52 ("target/ppc: convert
to TranslatorOps", 2018-02-16).

Fix it by setting is_jmp, so that we break from the translation loop
as originally intended.

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index e120f2ed0b..65c8cc94e7 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7482,6 +7482,7 @@ static bool ppc_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cs,
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
     gen_debug_exception(ctx);
+    dcbase->is_jmp = DISAS_NORETURN;
     /* The address covered by the breakpoint must be included in
        [tb->pc, tb->pc + tb->size) in order to for it to be
        properly cleared -- thus we increment the PC here so that
-- 
2.17.1
