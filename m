Received: from eggs.gnu.org ([2001:4830:134:3::10]:35030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <steven.seeger@flightsystems.net>) id 1elhhu-0004fx-Uq
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 16:01:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <steven.seeger@flightsystems.net>) id 1elhhq-0000Ui-4v
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 16:01:43 -0500
Received: from p3plsmtpa11-08.prod.phx3.secureserver.net
	([68.178.252.109]:50150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <steven.seeger@flightsystems.net>)
	id 1elhhp-0000Tm-Uw
	for qemu-devel@nongnu.org; Tue, 13 Feb 2018 16:01:38 -0500
From: Steven Seeger <steven.seeger@flightsystems.net>
Reply-To: steven.seeger@flightsystems.net
Date: Tue, 13 Feb 2018 16:01:34 -0500
Message-ID: <7381713.AMGm5Pu749@wirbelwind>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Subject: [Qemu-devel] sparc crash on delayed control-transfer couples
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>

Consider the following code: 

0x100     cmp %g5, 3
0x104     be 0x200
0x108     b 0x300

I believe this is what is described on page 55 of the sparc v8 manual as 
unpredictable behavior, where a Bicc precedes an unconditional branch.

QEMU actually crashes unless run in GDB. Single stepping will actually have a 
successful compare of %g5==3 executing from 0x300.

Without GDB, qemu crashes with unaligned access at address 2 (JUMP_PC) on the 
fetch.

I understand that this may be "bad code" and may be "unpredictable" but I 
don't think QEMU crashing is an acceptable case. :)

I am not a SPARC expert at all (only started looking at sparc assembly 
yesterday, in fact) so I am not trying to say what the correct behavior it. It 
appears that the be should be a be,a, but is not. This may be a compiler bug 
in what was used to compile this code.

It seems that our board (real hardware) will run at 0x200 and ignore the 
branch. I am attempting to modify translate.c to do just that to see how 
things go.

If anyone else has any ideas, please chime in.

Thanks to you all for what you do.

Steven
