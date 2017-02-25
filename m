Received: from eggs.gnu.org ([2001:4830:134:3::10]:58015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1chebV-0000wo-O1
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 10:49:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1chebU-0003wh-9H
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 10:49:49 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-55-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <458f9f5e-991c-8430-0114-342ba44ffe0b@redhat.com>
Date: Sat, 25 Feb 2017 16:49:36 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-55-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7QOUwSSXJxonll8RDrEIsQf5eAwUXfvwo"
Subject: Re: [Qemu-devel] [PATCH 54/54] block: Add Error parameter to
 bdrv_append()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7QOUwSSXJxonll8RDrEIsQf5eAwUXfvwo
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <458f9f5e-991c-8430-0114-342ba44ffe0b@redhat.com>
Subject: Re: [PATCH 54/54] block: Add Error parameter to bdrv_append()
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-55-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-55-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> Aborting on error in bdrv_append() isn't correct. This patch fixes it
> and lets the callers handle failures.
>=20
> Test case 085 needs a reference output update. This is caused by the
> reversed order of bdrv_set_backing_hd() and change_parent_backing_link(=
)
> in bdrv_append(): When the backing file of the new node is set, the
> parent nodes are still pointing to the old top, so the backing blocker
> is now initialised with the node name rather than the BlockBackend name=
=2E
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c                    | 23 +++++++++++++++++------
>  block/mirror.c             |  9 ++++++++-
>  blockdev.c                 | 15 +++++++++++++--
>  include/block/block.h      |  3 ++-
>  tests/qemu-iotests/085.out |  2 +-
>  5 files changed, 41 insertions(+), 11 deletions(-)
>=20
> diff --git a/block.c b/block.c
> index b3f03a4..33edbda 100644
> --- a/block.c
> +++ b/block.c
> @@ -2060,6 +2060,7 @@ static BlockDriverState *bdrv_append_temp_snapsho=
t(BlockDriverState *bs,
>      int64_t total_size;
>      QemuOpts *opts =3D NULL;
>      BlockDriverState *bs_snapshot;
> +    Error *local_err =3D NULL;
>      int ret;
> =20
>      /* if snapshot, we create a temporary backing file and open it
> @@ -2109,7 +2110,12 @@ static BlockDriverState *bdrv_append_temp_snapsh=
ot(BlockDriverState *bs,
>       * call bdrv_unref() on it), so in order to be able to return one,=
 we have
>       * to increase bs_snapshot's refcount here */
>      bdrv_ref(bs_snapshot);
> -    bdrv_append(bs_snapshot, bs);
> +    bdrv_append(bs_snapshot, bs, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        ret =3D -EINVAL;
> +        goto out;
> +    }
> =20
>      g_free(tmp_filename);
>      return bs_snapshot;
> @@ -2900,20 +2906,25 @@ static void change_parent_backing_link(BlockDri=
verState *from,
>   * parents of bs_top after bdrv_append() returns. If the caller needs =
to keep a
>   * reference of its own, it must call bdrv_ref().
>   */
> -void bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top)
> +void bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
> +                 Error **errp)
>  {
> +    Error *local_err =3D NULL;
> +
>      assert(!atomic_read(&bs_top->in_flight));
>      assert(!atomic_read(&bs_new->in_flight));
> =20
> -    bdrv_ref(bs_top);
> +    bdrv_set_backing_hd(bs_new, bs_top, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        goto out;
> +    }
> =20
>      change_parent_backing_link(bs_top, bs_new);
> -    /* FIXME Error handling */
> -    bdrv_set_backing_hd(bs_new, bs_top, &error_abort);
> -    bdrv_unref(bs_top);
> =20
>      /* bs_new is now referenced by its new parents, we don't need the
>       * additional reference any more. */
> +out:
>      bdrv_unref(bs_new);
>  }
> =20
> diff --git a/block/mirror.c b/block/mirror.c
> index abbd847..4e35d85 100644
> --- a/block/mirror.c
> +++ b/block/mirror.c
> @@ -1066,6 +1066,7 @@ static void mirror_start_job(const char *job_id, =
BlockDriverState *bs,
>      BlockDriverState *mirror_top_bs;
>      bool target_graph_mod;
>      bool target_is_backing;
> +    Error *local_err =3D NULL;
>      int ret;
> =20
>      if (granularity =3D=3D 0) {
> @@ -1096,9 +1097,15 @@ static void mirror_start_job(const char *job_id,=
 BlockDriverState *bs,
>       * it alive until block_job_create() even if bs has no parent. */
>      bdrv_ref(mirror_top_bs);
>      bdrv_drained_begin(bs);
> -    bdrv_append(mirror_top_bs, bs);
> +    bdrv_append(mirror_top_bs, bs, &local_err);
>      bdrv_drained_end(bs);
> =20
> +    if (local_err) {
> +        bdrv_unref(mirror_top_bs);
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
>      /* Make sure that the source is not resized while the job is runni=
ng */
>      s =3D block_job_create(job_id, driver, mirror_top_bs,
>                           BLK_PERM_CONSISTENT_READ,
> diff --git a/blockdev.c b/blockdev.c
> index 63b1ac4..580fa66 100644
> --- a/blockdev.c
> +++ b/blockdev.c
> @@ -1764,6 +1764,16 @@ static void external_snapshot_prepare(BlkActionS=
tate *common,
> =20
>      if (!state->new_bs->drv->supports_backing) {
>          error_setg(errp, "The snapshot does not support backing images=
");
> +        return;
> +    }
> +
> +    /* This removes our old bs and adds the new bs. This is an operati=
on that
> +     * can fail, so we need to do it in .prepare; undoing it for abort=
 is
> +     * always possible. */
> +    bdrv_append(state->new_bs, state->old_bs, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
>      }

After bdrv_append(), the state->new_bs reference is no longer valid,
necessarily; especially if the operation failed.

>  }
> =20
> @@ -1774,8 +1784,6 @@ static void external_snapshot_commit(BlkActionSta=
te *common)
> =20
>      bdrv_set_aio_context(state->new_bs, state->aio_context);
> =20
> -    /* This removes our old bs and adds the new bs */
> -    bdrv_append(state->new_bs, state->old_bs);
>      /* We don't need (or want) to use the transactional
>       * bdrv_reopen_multiple() across all the entries at once, because =
we
>       * don't want to abort all of them if one of them fails the reopen=
 */
> @@ -1791,6 +1799,9 @@ static void external_snapshot_abort(BlkActionStat=
e *common)
>                               DO_UPCAST(ExternalSnapshotState, common, =
common);
>      if (state->new_bs) {
>          bdrv_unref(state->new_bs);

So this is not necessarily a good idea. I guess the solution would be a
bdrv_ref() before bdrv_append().

(At which point we might just remove the bdrv_unref() from bdrv_append()
because all of its callers would invoke bdrv_ref() before, so it's
definitely no longer "what the callers commonly need.")

> +        if (state->new_bs->backing) {
> +            bdrv_replace_in_backing_chain(state->new_bs, state->old_bs=
);
> +        }

And in any case, this should be before the bdrv_unref(), because that
may have dropped the last reference to state->new_bs.

Max

>      }
>  }
> =20
> diff --git a/include/block/block.h b/include/block/block.h
> index 6a6408e..6ce8b26 100644
> --- a/include/block/block.h
> +++ b/include/block/block.h
> @@ -235,7 +235,8 @@ int bdrv_create(BlockDriver *drv, const char* filen=
ame,
>                  QemuOpts *opts, Error **errp);
>  int bdrv_create_file(const char *filename, QemuOpts *opts, Error **err=
p);
>  BlockDriverState *bdrv_new(void);
> -void bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top);
> +void bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
> +                 Error **errp);
>  void bdrv_replace_in_backing_chain(BlockDriverState *old,
>                                     BlockDriverState *new);
> =20
> diff --git a/tests/qemu-iotests/085.out b/tests/qemu-iotests/085.out
> index 08e4bb7..182acb4 100644
> --- a/tests/qemu-iotests/085.out
> +++ b/tests/qemu-iotests/085.out
> @@ -74,7 +74,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D1=
34217728 backing_file=3DTEST_DIR/
> =20
>  =3D=3D=3D Invalid command - snapshot node used as backing hd =3D=3D=3D=

> =20
> -{"error": {"class": "GenericError", "desc": "Node 'snap_11' is busy: n=
ode is used as backing hd of 'virtio0'"}}
> +{"error": {"class": "GenericError", "desc": "Node 'snap_11' is busy: n=
ode is used as backing hd of 'snap_12'"}}
> =20
>  =3D=3D=3D Invalid command - snapshot node has a backing image =3D=3D=3D=

> =20
>=20



--7QOUwSSXJxonll8RDrEIsQf5eAwUXfvwo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlixp5ASHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AMSwH/3ibwc+N4qnSKlzDAaq7+2SyCWSNTbq6
zYpjh11R59Z1s37eRP3dpBt5pdqQNIUl2k/3Z+X5hF3a38e041erB0Uv/z9QmNxc
TiuhHTRtQyOioNNXUPcWuWiuKeBAStbWgH+Kqhg6yLFtg5o40tRw0pRVLeR+RX+u
hwMZc6uvA07nJfLS2HhrIqJLyeDabyMFlh415i7e4x0BL4f9gub2kl14v7ORvHLN
/+DIY9pZSQ4vxe15Yy2p8IC24O9m/eAeM+NkeL5k3qcvO4UGPKKvX6sM2gYZDonj
d1wlzP9yy9akspIlaPHkfcNaZjM2rcW2kHgnsb8+kFvJQLTq1nlDTts=
=0gSK
-----END PGP SIGNATURE-----

--7QOUwSSXJxonll8RDrEIsQf5eAwUXfvwo--
