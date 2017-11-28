Received: from eggs.gnu.org ([2001:4830:134:3::10]:57654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eJeI2-00020F-6p
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 06:43:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1eJeI0-0004LQ-TX
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 06:43:02 -0500
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:35106)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1eJeI0-0004LC-MI
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 06:43:00 -0500
Received: by mail-wr0-x242.google.com with SMTP id w95so57625wrc.2
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 03:43:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171128113204.22912-1-pbonzini@redhat.com>
References: <20171128113204.22912-1-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 28 Nov 2017 12:42:58 +0100
Message-ID: <CAJ+F1CLzoyrtwG=iiB0_ocMGELrYY9-v_pm4AGaShFw3_CzHhQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] memfd: fix configure test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Cole Robinson <crobinso@redhat.com>, fweimer@redhat.com

Hi

On Tue, Nov 28, 2017 at 12:32 PM, Paolo Bonzini <pbonzini@redhat.com> wrote=
:
> Recent glibc added memfd_create in sys/mman.h.  This conflicts with
> the definition in util/memfd.c:
>
>     /builddir/build/BUILD/qemu-2.11.0-rc1/util/memfd.c:40:12: error: stat=
ic declaration of memfd_create follows non-static declaration
>
> Fix the configure test, and remove the sys/memfd.h inclusion since the
> file actually does not exist---it is a typo in the memfd_create(2) man
> page.
>

It is introduced by this commit, right?
https://sourceware.org/git/?p=3Dglibc.git;a=3Dcommit;h=3D59d2cbb1fe4b8601d5=
cbd359c3806973eab6c62d

(I added Florian Weimer in cc)

So it's not part of glibc release yet.

Couldn't the declarations be put in sys/memfd.h like the man claimed
it would be for > 1y?


> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  configure    | 2 +-
>  util/memfd.c | 4 +---
>  2 files changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/configure b/configure
> index e31d6a7fee..11eac205ec 100755
> --- a/configure
> +++ b/configure
> @@ -3910,7 +3910,7 @@ fi
>  # check if memfd is supported
>  memfd=3Dno
>  cat > $TMPC << EOF
> -#include <sys/memfd.h>
> +#include <sys/mman.h>
>
>  int main(void)
>  {
> diff --git a/util/memfd.c b/util/memfd.c
> index 4571d1aba8..412e94a405 100644
> --- a/util/memfd.c
> +++ b/util/memfd.c
> @@ -31,9 +31,7 @@
>
>  #include "qemu/memfd.h"
>
> -#ifdef CONFIG_MEMFD
> -#include <sys/memfd.h>
> -#elif defined CONFIG_LINUX
> +#if defined CONFIG_LINUX && !defined CONFIG_MEMFD
>  #include <sys/syscall.h>
>  #include <asm/unistd.h>
> --
> 2.14.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
