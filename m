Received: from eggs.gnu.org ([2001:4830:134:3::10]:60445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dJJxL-000711-Pg
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:28:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dJJxK-0003wu-Rn
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:28:03 -0400
References: <20170602112158.232757-1-vsementsov@virtuozzo.com>
	<20170602112158.232757-14-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3c884dff-5736-5e27-c68a-f1df374e26b0@redhat.com>
Date: Fri, 9 Jun 2017 15:27:23 +0200
MIME-Version: 1.0
In-Reply-To: <20170602112158.232757-14-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="j1IPiJ44JeVbcfIqWe0O2gaR35NUnt3Oa"
Subject: Re: [Qemu-devel] [PATCH v20 13/30] block: new
 bdrv_reopen_bitmaps_rw interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--j1IPiJ44JeVbcfIqWe0O2gaR35NUnt3Oa
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <3c884dff-5736-5e27-c68a-f1df374e26b0@redhat.com>
Subject: Re: [PATCH v20 13/30] block: new bdrv_reopen_bitmaps_rw interface
References: <20170602112158.232757-1-vsementsov@virtuozzo.com>
 <20170602112158.232757-14-vsementsov@virtuozzo.com>
In-Reply-To: <20170602112158.232757-14-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-06-02 13:21, Vladimir Sementsov-Ogievskiy wrote:
> Add format driver handler, which should mark loaded read-only
> bitmaps as 'IN_USE' in the image and unset read_only field in
> corresponding BdrvDirtyBitmap's.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block.c                   | 17 +++++++++++++++++
>  include/block/block_int.h |  7 +++++++
>  2 files changed, 24 insertions(+)
>=20
> diff --git a/block.c b/block.c
> index 04af7697dc..161db9e32a 100644
> --- a/block.c
> +++ b/block.c
> @@ -2946,12 +2946,16 @@ void bdrv_reopen_commit(BDRVReopenState *reopen=
_state)
>  {
>      BlockDriver *drv;
>      BlockDriverState *bs;
> +    bool old_can_write, new_can_write;
> =20
>      assert(reopen_state !=3D NULL);
>      bs =3D reopen_state->bs;
>      drv =3D bs->drv;
>      assert(drv !=3D NULL);
> =20
> +    old_can_write =3D
> +        !bdrv_is_read_only(bs) && !(bdrv_get_flags(bs) & BDRV_O_INACTI=
VE);
> +
>      /* If there are any driver level actions to take */
>      if (drv->bdrv_reopen_commit) {
>          drv->bdrv_reopen_commit(reopen_state);
> @@ -2965,6 +2969,19 @@ void bdrv_reopen_commit(BDRVReopenState *reopen_=
state)
>      bs->read_only =3D !(reopen_state->flags & BDRV_O_RDWR);
> =20
>      bdrv_refresh_limits(bs, NULL);
> +
> +    new_can_write =3D
> +        !bdrv_is_read_only(bs) && !(bdrv_get_flags(bs) & BDRV_O_INACTI=
VE);
> +    if (!old_can_write && new_can_write && drv->bdrv_reopen_bitmaps_rw=
) {
> +        Error *local_err =3D NULL;
> +        if (drv->bdrv_reopen_bitmaps_rw(bs, &local_err) < 0) {
> +            /* This is not fatal, bitmaps just left read-only, so all =
following
> +             * writes will fail. User can remove read-only bitmaps to =
unblock
> +             * writes.
> +             */

In a sense, it pretty much is fatal. We were asked to make the image
non-read-only but we failed because it effectively still is read-only.

But I can't think of anything better, and you're right, removing the
bitmaps would resolve the situation. This would require the user to know
that updating the bitmaps was the issue, and local_err may not actually
reflect that.

> +            error_report_err(local_err);

So I'd prepend this with something like "$node_name: Failed to make
dirty bitmaps writable", and maybe append a hint like "Removing all
persistent dirty bitmaps from this node will allow writing to it".

Max

> +        }
> +    }
>  }
> =20
>  /*
> diff --git a/include/block/block_int.h b/include/block/block_int.h
> index 8d3724cce6..1dc6f2e90d 100644
> --- a/include/block/block_int.h
> +++ b/include/block/block_int.h
> @@ -380,6 +380,13 @@ struct BlockDriver {
>                               uint64_t parent_perm, uint64_t parent_sha=
red,
>                               uint64_t *nperm, uint64_t *nshared);
> =20
> +    /**
> +     * Bitmaps should be marked as 'IN_USE' in the image on reopening =
image
> +     * as rw. This handler should realize it. It also should unset rea=
donly
> +     * field of BlockDirtyBitmap's in case of success.
> +     */
> +    int (*bdrv_reopen_bitmaps_rw)(BlockDriverState *bs, Error **errp);=

> +
>      QLIST_ENTRY(BlockDriver) list;
>  };
> =20
>=20



--j1IPiJ44JeVbcfIqWe0O2gaR35NUnt3Oa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZOqI8EhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQOww
B/9Jy8ipRHMpY4wS0nkipXSukhOCtDaxdAJWJfOH7GHS2RwekT7ME1otb7nKFR4Y
KMTZhvJ1I9NcixmW5zpZ48L8pTTnJgh801wpW7CjZcR6xxEjVxrGDllnq1GiA7bA
xfOo6BMWw2+k+R8n4g/qJcGZA7ErtZuMRR/HPJpQe9vz1P4te79ZEV0DYs1Lqdxh
Oc8UwFdQmWJXb7MixXmFHYyQCWBdOAG5Aag0iJ/ZC/BgxxEmKkmifqemSfVR5BX+
gU2k9FGxlbY4FusMlc5kprQ/h9wwYEwNqqVTrEwhsYVCczdhOx84IwSRTuc/BWS/
ZOfZn2yxx31uSKBbBVb8qcR+
=2yYN
-----END PGP SIGNATURE-----

--j1IPiJ44JeVbcfIqWe0O2gaR35NUnt3Oa--
