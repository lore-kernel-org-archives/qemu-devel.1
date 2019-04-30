Received: from eggs.gnu.org ([209.51.188.92]:52932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLZVG-0002Jh-Bi
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:37:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLZUt-0003ov-CT
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 16:37:04 -0400
References: <cover.1556650594.git.alistair.francis@wdc.com>
	<f2aaec5b3c12a8512cd7078f3a5d1230906d80ea.1556650594.git.alistair.francis@wdc.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6650d0b8-1c5c-a8ea-ef92-a69ad50f7d8b@redhat.com>
Date: Tue, 30 Apr 2019 15:36:57 -0500
MIME-Version: 1.0
In-Reply-To: <f2aaec5b3c12a8512cd7078f3a5d1230906d80ea.1556650594.git.alistair.francis@wdc.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ygvcqInAwtIo00JF4xF60WCVo3qUrdqID"
Subject: Re: [Qemu-devel] [PATCH v1 3/5] hw/usb/dev-mtp: Fix GCC 9 build
 warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "laurent@vivier.eu" <laurent@vivier.eu>, "kraxel@redhat.com" <kraxel@redhat.com>, "alistair23@gmail.com" <alistair23@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ygvcqInAwtIo00JF4xF60WCVo3qUrdqID
From: Eric Blake <eblake@redhat.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 "riku.voipio@iki.fi" <riku.voipio@iki.fi>,
 "laurent@vivier.eu" <laurent@vivier.eu>,
 "kraxel@redhat.com" <kraxel@redhat.com>,
 "alistair23@gmail.com" <alistair23@gmail.com>
Message-ID: <6650d0b8-1c5c-a8ea-ef92-a69ad50f7d8b@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v1 3/5] hw/usb/dev-mtp: Fix GCC 9 build
 warning
References: <cover.1556650594.git.alistair.francis@wdc.com>
 <f2aaec5b3c12a8512cd7078f3a5d1230906d80ea.1556650594.git.alistair.francis@wdc.com>
In-Reply-To: <f2aaec5b3c12a8512cd7078f3a5d1230906d80ea.1556650594.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/30/19 3:09 PM, Alistair Francis wrote:
> Fix this warning with GCC 9 on Fedora 30:
> hw/usb/dev-mtp.c:1715:36: error: taking address of packed member of =E2=
=80=98struct <anonymous>=E2=80=99 may result in an unaligned pointer valu=
e [-Werror=3Daddress-of-packed-member]
>  1715 |                             dataset->filename);
>       |                             ~~~~~~~^~~~~~~~~~
>=20
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  hw/usb/dev-mtp.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
> index 99548b012d..6de85d99e6 100644
> --- a/hw/usb/dev-mtp.c
> +++ b/hw/usb/dev-mtp.c
> @@ -1711,9 +1711,22 @@ static void usb_mtp_write_metadata(MTPState *s, =
uint64_t dlen)
>      assert(!s->write_pending);
>      assert(p !=3D NULL);
> =20
> +/*
> + * We are about to access a packed struct. We are confident that the p=
ointer
> + * address won't be unalligned, so we ignore GCC warnings.

unaligned

Aren't there other potential proposed patches floating around for this
issue that do not involve messing with pragmas?

> + */
> +#if defined(CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE) && QEMU_GNUC_PREREQ(9,=
 0)
> +#pragma GCC diagnostic push
> +#pragma GCC diagnostic ignored "-Waddress-of-packed-member"
> +#endif
> +
>      filename =3D utf16_to_str(MIN(dataset->length, filename_chars),
>                              dataset->filename);
> =20
> +#if defined(CONFIG_PRAGMA_DIAGNOSTIC_AVAILABLE) && QEMU_GNUC_PREREQ(9,=
 0)
> +#pragma GCC diagnostic pop
> +#endif
> +
>      if (strchr(filename, '/')) {
>          usb_mtp_queue_result(s, RES_PARAMETER_NOT_SUPPORTED, d->trans,=

>                               0, 0, 0, 0);
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--ygvcqInAwtIo00JF4xF60WCVo3qUrdqID
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzIsekACgkQp6FrSiUn
Q2p4+wf/RgBhkn0HTl4PgCsaDlkgRu5sszuTi/mtEY7TfuV5l5gu8ez3f23n2/CW
VWg09kOgTtH9vTvtPjpGE1QLJYIomZISIEW/d7rHoDHo8YuE8Kq7BmD5GFE+QTpl
CvWs26jWs2wKUtHsZG4ZmTWc1JxQDm5GKEtAh2Sf8/DglaGAyMIFn/AYrGk7+0Yu
NmGXrVeYyxJeG+zBndyFF/A1X7i4DqkZgaLFXe+dZLTTCXeIkZh+ep00237SfMZC
anT99KaaD/yxqTplZlt2iFz4CDz6+lQfFx6ByelRSnzLmLohZmMGkw9tSikddGv+
rKdUqiR9uLSpxPWFkEe4C8XShC0Mrg==
=Z5LF
-----END PGP SIGNATURE-----

--ygvcqInAwtIo00JF4xF60WCVo3qUrdqID--
