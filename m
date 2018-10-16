Received: from eggs.gnu.org ([2001:4830:134:3::10]:33833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gCLmv-0007Fu-8U
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 05:37:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gCLmu-0000ys-HM
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 05:37:17 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Oct 2018 10:37:01 +0100
Message-Id: <20181016093703.10637-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/2] target/arm: fix some ATS* bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

This small patchset fixes a couple of bugs in our ATS insn
handling:
 * for faults reported to the 64-bit PAR we were not
   setting the S and PTW bits to indicate stage 2
   fault information
   (NB: stage 2 faults aren't reported with 32-bit
   PAR formats so there's no need to change the 32-bit
   code path)
 * ATS1Hx were implementing the wrong thing (doing a
   stage 2 lookup rather than an EL2 stage 1 lookup)

The major missing bit of ATS at the moment is that a stage
2 fault during execution of an NS-EL1 ATS insn that asks
for a stage 1 lookup should cause a trap to EL2. I started
to sketch out some code to do that, but I realised by
putting an assert() in it that I didn't have any guests
that actually hit the problem, so put it on the back burner.
If anybody does hit that missing feature, feel free to send
me a test case :-)

Based-on: <20181012144235.19646-1-peter.maydell@linaro.org>
("[PATCH 00/10] target/arm: more HCR bits, improve syndrome reporting")
but only to avoid a textual conflict in the patch context.

thanks
-- PMM

Peter Maydell (2):
  target/arm: Set S and PTW in 64-bit PAR format
  target/arm: Fix ATS1Hx instructions

 target/arm/helper.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

-- 
2.19.0
