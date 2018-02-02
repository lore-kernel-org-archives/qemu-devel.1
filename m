Received: from eggs.gnu.org ([2001:4830:134:3::10]:59484)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehe9i-0003lj-C3
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:26:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ehe4n-0004wd-Ua
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 11:24:42 -0500
References: <20180202160752.143796-1-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ee7b1763-3106-cda3-cecb-097bc6248737@redhat.com>
Date: Fri, 2 Feb 2018 10:18:09 -0600
MIME-Version: 1.0
In-Reply-To: <20180202160752.143796-1-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="s05VpxmvZfDTgueByIZPDMF9mzfsmtrUo"
Subject: Re: [Qemu-devel] [PATCH v3] block: maintain persistent disabled
 bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, nshirokovskiy@virtuozzo.com, mnestratov@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s05VpxmvZfDTgueByIZPDMF9mzfsmtrUo
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, nshirokovskiy@virtuozzo.com,
 mnestratov@virtuozzo.com
Message-ID: <ee7b1763-3106-cda3-cecb-097bc6248737@redhat.com>
Subject: Re: [PATCH v3] block: maintain persistent disabled bitmaps
References: <20180202160752.143796-1-vsementsov@virtuozzo.com>
In-Reply-To: <20180202160752.143796-1-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/02/2018 10:07 AM, Vladimir Sementsov-Ogievskiy wrote:
> To maintain load/store disabled bitmap there is new approach:
>=20
>  - deprecate @autoload flag of block-dirty-bitmap-add, make it ignored
>  - store enabled bitmaps as "auto" to qcow2
>  - store disabled bitmaps without "auto" flag to qcow2
>  - on qcow2 open load "auto" bitmaps as enabled and others
>    as disabled (except in_use bitmaps)
>=20
> Also, adjust iotests 165 and 176 appropriately.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

> +++ b/qemu-doc.texi
> @@ -2749,6 +2749,13 @@ used and it will be removed with no replacement.=

>  The ``convert -s snapshot_id_or_name'' argument is obsoleted
>  by the ``convert -l snapshot_param'' argument instead.
> =20
> +@section QEMU Machine Protocol (QMP) commands
> +
> +@subsection block-dirty-bitmap-add "autoload" parameter (since 2.12.0)=

> +
> +"autoload" parameter is now ignored. All bitmaps are automatically loa=
ded
> +from qcow2 image.

Won't later patches be adding the ability to enable/disable bitmaps,
which then affects whether they are autoloaded?  So we don't forget to
revisit this text in that patch, a better wording might be:

The "autoload" parameter is ignored; all enabled persistent dirty
bitmaps are automatically loaded from a qcow2 image, regardless of the
initial setting requested in this parameter.


> @@ -667,19 +662,6 @@ bool bdrv_has_readonly_bitmaps(BlockDriverState *b=
s)
>  }
> =20
>  /* Called with BQL taken. */
> -void bdrv_dirty_bitmap_set_autoload(BdrvDirtyBitmap *bitmap, bool auto=
load)
> -{
> -    qemu_mutex_lock(bitmap->mutex);
> -    bitmap->autoload =3D autoload;
> -    qemu_mutex_unlock(bitmap->mutex);
> -}
> -
> -bool bdrv_dirty_bitmap_get_autoload(const BdrvDirtyBitmap *bitmap)
> -{
> -    return bitmap->autoload;
> -}

Will later patches be reintroducing these functions for learning which
bitmaps are enabled/disabled?  But I'm okay with deleting them in this
patch, even if that is more churn.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--s05VpxmvZfDTgueByIZPDMF9mzfsmtrUo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlp0j0EACgkQp6FrSiUn
Q2oOqwf/ZQdM+NQJQRh0OQMx+y1LrTQiDHSHgYNForV+/QwfCIO5zzFL9UMZbfop
sVT5Tp9wwtLFDQmJneipMj2Nlagmn1dkj3smSi2fJXUEwlPZEneVqX/hMNFpFCNH
8TSQNArnCPW0P4DXKLhwMyWGn03b1EKCbZHwL5kVN/VwkqlZ/QtKMd3xxME9RfkH
qGzf8uowQUbLuUyt65JFPFioSoiCHi88w+SXptuh+x/FCZyflmoFGMFYnnwvZBgG
qVQ4OUvec3zS0JPTrZ+lr6CauroB4ACyy6k46glXCix6SfPu9c0YM3Udnlb7z4zz
ym9Wg1ER9utZs4td2PQQ7zbiAXWwjg==
=e/Fj
-----END PGP SIGNATURE-----

--s05VpxmvZfDTgueByIZPDMF9mzfsmtrUo--
