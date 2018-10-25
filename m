Received: from eggs.gnu.org ([2001:4830:134:3::10]:38757)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFhI5-0000mb-PT
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 11:11:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFhI4-0002tU-QU
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 11:11:17 -0400
Date: Thu, 25 Oct 2018 11:11:03 -0400
From: "Emilio G. Cota" <cota@braap.org>
Message-ID: <20181025151103.GA19931@flamenco>
References: <20181025144644.15464-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181025144644.15464-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v4 00/71] per-CPU locks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Alexander Graf <agraf@suse.de>, Alistair Francis <alistair23@gmail.com>, Andrzej Zaborowski <balrogg@gmail.com>, Anthony Green <green@moxielogic.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Chris Wulff <crwulff@gmail.com>, Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, David Hildenbrand <david@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Fabien Chouteau <chouteau@adacore.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, James Hogan <jhogan@kernel.org>, Laurent Vivier <laurent@vivier.eu>, Marek Vasut <marex@denx.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Max Filippov <jcmvbkbc@gmail.com>, Michael Clark <mjc@sifive.com>, Michael Walle <michael@walle.cc>, Palmer Dabbelt <palmer@sifive.com>, Pavel Dovgalyuk <dovgaluk@ispras.ru>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>, Stafford Horne <shorne@gmail.com>

[I forgot to add the cover letter to git send-email; here it is]

v3: https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg04179.html

"Why is this an RFC?" See v3 link above. Also, see comment at
the bottom of this message regarding the last patch of this series.

Changes since v3:

- Add R-b's -- rth: thanks for all the reviews!

- Partially bring back the approach in the v1 series, that is,
  do not acquire the CPU mutex in cpu_interrupt_request; use
  atomic_read instead. The lock is not needed because of the
  OR+kick sequence; note that when we do not have the BQL
  (i.e. in MTTCG's CPU loop), we do have the lock while reading
  cpu_interrupt_request, so no writes can be missed there.
  This simplifies the calling code quite a bit, since we do
  not hold cpu_mutex across large portions of code (this is
  a very bad idea, e.g. could lead to deadlock for instance
  if we tried to queue work on another CPU).
  Setters still acquire the lock, since it's the cost is
  very similar to that of a locked atomic, and makes the
  code simpler.

- Use an intermediate interrupt_request variable wherever
  this is trivial to do. Whenever there's a chance that
  cpu->interrupt_request might have been updated between
  reads, just use cpu_interrupt_request to perform a load
  via atomic_read.

- Drop the BQL assert in run_on_cpu. Keep the guarantee that
  the queued work holds the BQL, though.

- Add a no_cpu_mutex_lock_held assert to run_on_cpu; note that
  acquiring CPU locks can only be done in CPU_FOREACH order,
  otherwise we might deadlock.

- Remove qemu_cpu_cond leftovers; it's superseded by cpu->cond.

- Export no_cpu_mutex_lock_held.

- Do not export process_queued_work_locked from cpus-common.c;
  at some point we need to drop cpu_mutex for other vCPUs to queue
  work on the current vCPU, and process_queued_work is a good
  place to do that. Add comment about this.

- Add helper_cpu_halted_set helper to tcg-runtime. Convert
  the TCG targets that were setting cpu->halted directly.

- Fix cpu_reset_interrupt in cpu_common_post_load, as reported
  by Richard.

- Fix a hang after making qemu_work_cond per-cpu. The hang can
  only happen between that commit and the commit that completes
  the transition to per-CPU locks. This would break bisect, so
  fix it. In addition, add a comment about it, and add a tiny
  patch to undo the fix once the transition is complete and the
  fix isn't needed any more.

- Fix a possible deadlock (acquiring the BQL *after* having
  acquired the CPU mutex) in cpu_reset_interrupt. This would break
  bisection until the transition to per-CPU locks, so fix it
  and add a comment about it to the commit log of the "cpu: define
  cpu_interrupt_request helpers" patch.

- Add cc->has_work_with_iothread_lock, as suggested by Paolo,
  and convert the targets that need it.

- Add a patch to reduce contention when doing exclusive work.
  In my tests I've only found aarch64 to benefit (very minimally)
  from this; for other targets this patch is perf-neutral.
  In aarch64, the problem is that frequent global TLB invalidations
  require frequent exclusive work; sync-profile points to unnecessary
  contention on cpu_list_lock, which all waiters wait on
  while the exclusive work completes. To fix this, make the
  waiters wait on their CPU lock, so that their wakeup is uncontended.
  The perf impact is that the scalability collapse due to exclusive
  work is mitigated, but not fixed.
  So I'm including this patch to raise awareness about the issue,
  but I don't feel strongly at all about merging it.

The series is checkpatch-clean (single warning about __COVERITY__).

You can fetch it from:
  https://github.com/cota/qemu/tree/cpu-lock-v4

Thanks,

		Emilio
