Received: from eggs.gnu.org ([2001:4830:134:3::10]:42138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fDB3v-0003kd-EZ
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 11:50:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1fDB3s-0005yC-CM
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 11:49:59 -0400
Received: from 8.mo177.mail-out.ovh.net ([46.105.61.98]:57861)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1fDB3s-0005xr-59
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 11:49:56 -0400
Received: from player770.ha.ovh.net (unknown [10.109.120.3])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 690E6AF1CF
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 17:49:54 +0200 (CEST)
Date: Mon, 30 Apr 2018 17:49:48 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20180430174948.03484883@bahia.lan>
In-Reply-To: <1513790098-9815-2-git-send-email-pbonzini@redhat.com>
References: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
	<1513790098-9815-2-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 01/46] memfd: fix configure test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>, qemu-stable@nongnu.org

This one is needed to build QEMU 2.11.x on Ubuntu 18.04.

On Wed, 20 Dec 2017 18:14:13 +0100
Paolo Bonzini <pbonzini@redhat.com> wrote:

> Recent glibc added memfd_create in sys/mman.h.  This conflicts with
> the definition in util/memfd.c:
>=20
>     /builddir/build/BUILD/qemu-2.11.0-rc1/util/memfd.c:40:12: error: stat=
ic declaration of memfd_create follows non-static declaration
>=20
> Fix the configure test, and remove the sys/memfd.h inclusion since the
> file actually does not exist---it is a typo in the memfd_create(2) man
> page.
>=20
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  configure    | 2 +-
>  util/memfd.c | 4 +---
>  2 files changed, 2 insertions(+), 4 deletions(-)
>=20
> diff --git a/configure b/configure
> index 9c8aa5a..99ccc17 100755
> --- a/configure
> +++ b/configure
> @@ -3923,7 +3923,7 @@ fi
>  # check if memfd is supported
>  memfd=3Dno
>  cat > $TMPC << EOF
> -#include <sys/memfd.h>
> +#include <sys/mman.h>
> =20
>  int main(void)
>  {
> diff --git a/util/memfd.c b/util/memfd.c
> index 4571d1a..412e94a 100644
> --- a/util/memfd.c
> +++ b/util/memfd.c
> @@ -31,9 +31,7 @@
> =20
>  #include "qemu/memfd.h"
> =20
> -#ifdef CONFIG_MEMFD
> -#include <sys/memfd.h>
> -#elif defined CONFIG_LINUX
> +#if defined CONFIG_LINUX && !defined CONFIG_MEMFD
>  #include <sys/syscall.h>
>  #include <asm/unistd.h>
> =20
