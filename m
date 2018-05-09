Received: from eggs.gnu.org ([2001:4830:134:3::10]:55156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fGMxi-0004jI-KA
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:08:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fGMxe-0004Sx-CH
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:08:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51474 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fGMxe-0004RN-5b
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:08:42 -0400
Date: Wed, 9 May 2018 12:08:34 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180509110833.GD2527@work-vm>
References: <20180413075200.15217-1-clg@kaod.org>
	<20180419165800.GA2731@work-vm>
	<e5447136-8de7-73f3-ca6d-0c7a1fe11abe@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <e5447136-8de7-73f3-ca6d-0c7a1fe11abe@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] migration: discard non-migratable
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

This thread seems to have stalled; we've got the list of potential
migration breaks that Peter found and only some minor comments on the
actual patch.

I'd like to get it going again sicne as well as C=E9dric, and Peter's
cases, there's Lai Jiangshan and now Eric Wheeler was asking for
something similar.

Anyone understand the way forward? Do we have to go and fix the
odd board failures first?

Dave

* C=E9dric Le Goater (clg@kaod.org) wrote:
> Hello David,
>=20
> On 04/19/2018 06:58 PM, Dr. David Alan Gilbert wrote:
> > * C=E9dric Le Goater (clg@kaod.org) wrote:
> >> On the POWER9 processor, the XIVE interrupt controller can control
> >> interrupt sources using MMIO to trigger events, to EOI or to turn of=
f
> >> the sources. Priority management and interrupt acknowledgment is als=
o
> >> controlled by MMIO in the presenter sub-engine.
> >>
> >> These MMIO regions are exposed to guests in QEMU with a set of 'ram
> >> device' memory mappings, similarly to VFIO, and the VMAs are populat=
ed
> >> dynamically with the appropriate pages using a fault handler.
> >>
> >> But, these regions are an issue for migration. We need to discard th=
e
> >> associated RAMBlocks from the RAM state on the source VM and let the
> >> destination VM rebuild the memory mappings on the new host in the
> >> post_load() operation just before resuming the system.
> >>
> >> To achieve this goal, the following introduces a new RAMBlock flag
> >> RAM_MIGRATABLE which is updated in the vmstate_register_ram() and
> >> vmstate_unregister_ram() routines. This flag is then used by the
> >> migration to identify RAMBlocks to discard on the source. Some check=
s
> >> are also performed on the destination to make sure nothing invalid w=
as
> >> sent.
> >>
> >> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> >=20
> > Hi C=E9dric,
> >   Yes, this is looking nicer; the macro makes the changes quite small=
.
> > A couple of questions:
> >=20
> >> ---
> >>
> >>  Changes since v1:
> >>
> >>  - introduced a new RAMBlock flag RAM_MIGRATABLE
> >>  - fixed RAMBLOCK_FOREACH_MIGRATABLE() macro to handle code that
> >>    omitted {}.=20
> >>
> >>  exec.c                    | 10 ++++++++++
> >>  include/exec/cpu-common.h |  1 +
> >>  migration/ram.c           | 42 ++++++++++++++++++++++++++++++++----=
------
> >>  3 files changed, 43 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/exec.c b/exec.c
> >> index 02b1efebb7c3..e9432c06294e 100644
> >> --- a/exec.c
> >> +++ b/exec.c
> >> @@ -104,6 +104,9 @@ static MemoryRegion io_mem_unassigned;
> >>   * (Set during postcopy)
> >>   */
> >>  #define RAM_UF_ZEROPAGE (1 << 3)
> >> +
> >> +/* RAM can be migrated */
> >> +#define RAM_MIGRATABLE (1 << 4)
> >>  #endif
> >> =20
> >>  #ifdef TARGET_PAGE_BITS_VARY
> >> @@ -1807,6 +1810,11 @@ void qemu_ram_set_uf_zeroable(RAMBlock *rb)
> >>      rb->flags |=3D RAM_UF_ZEROPAGE;
> >>  }
> >> =20
> >> +bool qemu_ram_is_migratable(RAMBlock *rb)
> >> +{
> >> +    return rb->flags & RAM_MIGRATABLE;
> >> +}
> >> +
> >>  /* Called with iothread lock held.  */
> >>  void qemu_ram_set_idstr(RAMBlock *new_block, const char *name, Devi=
ceState *dev)
> >>  {
> >> @@ -1823,6 +1831,7 @@ void qemu_ram_set_idstr(RAMBlock *new_block, c=
onst char *name, DeviceState *dev)
> >>          }
> >>      }
> >>      pstrcat(new_block->idstr, sizeof(new_block->idstr), name);
> >> +    new_block->flags |=3D RAM_MIGRATABLE;
> >> =20
> >>      rcu_read_lock();
> >>      RAMBLOCK_FOREACH(block) {
> >> @@ -1845,6 +1854,7 @@ void qemu_ram_unset_idstr(RAMBlock *block)
> >>       */
> >>      if (block) {
> >>          memset(block->idstr, 0, sizeof(block->idstr));
> >> +        block->flags &=3D ~RAM_MIGRATABLE;
> >>      }
> >>  }
> >=20
> > Why in qemu_ram_set_idstr and qemu_ram_(un)set_idstr ?  It seems an
> > odd place to put them.
>=20
> The only place where this routines are called is from vmstate_un/regist=
er_ram()
> It seemed unnecessary to add an extra interface qemu_ram_un/set_migrata=
ble().
>=20
> May be should just rename qemu_ram_un/set_idstr() ?
>=20
> >=20
> >> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> >> index 24d335f95d45..96854519b514 100644
> >> --- a/include/exec/cpu-common.h
> >> +++ b/include/exec/cpu-common.h
> >> @@ -75,6 +75,7 @@ const char *qemu_ram_get_idstr(RAMBlock *rb);
> >>  bool qemu_ram_is_shared(RAMBlock *rb);
> >>  bool qemu_ram_is_uf_zeroable(RAMBlock *rb);
> >>  void qemu_ram_set_uf_zeroable(RAMBlock *rb);
> >> +bool qemu_ram_is_migratable(RAMBlock *rb);
> >> =20
> >>  size_t qemu_ram_pagesize(RAMBlock *block);
> >>  size_t qemu_ram_pagesize_largest(void);
> >> diff --git a/migration/ram.c b/migration/ram.c
> >> index 0e90efa09236..89c3accc4e26 100644
> >> --- a/migration/ram.c
> >> +++ b/migration/ram.c
> >> @@ -187,6 +187,11 @@ void ramblock_recv_bitmap_set_range(RAMBlock *r=
b, void *host_addr,
> >>                        nr);
> >>  }
> >> =20
> >> +/* Should be holding either ram_list.mutex, or the RCU lock. */
> >> +#define RAMBLOCK_FOREACH_MIGRATABLE(block)             \
> >> +    RAMBLOCK_FOREACH(block)                            \
> >> +        if (!qemu_ram_is_migratable(block)) {} else
> >> +
> >>  /*
> >>   * An outstanding page request, on the source, having been received
> >>   * and queued
> >> @@ -780,6 +785,10 @@ unsigned long migration_bitmap_find_dirty(RAMSt=
ate *rs, RAMBlock *rb,
> >>      unsigned long *bitmap =3D rb->bmap;
> >>      unsigned long next;
> >> =20
> >> +    if (!qemu_ram_is_migratable(rb)) {
> >> +        return size;
> >> +    }
> >> +
> >>      if (rs->ram_bulk_stage && start > 0) {
> >>          next =3D start + 1;
> >>      } else {
> >> @@ -825,7 +834,7 @@ uint64_t ram_pagesize_summary(void)
> >>      RAMBlock *block;
> >>      uint64_t summary =3D 0;
> >> =20
> >> -    RAMBLOCK_FOREACH(block) {
> >> +    RAMBLOCK_FOREACH_MIGRATABLE(block) {
> >>          summary |=3D block->page_size;
> >>      }
> >> =20
> >> @@ -849,7 +858,7 @@ static void migration_bitmap_sync(RAMState *rs)
> >> =20
> >>      qemu_mutex_lock(&rs->bitmap_mutex);
> >>      rcu_read_lock();
> >> -    RAMBLOCK_FOREACH(block) {
> >> +    RAMBLOCK_FOREACH_MIGRATABLE(block) {
> >>          migration_bitmap_sync_range(rs, block, 0, block->used_lengt=
h);
> >>      }
> >>      rcu_read_unlock();
> >> @@ -1499,6 +1508,10 @@ static int ram_save_host_page(RAMState *rs, P=
ageSearchStatus *pss,
> >>      size_t pagesize_bits =3D
> >>          qemu_ram_pagesize(pss->block) >> TARGET_PAGE_BITS;
> >> =20
> >> +    if (!qemu_ram_is_migratable(pss->block)) {
> >> +        return 0;
> >> +    }
> >> +
> >=20
> > We might want to print a diagnostic there - it shouldn't happen right=
?
>=20
> yes it should not. it should even be fatal.=20
>=20
> >>      do {
> >>          tmppages =3D ram_save_target_page(rs, pss, last_stage);
> >>          if (tmppages < 0) {
> >> @@ -1587,7 +1600,7 @@ uint64_t ram_bytes_total(void)
> >>      uint64_t total =3D 0;
> >> =20
> >>      rcu_read_lock();
> >> -    RAMBLOCK_FOREACH(block) {
> >> +    RAMBLOCK_FOREACH_MIGRATABLE(block) {
> >>          total +=3D block->used_length;
> >>      }
> >>      rcu_read_unlock();
> >> @@ -1642,7 +1655,7 @@ static void ram_save_cleanup(void *opaque)
> >>       */
> >>      memory_global_dirty_log_stop();
> >> =20
> >> -    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
> >> +    RAMBLOCK_FOREACH_MIGRATABLE(block) {
> >>          g_free(block->bmap);
> >>          block->bmap =3D NULL;
> >>          g_free(block->unsentmap);
> >> @@ -1705,7 +1718,7 @@ void ram_postcopy_migrated_memory_release(Migr=
ationState *ms)
> >>  {
> >>      struct RAMBlock *block;
> >> =20
> >> -    RAMBLOCK_FOREACH(block) {
> >> +    RAMBLOCK_FOREACH_MIGRATABLE(block) {
> >>          unsigned long *bitmap =3D block->bmap;
> >>          unsigned long range =3D block->used_length >> TARGET_PAGE_B=
ITS;
> >>          unsigned long run_start =3D find_next_zero_bit(bitmap, rang=
e, 0);
> >> @@ -1783,7 +1796,7 @@ static int postcopy_each_ram_send_discard(Migr=
ationState *ms)
> >>      struct RAMBlock *block;
> >>      int ret;
> >> =20
> >> -    RAMBLOCK_FOREACH(block) {
> >> +    RAMBLOCK_FOREACH_MIGRATABLE(block) {
> >>          PostcopyDiscardState *pds =3D
> >>              postcopy_discard_send_init(ms, block->idstr);
> >> =20
> >> @@ -1991,7 +2004,7 @@ int ram_postcopy_send_discard_bitmap(Migration=
State *ms)
> >>      rs->last_sent_block =3D NULL;
> >>      rs->last_page =3D 0;
> >> =20
> >> -    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
> >> +    RAMBLOCK_FOREACH_MIGRATABLE(block) {
> >>          unsigned long pages =3D block->used_length >> TARGET_PAGE_B=
ITS;
> >>          unsigned long *bitmap =3D block->bmap;
> >>          unsigned long *unsentmap =3D block->unsentmap;
> >> @@ -2150,7 +2163,7 @@ static void ram_list_init_bitmaps(void)
> >> =20
> >>      /* Skip setting bitmap if there is no RAM */
> >>      if (ram_bytes_total()) {
> >> -        QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
> >> +        RAMBLOCK_FOREACH_MIGRATABLE(block) {
> >>              pages =3D block->max_length >> TARGET_PAGE_BITS;
> >>              block->bmap =3D bitmap_new(pages);
> >>              bitmap_set(block->bmap, 0, pages);
> >> @@ -2226,7 +2239,7 @@ static int ram_save_setup(QEMUFile *f, void *o=
paque)
> >> =20
> >>      qemu_put_be64(f, ram_bytes_total() | RAM_SAVE_FLAG_MEM_SIZE);
> >> =20
> >> -    RAMBLOCK_FOREACH(block) {
> >> +    RAMBLOCK_FOREACH_MIGRATABLE(block) {
> >>          qemu_put_byte(f, strlen(block->idstr));
> >>          qemu_put_buffer(f, (uint8_t *)block->idstr, strlen(block->i=
dstr));
> >>          qemu_put_be64(f, block->used_length);
> >=20
> > Good, that's all quite neat;  we've just got to watch out we don't
> > accidentally add any RAMBLOCK_FOREACH's back.
>=20
> Thank,
>=20
> C.
>=20
> >> @@ -2471,6 +2484,11 @@ static inline RAMBlock *ram_block_from_stream=
(QEMUFile *f, int flags)
> >>          return NULL;
> >>      }
> >> =20
> >> +    if (!qemu_ram_is_migratable(block)) {
> >> +        error_report("block %s should not be migrated !", id);
> >> +        return NULL;
> >> +    }
> >> +
> >>      return block;
> >>  }
> >> =20
> >> @@ -2921,7 +2939,11 @@ static int ram_load(QEMUFile *f, void *opaque=
, int version_id)
> >>                  length =3D qemu_get_be64(f);
> >> =20
> >>                  block =3D qemu_ram_block_by_name(id);
> >> -                if (block) {
> >> +                if (block && !qemu_ram_is_migratable(block)) {
> >> +                    error_report("block %s should not be migrated !=
", id);
> >> +                    ret =3D -EINVAL;
> >> +
> >> +                } else if (block) {
> >>                      if (length !=3D block->used_length) {
> >>                          Error *local_err =3D NULL;
> >> =20
> >> --=20
> >> 2.13.6
> >=20
> > Dave
> >=20
> >>
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> >=20
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
