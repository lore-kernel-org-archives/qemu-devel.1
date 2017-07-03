Received: from eggs.gnu.org ([2001:4830:134:3::10]:41295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS3ir-0004dK-2f
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 11:57:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dS3iq-0000BG-4w
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 11:57:13 -0400
References: <20170629184320.7151-1-el13635@mail.ntua.gr>
	<20170629184320.7151-2-el13635@mail.ntua.gr>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8d2c43fd-d680-a268-f9e1-e960c92160c6@redhat.com>
Date: Mon, 3 Jul 2017 10:56:59 -0500
MIME-Version: 1.0
In-Reply-To: <20170629184320.7151-2-el13635@mail.ntua.gr>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0clDL8nePtBdHSsm3CH1FMfWsmt0whjkl"
Subject: Re: [Qemu-devel] [PATCH v2 1/3] block: pass bdrv_* methods to
 bs->file by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>, qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0clDL8nePtBdHSsm3CH1FMfWsmt0whjkl
From: Eric Blake <eblake@redhat.com>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>,
 qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Message-ID: <8d2c43fd-d680-a268-f9e1-e960c92160c6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] block: pass bdrv_* methods to
 bs->file by default
References: <20170629184320.7151-1-el13635@mail.ntua.gr>
 <20170629184320.7151-2-el13635@mail.ntua.gr>
In-Reply-To: <20170629184320.7151-2-el13635@mail.ntua.gr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/29/2017 01:43 PM, Manos Pitsidianakis wrote:
> The following functions fail if bs->drv does not implement them:
>=20
> bdrv_probe_blocksizes
> bdrv_probe_geometry
> bdrv_truncate
> bdrv_has_zero_init
> bdrv_get_info
> bdrv_media_changed
> bdrv_eject
> bdrv_lock_medium
> bdrv_co_ioctl
>=20
> Instead, the call should be passed to bs->file if it exists, to allow
> filter drivers to support those methods without implementing them.
>=20
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> ---
>  block.c    | 27 +++++++++++++++++++++++++--
>  block/io.c |  5 +++++
>  2 files changed, 30 insertions(+), 2 deletions(-)

Did you check whether any other existing drivers can be cleaned up to
rely on the defaults?  Or is it just the raw driver that you cleaned in 2=
/3?

At any rate, this makes sense to me.  However,

> @@ -4205,6 +4222,8 @@ int bdrv_media_changed(BlockDriverState *bs)
> =20
>      if (drv && drv->bdrv_media_changed) {
>          return drv->bdrv_media_changed(bs);
> +    } else if (drv && bs->file && bs->file->bs) {
> +        bdrv_media_changed(bs->file->bs);
>      }
>      return -ENOTSUP;

This one returns -ENOTSUP unconditionally after recursing; looks like
you omitted 'return'.

If that's the only fix you make for v3, you can add:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--0clDL8nePtBdHSsm3CH1FMfWsmt0whjkl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZWmlLAAoJEKeha0olJ0Nq/cYH/i5TN/D0S2XDJwRXXq1YlcTq
KCe8bx7iJKEVwQdWcpcOCafOMAgxTU0AjQPkdUy7bel3sJlWtuNLxSyBog7+9XpD
Mqbef/nZHanIiVX8jvxY5JNzKilA45T03lSxpbTTH+5DiqQu/dDNRbmxYM5G2TIA
9buDmm77P+92mGOGQmq+y2ey/4d/kZzIxn4kndHqrHuDqSSCLH8i9m3/GIyVlyCa
jV7Tf7Ku/LEeRwxMzQ6Ze6SoXoGov9VH+AWyZImsoCoCC5C3KEVsTHUp55tQ4yyw
u3GlP0MgQPt3PduwQvd1syMFlFYUpK0dsrCyo0RW4Yhou71sz7SbOnDzJEGLAIM=
=i6Nd
-----END PGP SIGNATURE-----

--0clDL8nePtBdHSsm3CH1FMfWsmt0whjkl--
