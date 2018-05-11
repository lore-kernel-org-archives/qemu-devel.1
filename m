Received: from eggs.gnu.org ([2001:4830:134:3::10]:50224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fHCGu-0006qA-TJ
	for qemu-devel@nongnu.org; Fri, 11 May 2018 13:56:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fHCGr-0000Vr-QW
	for qemu-devel@nongnu.org; Fri, 11 May 2018 13:56:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44848 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fHCGr-0000VN-Jg
	for qemu-devel@nongnu.org; Fri, 11 May 2018 13:55:57 -0400
Date: Fri, 11 May 2018 18:55:48 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180511175547.GG2720@work-vm>
References: <20180510220248.10272-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180510220248.10272-1-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3] migration: discard non-migratable
 RAMBlocks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>, Yulei Zhang <yulei.zhang@intel.com>, kevin.tian@intel.com, joonas.lahtinen@linux.intel.com, zhenyuw@linux.intel.com, kwankhede@nvidia.com, zhi.a.wang@intel.com, Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

* C=E9dric Le Goater (clg@kaod.org) wrote:
> On the POWER9 processor, the XIVE interrupt controller can control
> interrupt sources using MMIO to trigger events, to EOI or to turn off
> the sources. Priority management and interrupt acknowledgment is also
> controlled by MMIO in the presenter sub-engine.
>=20
> These MMIO regions are exposed to guests in QEMU with a set of 'ram
> device' memory mappings, similarly to VFIO, and the VMAs are populated
> dynamically with the appropriate pages using a fault handler.
>=20
> But, these regions are an issue for migration. We need to discard the
> associated RAMBlocks from the RAM state on the source VM and let the
> destination VM rebuild the memory mappings on the new host in the
> post_load() operation just before resuming the system.
>=20
> To achieve this goal, the following introduces a new RAMBlock flag
> RAM_MIGRATABLE which is updated in the vmstate_register_ram() and
> vmstate_unregister_ram() routines. This flag is then used by the
> migration to identify RAMBlocks to discard on the source. Some checks
> are also performed on the destination to make sure nothing invalid was
> sent.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

I was about to add Review-by when I noticed that we use
qemu_ram_foeach_block in a number of places, once in migration/ram.c
and a bunch in migration/postcopy-ram.c

Sorry, I guess we need a version of that as well (or a flag).

Dave


> ---
>=20
>  Changes sinve v2:
>=20
>  - added an error_report() in ram_save_host_page()=20
>  - un/set the RAMBlock RAM_MIGRATABLE directly under vmstate_un/registe=
r_ram()
>    with some new flag helpers=20
> =20
>  exec.c                    | 18 ++++++++++++++++++
>  include/exec/cpu-common.h |  3 +++
>  migration/ram.c           | 43 +++++++++++++++++++++++++++++++++------=
----
>  migration/savevm.c        |  2 ++
>  4 files changed, 56 insertions(+), 10 deletions(-)
>=20
> diff --git a/exec.c b/exec.c
> index c7fcefa851b2..079c5c8bab7b 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -104,6 +104,9 @@ static MemoryRegion io_mem_unassigned;
>   * (Set during postcopy)
>   */
>  #define RAM_UF_ZEROPAGE (1 << 3)
> +
> +/* RAM can be migrated */
> +#define RAM_MIGRATABLE (1 << 4)
>  #endif
> =20
>  #ifdef TARGET_PAGE_BITS_VARY
> @@ -1797,6 +1800,21 @@ void qemu_ram_set_uf_zeroable(RAMBlock *rb)
>      rb->flags |=3D RAM_UF_ZEROPAGE;
>  }
> =20
> +bool qemu_ram_is_migratable(RAMBlock *rb)
> +{
> +    return rb->flags & RAM_MIGRATABLE;
> +}
> +
> +void qemu_ram_set_migratable(RAMBlock *rb)
> +{
> +    rb->flags |=3D RAM_MIGRATABLE;
> +}
> +
> +void qemu_ram_unset_migratable(RAMBlock *rb)
> +{
> +    rb->flags &=3D ~RAM_MIGRATABLE;
> +}
> +
>  /* Called with iothread lock held.  */
>  void qemu_ram_set_idstr(RAMBlock *new_block, const char *name, DeviceS=
tate *dev)
>  {
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 24d335f95d45..488288fce959 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -75,6 +75,9 @@ const char *qemu_ram_get_idstr(RAMBlock *rb);
>  bool qemu_ram_is_shared(RAMBlock *rb);
>  bool qemu_ram_is_uf_zeroable(RAMBlock *rb);
>  void qemu_ram_set_uf_zeroable(RAMBlock *rb);
> +bool qemu_ram_is_migratable(RAMBlock *rb);
> +void qemu_ram_set_migratable(RAMBlock *rb);
> +void qemu_ram_unset_migratable(RAMBlock *rb);
> =20
>  size_t qemu_ram_pagesize(RAMBlock *block);
>  size_t qemu_ram_pagesize_largest(void);
> diff --git a/migration/ram.c b/migration/ram.c
> index 912810c18e0f..dfdec78ecb03 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -187,6 +187,11 @@ void ramblock_recv_bitmap_set_range(RAMBlock *rb, =
void *host_addr,
>                        nr);
>  }
> =20
> +/* Should be holding either ram_list.mutex, or the RCU lock. */
> +#define RAMBLOCK_FOREACH_MIGRATABLE(block)             \
> +    RAMBLOCK_FOREACH(block)                            \
> +        if (!qemu_ram_is_migratable(block)) {} else
> +
>  /*
>   * An outstanding page request, on the source, having been received
>   * and queued
> @@ -813,6 +818,10 @@ unsigned long migration_bitmap_find_dirty(RAMState=
 *rs, RAMBlock *rb,
>      unsigned long *bitmap =3D rb->bmap;
>      unsigned long next;
> =20
> +    if (!qemu_ram_is_migratable(rb)) {
> +        return size;
> +    }
> +
>      if (rs->ram_bulk_stage && start > 0) {
>          next =3D start + 1;
>      } else {
> @@ -858,7 +867,7 @@ uint64_t ram_pagesize_summary(void)
>      RAMBlock *block;
>      uint64_t summary =3D 0;
> =20
> -    RAMBLOCK_FOREACH(block) {
> +    RAMBLOCK_FOREACH_MIGRATABLE(block) {
>          summary |=3D block->page_size;
>      }
> =20
> @@ -882,7 +891,7 @@ static void migration_bitmap_sync(RAMState *rs)
> =20
>      qemu_mutex_lock(&rs->bitmap_mutex);
>      rcu_read_lock();
> -    RAMBLOCK_FOREACH(block) {
> +    RAMBLOCK_FOREACH_MIGRATABLE(block) {
>          migration_bitmap_sync_range(rs, block, 0, block->used_length);
>      }
>      rcu_read_unlock();
> @@ -1521,6 +1530,11 @@ static int ram_save_host_page(RAMState *rs, Page=
SearchStatus *pss,
>      size_t pagesize_bits =3D
>          qemu_ram_pagesize(pss->block) >> TARGET_PAGE_BITS;
> =20
> +    if (!qemu_ram_is_migratable(pss->block)) {
> +        error_report("block %s should not be migrated !", pss->block->=
idstr);
> +        return 0;
> +    }
> +
>      do {
>          /* Check the pages is dirty and if it is send it */
>          if (!migration_bitmap_clear_dirty(rs, pss->block, pss->page)) =
{
> @@ -1619,7 +1633,7 @@ uint64_t ram_bytes_total(void)
>      uint64_t total =3D 0;
> =20
>      rcu_read_lock();
> -    RAMBLOCK_FOREACH(block) {
> +    RAMBLOCK_FOREACH_MIGRATABLE(block) {
>          total +=3D block->used_length;
>      }
>      rcu_read_unlock();
> @@ -1674,7 +1688,7 @@ static void ram_save_cleanup(void *opaque)
>       */
>      memory_global_dirty_log_stop();
> =20
> -    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
> +    RAMBLOCK_FOREACH_MIGRATABLE(block) {
>          g_free(block->bmap);
>          block->bmap =3D NULL;
>          g_free(block->unsentmap);
> @@ -1737,7 +1751,7 @@ void ram_postcopy_migrated_memory_release(Migrati=
onState *ms)
>  {
>      struct RAMBlock *block;
> =20
> -    RAMBLOCK_FOREACH(block) {
> +    RAMBLOCK_FOREACH_MIGRATABLE(block) {
>          unsigned long *bitmap =3D block->bmap;
>          unsigned long range =3D block->used_length >> TARGET_PAGE_BITS=
;
>          unsigned long run_start =3D find_next_zero_bit(bitmap, range, =
0);
> @@ -1815,7 +1829,7 @@ static int postcopy_each_ram_send_discard(Migrati=
onState *ms)
>      struct RAMBlock *block;
>      int ret;
> =20
> -    RAMBLOCK_FOREACH(block) {
> +    RAMBLOCK_FOREACH_MIGRATABLE(block) {
>          PostcopyDiscardState *pds =3D
>              postcopy_discard_send_init(ms, block->idstr);
> =20
> @@ -2023,7 +2037,7 @@ int ram_postcopy_send_discard_bitmap(MigrationSta=
te *ms)
>      rs->last_sent_block =3D NULL;
>      rs->last_page =3D 0;
> =20
> -    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
> +    RAMBLOCK_FOREACH_MIGRATABLE(block) {
>          unsigned long pages =3D block->used_length >> TARGET_PAGE_BITS=
;
>          unsigned long *bitmap =3D block->bmap;
>          unsigned long *unsentmap =3D block->unsentmap;
> @@ -2182,7 +2196,7 @@ static void ram_list_init_bitmaps(void)
> =20
>      /* Skip setting bitmap if there is no RAM */
>      if (ram_bytes_total()) {
> -        QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
> +        RAMBLOCK_FOREACH_MIGRATABLE(block) {
>              pages =3D block->max_length >> TARGET_PAGE_BITS;
>              block->bmap =3D bitmap_new(pages);
>              bitmap_set(block->bmap, 0, pages);
> @@ -2263,7 +2277,7 @@ static int ram_save_setup(QEMUFile *f, void *opaq=
ue)
> =20
>      qemu_put_be64(f, ram_bytes_total() | RAM_SAVE_FLAG_MEM_SIZE);
> =20
> -    RAMBLOCK_FOREACH(block) {
> +    RAMBLOCK_FOREACH_MIGRATABLE(block) {
>          qemu_put_byte(f, strlen(block->idstr));
>          qemu_put_buffer(f, (uint8_t *)block->idstr, strlen(block->idst=
r));
>          qemu_put_be64(f, block->used_length);
> @@ -2507,6 +2521,11 @@ static inline RAMBlock *ram_block_from_stream(QE=
MUFile *f, int flags)
>          return NULL;
>      }
> =20
> +    if (!qemu_ram_is_migratable(block)) {
> +        error_report("block %s should not be migrated !", id);
> +        return NULL;
> +    }
> +
>      return block;
>  }
> =20
> @@ -3011,7 +3030,11 @@ static int ram_load(QEMUFile *f, void *opaque, i=
nt version_id)
>                  length =3D qemu_get_be64(f);
> =20
>                  block =3D qemu_ram_block_by_name(id);
> -                if (block) {
> +                if (block && !qemu_ram_is_migratable(block)) {
> +                    error_report("block %s should not be migrated !", =
id);
> +                    ret =3D -EINVAL;
> +
> +                } else if (block) {
>                      if (length !=3D block->used_length) {
>                          Error *local_err =3D NULL;
> =20
> diff --git a/migration/savevm.c b/migration/savevm.c
> index e2be02afe42c..9ebfba738ea4 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -2501,11 +2501,13 @@ void vmstate_register_ram(MemoryRegion *mr, Dev=
iceState *dev)
>  {
>      qemu_ram_set_idstr(mr->ram_block,
>                         memory_region_name(mr), dev);
> +    qemu_ram_set_migratable(mr->ram_block);
>  }
> =20
>  void vmstate_unregister_ram(MemoryRegion *mr, DeviceState *dev)
>  {
>      qemu_ram_unset_idstr(mr->ram_block);
> +    qemu_ram_unset_migratable(mr->ram_block);
>  }
> =20
>  void vmstate_register_ram_global(MemoryRegion *mr)
> --=20
> 2.13.6
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
