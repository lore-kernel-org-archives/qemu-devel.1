Received: from eggs.gnu.org ([2001:4830:134:3::10]:37911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cfstj-00033b-1d
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 13:41:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cfsti-0000Ce-9T
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 13:41:19 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Feb 2017 18:41:08 +0000
Message-Id: <1487616072-9226-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/4] arm: Fix M profile MSR/MRS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Michael Davidsaver <mdavidsaver@gmail.com>

This patchseries fixes up some deficiencies and one nasty
bug in the M profile MSR/MRS handling.

The first three patches are just cleaning up the decode
so that we UNDEF where we should in the MRS/MSR space
for M profile -- this won't have caused any problems in
practice since real world code doesn't generally execute
UNDEFfing instructions on purpose.

The fourth patch fixes a nasty bug that I introduced in
commit 58117c9bb429cd which broke APSR writes via MSR,
and brings them into line with the pseudocode by allowing
writes to the APSR GE[3:0] bits when the CPU implements
the DSP extensions.

Alex -- I should have paid closer attention to your review
comments on the patch that became commit 58117c9bb429cd;
sorry about that. I knew we didn't get the GE[3:0] stuff
right yet but I didn't spot that we'd managed to invert
the sense of the SYSm bit 2 test in that patch :-(

thanks
-- PMM

Peter Maydell (4):
  arm: HVC and SMC encodings don't exist for M profile
  arm: Don't decode MRS(banked) or MSR(banked) for M profile
  arm: Enforce should-be-1 bits in MRS decoding
  arm: Fix APSR writes via M profile MSR

 target/arm/helper.c    | 26 ++++++++++++++++++++++----
 target/arm/translate.c | 26 +++++++++++++++++++++++---
 2 files changed, 45 insertions(+), 7 deletions(-)

-- 
2.7.4
