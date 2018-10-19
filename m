Received: from eggs.gnu.org ([2001:4830:134:3::10]:59891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJGU-0005dJ-9K
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:07:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gDJGO-00049L-9I
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 21:07:46 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 18 Oct 2018 21:05:29 -0400
Message-Id: <20181019010625.25294-1-cota@braap.org>
Subject: [Qemu-devel] [RFC v3 0/56] per-CPU locks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Alexander Graf <agraf@suse.de>, Alistair Francis <alistair23@gmail.com>, Andrzej Zaborowski <balrogg@gmail.com>, Anthony Green <green@moxielogic.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Chris Wulff <crwulff@gmail.com>, Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, David Hildenbrand <david@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Fabien Chouteau <chouteau@adacore.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, James Hogan <jhogan@kernel.org>, Laurent Vivier <laurent@vivier.eu>, Marek Vasut <marex@denx.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Max Filippov <jcmvbkbc@gmail.com>, Michael Clark <mjc@sifive.com>, Michael Walle <michael@walle.cc>, Palmer Dabbelt <palmer@sifive.com>, Pavel Dovgalyuk <dovgaluk@ispras.ru>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>, Sagar Karandikar <sagark@eecs.berkeley.edu>, Stafford Horne <shorne@gmail.com>

Cc: Aleksandar Markovic <amarkovic@wavecomp.com>
Cc: Alexander Graf <agraf@suse.de>
Cc: Alistair Francis <alistair23@gmail.com>
Cc: Andrzej Zaborowski <balrogg@gmail.com>
Cc: Anthony Green <green@moxielogic.com>
Cc: Artyom Tarasenko <atar4qemu@gmail.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Chris Wulff <crwulff@gmail.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: David Hildenbrand <david@redhat.com>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Fabien Chouteau <chouteau@adacore.com>
Cc: Guan Xuetao <gxt@mprc.pku.edu.cn>
Cc: James Hogan <jhogan@kernel.org>
Cc: Laurent Vivier <laurent@vivier.eu>
Cc: Marek Vasut <marex@denx.de>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Cc: Michael Clark <mjc@sifive.com>
Cc: Michael Walle <michael@walle.cc>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
Cc: qemu-ppc@nongnu.org
Cc: qemu-s390x@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>
Cc: Sagar Karandikar <sagark@eecs.berkeley.edu>
Cc: Stafford Horne <shorne@gmail.com>

I'm calling this series a v3 because it supersedes the two series
I previously sent about using atomics for interrupt_request:
  https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg02013.html
The approach in that series cannot work reliably; using (locked) atomics
to set interrupt_request but not using (locked) atomics to read it
can lead to missed updates.

This series takes a different approach: it serializes access to many
CPUState fields, including .interrupt_request, with a per-CPU lock.

Protecting more fields of CPUState with the lock then allows us to
substitute the BQL for the per-CPU lock in many places, notably
the execution loop in cpus.c. This leads to better scalability
for MTTCG, since CPUs don't have to acquire a contended lock
(the BQL) every time they stop executing code.

Some hurdles that remain:

1. I am not happy with the shutdown path via pause_all_vcpus.
   What happens if
   (a) A CPU is added while we're calling pause_all_vcpus?
   (b) Some CPUs are trying to run exclusive work while we
       call pause_all_vcpus?
   Am I being overly paranoid here?

2. I have done very light testing with x86_64 KVM, and no
   testing with other accels (hvf, hax, whpx). check-qtest
   works, except for an s390x test that to me is broken
   in master -- I reported the problem here:
     https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg03728.html

3. This might break record-replay. Furthermore, a quick test with icount
   on aarch64 seems to work, but I haven't tested icount extensively.

4. Some architectures still need the BQL in cpu_has_work.
   This leads to some contortions to avoid deadlock, since
   in this series cpu_has_work is called with the CPU lock held.

5. The interrupt handling path remains with the BQL held, mostly
   because the ISAs I routinely work with need the BQL anyway
   when handling the interrupt. We can complete the pushdown
   of the BQL to .do_interrupt/.exec_interrupt later on; this
   series is already way too long.

Points (1)-(3) makes this series an RFC and not a proper patch series.
I'd appreciate feedback on this approach and/or testing.

Note that this series fixes a bug by which cpu_has_work is
called without the BQL (from cpu_handle_halt). After
this series, cpu_has_work is called with the CPU lock,
and only the targets that need the BQL in cpu_has_work
acquire it.

For some performance numbers, see the last patch.

The series is checkpatch-clean; only one warning due to the
use of __COVERITY__ in cpus.c.

You can fetch this series from:

  https://github.com/cota/qemu/tree/cpu-lock-v3

Note that it applies on top of tcg-next + my dynamic TLB series,
which I'm using in the faint hope that the ubuntu experiments might
run a bit faster.

Thanks!

		Emilio
