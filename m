Received: from eggs.gnu.org ([209.51.188.92]:50340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gjneM-00046b-UF
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 11:02:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gjneJ-0005aA-1K
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 11:02:42 -0500
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
	<20181229122027.42245-8-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5a822e18-6967-5059-bf21-6891aa701af4@redhat.com>
Date: Wed, 16 Jan 2019 17:02:07 +0100
MIME-Version: 1.0
In-Reply-To: <20181229122027.42245-8-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iAYkkCt40lnKiJOl8Ee4AwzSPMLwPASUP"
Subject: Re: [Qemu-devel] [PATCH v5 07/11] block: introduce backup-top
 filter driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: fam@euphon.net, stefanha@redhat.com, jcody@redhat.com, kwolf@redhat.com, den@openvz.org, eblake@redhat.com, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iAYkkCt40lnKiJOl8Ee4AwzSPMLwPASUP
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: fam@euphon.net, stefanha@redhat.com, jcody@redhat.com, kwolf@redhat.com,
 den@openvz.org, eblake@redhat.com, jsnow@redhat.com
Message-ID: <5a822e18-6967-5059-bf21-6891aa701af4@redhat.com>
Subject: Re: [PATCH v5 07/11] block: introduce backup-top filter driver
References: <20181229122027.42245-1-vsementsov@virtuozzo.com>
 <20181229122027.42245-8-vsementsov@virtuozzo.com>
In-Reply-To: <20181229122027.42245-8-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 29.12.18 13:20, Vladimir Sementsov-Ogievskiy wrote:
> Backup-top filter does copy-before-write operation. It should be
> inserted above active disk and has a target node for CBW, like the
> following:
>=20
>     +-------+
>     | Guest |
>     +---+---+
>         |r,w
>         v
>     +---+-----------+  target   +---------------+
>     | backup_top    |---------->| target(qcow2) |
>     +---+-----------+   CBW     +---+-----------+
>         |
> backing |r,w
>         v
>     +---+---------+
>     | Active disk |
>     +-------------+
>=20
> The driver will be used in backup instead of write-notifiers.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/backup-top.h  |  43 +++++++
>  block/backup-top.c  | 306 ++++++++++++++++++++++++++++++++++++++++++++=

>  block/Makefile.objs |   2 +
>  3 files changed, 351 insertions(+)
>  create mode 100644 block/backup-top.h
>  create mode 100644 block/backup-top.c

Looks good to me overall, comments below:

> diff --git a/block/backup-top.h b/block/backup-top.h
> new file mode 100644
> index 0000000000..abe4dda574
> --- /dev/null
> +++ b/block/backup-top.h
> @@ -0,0 +1,43 @@
> +/*
> + * backup-top filter driver
> + *
> + * The driver performs Copy-Before-Write (CBW) operation: it is inject=
ed above
> + * some node, and before each write it copies _old_ data to the target=
 node.
> + *
> + * Copyright (c) 2018 Virtuozzo International GmbH. All rights reserve=
d.
> + *
> + * Author:
> + *  Sementsov-Ogievskiy Vladimir <vsementsov@virtuozzo.com>
> + *
> + * This program is free software; you can redistribute it and/or modif=
y
> + * it under the terms of the GNU General Public License as published b=
y
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>=
=2E
> + */
> +

Include guards are missing here.

> +#include "qemu/osdep.h"
> +
> +#include "block/block_int.h"
> +
> +typedef struct BDRVBackupTopState {
> +    HBitmap *copy_bitmap; /* what should be copied to @target on guest=
 write. */
> +    BdrvChild *target;
> +
> +    uint64_t bytes_copied;
> +} BDRVBackupTopState;
> +
> +void bdrv_backup_top_drop(BlockDriverState *bs);
> +uint64_t bdrv_backup_top_progress(BlockDriverState *bs);
> +
> +BlockDriverState *bdrv_backup_top_append(BlockDriverState *source,
> +                                         BlockDriverState *target,
> +                                         HBitmap *copy_bitmap,
> +                                         Error **errp);

A comment describing at least parts of the interface would be nice; for
instance, that @target will be forced into the same AioContext as
@source, or that the backup-top node will be an implicit node.

> diff --git a/block/backup-top.c b/block/backup-top.c
> new file mode 100644
> index 0000000000..0e7b3e3142
> --- /dev/null
> +++ b/block/backup-top.c
> @@ -0,0 +1,306 @@
> +/*
> + * backup-top filter driver
> + *
> + * The driver performs Copy-Before-Write (CBW) operation: it is inject=
ed above
> + * some node, and before each write it copies _old_ data to the target=
 node.
> + *
> + * Copyright (c) 2018 Virtuozzo International GmbH. All rights reserve=
d.
> + *
> + * Author:
> + *  Sementsov-Ogievskiy Vladimir <vsementsov@virtuozzo.com>
> + *
> + * This program is free software; you can redistribute it and/or modif=
y
> + * it under the terms of the GNU General Public License as published b=
y
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program. If not, see <http://www.gnu.org/licenses/>=
=2E
> + */
> +
> +#include "qemu/osdep.h"
> +
> +#include "qemu/cutils.h"
> +#include "qapi/error.h"
> +#include "block/block_int.h"
> +#include "block/qdict.h"
> +
> +#include "block/backup-top.h"
> +
> +static coroutine_fn int backup_top_co_preadv(
> +        BlockDriverState *bs, uint64_t offset, uint64_t bytes,
> +        QEMUIOVector *qiov, int flags)
> +{
> +    /*
> +     * Features to be implemented:
> +     * F1. COR. save read data to fleecing target for fast access
> +     *     (to reduce reads). This possibly may be done with use of co=
py-on-read
> +     *     filter, but we need an ability to make COR requests optiona=
l: for
> +     *     example, if target is a ram-cache, and if it is full now, w=
e should
> +     *     skip doing COR request, as it is actually not necessary.
> +     *
> +     * F2. Feature for guest: read from fleecing target if data is in =
ram-cache
> +     *     and is unchanged
> +     */
> +
> +    return bdrv_co_preadv(bs->backing, offset, bytes, qiov, flags);
> +}
> +
> +static coroutine_fn int backup_top_cbw(BlockDriverState *bs, uint64_t =
offset,
> +                                          uint64_t bytes)

I don't know if there is a real guideline, but usually parameters are
aligned at the opening parenthesis.

> +{
> +    int ret =3D 0;
> +    BDRVBackupTopState *s =3D bs->opaque;
> +    uint64_t gran =3D 1UL << hbitmap_granularity(s->copy_bitmap);
> +    uint64_t end =3D QEMU_ALIGN_UP(offset + bytes, gran);
> +    uint64_t off =3D QEMU_ALIGN_DOWN(offset, gran), len;
> +    size_t align =3D MAX(bdrv_opt_mem_align(bs->backing->bs),
> +                       bdrv_opt_mem_align(s->target->bs));
> +    struct iovec iov =3D {
> +        .iov_base =3D qemu_memalign(align, end - off),

I think it would be more correct to use qemu_blockalign() here and set
bs->bl.opt_mem_alignment somewhere.

> +        .iov_len =3D end - off

How about just leaving this out here... [1]

> +    };
> +    QEMUIOVector qiov;
> +
> +    qemu_iovec_init_external(&qiov, &iov, 1);

[1] ...and move this... [1]

> +
> +    /*
> +     * Features to be implemented:
> +     * F3. parallelize copying loop
> +     * F4. detect zeros

Isn't there detect-zeroes for that?

> +     * F5. use block_status ?
> +     * F6. don't copy clusters which are already cached by COR [see F1=
]
> +     * F7. if target is ram-cache and it is full, there should be a po=
ssibility
> +     *     to drop not necessary data (cached by COR [see F1]) to hand=
le CBW
> +     *     fast.

Another idea: Read all dirty data from bs->backing (in parallel, more or
less), and then perform all writes (to bs->backing and s->target) in
parallel as well.

(So the writes do not have to wait on one another)

> +     */
> +
> +    len =3D end - off;
> +    while (hbitmap_next_dirty_area(s->copy_bitmap, &off, &len)) {
> +        iov.iov_len =3D qiov.size =3D len;

[1] ...here, and not setting qiov.size?

> +
> +        hbitmap_reset(s->copy_bitmap, off, len);
> +
> +        ret =3D bdrv_co_preadv(bs->backing, off, len, &qiov,
> +                             BDRV_REQ_NO_SERIALISING);
> +        if (ret < 0) {
> +            hbitmap_set(s->copy_bitmap, off, len);
> +            goto finish;
> +        }
> +
> +        ret =3D bdrv_co_pwritev(s->target, off, len, &qiov, BDRV_REQ_S=
ERIALISING);
> +        if (ret < 0) {
> +            hbitmap_set(s->copy_bitmap, off, len);
> +            goto finish;
> +        }
> +
> +        s->bytes_copied +=3D len;
> +        off +=3D len;
> +        if (off >=3D end) {
> +            break;
> +        }
> +        len =3D end - off;
> +    }
> +
> +finish:
> +    qemu_vfree(iov.iov_base);
> +
> +    /*
> +     * F8. we fail guest request in case of error. We can alter it by
> +     * possibility to fail copying process instead, or retry several t=
imes, or
> +     * may be guest pause, etc.
> +     */
> +    return ret;
> +}
> +
> +static int coroutine_fn backup_top_co_pdiscard(BlockDriverState *bs,
> +                                                  int64_t offset, int =
bytes)

(Indentation)

> +{
> +    int ret =3D backup_top_cbw(bs, offset, bytes);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    /*
> +     * Features to be implemented:
> +     * F9. possibility of lazy discard: just defer the discard after f=
leecing
> +     *     completion. If write (or new discard) occurs to the same ar=
ea, just
> +     *     drop deferred discard.
> +     */
> +
> +    return bdrv_co_pdiscard(bs->backing, offset, bytes);
> +}
> +
> +static int coroutine_fn backup_top_co_pwrite_zeroes(BlockDriverState *=
bs,
> +        int64_t offset, int bytes, BdrvRequestFlags flags)
> +{
> +    int ret =3D backup_top_cbw(bs, offset, bytes);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    return bdrv_co_pwrite_zeroes(bs->backing, offset, bytes, flags);
> +}
> +
> +static coroutine_fn int backup_top_co_pwritev(BlockDriverState *bs,
> +                                                 uint64_t offset,
> +                                                 uint64_t bytes,
> +                                                 QEMUIOVector *qiov, i=
nt flags)

(Indentation)

> +{
> +    int ret =3D backup_top_cbw(bs, offset, bytes);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    return bdrv_co_pwritev(bs->backing, offset, bytes, qiov, flags);
> +}
> +
> +static int coroutine_fn backup_top_co_flush(BlockDriverState *bs)
> +{
> +    if (!bs->backing) {
> +        return 0;
> +    }
> +
> +    return bdrv_co_flush(bs->backing->bs);

Why not the target as well?

> +}
> +
> +static void backup_top_refresh_filename(BlockDriverState *bs, QDict *o=
pts)
> +{
> +    if (bs->backing =3D=3D NULL) {
> +        /*
> +         * we can be here after failed bdrv_attach_child in
> +         * bdrv_set_backing_hd
> +         */
> +        return;
> +    }
> +    bdrv_refresh_filename(bs->backing->bs);
> +    pstrcpy(bs->exact_filename, sizeof(bs->exact_filename),
> +            bs->backing->bs->filename);
> +}
> +
> +static void backup_top_child_perm(BlockDriverState *bs, BdrvChild *c,
> +                                       const BdrvChildRole *role,
> +                                       BlockReopenQueue *reopen_queue,=

> +                                       uint64_t perm, uint64_t shared,=

> +                                       uint64_t *nperm, uint64_t *nsha=
red)

(Indentation)

> +{
> +    bdrv_filter_default_perms(bs, c, role, reopen_queue, perm, shared,=
 nperm,
> +                              nshared);
> +
> +    if (role =3D=3D &child_file) {
> +        /*
> +         * share write to target, to not interfere guest writes to it'=
s disk

*interfere with guest writes to its disk

> +         * which will be in target backing chain
> +         */
> +        *nshared =3D *nshared | BLK_PERM_WRITE;
> +        *nperm =3D *nperm | BLK_PERM_WRITE;

Why do you need to take the write permission?  This filter does not
perform any writes unless it receives writes, right?  (So
bdrv_filter_default_perms() should take care of this.)

> +    } else {
> +        *nperm =3D *nperm | BLK_PERM_CONSISTENT_READ;
> +    }
> +}
> +
> +BlockDriver bdrv_backup_top_filter =3D {
> +    .format_name =3D "backup-top",
> +    .instance_size =3D sizeof(BDRVBackupTopState),
> +
> +    .bdrv_co_preadv             =3D backup_top_co_preadv,
> +    .bdrv_co_pwritev            =3D backup_top_co_pwritev,
> +    .bdrv_co_pwrite_zeroes      =3D backup_top_co_pwrite_zeroes,
> +    .bdrv_co_pdiscard           =3D backup_top_co_pdiscard,
> +    .bdrv_co_flush              =3D backup_top_co_flush,
> +
> +    .bdrv_co_block_status       =3D bdrv_co_block_status_from_backing,=

> +
> +    .bdrv_refresh_filename      =3D backup_top_refresh_filename,
> +
> +    .bdrv_child_perm            =3D backup_top_child_perm,
> +
> +    .is_filter =3D true,
> +};
> +
> +BlockDriverState *bdrv_backup_top_append(BlockDriverState *source,
> +                                         BlockDriverState *target,
> +                                         HBitmap *copy_bitmap,
> +                                         Error **errp)
> +{
> +    Error *local_err =3D NULL;
> +    BDRVBackupTopState *state;
> +    BlockDriverState *top =3D bdrv_new_open_driver(&bdrv_backup_top_fi=
lter,
> +                                                 NULL, BDRV_O_RDWR, er=
rp);
> +
> +    if (!top) {
> +        return NULL;
> +    }
> +
> +    top->implicit =3D true;
> +    top->total_sectors =3D source->total_sectors;
> +    top->opaque =3D state =3D g_new0(BDRVBackupTopState, 1);
> +    state->copy_bitmap =3D copy_bitmap;
> +
> +    bdrv_ref(target);
> +    state->target =3D bdrv_attach_child(top, target, "target", &child_=
file, errp);
> +    if (!state->target) {
> +        bdrv_unref(target);
> +        bdrv_unref(top);
> +        return NULL;
> +    }
> +
> +    bdrv_set_aio_context(top, bdrv_get_aio_context(source));
> +    bdrv_set_aio_context(target, bdrv_get_aio_context(source));
> +
> +    bdrv_drained_begin(source);
> +
> +    bdrv_ref(top);
> +    bdrv_append(top, source, &local_err);
> +
> +    if (local_err) {
> +        bdrv_unref(top);

This is done automatically by bdrv_append().

> +    }
> +
> +    bdrv_drained_end(source);
> +
> +    if (local_err) {
> +        bdrv_unref_child(top, state->target);
> +        bdrv_unref(top);
> +        error_propagate(errp, local_err);
> +        return NULL;
> +    }
> +
> +    return top;
> +}
> +
> +void bdrv_backup_top_drop(BlockDriverState *bs)
> +{
> +    BDRVBackupTopState *s =3D bs->opaque;
> +
> +    AioContext *aio_context =3D bdrv_get_aio_context(bs);
> +
> +    aio_context_acquire(aio_context);
> +
> +    bdrv_drained_begin(bs);
> +
> +    bdrv_child_try_set_perm(bs->backing, 0, BLK_PERM_ALL, &error_abort=
);
> +    bdrv_replace_node(bs, backing_bs(bs), &error_abort);
> +    bdrv_set_backing_hd(bs, NULL, &error_abort);

This is done automatically in bdrv_close(), and after bs has been
replaced by backing_bs(bs), I don't think new requests should come in,
so I don't think this needs to be done here.

> +
> +    bdrv_drained_end(bs);
> +
> +    if (s->target) {
> +        bdrv_unref_child(bs, s->target);
> +    }

And this should be done in a .bdrv_close() implementation, I think.

Max

> +    bdrv_unref(bs);
> +
> +    aio_context_release(aio_context);
> +}
> +
> +uint64_t bdrv_backup_top_progress(BlockDriverState *bs)
> +{
> +    BDRVBackupTopState *s =3D bs->opaque;
> +
> +    return s->bytes_copied;
> +}
> diff --git a/block/Makefile.objs b/block/Makefile.objs
> index 7a81892a52..9072115c09 100644
> --- a/block/Makefile.objs
> +++ b/block/Makefile.objs
> @@ -40,6 +40,8 @@ block-obj-y +=3D throttle.o copy-on-read.o
> =20
>  block-obj-y +=3D crypto.o
> =20
> +block-obj-y +=3D backup-top.o
> +
>  common-obj-y +=3D stream.o
> =20
>  nfs.o-libs         :=3D $(LIBNFS_LIBS)
>=20



--iAYkkCt40lnKiJOl8Ee4AwzSPMLwPASUP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlw/VX8ACgkQ9AfbAGHV
z0C9Kgf/cRaoUBy9Rj23+tKxsgMjJrrkfz7Thao/t2RJT2b0yppTLG81Gy5eeu+d
D87KrwjEr6puDxSa0NgkQHQwCCZT9y++LWxRjOnyyLkISH0OYa8LUh87zgCQJOo3
GpiM6RtyPvTmgqpyraPjOiV8X+f37YdY82xs+KDVNHqJgQA/Qpj3tW/NXCpszkO6
V6uxx0ywLa7h+AF4gXHpQQbG0gYvGx8fI+mVGpCVWC189QkuuJH0rxtA5G1izJF4
JdMzK1wumUQCFNMCWLRG/wB4Xzyv2RSURULgpFfKY0ytd7GT8By2gPHwwt3SQ6cl
daOD+i7e4eXjilkk8zqusxKR6CkcRw==
=jQ7z
-----END PGP SIGNATURE-----

--iAYkkCt40lnKiJOl8Ee4AwzSPMLwPASUP--
