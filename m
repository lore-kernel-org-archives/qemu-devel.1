Received: from eggs.gnu.org ([2001:4830:134:3::10]:43562)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gXrU3-0006BC-8h
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 12:42:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gXrTy-0000j4-JW
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 12:42:43 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:57165)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gXrTy-0000hL-1I
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 12:42:38 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri, 14 Dec 2018 12:42:30 -0500
Message-Id: <20181214174233.18027-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v5 0/3] Dynamic TLB sizing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

v4: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg02679.html

Changes since v4:

- Rebase on v3.1.0. Quite a few conflicts, but the resulting diffs
  are simpler than in v4.

- Re-run benchmarks on a different Skylake machine (this one is
  a server with a lower clock frequency).

- Add comment on the resizing policy and mechanism.

- Change the downsizing policy. Instead of not downsizing until
  a certain number of consecutive low use rates, keep track of
  the max use rate in a given time window (100ms), and
  downsize according to that max. This makes the policy resistant
  to guests that flush *very* quickly and often (I was not happy
  about just waiting until a certain number of flushes, since
  we cannot know what that number should be for all guests).
  The new policy has the shortcoming that since we check the
  time on the host, if the host is overcommitted we might downsize
  too aggressively. So the policy isn't perfect, but the gains
  are big enough that we might want to merge this as a start.
  Here's v4 vs. v5:
    https://imgur.com/jkcFkdv
  v4 is a little better for mcf, but v5 is better for xalancbmk,
  and the average speedup is almost the same (1.48x vs. 1.51x,
  respectively).

You can fetch this series from:
  https://github.com/cota/qemu/tree/tlb-dyn-v5

Thanks,

		Emilio
---
 accel/tcg/cputlb.c        | 186 ++++++++++++++++++++++++++++++++++++++++++++--
 include/exec/cpu-all.h    |   9 +++
 include/exec/cpu-defs.h   |  48 +++++++++++-
 include/exec/cpu_ldst.h   |  21 ++++++
 tcg/aarch64/tcg-target.h  |   1 +
 tcg/arm/tcg-target.h      |   1 +
 tcg/i386/tcg-target.h     |   1 +
 tcg/i386/tcg-target.inc.c |  28 +++----
 tcg/mips/tcg-target.h     |   1 +
 tcg/ppc/tcg-target.h      |   1 +
 tcg/s390/tcg-target.h     |   1 +
 tcg/sparc/tcg-target.h    |   1 +
 tcg/tci/tcg-target.h      |   1 +
 13 files changed, 278 insertions(+), 22 deletions(-)
