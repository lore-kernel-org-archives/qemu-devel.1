Received: from eggs.gnu.org ([2001:4830:134:3::10]:44024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cosqa-0007I3-7N
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 10:27:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cosqZ-0001kK-8q
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 10:27:16 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:36020)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cosqZ-0001kD-1Y
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 10:27:15 -0400
Received: by mail-wr0-x22a.google.com with SMTP id u108so53087130wrb.3
	for <qemu-devel@nongnu.org>; Fri, 17 Mar 2017 07:27:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170316090048.23185-1-jordan.l.justen@intel.com>
References: <20170316090048.23185-1-jordan.l.justen@intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Mar 2017 14:26:53 +0000
Message-ID: <CAFEAcA_2eaD5SFj6BdffyAT71dh1KJJ7VZZDRUzmbT6q4ZK-Lg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] qemu: Fix -version with configure
 --with-pkgversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jordan Justen <jordan.l.justen@intel.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Fam Zheng <famz@redhat.com>, 1673373@bugs.launchpad.net, Paolo Bonzini <pbonzini@redhat.com>

On 16 March 2017 at 09:00, Jordan Justen <jordan.l.justen@intel.com> wrote:
> This appears to have regressed in 67a1de0d19.
>
> When the configure --with-pkgversion=foo option is used, the output
> from -version will look like:
>
> QEMU emulator version 2.8.90(foo)
> Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers
>
> After this patch, it will be:
>
> QEMU emulator version 2.8.90 (foo)
> Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers
>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Fam Zheng <famz@redhat.com>
> Fixes: https://bugs.launchpad.net/bugs/1673373
> Cc: 1673373@bugs.launchpad.net
> Signed-off-by: Jordan Justen <jordan.l.justen@intel.com>
> ---
>  Makefile  | 2 +-
>  configure | 2 +-
>  vl.c      | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Makefile b/Makefile
> index 1c4c04f6f2..c9df119798 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -289,7 +289,7 @@ qemu-version.h: FORCE
>                         printf '"$(PKGVERSION)"\n'; \
>                 else \
>                         if test -d .git; then \
> -                               printf '" ('; \
> +                               printf '"('; \
>                                 git describe --match 'v*' 2>/dev/null | tr -d '\n'; \
>                                 if ! git diff-index --quiet HEAD &>/dev/null; then \
>                                         printf -- '-dirty'; \
> diff --git a/configure b/configure
> index 99d8bece70..e94b06b5fc 100755
> --- a/configure
> +++ b/configure
> @@ -1004,7 +1004,7 @@ for opt do
>    ;;
>    --disable-blobs) blobs="no"
>    ;;
> -  --with-pkgversion=*) pkgversion=" ($optarg)"
> +  --with-pkgversion=*) pkgversion="($optarg)"
>    ;;
>    --with-coroutine=*) coroutine="$optarg"
>    ;;
> diff --git a/vl.c b/vl.c
> index 0b4ed5241c..3e60e61905 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -1904,7 +1904,7 @@ static void main_loop(void)
>
>  static void version(void)
>  {
> -    printf("QEMU emulator version " QEMU_VERSION QEMU_PKGVERSION "\n"
> +    printf("QEMU emulator version " QEMU_VERSION " " QEMU_PKGVERSION "\n"
>             QEMU_COPYRIGHT "\n");
>  }

This is not the only place where we assemble a string from
QEMU_VERSION QEMU_PKGVERSION, so if you want to change from the
original approach where QEMU_PKGVERSION had a space in it then
you need to change the other places too.

Also it looks like we return QEMU_PKGVERSION as part of the
QMP qmp_query_version() code, so we should check to see what
the expected behaviour there is regarding having the space
or not.

I think when I wrote those printfs I was expecting that
QEMU_PKGVERSION might be a "-something" kind of string,
and so did whoever wrote the commit log for 67a1de0d19.
However looking at git history it seems to have always been
a " (something)" format, so obviously some confusion here...

thanks
-- PMM
