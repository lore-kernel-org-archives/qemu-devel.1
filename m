Received: from eggs.gnu.org ([2001:4830:134:3::10]:34187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPcBi-0003YH-BV
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 16:36:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPcBf-0002YH-8f
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 16:36:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32950)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cPcBf-0002Xn-0F
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 16:36:35 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8D5E29D781
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 21:36:34 +0000 (UTC)
References: <20170105165329.17227-1-marcandre.lureau@redhat.com>
	<20170105165329.17227-8-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6a8eaa9b-ce63-1ff4-bfba-765de67a5bb8@redhat.com>
Date: Fri, 6 Jan 2017 15:36:31 -0600
MIME-Version: 1.0
In-Reply-To: <20170105165329.17227-8-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1oDRca2oCnfNafsDCkL3wPU4X8MaVQS0S"
Subject: Re: [Qemu-devel] [PATCH 07/20] char: move callbacks in CharDriver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1oDRca2oCnfNafsDCkL3wPU4X8MaVQS0S
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <6a8eaa9b-ce63-1ff4-bfba-765de67a5bb8@redhat.com>
Subject: Re: [PATCH 07/20] char: move callbacks in CharDriver
References: <20170105165329.17227-1-marcandre.lureau@redhat.com>
 <20170105165329.17227-8-marcandre.lureau@redhat.com>
In-Reply-To: <20170105165329.17227-8-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/05/2017 10:53 AM, Marc-Andr=C3=A9 Lureau wrote:
> This makes the code more declarative, and avoids duplicating the
> information on all instances.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/sysemu/char.h |  46 ++---
>  backends/baum.c       |  11 +-
>  backends/msmouse.c    |  11 +-
>  backends/testdev.c    |   8 +-
>  gdbstub.c             |   7 +-
>  hw/bt/hci-csr.c       |   8 +-
>  qemu-char.c           | 489 +++++++++++++++++++++++++++++-------------=
--------
>  spice-qemu-char.c     |  32 ++--
>  ui/console.c          |  28 +--
>  ui/gtk.c              |  11 +-
>  10 files changed, 381 insertions(+), 270 deletions(-)
>=20

> +++ b/gdbstub.c
> @@ -1730,6 +1730,10 @@ int gdbserver_start(const char *device)
>      CharDriverState *chr =3D NULL;
>      CharDriverState *mon_chr;
>      ChardevCommon common =3D { 0 };
> +    static const CharDriver driver =3D {
> +        .kind =3D -1,
> +        .chr_write =3D gdb_monitor_write

Missing a trailing comma.

> @@ -2624,7 +2639,7 @@ static CharDriverState *qemu_chr_open_stdio(const=
 char *id,
>      int                is_console =3D 0;
>      ChardevCommon *common =3D qapi_ChardevStdio_base(backend->u.stdio.=
data);
> =20
> -    chr   =3D qemu_chr_alloc(common, errp);
> +    chr   =3D qemu_chr_alloc(driver, common, errp);

Minor, but it looks like there's not much to align to anymore, and we
could trim it to one space while touching it.  But I don't care if it
stays the same, either, given the weird alignment on is_console a bit
earlier.

> +static const CharDriver ringbuf_driver =3D {
> +    .kind =3D CHARDEV_BACKEND_KIND_RINGBUF,
> +    .parse =3D qemu_chr_parse_ringbuf,
> +    .create =3D qemu_chr_open_ringbuf,
> +    .chr_write =3D ringbuf_chr_write,
> +    .chr_free =3D ringbuf_chr_free,
> +};
> +
> +/* Bug-compatibility: */
> +static const CharDriver memory_driver =3D {
> +    .kind =3D CHARDEV_BACKEND_KIND_MEMORY,
> +    .parse =3D qemu_chr_parse_ringbuf,
> +    .create =3D qemu_chr_open_ringbuf,
> +    .chr_write =3D ringbuf_chr_write,
> +    .chr_free =3D ringbuf_chr_free,
> +};

Again, depending on what we decide to do about the QAPI, we could delete
the 'memory' value from QMP and use .alias to still support it from the
command line, for just one driver instead of two here, if desired.  But
not a show-stopper if we don't make that decision before this patch, thou=
gh.

> -#if defined HAVE_CHARDEV_SERIAL
> -        {
> -            .kind =3D CHARDEV_BACKEND_KIND_SERIAL,
> -            .alias =3D "tty",
> -            .parse =3D qemu_chr_parse_serial,
> -            .create =3D qmp_chardev_open_serial,
> -        },
> -        {
> -            .kind =3D CHARDEV_BACKEND_KIND_SERIAL,
> -            .parse =3D qemu_chr_parse_serial,
> -            .create =3D qmp_chardev_open_serial,
> -        },
> +    static const CharDriver *drivers[] =3D {
> +        &null_driver,
> +        &socket_driver,
> +        &udp_driver,
> +        &ringbuf_driver,
> +        &file_driver,
> +        &stdio_driver,
> +#ifdef HAVE_CHARDEV_SERIAL
> +        &serial_driver,
>  #endif

Will be some rebase churn here as you deal with my comments on earlier
patches, but they should be obvious enough that it shouldn't affect my
review.

With nits fixed,
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--1oDRca2oCnfNafsDCkL3wPU4X8MaVQS0S
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYcA3fAAoJEKeha0olJ0NqvD0H/A8PXr/n5+ECKZAAX2xRRZVk
9nFA7grOKI/Q3Mc89ymPZ2td8ZVerOBWfrOoHJ7DRJ9jX0NhpVYokLrAgFe+99OT
HrhkmVwq7l3ER5XJa6UKb9rUvIqBawvkOzvJLNyigptmyuzuudDvHB1CiFTFe3/f
FNK2+WvwW2+mK3CJGG2F1W3oA0kdPRcLyveFs6lotKVgdNYJx8Bbt/8u3wpdw/Mz
J/Cid5D5lGeTMxN+DTnIiWczbM0swNkoYhyrHTyhPqWsXM+8mVd3+hMW+YtQu1lC
P6gKhJ0G8nkX6CWM9m8GZX3zzXXcUCGftIz9oEfdVhFcJds3EvC6EDSujX5c/1s=
=TnPN
-----END PGP SIGNATURE-----

--1oDRca2oCnfNafsDCkL3wPU4X8MaVQS0S--
