Received: from eggs.gnu.org ([2001:4830:134:3::10]:52896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dPtku-0007PJ-Au
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:54:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dPtQV-00069m-If
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:33:20 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:38673)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dPtQV-00069H-Br
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 12:33:19 -0400
Received: by mail-wm0-x22b.google.com with SMTP id b184so32502953wme.1
	for <qemu-devel@nongnu.org>; Tue, 27 Jun 2017 09:33:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170123021748.13170-3-rth@twiddle.net>
References: <20170123021748.13170-1-rth@twiddle.net>
	<20170123021748.13170-3-rth@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Jun 2017 17:32:57 +0100
Message-ID: <CAFEAcA8d-MkJhjGHa=sfdWSD2VgAwfhZyNikWruba9JAmruh=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 02/26] linux-user: Support stack-grows-up in
 elfload.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 23 January 2017 at 02:17, Richard Henderson <rth@twiddle.net> wrote:
> HPPA is a (the) stack-grows-up target, and supporting that requires
> rearranging how we compute addresses while laying out the initial
> program stack.  In addition, hppa32 requires 64-byte stack alignment
> so parameterize that as well.

>  #define NEW_AUX_ENT(id, val) do {               \
> -        sp -= n; put_user_ual(val, sp);         \
> -        sp -= n; put_user_ual(id, sp);          \
> +        put_user_ual(id, u_auxv);  u_auxv += n; \
> +        put_user_ual(val, u_auxv); u_auxv += n; \
>      } while(0)

I've just noticed that this change breaks powerpc32, because now
we fill in the auxv starting at the lowest address and working
up, rather than starting at the highest address and working down.
powerpc32 needs some magic values at the lowest address, which
we deal with in ARCH_DLINFO. So now we need to invoke ARCH_DLINFO
first, rather than last (the kernel also fills auxv in from
low to high and invokes ARCH_DLINFO first). The PPC ARCH_DLINFO
also needs to have its entries reversed so the AT_IGNOREPPC
entries come first (lowest address).

The effect of this bug is that my ppc test program
(which is one of the ones in the ancient collection on the
wiki: http://wiki.qemu.org/download/linux-user-test-0.3.tar.gz )
segfaults on startup if the environment is the wrong size:

e104462:xenial:linux-user-test-0.3$ X=1
/home/petmay01/linaro/qemu-for-merges/build/all-linux-static/ppc-linux-user/qemu-ppc
-L ./gnemul/qemu-ppc ppc/ls -l dummyfile
-rw-r--r--    1 petmay01 petmay01        0 Nov 12  2007 dummyfile
e104462:xenial:linux-user-test-0.3$ X=1 Y=1
/home/petmay01/linaro/qemu-for-merges/build/all-linux-static/ppc-linux-user/qemu-ppc
-L ./gnemul/qemu-ppc ppc/ls -l dummyfile
-rw-r--r--    1 petmay01 petmay01        0 Nov 12  2007 dummyfile
e104462:xenial:linux-user-test-0.3$ X=1 Y=1 Z=1
/home/petmay01/linaro/qemu-for-merges/build/all-linux-static/ppc-linux-user/qemu-ppc
-L ./gnemul/qemu-ppc ppc/ls -l dummyfile
-rw-r--r--    1 petmay01 petmay01        0 Nov 12  2007 dummyfile
e104462:xenial:linux-user-test-0.3$ X=1 Y=1 Z=1 A=1
/home/petmay01/linaro/qemu-for-merges/build/all-linux-static/ppc-linux-user/qemu-ppc
-L ./gnemul/qemu-ppc ppc/ls -l dummyfile
qemu: uncaught target signal 11 (Segmentation fault) - core dumped
Segmentation fault (core dumped)
e104462:xenial:linux-user-test-0.3$ X=1 Y=1 Z=1 A=1 B=1
/home/petmay01/linaro/qemu-for-merges/build/all-linux-static/ppc-linux-user/qemu-ppc
-L ./gnemul/qemu-ppc ppc/ls -l dummyfile
-rw-r--r--    1 petmay01 petmay01        0 Nov 12  2007 dummyfile

(exactly which 1 out of 4 will fail for you will depend
on the size of your environment, etc, obviously.)

Newer ppc binaries which have glibc versions that dropped
that attempt to handle alignment won't trip over this,
only older ones.

thanks
-- PMM
