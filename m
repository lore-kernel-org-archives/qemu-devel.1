Received: from eggs.gnu.org ([2001:4830:134:3::10]:38076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ce9Br-0002qh-DJ
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 18:40:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ce9Bq-0006US-Bd
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 18:40:51 -0500
References: <1487153430-17260-1-git-send-email-vsementsov@virtuozzo.com>
	<1487153430-17260-26-git-send-email-vsementsov@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <6f5fd357-2aed-5f47-d0de-03fa02f89f5e@redhat.com>
Date: Wed, 15 Feb 2017 18:40:43 -0500
MIME-Version: 1.0
In-Reply-To: <1487153430-17260-26-git-send-email-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v15 25/25] qcow2-bitmap: improve
 check_constraints_on_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, armbru@redhat.com, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org



On 02/15/2017 05:10 AM, Vladimir Sementsov-Ogievskiy wrote:
> Add detailed error messages.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Reviewed-by: John Snow <jsnow@redhat.com>

> ---
>  block/qcow2-bitmap.c | 48 ++++++++++++++++++++++++++++++++++----------=
----
>  1 file changed, 34 insertions(+), 14 deletions(-)
>=20
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index 9177c56..e25c872 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c
> @@ -160,28 +160,49 @@ static int check_table_entry(uint64_t entry, int =
cluster_size)
> =20
>  static int check_constraints_on_bitmap(BlockDriverState *bs,
>                                         const char *name,
> -                                       uint32_t granularity)
> +                                       uint32_t granularity,
> +                                       Error **errp)
>  {
>      BDRVQcow2State *s =3D bs->opaque;
>      int granularity_bits =3D ctz32(granularity);
>      int64_t len =3D bdrv_getlength(bs);
> -    bool fail;
> =20
>      assert(granularity > 0);
>      assert((granularity & (granularity - 1)) =3D=3D 0);
> =20
>      if (len < 0) {
> +        error_setg_errno(errp, -len, "Failed to get size of '%s'",
> +                         bdrv_get_device_or_node_name(bs));
>          return len;
>      }
> =20
> -    fail =3D (granularity_bits > BME_MAX_GRANULARITY_BITS) ||
> -           (granularity_bits < BME_MIN_GRANULARITY_BITS) ||
> -           (len > (uint64_t)BME_MAX_PHYS_SIZE << granularity_bits) ||
> -           (len > (uint64_t)BME_MAX_TABLE_SIZE * s->cluster_size <<
> -                  granularity_bits) ||
> -           (strlen(name) > BME_MAX_NAME_SIZE);
> +    if (granularity_bits > BME_MAX_GRANULARITY_BITS) {
> +        error_setg(errp, "Granularity exceeds maximum (%u bytes)",
> +                   1 << BME_MAX_GRANULARITY_BITS);
> +        return -EINVAL;
> +    }
> +    if (granularity_bits < BME_MIN_GRANULARITY_BITS) {
> +        error_setg(errp, "Granularity is under minimum (%u bytes)",
> +                   1 << BME_MIN_GRANULARITY_BITS);
> +        return -EINVAL;
> +    }
> =20
> -    return fail ? -EINVAL : 0;
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
>  }
> =20
>  static void clear_bitmap_table(BlockDriverState *bs, uint64_t *bitmap_=
table,
> @@ -1142,9 +1163,9 @@ void qcow2_store_persistent_dirty_bitmaps(BlockDr=
iverState *bs, Error **errp)
>              continue;
>          }
> =20
> -        if (check_constraints_on_bitmap(bs, name, granularity) < 0) {
> -            error_setg(errp, "Bitmap '%s' doesn't satisfy the constrai=
nts",
> -                       name);
> +        if (check_constraints_on_bitmap(bs, name, granularity, errp) <=
 0) {
> +            error_prepend(errp, "Bitmap '%s' doesn't satisfy the const=
raints: ",
> +                          name);
>              goto fail;
>          }
> =20
> @@ -1233,8 +1254,7 @@ bool qcow2_can_store_new_dirty_bitmap(BlockDriver=
State *bs,
>      bool found;
>      Qcow2BitmapList *bm_list;
> =20
> -    if (check_constraints_on_bitmap(bs, name, granularity) !=3D 0) {
> -        error_setg(errp, "The constraints are not satisfied");
> +    if (check_constraints_on_bitmap(bs, name, granularity, errp) !=3D =
0) {
>          goto fail;
>      }
> =20
>=20

--=20
=97js
