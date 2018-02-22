Received: from eggs.gnu.org ([2001:4830:134:3::10]:39857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eor73-0001Hq-47
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 08:40:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1eor6z-0000cW-VX
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 08:40:41 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180215131008.5153-1-berto@igalia.com>
References: <20180215131008.5153-1-berto@igalia.com>
Date: Thu, 22 Feb 2018 14:40:34 +0100
Message-ID: <w51bmgh5ei5.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] qcow2: Replace align_offset() with
 ROUND_UP()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

ping

On Thu 15 Feb 2018 02:10:08 PM CET, Alberto Garcia wrote:
> The align_offset() function is equivalent to the ROUND_UP() macro so
> there's no need to use the former. The ROUND_UP() name is also a bit
> more explicit.
>
> This patch uses ROUND_UP() instead of the slower QEMU_ALIGN_UP()
> because align_offset() already requires that the second parameter is a
> power of two.
>
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
> v3 is the same as v2, but rebased on top of the current master fixing
> a merge conflict.
> ---
>  block/qcow2-bitmap.c   |  4 ++--
>  block/qcow2-cluster.c  |  4 ++--
>  block/qcow2-refcount.c |  4 ++--
>  block/qcow2-snapshot.c | 10 +++++-----
>  block/qcow2.c          | 14 +++++++-------
>  block/qcow2.h          |  6 ------
>  6 files changed, 18 insertions(+), 24 deletions(-)
>
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index 4f6fd863ea..5127276f90 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c
> @@ -413,8 +413,8 @@ static inline void bitmap_dir_entry_to_be(Qcow2Bitmap=
DirEntry *entry)
>=20=20
>  static inline int calc_dir_entry_size(size_t name_size, size_t extra_dat=
a_size)
>  {
> -    return align_offset(sizeof(Qcow2BitmapDirEntry) +
> -                        name_size + extra_data_size, 8);
> +    int size =3D sizeof(Qcow2BitmapDirEntry) + name_size + extra_data_si=
ze;
> +    return ROUND_UP(size, 8);
>  }
>=20=20
>  static inline int dir_entry_size(Qcow2BitmapDirEntry *entry)
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index e406b0f3b9..98908c4264 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -126,11 +126,11 @@ int qcow2_grow_l1_table(BlockDriverState *bs, uint6=
4_t min_size,
>=20=20
>      new_l1_size2 =3D sizeof(uint64_t) * new_l1_size;
>      new_l1_table =3D qemu_try_blockalign(bs->file->bs,
> -                                       align_offset(new_l1_size2, 512));
> +                                       ROUND_UP(new_l1_size2, 512));
>      if (new_l1_table =3D=3D NULL) {
>          return -ENOMEM;
>      }
> -    memset(new_l1_table, 0, align_offset(new_l1_size2, 512));
> +    memset(new_l1_table, 0, ROUND_UP(new_l1_size2, 512));
>=20=20
>      if (s->l1_size) {
>          memcpy(new_l1_table, s->l1_table, s->l1_size * sizeof(uint64_t));
> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index d46b69d7f3..126cca3276 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c
> @@ -1204,7 +1204,7 @@ int qcow2_update_snapshot_refcount(BlockDriverState=
 *bs,
>       * l1_table_offset when it is the current s->l1_table_offset! Be car=
eful
>       * when changing this! */
>      if (l1_table_offset !=3D s->l1_table_offset) {
> -        l1_table =3D g_try_malloc0(align_offset(l1_size2, 512));
> +        l1_table =3D g_try_malloc0(ROUND_UP(l1_size2, 512));
>          if (l1_size2 && l1_table =3D=3D NULL) {
>              ret =3D -ENOMEM;
>              goto fail;
> @@ -2553,7 +2553,7 @@ int qcow2_check_metadata_overlap(BlockDriverState *=
bs, int ign, int64_t offset,
>      }
>=20=20
>      /* align range to test to cluster boundaries */
> -    size =3D align_offset(offset_into_cluster(s, offset) + size, s->clus=
ter_size);
> +    size =3D ROUND_UP(offset_into_cluster(s, offset) + size, s->cluster_=
size);
>      offset =3D start_of_cluster(s, offset);
>=20=20
>      if ((chk & QCOW2_OL_ACTIVE_L1) && s->l1_size) {
> diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
> index 44243e0e95..cee25f582b 100644
> --- a/block/qcow2-snapshot.c
> +++ b/block/qcow2-snapshot.c
> @@ -66,7 +66,7 @@ int qcow2_read_snapshots(BlockDriverState *bs)
>=20=20
>      for(i =3D 0; i < s->nb_snapshots; i++) {
>          /* Read statically sized part of the snapshot header */
> -        offset =3D align_offset(offset, 8);
> +        offset =3D ROUND_UP(offset, 8);
>          ret =3D bdrv_pread(bs->file, offset, &h, sizeof(h));
>          if (ret < 0) {
>              goto fail;
> @@ -155,7 +155,7 @@ static int qcow2_write_snapshots(BlockDriverState *bs)
>      offset =3D 0;
>      for(i =3D 0; i < s->nb_snapshots; i++) {
>          sn =3D s->snapshots + i;
> -        offset =3D align_offset(offset, 8);
> +        offset =3D ROUND_UP(offset, 8);
>          offset +=3D sizeof(h);
>          offset +=3D sizeof(extra);
>          offset +=3D strlen(sn->id_str);
> @@ -215,7 +215,7 @@ static int qcow2_write_snapshots(BlockDriverState *bs)
>          assert(id_str_size <=3D UINT16_MAX && name_size <=3D UINT16_MAX);
>          h.id_str_size =3D cpu_to_be16(id_str_size);
>          h.name_size =3D cpu_to_be16(name_size);
> -        offset =3D align_offset(offset, 8);
> +        offset =3D ROUND_UP(offset, 8);
>=20=20
>          ret =3D bdrv_pwrite(bs->file, offset, &h, sizeof(h));
>          if (ret < 0) {
> @@ -441,7 +441,7 @@ int qcow2_snapshot_create(BlockDriverState *bs, QEMUS=
napshotInfo *sn_info)
>      /* The VM state isn't needed any more in the active L1 table; in fac=
t, it
>       * hurts by causing expensive COW for the next snapshot. */
>      qcow2_cluster_discard(bs, qcow2_vm_state_offset(s),
> -                          align_offset(sn->vm_state_size, s->cluster_siz=
e),
> +                          ROUND_UP(sn->vm_state_size, s->cluster_size),
>                            QCOW2_DISCARD_NEVER, false);
>=20=20
>  #ifdef DEBUG_ALLOC
> @@ -710,7 +710,7 @@ int qcow2_snapshot_load_tmp(BlockDriverState *bs,
>      }
>      new_l1_bytes =3D sn->l1_size * sizeof(uint64_t);
>      new_l1_table =3D qemu_try_blockalign(bs->file->bs,
> -                                       align_offset(new_l1_bytes, 512));
> +                                       ROUND_UP(new_l1_bytes, 512));
>      if (new_l1_table =3D=3D NULL) {
>          return -ENOMEM;
>      }
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 57a517e2bd..2c6c33b67c 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -1379,7 +1379,7 @@ static int qcow2_do_open(BlockDriverState *bs, QDic=
t *options, int flags,
>=20=20
>      if (s->l1_size > 0) {
>          s->l1_table =3D qemu_try_blockalign(bs->file->bs,
> -            align_offset(s->l1_size * sizeof(uint64_t), 512));
> +            ROUND_UP(s->l1_size * sizeof(uint64_t), 512));
>          if (s->l1_table =3D=3D NULL) {
>              error_setg(errp, "Could not allocate L1 table");
>              ret =3D -ENOMEM;
> @@ -2640,19 +2640,19 @@ static int64_t qcow2_calc_prealloc_size(int64_t t=
otal_size,
>  {
>      int64_t meta_size =3D 0;
>      uint64_t nl1e, nl2e;
> -    int64_t aligned_total_size =3D align_offset(total_size, cluster_size=
);
> +    int64_t aligned_total_size =3D ROUND_UP(total_size, cluster_size);
>=20=20
>      /* header: 1 cluster */
>      meta_size +=3D cluster_size;
>=20=20
>      /* total size of L2 tables */
>      nl2e =3D aligned_total_size / cluster_size;
> -    nl2e =3D align_offset(nl2e, cluster_size / sizeof(uint64_t));
> +    nl2e =3D ROUND_UP(nl2e, cluster_size / sizeof(uint64_t));
>      meta_size +=3D nl2e * sizeof(uint64_t);
>=20=20
>      /* total size of L1 tables */
>      nl1e =3D nl2e * sizeof(uint64_t) / cluster_size;
> -    nl1e =3D align_offset(nl1e, cluster_size / sizeof(uint64_t));
> +    nl1e =3D ROUND_UP(nl1e, cluster_size / sizeof(uint64_t));
>      meta_size +=3D nl1e * sizeof(uint64_t);
>=20=20
>      /* total size of refcount table and blocks */
> @@ -3706,8 +3706,8 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *op=
ts, BlockDriverState *in_bs,
>      has_backing_file =3D !!optstr;
>      g_free(optstr);
>=20=20
> -    virtual_size =3D align_offset(qemu_opt_get_size_del(opts, BLOCK_OPT_=
SIZE, 0),
> -                                cluster_size);
> +    virtual_size =3D qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0);
> +    virtual_size =3D ROUND_UP(virtual_size, cluster_size);
>=20=20
>      /* Check that virtual disk size is valid */
>      l2_tables =3D DIV_ROUND_UP(virtual_size / cluster_size,
> @@ -3727,7 +3727,7 @@ static BlockMeasureInfo *qcow2_measure(QemuOpts *op=
ts, BlockDriverState *in_bs,
>              goto err;
>          }
>=20=20
> -        virtual_size =3D align_offset(ssize, cluster_size);
> +        virtual_size =3D ROUND_UP(ssize, cluster_size);
>=20=20
>          if (has_backing_file) {
>              /* We don't how much of the backing chain is shared by the i=
nput
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 883802241f..1a84cc77b0 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -480,12 +480,6 @@ static inline int offset_to_l2_slice_index(BDRVQcow2=
State *s, int64_t offset)
>      return (offset >> s->cluster_bits) & (s->l2_slice_size - 1);
>  }
>=20=20
> -static inline int64_t align_offset(int64_t offset, int n)
> -{
> -    offset =3D (offset + n - 1) & ~(n - 1);
> -    return offset;
> -}
> -
>  static inline int64_t qcow2_vm_state_offset(BDRVQcow2State *s)
>  {
>      return (int64_t)s->l1_vm_state_index << (s->cluster_bits + s->l2_bit=
s);
> --=20
> 2.11.0
