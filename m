Received: from eggs.gnu.org ([2001:4830:134:3::10]:32964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <steven.seeger@flightsystems.net>) id 1elhdj-000149-0q
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 15:57:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <steven.seeger@flightsystems.net>) id 1elhdg-0004uP-0B
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 15:57:23 -0500
Received: from p3plsmtpa06-06.prod.phx3.secureserver.net
	([173.201.192.107]:45889)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <steven.seeger@flightsystems.net>)
	id 1elhdf-0004so-Qe
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 15:57:19 -0500
From: Steven Seeger <steven.seeger@flightsystems.net>
Reply-To: steven.seeger@flightsystems.net
Date: Tue, 13 Feb 2018 15:57:14 -0500
Message-ID: <4476423.I6xtnU8gSc@wirbelwind>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: [Qemu-devel] sparc branch to pc+4 issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

Consider pc==0x100:

0x100   b 0x104

The uncondtional not-annulled branch will go to 0x104, which is the next 
instruction anyway. do_branch() will leave dc->pc and dc->npc both set to 
0x104. This causes gdb to have a problem when single stepping. It will be 
stuck. QEMU will execute past this somehow, but I'm not sure with what side 
effect. It seems to me the following patch will fix this:

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 71e0853e43..95ca90b51a 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -1464,6 +1464,7 @@ static void do_branch(DisasContext *dc, int32_t offset, 
uint32_t insn, int cc)
             dc->npc = dc->pc + 4;
         } else {
             dc->pc = dc->npc;
+            if(target==dc->pc) target += 4;
             dc->npc = target;
             tcg_gen_mov_tl(cpu_pc, cpu_npc);
         }

I apologize if I am missing something with this assessment.

Steven
