Received: from eggs.gnu.org ([209.51.188.92]:34604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghJQ4-0005SG-L8
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 14:21:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghJQ1-0004ND-Uh
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 14:21:39 -0500
References: <20180609151758.17343-1-vsementsov@virtuozzo.com>
	<20180609151758.17343-5-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <91a97b47-abab-4508-09d5-a12ddd1a4101@redhat.com>
Date: Wed, 9 Jan 2019 13:21:12 -0600
MIME-Version: 1.0
In-Reply-To: <20180609151758.17343-5-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="d6Oicz2762RAR69TuTn3f1OYpM0MXfFWv"
Subject: Re: [Qemu-devel] [PATCH v5 4/6] nbd/server: implement dirty bitmap
 export
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--d6Oicz2762RAR69TuTn3f1OYpM0MXfFWv
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, mreitz@redhat.com,
 kwolf@redhat.com, den@openvz.org
Message-ID: <91a97b47-abab-4508-09d5-a12ddd1a4101@redhat.com>
Subject: Re: [PATCH v5 4/6] nbd/server: implement dirty bitmap export
References: <20180609151758.17343-1-vsementsov@virtuozzo.com>
 <20180609151758.17343-5-vsementsov@virtuozzo.com>
In-Reply-To: <20180609151758.17343-5-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Revisiting an older thread:

On 6/9/18 10:17 AM, Vladimir Sementsov-Ogievskiy wrote:
> Handle new NBD meta namespace: "qemu", and corresponding queries:
> "qemu:dirty-bitmap:<export bitmap name>".
>=20
> With new metadata context negotiated, BLOCK_STATUS query will reply
> with dirty-bitmap data, converted to extents. New public function
> nbd_export_bitmap selects bitmap to export. For now, only one bitmap
> may be exported.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

> @@ -2199,3 +2393,44 @@ void nbd_client_new(NBDExport *exp,
>      co =3D qemu_coroutine_create(nbd_co_client_start, client);
>      qemu_coroutine_enter(co);
>  }
> +
> +void nbd_export_bitmap(NBDExport *exp, const char *bitmap,
> +                       const char *bitmap_export_name, Error **errp)
> +{
> +    BdrvDirtyBitmap *bm =3D NULL;
> +    BlockDriverState *bs =3D blk_bs(exp->blk);
> +
> +    if (exp->export_bitmap) {
> +        error_setg(errp, "Export bitmap is already set");
> +        return;
> +    }
> +
> +    while (true) {
> +        bm =3D bdrv_find_dirty_bitmap(bs, bitmap);
> +        if (bm !=3D NULL || bs->backing =3D=3D NULL) {
> +            break;
> +        }
> +
> +        bs =3D bs->backing->bs;
> +    }
> +
> +    if (bm =3D=3D NULL) {
> +        error_setg(errp, "Bitmap '%s' is not found", bitmap);
> +        return;
> +    }
> +
> +    if (bdrv_dirty_bitmap_enabled(bm)) {
> +        error_setg(errp, "Bitmap '%s' is enabled", bitmap);
> +        return;
> +    }

Why are we restricting things to only export disabled bitmaps?

I can understand the argument that if the image being exported is
read-only, then an enabled bitmap _that can be changed_ is probably a
bad idea (it goes against the notion of the export being read only).
But if we were to allow a writable access to an image, wouldn't we
expect that writes be reflected into the bitmap, which means permitting
an enabled bitmap?

Furthermore, consider the scenario:

backing [with bitmap b0] <- active

If I request a bitmap add of b0 for an export of active, then it really
shouldn't matter whether b0 is left enabled or disabled - the backing
file is read-only, and so no changes will be made to bitmap b0.

I stumbled into the latter scenario while testing my new 'qemu-nbd -B
bitmap', but the problem appears anywhere that we have read-only access
to an image, where we can't change the status of the bitmap from enabled
to disabled (because the image is read-only) but where the bitmap
shouldn't be changing anyways (because the image is read-only).

> +
> +    if (bdrv_dirty_bitmap_qmp_locked(bm)) {
> +        error_setg(errp, "Bitmap '%s' is locked", bitmap);
> +        return;
> +    }
> +
> +    bdrv_dirty_bitmap_set_qmp_locked(bm, true);

Can we have an enabled-but-locked bitmap (one that we can't delete
because some operation such as a writable NBD export is still using it,
but one that is still being updated by active writes)?  If so, then it
may make sense to drop the restriction that an exported bitmap must be
disabled.  And even if it is not possible, I'd still like to loosen the
restriction to require a disabled bitmap only if the image owning the
bitmap is writable (making it easier to do read-only exports without
having to first tweak the bitmap to be disabled).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--d6Oicz2762RAR69TuTn3f1OYpM0MXfFWv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlw2SagACgkQ3g5py3or
ov0T7wf/bvYx0dSCIxAgbmNit6Lh3YCM4LyzFnfOk85Asx9+bfSk8mpQp3N1YbDx
E+KZSB+0VjC5l8vHhQMxhlf0p3qMmdm1MHRBfLwKeQd1pi/qWn1y7ZS6+XpvDJ2L
FCg1qLODXIS0hseUX5emjKtHEmJ12JlqIEHrd+qB76GFLboquWLsrQN1ZHIGP8GE
EMSM+s1JAJOOL2gR9NkqTg4XGTLK4oQagNF79FlynSnkpfWQDnWC0KziQRaNxEmN
323n0W8S7q/J8S+iEu9Dp7ZmMvMgelG88zPNn9bHF/yapY9wDV/yceC3Gv5XH+Al
5+WZ9BjQCD4wW+n5Sa2ZTSINS0lBjQ==
=ol8R
-----END PGP SIGNATURE-----

--d6Oicz2762RAR69TuTn3f1OYpM0MXfFWv--
