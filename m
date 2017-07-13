Received: from eggs.gnu.org ([2001:4830:134:3::10]:50626)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVT23-0006Pj-M7
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 21:35:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVT22-0004yF-KP
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 21:35:07 -0400
References: <20170711163748.17817-1-el13635@mail.ntua.gr>
	<20170711163748.17817-2-el13635@mail.ntua.gr>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4b9e0c05-db46-6174-a543-1226b4fc7402@redhat.com>
Date: Wed, 12 Jul 2017 20:34:54 -0500
MIME-Version: 1.0
In-Reply-To: <20170711163748.17817-2-el13635@mail.ntua.gr>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mbrv5tp4l6CAGQi4HvFfxtQqQSVr3JKd8"
Subject: Re: [Qemu-devel] [PATCH v4 1/4] block: pass bdrv_* methods to
 bs->file by default in block filters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mbrv5tp4l6CAGQi4HvFfxtQqQSVr3JKd8
From: Eric Blake <eblake@redhat.com>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Alberto Garcia <berto@igalia.com>,
 qemu-block <qemu-block@nongnu.org>
Message-ID: <4b9e0c05-db46-6174-a543-1226b4fc7402@redhat.com>
Subject: Re: [PATCH v4 1/4] block: pass bdrv_* methods to bs->file by default
 in block filters
References: <20170711163748.17817-1-el13635@mail.ntua.gr>
 <20170711163748.17817-2-el13635@mail.ntua.gr>
In-Reply-To: <20170711163748.17817-2-el13635@mail.ntua.gr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/11/2017 11:37 AM, Manos Pitsidianakis wrote:
> The following functions fail if bs->drv is a filter and does not
> implement them:
>=20
> bdrv_probe_blocksizes
> bdrv_probe_geometry
> bdrv_truncate
> bdrv_has_zero_init
> bdrv_get_info
>=20
> Instead, the call should be passed to bs->file if it exists, to allow
> filter drivers to support those methods without implementing them. This=

> commit makes `drv->is_filter =3D true` imply that these callbacks will =
be
> forwarded to bs->file by default, so disabling support for these
> functions must be done explicitly.
>=20
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> ---
>  block.c                   | 21 +++++++++++++++++++--
>  include/block/block_int.h |  6 +++++-
>  2 files changed, 24 insertions(+), 3 deletions(-)

> @@ -3406,11 +3410,15 @@ int bdrv_truncate(BdrvChild *child, int64_t off=
set, Error **errp)
> =20
>      assert(child->perm & BLK_PERM_RESIZE);
> =20
> +    /* if bs->drv =3D=3D NULL, bs is closed, so there's nothing to do =
here */
>      if (!drv) {
>          error_setg(errp, "No medium inserted");
>          return -ENOMEDIUM;
>      }
>      if (!drv->bdrv_truncate) {
> +        if (bs->file && drv->is_filter) {
> +            return bdrv_truncate(bs->file, offset, errp);
> +        }

This has a semantic (but not merge) conflict with Max's preallocation
work, and it started to be non-trivial for me to adjust locally in my
testing. It may be easiest if you send a v5 on top of
'https://github.com/XanClic/qemu.git block', since Max already has a
pending pull request:

https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg02841.html

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--mbrv5tp4l6CAGQi4HvFfxtQqQSVr3JKd8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZZs4+AAoJEKeha0olJ0NqoyUH/1nj21N44fJVe4cBpOYPoVEn
ycBfUqQ9AtM3JQHiLeim230bmFuYt3+gn+op+EvhToHVDT3a1z8H1ZGDMeE/xVHk
Du6IWh1RDYxGXHLa/GvU79rM03B48piSVMjvwAncit9zZSGy2TvVkg4r8TedV6/W
YC4l7CwFyJqWQCkJaQ3cx0aDopsN47WTojM0aZULVhHN8KFsfOvdr6lEoa2PipsW
YTpU1QFoxqVypWQbdIogDV5XzjGzut+xkHWYtwW11Se8qYxoGTyuL80NUZCVgut1
wqNyR3fHWhlLlOzmx3cRQFAAPDz3Viqr+4OXyaZFNfcutpZ28RfvnOiH8LN05zw=
=9bbA
-----END PGP SIGNATURE-----

--mbrv5tp4l6CAGQi4HvFfxtQqQSVr3JKd8--
