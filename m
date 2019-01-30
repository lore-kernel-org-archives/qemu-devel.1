Received: from eggs.gnu.org ([209.51.188.92]:35940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe44-0000Lp-F0
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1goe42-0001Xd-HC
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 19:49:16 -0500
From: "Emilio G. Cota" <cota@braap.org>
Date: Tue, 29 Jan 2019 19:46:58 -0500
Message-Id: <20190130004811.27372-1-cota@braap.org>
Subject: [Qemu-devel] [PATCH v6 00/73] per-CPU locks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Alistair Francis <alistair23@gmail.com>, Andrzej Zaborowski <balrogg@gmail.com>, Anthony Green <green@moxielogic.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Aurelien Jarno <aurelien@aurel32.net>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Chris Wulff <crwulff@gmail.com>, Cornelia Huck <cohuck@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, David Hildenbrand <david@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Fabien Chouteau <chouteau@adacore.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, James Hogan <jhogan@kernel.org>, Laurent Vivier <laurent@vivier.eu>, Marek Vasut <marex@denx.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Max Filippov <jcmvbkbc@gmail.com>, Michael Walle <michael@walle.cc>, Palmer Dabbelt <palmer@sifive.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org, Sagar Karandikar <sagark@eecs.berkeley.edu>, Stafford Horne <shorne@gmail.com>

v5: https://lists.gnu.org/archive/html/qemu-devel/2018-12/msg02979.html

For context, the goal of this series is to substitute the BQL for the
per-CPU locks in many places, notably the execution loop in cpus.c.
This leads to better scalability for MTTCG, since CPUs don't have
to acquire a contended global lock (the BQL) every time they
stop executing code.

See the last commit for some performance numbers.

After this series, the remaining obstacles to achieving KVM-like
scalability in MTTCG are: (1) interrupt handling, which
in some targets requires the BQL, and (2) frequent execution of
"async safe" work.
That said, some targets scale great on MTTCG even before this
series -- for instance, when running a parallel compilation job
in an x86_64 guest, scalability is comparable to what we get with
KVM.

This series is very long. If you only have time to look at a few patches,
I suggest the following, which do most of the heavy lifting and
have not yet been reviewed:

- Patch 7: cpu: make per-CPU locks an alias of the BQL in TCG rr mode
- Patch 70: cpu: protect CPU state with cpu->lock instead of the BQL

I've tested all patches with `make check-qtest -j' for all targets.
The series is checkpatch-clean (just some warnings about __COVERITY__).

You can fetch the series from:
  https://github.com/cota/qemu/tree/cpu-lock-v6

---
Changes since v5:

- Rebase on current master
  + Fixed a few conflicts, and converted the references to cpu->halted and
    cpu->interrupt_request that had been added since v5.

- Add R-b's and Ack's -- thanks everyone!

Thanks,

		Emilio
---
 accel/tcg/cpu-exec.c            |  40 ++--
 accel/tcg/cputlb.c              |  10 +-
 accel/tcg/tcg-all.c             |  12 +-
 accel/tcg/tcg-runtime.c         |   7 +
 accel/tcg/tcg-runtime.h         |   2 +
 accel/tcg/translate-all.c       |   2 +-
 cpus-common.c                   | 129 ++++++++----
 cpus.c                          | 421 ++++++++++++++++++++++++++++++++--------
 exec.c                          |   2 +-
 gdbstub.c                       |   4 +-
 hw/arm/omap1.c                  |   4 +-
 hw/arm/pxa2xx_gpio.c            |   2 +-
 hw/arm/pxa2xx_pic.c             |   2 +-
 hw/intc/s390_flic.c             |   4 +-
 hw/mips/cps.c                   |   2 +-
 hw/misc/mips_itu.c              |   4 +-
 hw/openrisc/cputimer.c          |   2 +-
 hw/ppc/e500.c                   |   4 +-
 hw/ppc/ppc.c                    |  12 +-
 hw/ppc/ppce500_spin.c           |   6 +-
 hw/ppc/spapr_cpu_core.c         |   4 +-
 hw/ppc/spapr_hcall.c            |   4 +-
 hw/ppc/spapr_rtas.c             |   6 +-
 hw/sparc/leon3.c                |   2 +-
 hw/sparc/sun4m.c                |   8 +-
 hw/sparc64/sparc64.c            |   8 +-
 include/qom/cpu.h               | 189 +++++++++++++++---
 qom/cpu.c                       |  27 ++-
 stubs/Makefile.objs             |   1 +
 stubs/cpu-lock.c                |  28 +++
 target/alpha/cpu.c              |   8 +-
 target/alpha/translate.c        |   6 +-
 target/arm/arm-powerctl.c       |   4 +-
 target/arm/cpu.c                |   8 +-
 target/arm/helper.c             |  16 +-
 target/arm/machine.c            |   2 +-
 target/arm/op_helper.c          |   2 +-
 target/cris/cpu.c               |   2 +-
 target/cris/helper.c            |   6 +-
 target/cris/translate.c         |   5 +-
 target/hppa/cpu.c               |   2 +-
 target/hppa/translate.c         |   3 +-
 target/i386/cpu.c               |   4 +-
 target/i386/cpu.h               |   2 +-
 target/i386/hax-all.c           |  36 ++--
 target/i386/helper.c            |   8 +-
 target/i386/hvf/hvf.c           |  16 +-
 target/i386/hvf/x86hvf.c        |  38 ++--
 target/i386/kvm.c               |  78 ++++----
 target/i386/misc_helper.c       |   2 +-
 target/i386/seg_helper.c        |  13 +-
 target/i386/svm_helper.c        |   6 +-
 target/i386/whpx-all.c          |  57 +++---
 target/lm32/cpu.c               |   2 +-
 target/lm32/op_helper.c         |   4 +-
 target/m68k/cpu.c               |   2 +-
 target/m68k/op_helper.c         |   2 +-
 target/m68k/translate.c         |   9 +-
 target/microblaze/cpu.c         |   2 +-
 target/microblaze/translate.c   |   4 +-
 target/mips/cpu.c               |  11 +-
 target/mips/kvm.c               |   4 +-
 target/mips/op_helper.c         |   8 +-
 target/mips/translate.c         |   4 +-
 target/moxie/cpu.c              |   2 +-
 target/nios2/cpu.c              |   2 +-
 target/openrisc/cpu.c           |   4 +-
 target/openrisc/sys_helper.c    |   4 +-
 target/ppc/excp_helper.c        |   8 +-
 target/ppc/helper_regs.h        |   2 +-
 target/ppc/kvm.c                |   8 +-
 target/ppc/translate.c          |   6 +-
 target/ppc/translate_init.inc.c |  36 ++--
 target/riscv/cpu.c              |   5 +-
 target/riscv/op_helper.c        |   2 +-
 target/s390x/cpu.c              |  28 ++-
 target/s390x/excp_helper.c      |   4 +-
 target/s390x/kvm.c              |   2 +-
 target/s390x/sigp.c             |   8 +-
 target/sh4/cpu.c                |   2 +-
 target/sh4/helper.c             |   2 +-
 target/sh4/op_helper.c          |   2 +-
 target/sparc/cpu.c              |   6 +-
 target/sparc/helper.c           |   2 +-
 target/unicore32/cpu.c          |   2 +-
 target/unicore32/softmmu.c      |   2 +-
 target/xtensa/cpu.c             |   6 +-
 target/xtensa/exc_helper.c      |   2 +-
 target/xtensa/helper.c          |   2 +-
 89 files changed, 1018 insertions(+), 455 deletions(-)
