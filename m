Received: from eggs.gnu.org ([2001:4830:134:3::10]:56523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eRKrR-0004SD-EU
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 11:35:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eRKrO-0001Al-Hy
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 11:35:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eRKrO-00019c-BI
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 11:35:18 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7F822C0050CB
	for <qemu-devel@nongnu.org>; Tue, 19 Dec 2017 16:35:17 +0000 (UTC)
References: <20171215150659.1811-1-marcandre.lureau@redhat.com>
	<20171215150659.1811-3-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8d27589c-50a3-69b4-adca-f44f076057a8@redhat.com>
Date: Tue, 19 Dec 2017 10:35:13 -0600
MIME-Version: 1.0
In-Reply-To: <20171215150659.1811-3-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 02/13] build-sys: silence make by
 default or V=0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On 12/15/2017 09:06 AM, Marc-Andr=C3=A9 Lureau wrote:
> Move generic make flags in MAKEFLAGS (SUBDIR_MAKEFLAGS is more qemu spe=
cific).
>=20
> Use --quiet to silence make 'is up to date' message.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>   Makefile  | 2 +-
>   rules.mak | 2 ++
>   2 files changed, 3 insertions(+), 1 deletion(-)

Tested-by: Eric Blake <eblake@redhat.com>

I'd still like a second opinion from another make expert (Paolo?) on=20
whether this makes sense.  Thus, even though it looks sane to me, I'm=20
not (yet) giving R-b.

>=20
> diff --git a/Makefile b/Makefile
> index 0331c182ed..199f39fde1 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -274,7 +274,7 @@ else
>   DOCS=3D
>   endif
>  =20
> -SUBDIR_MAKEFLAGS=3D$(if $(V),,--no-print-directory) BUILD_DIR=3D$(BUIL=
D_DIR)
> +SUBDIR_MAKEFLAGS=3DBUILD_DIR=3D$(BUILD_DIR)
>   SUBDIR_DEVICES_MAK=3D$(patsubst %, %/config-devices.mak, $(TARGET_DIR=
S))
>   SUBDIR_DEVICES_MAK_DEP=3D$(patsubst %, %-config-devices.mak.d, $(TARG=
ET_DIRS))
>  =20
> diff --git a/rules.mak b/rules.mak
> index 6e943335f3..5fb4951561 100644
> --- a/rules.mak
> +++ b/rules.mak
> @@ -131,6 +131,8 @@ modules:
>   # If called with only a single argument, will print nothing in quiet =
mode.
>   quiet-command =3D $(if $(V),$1,$(if $(2),@printf "  %-7s %s\n" $2 $3 =
&& $1, @$1))
>  =20
> +MAKEFLAGS +=3D $(if $(V),,--no-print-directory --quiet)
> +
>   # cc-option
>   # Usage: CFLAGS+=3D$(call cc-option, -falign-functions=3D0, -malign-f=
unctions=3D0)
>  =20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
