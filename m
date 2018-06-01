Received: from eggs.gnu.org ([2001:4830:134:3::10]:48656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fOlTb-00067P-9c
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 10:56:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fOlTa-0006Sw-KN
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 10:56:23 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Jun 2018 15:43:26 +0100
Message-Id: <20180601144328.23817-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/2] armv7m: Remove armv7m_init() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Julia Suvorova <jusual@mail.ru>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <mail@steffen-goertz.de>

The armv7m_init() function is a legacy from before we properly QOMified
ARMv7M, and it has some flaws:
    
 * it combines work that needs to be done by an SoC object (creating
   and initializing the TYPE_ARMV7M object) with work that needs to
   be done by the board model (setting the system up to load the ELF
   file specified with -kernel)
 * TYPE_ARMV7M creation failure is fatal, but an SoC object wants to
   arrange to propagate the failure outward
 * it uses allocate-and-create via qdev_create() whereas the current
   preferred style for SoC objects is to do creation in-place

This patchset fixes the only current caller (the stellaris board)
to not use it, and then removes the function.
    
New board and SoC models should do the two jobs this function
was doing themselves, in the right places and with whatever their
preferred style/error handling is.

(I've cc'd the people working on the nRF51 SoC model, as a heads-up
that they'll need to update their code so it compiles once this
hits master.)

thanks
-- PMM

Peter Maydell (2):
  stellaris: Stop using armv7m_init()
  hw/arm/armv7m: Remove unused armv7m_init() function

 include/hw/arm/arm.h |  8 ++------
 hw/arm/armv7m.c      | 21 ---------------------
 hw/arm/stellaris.c   | 12 ++++++++++--
 3 files changed, 12 insertions(+), 29 deletions(-)

-- 
2.17.1
