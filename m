Received: from eggs.gnu.org ([2001:4830:134:3::10]:46888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cXwir-00080O-Cq
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 16:09:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cXwim-0002Ak-Nd
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 16:09:17 -0500
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:33178)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cXwim-0002AZ-Hu
	for qemu-devel@nongnu.org; Sun, 29 Jan 2017 16:09:12 -0500
Received: by mail-qk0-x243.google.com with SMTP id 11so16258453qkl.0
	for <qemu-devel@nongnu.org>; Sun, 29 Jan 2017 13:09:12 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 29 Jan 2017 22:09:03 +0100
Message-Id: <20170129210910.6333-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [RFC/RFT PATCH 0/7] cpu-exec: simplify cpu_exec and
 remove some icount special cases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: serge.fdrv@gmail.com, peter.maydell@linaro.org, pavel.dovgaluk@ispras.ru

The series includes three parts:

1-2: fix two bugs, the first one pretty bad, the second seems
to be theoretical only.

3-5: simplify cpu_exec.  This builds on Sergey's conversion
of cpu_exec to a simple top-down logic, making the phases
clearer and saving on the cost of siglongjmp in the meanwhile.

6-7: these are intended to be a base for Pavel's record/replay
fixes.  The main thing I noticed while reviewing is that icount
is redoing (with u16.high) a lot of things that tcg_exit_req is
doing too.  This is because, at the time icount was introduced,
tcg_exit_req didn't exist and QEMU instead unwound chained TBs
through POSIX signals.  But now we have essentially two ways to
do the same thing with subtly different invariants or downright
bugs (such as the one fixed by patch 1).  Patch 6 therefore
unifies tcg_exit_req and the icount interrupt flag.  It saves a
handful of instructions per TB in icount mode and generally
makes icount mode "less special", which is a good thing since
no one seems to understand it well.  Patch 7 then removes another
EXCP_INTERRUPT/cpu_loop_exit pair; by exiting to main loop simply
through cpu->exit_request, hopefully it fixes one of the issues that
Pavel was seeing.

For now I've tested this only on an aarch64 Linux image (with
and without -icount).  Thanks,

Paolo

Paolo Bonzini (7):
  cpu-exec: fix jmp_first out-of-bounds access with icount
  cpu-exec: tighten barrier on TCG_EXIT_REQUESTED
  cpu-exec: avoid cpu_loop_exit in cpu_handle_interrupt
  cpu-exec: avoid repeated sigsetjmp on interrupts
  cpu-exec: remove outermost infinite loop
  cpu-exec: unify icount_decr and tcg_exit_req
  cpu-exec: centralize exiting to the main loop

 cpu-exec.c                | 153 +++++++++++++++++++++-------------------------
 include/exec/exec-all.h   |   1 +
 include/exec/gen-icount.h |  53 ++++++++--------
 include/qom/cpu.h         |  15 +++--
 qom/cpu.c                 |   2 +-
 tcg/tcg.h                 |   1 -
 translate-all.c           |   2 +-
 translate-common.c        |  13 ++--
 8 files changed, 109 insertions(+), 131 deletions(-)

-- 
2.9.3
