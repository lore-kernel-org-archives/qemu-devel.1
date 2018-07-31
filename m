Received: from eggs.gnu.org ([2001:4830:134:3::10]:51284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fkOmm-0005ZJ-FI
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 03:09:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fkOmj-0001pq-AD
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 03:09:36 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:39242)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fkOmi-0001pk-VD
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 03:09:33 -0400
Received: by mail-wm0-x243.google.com with SMTP id h20-v6so1889666wmb.4
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 00:09:32 -0700 (PDT)
References: <20180730201553.32423-1-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180730201553.32423-1-richard.henderson@linaro.org>
Date: Tue, 31 Jul 2018 08:09:30 +0100
Message-ID: <87y3dr9905.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] linux-user/sparc: Fixes for clone
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, laurent@vivier.eu, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com


Richard Henderson <richard.henderson@linaro.org> writes:

> There are at least 4 separate bugs preventing clone from working.
>
> (1) cpu_copy left both cpus sharing the same register window (!)
>
> (2) cpu_clone_regs did not initialize %o1, so the new thread path
>     in the guest __clone was always taken, even for the parent
>     (old %o1 value was newsp, and so non-zero).
>
> (3) cpu_clone_regs did not advance the pc past the syscall in the
>     child, which meant that the child re-executed the syscall
>     (and because of (1), with essentially random inputs).
>
> (4) clone did not flush register windows, which would cause the
>     parent stack to be clobbered by the child writing out old
>     windows in order to allocate a new one.
>
> This is enough for Alex's atomic-test to make progress, but not
> quite enough for it to actually work.  What I'm seeing now is a
> legitimate SEGV for a write to a r-xp memory segment.  I'll need
> to examine the testcase further to see why that is happening.


Hmm and testthread now reliably bombs with:

  thread2: 10 hello2
  testthread: allocatestack.c:384: advise_stack_range: Assertion `freesize =
< size' failed.
  fish: =E2=80=9C./qemu-sparc64 -d trace:user_qu=E2=80=A6=E2=80=9D terminat=
ed by signal SIGABRT (Abort)

However the behaviour of the atomic test now looks similar to the
occasional failure I was seeing in testthread before, i.e. a crash
during atomic operations.

>
>
> r~
>
>
> Richard Henderson (4):
>   linux-user: Disallow setting newsp for fork
>   linux-user: Pass the parent env to cpu_clone_regs
>   linux-user/sparc: Fix cpu_clone_regs
>   linux-user/sparc: Flush register windows before clone
>
>  linux-user/aarch64/target_cpu.h    |  3 ++-
>  linux-user/alpha/target_cpu.h      |  3 ++-
>  linux-user/arm/target_cpu.h        |  3 ++-
>  linux-user/cris/target_cpu.h       |  3 ++-
>  linux-user/hppa/target_cpu.h       |  3 ++-
>  linux-user/i386/target_cpu.h       |  3 ++-
>  linux-user/m68k/target_cpu.h       |  3 ++-
>  linux-user/microblaze/target_cpu.h |  3 ++-
>  linux-user/mips/target_cpu.h       |  3 ++-
>  linux-user/nios2/target_cpu.h      |  3 ++-
>  linux-user/openrisc/target_cpu.h   |  4 +++-
>  linux-user/ppc/target_cpu.h        |  3 ++-
>  linux-user/riscv/target_cpu.h      |  3 ++-
>  linux-user/s390x/target_cpu.h      |  3 ++-
>  linux-user/sh4/target_cpu.h        |  3 ++-
>  linux-user/sparc/target_cpu.h      | 23 ++++++++++++++++++++---
>  linux-user/tilegx/target_cpu.h     |  3 ++-
>  linux-user/xtensa/target_cpu.h     |  3 ++-
>  linux-user/sparc/cpu_loop.c        |  3 +++
>  linux-user/syscall.c               |  9 ++++++---
>  20 files changed, 64 insertions(+), 23 deletions(-)


--
Alex Benn=C3=A9e
