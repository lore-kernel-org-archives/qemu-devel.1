Received: from eggs.gnu.org ([2001:4830:134:3::10]:45777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e9xfu-0004mG-J6
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 14:23:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e9xft-00005A-Re
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 14:23:38 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:47648)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e9xft-0008Vb-L9
	for qemu-devel@nongnu.org; Wed, 01 Nov 2017 14:23:37 -0400
Received: by mail-wm0-x244.google.com with SMTP id r196so6407085wmf.2
	for <qemu-devel@nongnu.org>; Wed, 01 Nov 2017 11:23:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171101175356.11771-1-danielhb@linux.vnet.ibm.com>
References: <20171101175356.11771-1-danielhb@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 1 Nov 2017 18:23:15 +0000
Message-ID: <CAFEAcA9HjqAss=j+unytx=FJKqMo6neNah4yvWtx2aXCvYw29Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] configure: adding ppc64le to supported
 host CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 1 November 2017 at 17:53, Daniel Henrique Barboza
<danielhb@linux.vnet.ibm.com> wrote:
> When executing 'configure' in a fresh QEMU clone, in a fresh
> OS install running in a ppc64le host, this is the error
> shown:
>
> -----
>
> ../configure --enable-trace-backend=simple --enable-debug
>     --target-list=ppc64-softmmu
>
> ERROR: Unsupported CPU = ppc64le, try --enable-tcg-interpreter
>
> -----
>
> This isn't true, ppc64le host CPU is supported.
>
> This patch adds 'ppc64le' to the list of supported host CPUs. After
> this patch, the next error when executing configure in the
> scenario mentioned is:
>
> -----
>
> ../configure --enable-trace-backend=simple --enable-debug
>     --target-list=ppc64-softmmu
>
> ERROR: "cc" either does not exist or does not work
>
> -----
>
> Indicating that now we need a valid compiler to proceed.
>
> Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
> ---

I think this is either unnecessary or it should be a lot more
changes than this. The problem here is that how we determine
the host CPU type is by using the C compiler. So if you don't
have a C compiler then we're going to fail to autodetect,
and the (kind of bogus) fallback is via "uname -a". What
we ought to do is (a) detect "no C compiler" before we
try to use it and (b) not have that uname -a fallback.

I suggest you install a C compiler and then try again with
an unmodified configure to see how that does.

(I think that the correct value of the "cpu" variable for
ppc64le is "ppc64", same as for bigendian, which we'll
autodetect if we have a compiler to do it with. If that's
right, then you could argue for having our "normalise
CPU host name" code map ppc64le to ppc64. Certainly a
lot of places in configure assume "ppc64" is the only
kind...)

thanks
-- PMM
