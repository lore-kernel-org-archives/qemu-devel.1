Received: from eggs.gnu.org ([209.51.188.92]:51319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1hC2Du-00053N-Py
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 09:16:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1hC2Dp-0004eM-U9
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 09:16:06 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:40225 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mateja.marjanovic@rt-rk.com>)
	id 1hC2Dp-0003GT-IY
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 09:16:01 -0400
From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Date: Thu,  4 Apr 2019 15:14:46 +0200
Message-Id: <1554383690-28338-1-git-send-email-mateja.marjanovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v6 0/4] target/mips: Optimize MSA interleave
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, philmd@redhat.com, richard.henderson@linaro.org, amarkovic@wavecomp.com, arikalo@wavecomp.com

From: Mateja Marjanovic <Mateja.Marjanovic@rt-rk.com>

Optimize MSA instructions ILVEV.<B|H|W|D>, ILVOD.<B|H|W|D>,
ILVL.<B|H|W|D> and ILVR.<B|H|W|D> using the hybrid approach,
MSA helpers in some cases and directly tcg registers in other
cases, so the performance would be better.

v6:
 - Add ILVL.<B|H|W|D> and ILVR.<B|H|W|D> MSA instructions
   with mixed approaches (with helpers and with tcg
   registers).
 - Test the performance for ILVL.<B|H|W|D> and
   ILVR.<B|H|W|D> MSA instructions, with helpers,
   with tcg and with the mixed approach.
 - Use a tcg register instead of an int variable for
   storing a constant value of the mask (for logic
   operations).
 - Eliminate some unnecessary tcg_gen calls.
 - Changes in commit messages and the cover letter.

v5:
 - Use tcg_gen_deposit function.
 - Added performance number for no-deposit and
   with-deposit cases of ILVEV.W.
 - Minor changes in commit messages and the cover letter.

v4:
 - Clean up typing errors.
 - Change the commit message and the cover letter.
 - Fix bug for ILVEV.D, in case where the destination
   and one of the sources are the same register.

v3:
 - Reduce the number of logic operations to a
   minimum.
 - Add comments.

v2:
 - Minor changes in commit messages and the cover letter.

Mateja Marjanovic (4):
  target/mips: Optimize ILVOD.<B|H|W|D> MSA instructions
  target/mips: Optimize ILVEV.<B|H|W|D> MSA instructions
  target/mips: Optimize ILVL.<B|H|W|D> MSA instructions
  target/mips: Optimize ILVR.<B|H|W|D> MSA instructions

 target/mips/helper.h     |   7 +-
 target/mips/msa_helper.c |  82 +++++---
 target/mips/translate.c  | 498 ++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 547 insertions(+), 40 deletions(-)

-- 
2.7.4
