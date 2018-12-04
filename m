Received: from eggs.gnu.org ([2001:4830:134:3::10]:58174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gUAmE-0007sM-L4
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:30:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gUAmC-0001BN-OY
	for qemu-devel@nongnu.org; Tue, 04 Dec 2018 08:30:14 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  4 Dec 2018 13:29:47 +0000
Message-Id: <20181204132952.2601-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 0/5] arm: five simple memory leak fixes
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

I ran 'make check' with the clang sanitizers enabled, which
it turns out these days includes LeakSanitizer. That points
out a fair number of memory leaks, most of which are not
terribly significant. This patchset fixes five of them (there
are plenty more to do).

The "device does timer_new() in its instance_init function"
leak seems to be a common one with multiple other devices
showing up as having the same problem. Switching timer_init()
is probably a nicer fix than just moving timer_new() to realize,
but I wasn't sure if going from VMSTATE_TIMER_PTR to
VMSTATE_TIMER would be a migration compat break.

thanks
-- PMM

Peter Maydell (5):
  target/arm: Free name string in ARMCPRegInfo hashtable entries
  hw/arm/mps2-tz.c: Free mscname string in make_dma()
  hw/sd/sdhci: Don't leak memory region in sdhci_sysbus_realize()
  tests/test-arm-mptimer: Don't leak string memory
  target/arm: Create timers in realize, not init

 hw/arm/mps2-tz.c         |   1 +
 hw/sd/sdhci.c            |   5 +-
 target/arm/cpu.c         |  33 ++++++---
 tests/test-arm-mptimer.c | 153 ++++++++++++++++++---------------------
 4 files changed, 95 insertions(+), 97 deletions(-)

-- 
2.19.2
