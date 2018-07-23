Received: from eggs.gnu.org ([2001:4830:134:3::10]:43657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhLP-0004ah-Gu
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:22:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhLO-0005ku-EB
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:22:11 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:17:45 -0500
Message-Id: <20180723201748.25573-97-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 96/99] target/ppc: set is_jmp on
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
Cc: qemu-stable@nongnu.org, "Emilio G. Cota" <cota@braap.org>, David Gibson <david@gibson.dropbear.id.au>

From: "Emilio G. Cota" <cota@braap.org>

The use of GDB breakpoints was broken by b0c2d52 ("target/ppc: convert
to TranslatorOps", 2018-02-16).

Fix it by setting is_jmp, so that we break from the translation loop
as originally intended.

Tested-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
(cherry picked from commit 2a8ceefca23bc2aaafe711f8afd7585be3c27064)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 target/ppc/translate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 3457d29f8e..c535cd76f2 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -7296,6 +7296,7 @@ static bool ppc_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cs,
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
 
     gen_debug_exception(ctx);
+    dcbase->is_jmp = DISAS_NORETURN;
     /* The address covered by the breakpoint must be included in
        [tb->pc, tb->pc + tb->size) in order to for it to be
        properly cleared -- thus we increment the PC here so that
-- 
2.17.1
