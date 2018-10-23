Received: from eggs.gnu.org ([2001:4830:134:3::10]:59417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEqm3-0008Ne-Tf
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 03:06:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gEqie-0003uh-F8
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 03:03:17 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:52518)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gEqie-0003g6-0H
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 03:03:12 -0400
Received: by mail-wm1-x333.google.com with SMTP id 189-v6so532958wmw.2
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 00:02:58 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 23 Oct 2018 08:02:42 +0100
Message-Id: <20181023070253.6407-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 00/10] cputlb: track dirty tlbs and general
 cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: cota@braap.org

The motivation here is reducing the total overhead.

Before a few patches went into target-arm.next, I measured total
tlb flush overhead for aarch64 at 25%.  This appears to reduce the
total overhead to about 5% (I do need to re-run the control tests,
not just watch perf top as I'm doing now).

The final patch is somewhat of an RFC.  I'd like to know what
benchmark was used when putting in pending_tlb_flushes, and I
have not done any archaeology to find out.  I suspect that it
does make any measurable difference beyond tlb_c.dirty, and I
think the code is a bit cleaner without it.


r~


Richard Henderson (10):
  cputlb: Move tlb_lock to CPUTLBCommon
  cputlb: Remove tcg_enabled hack from tlb_flush_nocheck
  cputlb: Move cpu->pending_tlb_flush to env->tlb_c.pending_flush
  cputlb: Split large page tracking per mmu_idx
  cputlb: Move env->vtlb_index to env->tlb_d.vindex
  cputlb: Merge tlb_flush_nocheck into tlb_flush_by_mmuidx_async_work
  cputlb: Merge tlb_flush_page into tlb_flush_page_by_mmuidx
  cputlb: Count "partial" and "elided" tlb flushes
  cputlb: Filter flushes on already clean tlbs
  cputlb: Remove tlb_c.pending_flushes

 include/exec/cpu-defs.h   |  51 +++++-
 include/exec/cputlb.h     |   2 +-
 include/qom/cpu.h         |   6 -
 accel/tcg/cputlb.c        | 354 +++++++++++++++-----------------------
 accel/tcg/translate-all.c |   8 +-
 5 files changed, 184 insertions(+), 237 deletions(-)

-- 
2.17.2
