Received: from eggs.gnu.org ([2001:4830:134:3::10]:60378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUbPU-0007sl-7A
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 10:47:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cUbPT-0004hc-9U
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 10:47:28 -0500
Received: from mail-ua0-x22a.google.com ([2607:f8b0:400c:c08::22a]:33115)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cUbPT-0004hN-0p
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 10:47:27 -0500
Received: by mail-ua0-x22a.google.com with SMTP id i68so64635248uad.0
	for <qemu-devel@nongnu.org>; Fri, 20 Jan 2017 07:47:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170120152141.14276.42073.malonedeb@soybean.canonical.com>
References: <20170120152141.14276.42073.malonedeb@soybean.canonical.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 20 Jan 2017 15:47:05 +0000
Message-ID: <CAFEAcA9_j-7qoRFB7QWC=dM6eVsTjwV6EdSmFN+v+7pbdhXC6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Bug 1658120] [NEW] building with
 gcc-aarch64-linux-gnu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1658120 <1658120@bugs.launchpad.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 20 January 2017 at 15:21, Bilal Amarni <1658120@bugs.launchpad.net> wrote:
> Hi, while trying to build qemu v2.8.0 with gcc-aarch64-linux-gnu cross-
> compiler I'm getting the following :
>
>
> In file included from /usr/include/x86_64-linux-gnu/sys/syscall.h:31:0,
>                  from /root/qemu/util/compatfd.c:21:
> /root/qemu/util/compatfd.c: In function 'qemu_signalfd':
> /root/qemu/util/compatfd.c:103:19: error: '__NR_signalfd' undeclared (first use in this function)
>      ret = syscall(SYS_signalfd, -1, mask, _NSIG / 8);
>                    ^
> /root/qemu/util/compatfd.c:103:19: note: each undeclared identifier is reported only once for each function it appears in
> /root/qemu/rules.mak:59: recipe for target 'util/compatfd.o' failed
> make: *** [util/compatfd.o] Error 1

You can see from the error message that the compile has
pulled in the include file /usr/include/x86_64-linux-gnu/sys/syscall.h
from the host, which is the x86-64 version. This is an
indication that either your cross compiler is broken, or
you're not using it at all.

>  ../configure --target-list=x86_64-linux-user --static --cpu=aarch64

You haven't told configure to use a cross compiler at all,
so it is building with the x86 system compiler, which
doesn't work. You shouldn't need to use the --cpu argument
at all, because if you get the build to use the right
compiler it can figure that out itself. (Passing --cpu=aarch64
tells configure "ignore the fact this is an x86 compiler
and assume it's aarch64 instead", which just results in
things breaking because that assumption is wrong.)

You need to pass configure --cross-prefix=aarch64-linux-gnu-
You'll also need to ensure you have an aarch64-linux-gnu-pkg-config
and that you have cross versions of all QEMU's library
dependencies (notably zlib and glib) in the right place that
your cross-compiler can find them, and that your cross
pkg-config is set up to point to them.

On Ubuntu, you may find it easier to set up a cross-architecture
chroot and do the build in that (where it looks like a native
build). Cross-compilation of software with non-trivial
dependencies is always an enormous pain in the neck.

thanks
-- PMM
