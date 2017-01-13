Received: from eggs.gnu.org ([2001:4830:134:3::10]:53405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cRvMY-0006Y1-92
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 01:29:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1cRvMX-00025t-Fn
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 01:29:22 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri, 13 Jan 2017 17:28:21 +1100
Message-Id: <1484288903-18807-16-git-send-email-sjitindarsingh@gmail.com>
In-Reply-To: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
References: <1484288903-18807-1-git-send-email-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [RFC PATCH 15/17] tcg/POWER9: NOOP the cp_abort
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: david@gibson.dropbear.id.au, agraf@suse.de, qemu-devel@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The cp_abort instruction is used to remove the state of an in progress
copy paste sequence. POWER9 compilers add this in various places, such
as context switches which causes illegal instruction signals since we
don't yet implement this instruction.

Given there is no implementation of the copy paste facility and that we
don't claim to support it, we can just noop this instruction.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 target/ppc/translate.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 5d63254..7527bd2 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6166,6 +6166,10 @@ GEN_TM_NOOP(tabortwci);
 GEN_TM_NOOP(tabortdc);
 GEN_TM_NOOP(tabortdci);
 GEN_TM_NOOP(tsr);
+static inline void gen_cp_abort(DisasContext *ctx)
+{
+    // Do Nothing
+}
 
 static void gen_tcheck(DisasContext *ctx)
 {
@@ -6255,6 +6259,7 @@ GEN_HANDLER2(andi_, "andi.", 0x1C, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 GEN_HANDLER2(andis_, "andis.", 0x1D, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
 GEN_HANDLER(cntlzw, 0x1F, 0x1A, 0x00, 0x00000000, PPC_INTEGER),
 GEN_HANDLER_E(cnttzw, 0x1F, 0x1A, 0x10, 0x00000000, PPC_NONE, PPC2_ISA300),
+GEN_HANDLER_E(cp_abort, 0x1F, 0x06, 0x1A, 0x03FFF801, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER(or, 0x1F, 0x1C, 0x0D, 0x00000000, PPC_INTEGER),
 GEN_HANDLER(xor, 0x1F, 0x1C, 0x09, 0x00000000, PPC_INTEGER),
 GEN_HANDLER(ori, 0x18, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
-- 
2.5.5
