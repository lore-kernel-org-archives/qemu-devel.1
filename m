Received: from eggs.gnu.org ([2001:4830:134:3::10]:55229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eKqNB-0001tg-1A
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 13:49:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eKqNA-0005mp-50
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 13:49:17 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Dec 2017 18:44:32 +0000
Message-Id: <1512153879-5291-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/7] armv8m: Implement TT, and other bugfixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

The main aim of this patchseries is to implement the new-for-v8M
TT/TTT/TTA/TTAT instructions (which take an address and do an
MPU/SAU lookup and tell you the security state and access
permissions for the address).

The first part of the series is some smaller bugfixes that
I noticed along the way, followed by a bit of refactoring
before finally implementing TT in the last patch.

(Notably, patch 4 splits the existing MNegPri and MSNegPri
MMU indexes into two new indexes each -- when I originally
added them I hadn't realized that "negative execution priority"
was orthogonal to "user vs privileged", rather than implying
privileged. This brings us up to 8 MMU indexes, but that
should not cost us any more than having 7, so it seems a
better approach than a more convoluted other option (which
you can find briefly described in the patch 4 commit message).

thanks
-- PMM

Peter Maydell (7):
  target/arm: Handle SPSEL and current stack being out of sync in
    MSP/PSP reads
  target/arm: Allow explicit writes to CONTROL.SPSEL in Handler mode
  target/arm: Add missing M profile case to regime_is_user()
  target/arm: Split M profile MNegPri mmu index into user and priv
  target/arm: Create new arm_v7m_mmu_idx_for_secstate_and_priv()
  target/arm: Factor MPU lookup code out of get_phys_addr_pmsav8()
  target/arm: Implement TT instruction

 target/arm/cpu.h       |  68 ++++++++-----
 target/arm/helper.h    |   2 +
 target/arm/internals.h |   6 +-
 target/arm/helper.c    | 268 +++++++++++++++++++++++++++++++++++++------------
 target/arm/translate.c |  37 ++++++-
 5 files changed, 289 insertions(+), 92 deletions(-)

-- 
2.7.4
