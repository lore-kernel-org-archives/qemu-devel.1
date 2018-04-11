Received: from eggs.gnu.org ([2001:4830:134:3::10]:45324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f6Fi4-0001Wn-52
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 09:22:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1f6Fi2-0003GQ-Tk
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 09:22:48 -0400
References: <20180411122606.367301-1-vsementsov@virtuozzo.com>
	<20180411122606.367301-2-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b763ca01-d906-dbf8-2eb6-48e4140d2efe@redhat.com>
Date: Wed, 11 Apr 2018 08:22:36 -0500
MIME-Version: 1.0
In-Reply-To: <20180411122606.367301-2-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eb1BepEJyQTHYmaUGkrDjcPpiKuHmkfy3"
Subject: Re: [Qemu-devel] [PATCH v2 1/2] qcow2: try load bitmaps only once
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, jsnow@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eb1BepEJyQTHYmaUGkrDjcPpiKuHmkfy3
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org, jsnow@redhat.com, mreitz@redhat.com
Message-ID: <b763ca01-d906-dbf8-2eb6-48e4140d2efe@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] qcow2: try load bitmaps only once
References: <20180411122606.367301-1-vsementsov@virtuozzo.com>
 <20180411122606.367301-2-vsementsov@virtuozzo.com>
In-Reply-To: <20180411122606.367301-2-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/11/2018 07:26 AM, Vladimir Sementsov-Ogievskiy wrote:
> Checking reopen by existence of some bitmaps is wrong, as it may be
> some other bitmaps, or on the other hand, user may remove bitmaps. This=

> criteria is bad. To simplify things and make behavior more predictable
> let's just add a flag to remember, that we've already tried to load
> bitmaps on open and do not want do it again.

Wording suggestion:

Checking whether we are reopening an image based on the existence of
some bitmaps is wrong, as the set of bitmaps may have changed (for
example, the user may have added or removed bitmaps in the meantime).
To simplify things and make behavior more predictable, let's just add a
flag to remember whether we've already tried to load bitmaps, so that we
only attempt it on the initial open.

>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2.h |  1 +
>  block/qcow2.c | 16 ++++++++--------
>  2 files changed, 9 insertions(+), 8 deletions(-)
>=20
> @@ -1480,10 +1481,9 @@ static int coroutine_fn qcow2_do_open(BlockDrive=
rState *bs, QDict *options,
>          s->autoclear_features &=3D QCOW2_AUTOCLEAR_MASK;
>      }
> =20
> -    if (bdrv_dirty_bitmap_next(bs, NULL)) {
> -        /* It's some kind of reopen with already existing dirty bitmap=
s. There
> -         * are no known cases where we need loading bitmaps in such si=
tuation,
> -         * so it's safer don't load them.
> +    if (s->dirty_bitmaps_loaded) {
> +        /* It's some kind of reopen. There are no known cases where we=
 need
> +         * loading bitmaps in such situation, so it's safer don't load=
 them.

Pre-existing wording, but sounds better as:

There are no known cases where we need to reload bitmaps in such a
situation, so it's safer to skip them.

>           *
>           * Moreover, if we have some readonly bitmaps and we are reope=
ning for
>           * rw we should reopen bitmaps correspondingly.
> @@ -1491,13 +1491,13 @@ static int coroutine_fn qcow2_do_open(BlockDriv=
erState *bs, QDict *options,
>          if (bdrv_has_readonly_bitmaps(bs) &&
>              !bdrv_is_read_only(bs) && !(bdrv_get_flags(bs) & BDRV_O_IN=
ACTIVE))
>          {
> -            bool header_updated =3D false;
>              qcow2_reopen_bitmaps_rw_hint(bs, &header_updated, &local_e=
rr);
> -            update_header =3D update_header && !header_updated;
>          }
> -    } else if (qcow2_load_dirty_bitmaps(bs, &local_err)) {
> -        update_header =3D false;
> +    } else {
> +        header_updated =3D qcow2_load_dirty_bitmaps(bs, &local_err);
> +        s->dirty_bitmaps_loaded =3D true;
>      }
> +    update_header =3D update_header && !header_updated;

Could write this as 'update_header &=3D !header_updated;'

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--eb1BepEJyQTHYmaUGkrDjcPpiKuHmkfy3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlrODBwACgkQp6FrSiUn
Q2rXPggAqzzvigiJKdNv0pZ6nV8NTq5posyJWrTxrq5FkznBOnLMAOS88WCFsJ6w
1ZLkRan1n8WPqPPi6D5JHGU4FgB3viIiIuudyM2Q1UZCVBwTWKulSROCFhLZ76EE
XNkivksW585havtgU7NA/bgdztJUGdTzzKwOXrmW7wt5NkIXC0WjI5f3P2IMkG/M
LLTmjbJ/YNTfKJ3cg7DrMF6rROd7jicHLDogdnBsf1IuiHrPDCFs+LJ5R6SkkHA3
OfR8HWqffDZ9qgF5iK/zzgxVC+xYSD94HjTsrmjYMxFgmUQacv2VGOnRRJmKwZec
a38d+ImIUqEK+haEgN9YDE5l/AdvUA==
=pciT
-----END PGP SIGNATURE-----

--eb1BepEJyQTHYmaUGkrDjcPpiKuHmkfy3--
