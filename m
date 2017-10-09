Received: from eggs.gnu.org ([2001:4830:134:3::10]:43383)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e1YQL-0001GL-Pj
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 09:48:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1e1YQL-00044r-0u
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 09:48:49 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  9 Oct 2017 14:48:30 +0100
Message-Id: <1507556919-24992-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/9] v8M: BLXNS, SG, secure function return
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, patches@linaro.org

This patchset is mostly implementation of SG, BLXNS and secure
function return. Parts of it were in the previous patchset,
but had a bug which I've fixed in the SG implementation where
we read the first half of the insn twice by mistake.

Patch 1 is a new trivial bugfix.
Patches 2-4 were in the previous set; only 2 has changed.
Patches 5-8 perform some refactoring so that we can correctly
implement the behaviour of a handful of Thumb instructions
which must be unconditional even when they appear inside
an IT block: SG, HLT and BKPT.
Patch 9 implements the final edge cases of the SG insn.

The refactoring has the nice property that we don't have to
pass the CPU env pointer into the bulk of the thumb decode
functions any more. I suspect it also might fix bugs in
setting breakpoints on instructions inside IT blocks, though
we haven't had any complaints about that so perhaps gdb
works around it by setting breakpoints on both the cc pass
and cc fail next instructions in an IT block...

Peter Maydell (9):
  target/arm: Add M profile secure MMU index values to
    get_a32_user_mem_index()
  target/arm: Implement SG instruction
  target/arm: Implement BLXNS
  target/arm: Implement secure function return
  target-arm: Don't check for "Thumb2 or M profile" for not-Thumb1
  target/arm: Pull Thumb insn word loads up to top level
  target-arm: Simplify insn_crosses_page()
  target/arm: Support some Thumb insns being always unconditional
  target/arm: Implement SG instruction corner cases

 target/arm/helper.h    |   1 +
 target/arm/internals.h |   8 ++
 target/arm/helper.c    | 306 +++++++++++++++++++++++++++++++++++++++++++++---
 target/arm/translate.c | 310 +++++++++++++++++++++++++++++++++----------------
 4 files changed, 515 insertions(+), 110 deletions(-)

-- 
2.7.4
