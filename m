Received: from eggs.gnu.org ([2001:4830:134:3::10]:40598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ciMRo-0007qJ-IG
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:38:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ciMRn-0001dG-Al
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:38:44 -0500
References: <20170225170758.427066-1-vsementsov@virtuozzo.com>
	<20170225170758.427066-14-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <01c5d48f-09c0-06e2-5a67-5467470c4fbe@redhat.com>
Date: Mon, 27 Feb 2017 15:38:30 +0100
MIME-Version: 1.0
In-Reply-To: <20170225170758.427066-14-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="OwneQrnlcmh0x4BtoBeQeA1VumL4Q9t2X"
Subject: Re: [Qemu-devel] [PATCH v16 13/22] qcow2: add persistent dirty
 bitmaps support
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
--OwneQrnlcmh0x4BtoBeQeA1VumL4Q9t2X
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <01c5d48f-09c0-06e2-5a67-5467470c4fbe@redhat.com>
Subject: Re: [PATCH v16 13/22] qcow2: add persistent dirty bitmaps support
References: <20170225170758.427066-1-vsementsov@virtuozzo.com>
 <20170225170758.427066-14-vsementsov@virtuozzo.com>
In-Reply-To: <20170225170758.427066-14-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 25.02.2017 18:07, Vladimir Sementsov-Ogievskiy wrote:
> Store persistent dirty bitmaps in qcow2 image.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block.c              |   6 +-
>  block/qcow2-bitmap.c | 473 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  block/qcow2.c        |   9 +
>  block/qcow2.h        |   1 +
>  4 files changed, 486 insertions(+), 3 deletions(-)
>=20
> diff --git a/block.c b/block.c
> index a0346c80c6..16cf522219 100644
> --- a/block.c
> +++ b/block.c
> @@ -2322,9 +2322,6 @@ static void bdrv_close(BlockDriverState *bs)
>      bdrv_flush(bs);
>      bdrv_drain(bs); /* in case flush left pending I/O */
> =20
> -    bdrv_release_named_dirty_bitmaps(bs);
> -    assert(QLIST_EMPTY(&bs->dirty_bitmaps));
> -
>      if (bs->drv) {
>          BdrvChild *child, *next;
> =20
> @@ -2363,6 +2360,9 @@ static void bdrv_close(BlockDriverState *bs)
>          bs->full_open_options =3D NULL;
>      }
> =20
> +    bdrv_release_named_dirty_bitmaps(bs);
> +    assert(QLIST_EMPTY(&bs->dirty_bitmaps));
> +
>      QLIST_FOREACH_SAFE(ban, &bs->aio_notifiers, list, ban_next) {
>          g_free(ban);
>      }

Might deserve an own patch, but I don't mind.

> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index ba72b7d2ac..e377215d5c 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c

[...]

> @@ -127,6 +145,70 @@ static int check_table_entry(uint64_t entry, int c=
luster_size)
>      return 0;
>  }
> =20
> +static int check_constraints_on_bitmap(BlockDriverState *bs,
> +                                       const char *name,
> +                                       uint32_t granularity,
> +                                       Error **errp)
> +{
> +    BDRVQcow2State *s =3D bs->opaque;
> +    int granularity_bits =3D ctz32(granularity);
> +    int64_t len =3D bdrv_getlength(bs);
> +
> +    assert(granularity > 0);
> +    assert((granularity & (granularity - 1)) =3D=3D 0);
> +
> +    if (len < 0) {
> +        error_setg_errno(errp, -len, "Failed to get size of '%s'",
> +                         bdrv_get_device_or_node_name(bs));
> +        return len;
> +    }
> +
> +    if (granularity_bits > BME_MAX_GRANULARITY_BITS) {
> +        error_setg(errp, "Granularity exceeds maximum (%u bytes)",
> +                   1 << BME_MAX_GRANULARITY_BITS);

This will overflow because 1 << 31 is not representable in int (and 1 is
an int). The %u saves it by converting it back, but it's still
implementation-defined behavior at most.

I'd prefer a plain 1ull and %ull. That way, this would be save no matter
what value BME_MAX_GRANULARITY_BITS is.

> +        return -EINVAL;
> +    }
> +    if (granularity_bits < BME_MIN_GRANULARITY_BITS) {
> +        error_setg(errp, "Granularity is under minimum (%u bytes)",
> +                   1 << BME_MIN_GRANULARITY_BITS);

The same applies here, although this does not have the overflow issue.

Rest looks good (to me O:-)).

Max

> +        return -EINVAL;
> +    }
> +
> +    if ((len > (uint64_t)BME_MAX_PHYS_SIZE << granularity_bits) ||
> +        (len > (uint64_t)BME_MAX_TABLE_SIZE * s->cluster_size <<
> +               granularity_bits))
> +    {
> +        error_setg(errp, "Too much space will be occupied by the bitma=
p. "
> +                   "Use larger granularity");
> +        return -EINVAL;
> +    }
> +
> +    if (strlen(name) > BME_MAX_NAME_SIZE) {
> +        error_setg(errp, "Name length exceeds maximum (%u characters)"=
,
> +                   BME_MAX_NAME_SIZE);
> +        return -EINVAL;
> +    }
> +
> +    return 0;
> +}


--OwneQrnlcmh0x4BtoBeQeA1VumL4Q9t2X
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAli0OeYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AoSUH/3KZR33HGdbR5aunvJQHjqbdfQU7EDoa
3MXIBDpvIIboPQxIruWbCaLE9I9NlEx39F15on1RZmJIbc2sPyIiO/2hJaluCKW+
MCMtK31eiQcKyVtpQcn2bv2mX7PoKuZO5rviE/flJVnDYYKEnhYxqH1rXWHHvGOp
pU2lAIYydYH1fLyWuxXAlrtTBVbuAVHKi9aL5l3rcUG7Ve11KN9liwh0K8dN4DFs
/gYvW9W/bBelGI8yETZ7PaJNPWWc5iav9r0rUZt/ydBKanxiHIpSTGJgnu+DI15O
+h/P0p0BofJRze9WJDUkXwqUJutSXNE/2ZhKnXYGnQ1pwXJzU5GK5LA=
=sQ7W
-----END PGP SIGNATURE-----

--OwneQrnlcmh0x4BtoBeQeA1VumL4Q9t2X--
