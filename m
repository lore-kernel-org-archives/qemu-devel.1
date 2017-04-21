Received: from eggs.gnu.org ([2001:4830:134:3::10]:50329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d1YqE-0002i4-UN
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 09:43:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d1YqD-00013t-UD
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 09:43:18 -0400
References: <1492765915-32253-1-git-send-email-pl@kamp.de>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ae879569-b0a0-0c99-f6a6-ec4853dd2fc0@redhat.com>
Date: Fri, 21 Apr 2017 08:43:04 -0500
MIME-Version: 1.0
In-Reply-To: <1492765915-32253-1-git-send-email-pl@kamp.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Ikh4if2IAfEE7bkAHagiHdNsFmjQ5bM1h"
Subject: Re: [Qemu-devel] [PATCH V2] qemu-img: simplify img_convert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, famz@redhat.com, stefanha@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ikh4if2IAfEE7bkAHagiHdNsFmjQ5bM1h
From: Eric Blake <eblake@redhat.com>
To: Peter Lieven <pl@kamp.de>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, famz@redhat.com,
 stefanha@redhat.com, mreitz@redhat.com
Message-ID: <ae879569-b0a0-0c99-f6a6-ec4853dd2fc0@redhat.com>
Subject: Re: [PATCH V2] qemu-img: simplify img_convert
References: <1492765915-32253-1-git-send-email-pl@kamp.de>
In-Reply-To: <1492765915-32253-1-git-send-email-pl@kamp.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/21/2017 04:11 AM, Peter Lieven wrote:
> img_convert has been around before there was an ImgConvertState or
> a block backend, but it has never been modified to directly use
> these structs. Change this by parsing parameters directly into
> the ImgConvertState and directly use BlockBackend where possible.
> Furthermore variable initialization has been reworked and sorted.
>=20
> Signed-off-by: Peter Lieven <pl@kamp.de>
> ---
> V1->V2: - fix s.target_has_backing [Fam]
>         - remove compress and use s.compressed everywhere [Kevin]
>         - Fix indent at one place
>         - Fix typos in commit msg [Eric]
>         - Further organize the local stack variables
>=20

> -    int c, bs_n, bs_i, compress, cluster_sectors, skip_create;
> -    int64_t ret =3D 0;
> -    int progress =3D 0, flags, src_flags;
> -    bool writethrough, src_writethrough;
> -    const char *fmt, *out_fmt, *cache, *src_cache, *out_baseimg, *out_=
filename;
> +    int c, bs_i, flags, src_flags =3D 0;
> +    const char *fmt =3D NULL, *out_fmt =3D "raw", *cache =3D "unsafe",=

> +               *src_cache =3D BDRV_DEFAULT_CACHE, *out_baseimg =3D NUL=
L,
> +               *out_filename, *out_baseimg_param, *snapshot_name =3D N=
ULL;

I'm not necessarily a fan of cramming as many variables as possible
under one type declaration. It creates more churn (aka larger diffs)
down the road if one of the variables has to change type, compared to
the case where every variable has its own line.  But nothing in HACKING
requires either crammed-together or one-per-line declarations, so it's
not worth changing.

> =20
> =20
> -    if (bs_n > 1 && out_baseimg) {
> +    if (s.src_num > 1 && out_baseimg) {
>          error_report("-B makes no sense when concatenating multiple in=
put "
>                       "images");


There's other patches on list that will conflict in this region.  But I
think the plan is that Kevin will take your v2, then have those patches
rebased on top of yours.

> @@ -2224,9 +2204,10 @@ static int img_convert(int argc, char **argv)
>      if (out_baseimg_param) {
>          out_baseimg =3D out_baseimg_param;
>      }
> +    s.target_has_backing =3D (bool) out_baseimg;

That's an unusual spelling. The compiler does the right thing without
the cast, and if you are still worried, writing !!out_baseimg is less
typing (and fewer casts) for the same effect.

At any rate, it fixes the failures I'm seeing on iotests 019.

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Ikh4if2IAfEE7bkAHagiHdNsFmjQ5bM1h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY+gxoAAoJEKeha0olJ0NqeG4H/3/8cw+s3pW9aEBaxvxxpKQy
c55DjCiMuUq/dEDo4PF92AvDP9t+OHGl9TGlTK4p0mQ5ijZKc4VnTc9w/aBF9Bqw
chdF5ev+nPqp0QXF+RTD9hcPHrTWPrI/sqgcPLQFz74SqEHdVNDg1tThbdRIBTlZ
HaaYTAXDJEp4uxUYIDlpLRxw1DbLi12i2vK5Wjzi1RMKhBNaI1s0k4vIBFnwevTg
OcFZSHEwHA3Nm55mfCedCbFIlR85Vl+S1Sn8/y6UzHG3ch53gzg/oKw67jm/HvIT
tB8xJTckUDqdt3enNJccev+q3yBd39sFdYTSfRqJXnQ7N/EqhFHtcQ4e5Q/zTxI=
=Ewfn
-----END PGP SIGNATURE-----

--Ikh4if2IAfEE7bkAHagiHdNsFmjQ5bM1h--
