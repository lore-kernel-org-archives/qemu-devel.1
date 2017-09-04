Received: from eggs.gnu.org ([2001:4830:134:3::10]:46299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1donkI-0007CL-H0
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 05:32:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1donkD-0007k0-RN
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 05:32:42 -0400
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:38261)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1donkD-0007jh-Ji
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 05:32:37 -0400
Received: by mail-wm0-x234.google.com with SMTP id 187so33750985wmn.1
	for <qemu-devel@nongnu.org>; Mon, 04 Sep 2017 02:32:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170903164952.26760-1-n54@gmx.com>
References: <20170903164952.26760-1-n54@gmx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Sep 2017 10:32:15 +0100
Message-ID: <CAFEAcA-wB8JezCNjyU92U83+75C5NccfBHe1G5q-D67H4CMTKA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] tests: Do not include lutil on SunOS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 3 September 2017 at 17:49, Kamil Rytarowski <n54@gmx.com> wrote:
> This fixes build on SmartOS (Joyent).
>
> Patch cherry-picked from pkgsrc by jperkin (Joyent).
>
> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
> ---
>  tests/Makefile.include | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index f08b7418f0..0e5e6cb9b8 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -810,8 +810,10 @@ tests/migration/initrd-stress.img: tests/migration/stress$(EXESUF)
>         rmdir $(INITRD_WORK_DIR)
>
>  ifeq ($(CONFIG_POSIX),y)
> +ifneq ($(CONFIG_SOLARIS),y)
>  LIBS += -lutil
>  endif
> +endif

I don't object to this patch in principle, but I don't think
this is the best way to fix the underlying problem.

My assumption is that the issue is that Solaris doesn't
have a -lutil (it's helpful to quote the linker or
compiler error message for this kind of patch to clarify
what the failure is that we're trying to fix).

It looks like we use libutil here for openpty, which
is used in the test-char test. But the condition we're
using in tests/Makefile.include isn't the same as the
one we used to decide whether to add -lutil to the
emulator binary link line, which is in configure:

if test "$darwin" != "yes" -a "$mingw32" != "yes" -a "$solaris" != yes -a \
        "$aix" != "yes" -a "$haiku" != "yes" ; then
    libs_softmmu="-lutil $libs_softmmu"
fi

So I think I'd prefer it if we have:
 * a configure test for "is openpty() in libutil"
 * use that to determine whether to add -lutil to
   libs_softmmu and to the libs for tests, rather than
   doing OS-specific tests

Q: does Solaris still not have an openpty() implementation?
Currently we have a local implementation in util/qemu-openpty.c,
but if that workaround is only needed in old Solaris we don't
support any more we could perhaps drop it.

thanks
-- PMM
