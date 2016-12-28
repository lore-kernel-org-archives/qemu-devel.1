Received: from eggs.gnu.org ([2001:4830:134:3::10]:54236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cMHfX-0003LI-Ov
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 12:05:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cMHfW-000170-Hc
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 12:05:39 -0500
Received: from mail-vk0-x22e.google.com ([2607:f8b0:400c:c05::22e]:34804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cMHfW-00016v-8P
	for qemu-devel@nongnu.org; Wed, 28 Dec 2016 12:05:38 -0500
Received: by mail-vk0-x22e.google.com with SMTP id x186so222852513vkd.1
	for <qemu-devel@nongnu.org>; Wed, 28 Dec 2016 09:05:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <098092bd-b92b-4fb8-5061-f77f9f75e392@freebsd.org>
References: <098092bd-b92b-4fb8-5061-f77f9f75e392@freebsd.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 28 Dec 2016 17:05:16 +0000
Message-ID: <CAFEAcA8ZuCxeFz83moePn80GFUbh0wGu4+T2wHdTSN=LE6-1CQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Looking for a linux-user mode test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sean Bruno <sbruno@freebsd.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 28 December 2016 at 15:06, Sean Bruno <sbruno@freebsd.org> wrote:
> After some recent-ish changes to how user mode executes things/stuff,
> I'm running into issues with the out of tree bsd-user mode code that
> FreeBSD has been maintaining.  It looks like the host_signal_handler()
> is never executed or registered correctly in our code.  I'm curious if
> the linux-user code can handle this bit of configure script from m4.
>
> https://people.freebsd.org/~sbruno/stack.c

Hmm. That code does:
 * set up a SIGSEGV signal handler to run on its own stack
 * go into an infinite recursion, expecting to run out of
   stack and trigger a SEGV
which is a bit of an obscure corner case of signal handling.

We recently fixed a lot of signal handler related bugs in linux-user
by doing a significant overhaul of that code. If bsd-user is still
using the old broken approach it's probably still got lots of bugs
in it. Alternatively, it's possible we changed some of the core
code in that process and broke bsd-user by mistake.

Ideally all of that rework (including the support for properly
interrupting syscalls without races) should be ported over to
bsd-user at some point.

> If someone has the time/inclination, can this code be compiled for ARMv6
> and executed in a linux chroot with the -strace argument applied?  I see
> the following, which after much debugging seems to indicate that the
> host_signal_handler() code is never executed as this code is requesting
> that SIGSEGV be masked to its own handler.

Built for ARMv7 since I don't have an ARMv6 cross compiler
or system, but it works ok for linux (also, built with -static
rather than run in a chroot, for convenience):

e104462:xenial:qemu$ ./build/arm-linux/arm-linux-user/qemu-arm -strace
~/linaro/qemu-misc-tests/stack
29798 uname(0xf6fff1f0) = 0
29798 brk(NULL) = 0x0007f000
29798 brk(0x0007fd00) = 0x0007fd00
29798 readlink("/proc/self/exe",0xf6ffe328,4096) = 43
29798 brk(0x000a0d00) = 0x000a0d00
29798 brk(0x000a1000) = 0x000a1000
29798 access("/etc/ld.so.nohwcap",F_OK) = -1 errno=2 (No such file or directory)
29798 sigaltstack(0xf6fff2e0,(nil)) = 0
29798 rt_sigaction(SIGSEGV,0xf6fff1b0,NULL) = 0
--- SIGSEGV {si_signo=SIGSEGV, si_code=1, si_addr = 0xf67ffffc} ---
29798 exit_group(0)

(the enhancement to linux-user's strace to print the line on signal
delivery is also a pretty new change.)

> https://people.freebsd.org/~sbruno/qemu-bsd-user-arm.txt
>
> Prior to 7e6c57e2957c7d868f74bd0d53b5e861b495e1c7 this DTRT for our
> ARMv6 targets.

This commit hash doesn't seem to be in QEMU master.

thanks
-- PMM
