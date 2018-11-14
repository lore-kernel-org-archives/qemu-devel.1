Received: from eggs.gnu.org ([2001:4830:134:3::10]:46942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gMwiu-0002iH-BZ
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 10:04:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gMwiq-0003nb-9K
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 10:04:56 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:56228)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gMwio-0003f2-8q
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 10:04:50 -0500
Received: by mail-wm1-x343.google.com with SMTP id i73-v6so10505924wmd.5
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 07:04:48 -0800 (PST)
References: <20181114130428.32326-1-asanchez@kryptoslogic.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181114130428.32326-1-asanchez@kryptoslogic.com>
Date: Wed, 14 Nov 2018 15:04:44 +0000
Message-ID: <87y39vd7jn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hax: Support for Linux hosts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexandro Sanchez Bach <asanchez@kryptoslogic.com>, Eduardo Habkost <ehabkost@redhat.com>, yu.ning@intel.com, Richard Henderson <rth@twiddle.net>


Alexandro Sanchez Bach <asanchez@kryptoslogic.com> writes:

> Intel HAXM supports now 32-bit and 64-bit Linux hosts. This patch includes
> the corresponding userland changes.
>
> Since the Darwin userland backend is POSIX-compliant, the hax-darwin.{c,h}
> files have been renamed to hax-posix.{c,h}. This prefix is consistent with
> the naming used in the rest of QEMU.
>
> Signed-off-by: Alexandro Sanchez Bach <asanchez@kryptoslogic.com>
> ---
>  target/i386/Makefile.objs                 |  5 ++++-
>  target/i386/hax-i386.h                    | 10 +++++++++-
>  target/i386/{hax-darwin.c =3D> hax-posix.c} |  0
>  target/i386/{hax-darwin.h =3D> hax-posix.h} |  0
>  4 files changed, 13 insertions(+), 2 deletions(-)
>  rename target/i386/{hax-darwin.c =3D> hax-posix.c} (100%)
>  rename target/i386/{hax-darwin.h =3D> hax-posix.h} (100%)
>
> diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs
> index 04678f5503..be36d31d23 100644
> --- a/target/i386/Makefile.objs
> +++ b/target/i386/Makefile.objs
> @@ -12,8 +12,11 @@ obj-$(call lnot,$(CONFIG_SEV)) +=3D sev-stub.o
>  ifdef CONFIG_WIN32
>  obj-$(CONFIG_HAX) +=3D hax-all.o hax-mem.o hax-windows.o
>  endif
> +ifdef CONFIG_LINUX
> +obj-$(CONFIG_HAX) +=3D hax-all.o hax-mem.o hax-posix.o
> +endif
>  ifdef CONFIG_DARWIN
> -obj-$(CONFIG_HAX) +=3D hax-all.o hax-mem.o hax-darwin.o
> +obj-$(CONFIG_HAX) +=3D hax-all.o hax-mem.o hax-posix.o

This is starting to get repetitive, perhaps:

  obj-$(CONFIG_HAX) +=3D hax-all.o hax-mem.o
  ifneq ($(CONFIG_LINUX)$(CONFIG_DARWIN),)
  obj-$(CONFIG_HAX) +=3D hax-posix.o
  endif
  ifdef CONFIG_WIN32
  obj-$(CONFIG_HAX) +=3D hax-windows.o
  endif

Would be better?

>  obj-$(CONFIG_HVF) +=3D hvf/
>  endif
>  obj-$(CONFIG_WHPX) +=3D whpx-all.o
> diff --git a/target/i386/hax-i386.h b/target/i386/hax-i386.h
> index 6abc156f88..f87a64c9df 100644
> --- a/target/i386/hax-i386.h
> +++ b/target/i386/hax-i386.h
> @@ -20,6 +20,10 @@
>  typedef int hax_fd;
>  #endif
>
> +#ifdef CONFIG_LINUX
> +typedef int hax_fd;
> +#endif

Again this could be merged with the other POSIX like above.

> +
>  #ifdef CONFIG_WIN32
>  typedef HANDLE hax_fd;
>  #endif
> @@ -83,7 +87,11 @@ void hax_memory_init(void);
>
>
>  #ifdef CONFIG_DARWIN
> -#include "target/i386/hax-darwin.h"
> +#include "target/i386/hax-posix.h"
> +#endif
> +
> +#ifdef CONFIG_LINUX
> +#include "target/i386/hax-posix.h"
>  #endif

And here.

In fact looking at my config-host.mak we have a CONFIG_POSIX so you
could use that.

>
>  #ifdef CONFIG_WIN32
> diff --git a/target/i386/hax-darwin.c b/target/i386/hax-posix.c
> similarity index 100%
> rename from target/i386/hax-darwin.c
> rename to target/i386/hax-posix.c
> diff --git a/target/i386/hax-darwin.h b/target/i386/hax-posix.h
> similarity index 100%
> rename from target/i386/hax-darwin.h
> rename to target/i386/hax-posix.h


--
Alex Benn=C3=A9e
