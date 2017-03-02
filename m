Received: from eggs.gnu.org ([2001:4830:134:3::10]:59619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cjWnG-0007xE-O2
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:53:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cjWnE-0002SR-36
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:53:42 -0500
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:35590)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cjWnD-0002Rl-T7
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:53:40 -0500
Received: by mail-wr0-x22d.google.com with SMTP id g10so60204629wrg.2
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 11:53:38 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  2 Mar 2017 19:53:26 +0000
Message-Id: <20170302195337.31558-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 00/11] MTTCG fixups for 2.9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, rth@twiddle.net, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Hi Peter,

So perhaps predictably the merging of MTTCG has thrown up some issues
during soft-freeze. The following patches fix up some of those:

The following where in v1 and just have r-b tags:

  vl/cpus: be smarter with icount and MTTCG
  target/i386/cpu.h: declare TCG_GUEST_DEFAULT_MO
  cpus.c: add additional error_report when !TARGET_SUPPORT_MTTCG

The next change downgrades the asserts to tcg_debug_asserts. This will
reduce the instances of production builds failing on non-MTTCG enabled
guests. The races still need to be fixed but you now have to
--enable-debug-tcg to go hunting for them:

  translate: downgrade IRQ BQL asserts to tcg_debug_assert

This never came up in my testing but it seems some guests can
translate while doing a tlb_fill. The call to cpu_restore_state never
worked before (as we are translating the block you are looking for)
but by bugging out we avoid the double tb_lock().

  translate-all: exit cpu_restore_state early if translating

Then we have a bunch of fixes from the reports on the list. They are
safe to merge but I'll leave that up to the maintainers. There may be
an argument for holding these patches back until the guest is
converted to be MTTCG aware and a full audit of the CPU<->HW emulation
boundaries is done for each one:

  sparc/sparc64: grab BQL before calling cpu_check_irqs
  s390x/misc_helper.c: wrap IO instructions in BQL
  target/xtensa: hold BQL for interrupt processing
  target/mips/op_helper: hold BQL before calling cpu_mips_get_count

Finally these are just tiny debug fixes while investigating the icount
regression:

  target/arm/helper: make it clear the EC field is also in hex
  hw/intc/arm_gic: modernise the DPRINTF

Going forward I think 1-5 are ready to be merged now. For 6-9 we
should await decisions from the target maintainers. The last two are
entirely up to you.

It looks like the -icount regression is a poor interaction between
icount timers and the BQL but this is going to require discussion with
Paolo in the morning.

Cheers,


Alex Bennée (11):
  vl/cpus: be smarter with icount and MTTCG
  target/i386/cpu.h: declare TCG_GUEST_DEFAULT_MO
  cpus.c: add additional error_report when !TARGET_SUPPORT_MTTCG
  translate: downgrade IRQ BQL asserts to tcg_debug_assert
  translate-all: exit cpu_restore_state early if translating
  sparc/sparc64: grab BQL before calling cpu_check_irqs
  s390x/misc_helper.c: wrap IO instructions in BQL
  target/xtensa: hold BQL for interrupt processing
  target/mips/op_helper: hold BQL before calling cpu_mips_get_count
  target/arm/helper: make it clear the EC field is also in hex
  hw/intc/arm_gic: modernise the DPRINTF

 cpus.c                      | 11 +++++++----
 hw/intc/arm_gic.c           | 13 +++++++++----
 hw/sparc/sun4m.c            |  3 +++
 hw/sparc64/sparc64.c        |  3 +++
 target/arm/helper.c         |  2 +-
 target/i386/cpu.h           |  3 +++
 target/mips/op_helper.c     | 17 ++++++++++++++---
 target/s390x/misc_helper.c  | 21 +++++++++++++++++++++
 target/sparc/int64_helper.c |  3 +++
 target/sparc/win_helper.c   | 11 +++++++++++
 target/xtensa/helper.c      |  1 +
 target/xtensa/op_helper.c   |  7 +++++++
 translate-all.c             |  9 ++++++++-
 translate-common.c          |  3 ++-
 vl.c                        |  7 ++-----
 15 files changed, 95 insertions(+), 19 deletions(-)

-- 
2.11.0
