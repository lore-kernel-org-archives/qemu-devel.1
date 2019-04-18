Received: from eggs.gnu.org ([209.51.188.92]:53535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1hH5SY-00037B-On
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:44:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mateja.marjanovic@rt-rk.com>) id 1hH5SV-0006Q5-Fw
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:44:04 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:45428 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mateja.marjanovic@rt-rk.com>)
	id 1hH5ST-0004tC-2e
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 07:44:01 -0400
From: Mateja Marjanovic <mateja.marjanovic@rt-rk.com>
Date: Thu, 18 Apr 2019 13:42:40 +0200
Message-Id: <1555587766-985-1-git-send-email-mateja.marjanovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v8 0/6] target/mips: Optimize MSA interleave
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

Optimize and refactor MSA instructions ILVEV.<B|H|W|D>,
ILVOD.<B|H|W|D>, ILVL.<B|H|W|D> and ILVR.<B|H|W|D>.

v8:
 - Rebased onto current master branch.
 - Inserted Reviewed-by in the applicable commit message.

v7:
 - Use tcg constants, instead of uint64_t constants in
   ILVEV.<B|H> and ILVOD.<B|H> instructions.
 - Refactor gen_ilvod_b and gen_ilvod_h functions. Use
   the shared function gen_ilvod_bh, which has two extra
   arguments mask and shift, because mask and shift are
   the only differences in the implementation of those
   two functions.
   Same applies for gen_ilvev_b and gen_ilvev_h.
 - Use assigning uint64_t constant values to the bit mask,
   instead of shifting the bit mask, in ILVR.<H|W> and
   ILVL.<H|W> instructions.
 - Use only one helper for ILVEV.D and ILVR.D instructions,
   because they are equivalent. 
   Same applies for ILVOD.D and ILVL.D.
 - Minor changes in the commit messages.

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

Mateja Marjanovic (6):
  target/mips: Optimize ILVOD.<B|H|W|D> MSA instructions
  target/mips: Optimize ILVEV.<B|H|W|D> MSA instructions
  target/mips: Optimize ILVL.<B|H|W|D> MSA instructions
  target/mips: Optimize ILVR.<B|H|W|D> MSA instructions
  target/mips: Merge implementation of ILVEV.D and ILVR.D
  target/mips: Merge implementation of ILVOD.D and ILVL.D

 target/mips/helper.h     |   7 +-
 target/mips/msa_helper.c |  82 +++++++----
 target/mips/translate.c  | 376 ++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 425 insertions(+), 40 deletions(-)

-- 
2.7.4
