Received: from eggs.gnu.org ([2001:4830:134:3::10]:48640)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fgWq3-0000SV-A7
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 10:57:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fgWq2-00060Y-Fl
	for qemu-devel@nongnu.org; Fri, 20 Jul 2018 10:56:59 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Jul 2018 15:56:43 +0100
Message-Id: <20180720145647.8810-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 0/4] target/arm: Implement tailchaining for M
 profile cores
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

Tailchaining is an optimization in handling of exception return
for M-profile cores: if we are about to pop the exception stack
for an exception return, but there is a pending exception which
is higher priority than the priority we are returning to, then
instead of unstacking and then immediately taking the exception
and stacking registers again, we can chain to the pending
exception without unstacking and stacking.

For v6M and v7M it is IMPDEF whether tailchaining happens for pending
exceptions; for v8M this is architecturally required.  Implement it
in QEMU for all M-profile cores, since in practice v6M and v7M
hardware implementations generally do have it.

(We were already doing tailchaining for derived exceptions which
happened during exception return, like the validity checks and
stack access failures; these have always been required to be
tailchained for all versions of the architecture.)

The first few patches here do some minor cleanup and bug fixing
that I noticed while working on this; patch 4 is the actual
implementation, which turns out to be pretty trivial.

thanks
-- PMM

Peter Maydell (4):
  target/arm: Improve exception-taken logging
  target/arm: Initialize exc_secure correctly in do_v7m_exception_exit()
  target/arm: Restore M-profile CONTROL.SPSEL before any tailchaining
  target/arm: Implement tailchaining for M profile cores

 target/arm/helper.c | 47 ++++++++++++++++++++++++++++++++++-----------
 1 file changed, 36 insertions(+), 11 deletions(-)

-- 
2.17.1
