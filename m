Received: from eggs.gnu.org ([2001:4830:134:3::10]:32947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eyHW8-0003A5-PD
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 09:41:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eyHW2-000425-QY
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 09:41:32 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Mar 2018 13:41:10 +0000
Message-Id: <20180320134114.30418-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-2.12 0/4] Fix various BRK/BKPT related bugs
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

The main aim of this patchset is to fix the bug reported in
https://bugs.launchpad.net/qemu/+bug/1756927 where we don't
report the correct FSR when a BKPT instruction causes us to
take an exception to AArch32 with LPAE enabled. The other
patches fix some minor bugs found along the way:

 * we weren't honouring MDCR_EL2.TDE when delivering an
   exception caused by a BRK or BKPT insn, so we'd always
   send it to EL1 even if it should have gone to EL2
 * our logic to decide whether to report a short-format or
   long-format LPAE for hardware breakpoint and watchpoint
   exceptions would get it wrong in some corner cases: we could
   select the short format because we're at EL0 and the EL1
   translation regime is not using LPAE, but then route the
   debug exception to EL2 because of MDCR_EL2.TDE and hand
   EL2 the wrong format FSR.
 * when taking a debug exception in AArch32, we would set the
   guest visible IFAR to whatever old value was lying around
   in env->exception.vaddress. IFAR in this situation is
   architecturally UNKNOWN, but letting it be possibly set
   to an old value that the guest shouldn't be able to see
   at its current security/exception level is not permitted,
   and setting it to a non-deterministic value is bad for
   record-and-replay.

(This patchset further reduces the set of places that are
calling the somewhat dubious extended_addresses_enabled()
function. The last callsite is in the CONTEXTIDR write
function, and that should probably be updated something along
the lines of the ideas I wrote in this email last year:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg491671.html
but that is a cleanup for another day.)

thanks
-- PMM

Peter Maydell (4):
  target/arm: Honour MDCR_EL2.TDE when routing exceptions due to
    BKPT/BRK
  target/arm: Factor out code to calculate FSR for debug exceptions
  target/arm: Set FSR for BKPT, BRK when raising exception
  target/arm: Always set FAR to a known unknown value for debug
    exceptions

 target/arm/helper.h        |  1 +
 target/arm/internals.h     | 25 +++++++++++++++++++++++++
 target/arm/helper.c        |  1 -
 target/arm/op_helper.c     | 33 ++++++++++++++++++++++-----------
 target/arm/translate-a64.c | 15 +++++++++++++--
 target/arm/translate.c     | 19 ++++++++++++++-----
 6 files changed, 75 insertions(+), 19 deletions(-)

-- 
2.16.2
