Received: from eggs.gnu.org ([2001:4830:134:3::10]:54408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g8XRc-0003gq-7X
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 17:15:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1g8XRR-0000l1-6U
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 17:15:28 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:39063)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1g8XR7-0000b4-KC
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 17:15:15 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Fri,  5 Oct 2018 17:14:46 -0400
Message-Id: <20181005211450.847-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v3 0/4] per-TLB lock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

v2: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg00617.html

Changes since v2:

- Add R-b's

- Include "qemu/thread.h" from cpu-defs.h to fix the build error
  reported by Alex.

- Eliminate (on average) the performance slowdown. This is achieved by:
  + Switching from a mutex to a spinlock
  + Acquiring the lock only once in tlb_set_page_with_attrs,
    instead of acquiring/releasing it several times.
    This function is called often enough for memory-hungry
    workloads that amortizing the lock acquisition cost
    makes sense. I've added a comment about this.

- Add SPEC06int perf numbers to patch 4's commit log.

The series is checkpatch-clean. You can fetch the code from:
  https://github.com/cota/qemu/tree/tlb-lock-v3

Thanks,

		Emilio
