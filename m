Received: from eggs.gnu.org ([2001:4830:134:3::10]:41788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwankhede@nvidia.com>) id 1f6L2f-00042I-Nt
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 15:04:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwankhede@nvidia.com>) id 1f6L2c-0002t9-Ft
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 15:04:25 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:14538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwankhede@nvidia.com>)
	id 1f6L2c-0002ro-4U
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 15:04:22 -0400
References: <20180411172014.24711-1-clg@kaod.org>
	<20180411115511.342c75b9@w520.home>
From: Kirti Wankhede <kwankhede@nvidia.com>
Message-ID: <0326be05-c25b-adab-c31d-b9e337a6247a@nvidia.com>
Date: Thu, 12 Apr 2018 00:34:03 +0530
MIME-Version: 1.0
In-Reply-To: <20180411115511.342c75b9@w520.home>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] migration: discard RAMBlocks of type
 ram_device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, "Dr . David
	Alan Gilbert" <dgilbert@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Yulei Zhang <yulei.zhang@intel.com>, kevin.tian@intel.com, joonas.lahtinen@linux.intel.com, zhenyuw@linux.intel.com, zhi.a.wang@intel.com



On 4/11/2018 11:25 PM, Alex Williamson wrote:
> [cc +folks working on vfio-mdev migration]
>=20
> On Wed, 11 Apr 2018 19:20:14 +0200
> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>=20
>> Here is some context for this strange change request.
>>
>> On the POWER9 processor, the XIVE interrupt controller can control
>> interrupt sources using MMIO to trigger events, to EOI or to turn off
>> the sources. Priority management and interrupt acknowledgment is also
>> controlled by MMIO in the presenter subengine.
>>
>> These MMIO regions are exposed to guests in QEMU with a set of 'ram
>> device' memory mappings, similarly to VFIO, and the VMAs are populated
>> dynamically with the appropriate pages using a fault handler.
>>
>> But, these regions are an issue for migration. We need to discard the
>> associated RAMBlocks from the RAM state on the source VM and let the
>> destination VM rebuild the memory mappings on the new host in the
>> post_load() operation just before resuming the system.
>>
>> This is the goal of the following proposal. Does it make sense ? It
>> seems to be working enough to migrate a running guest but there might
>> be a better, more subtle, approach.
>=20
> Yulei, is this something you've run into with GVT-g migration?  I don't
> see how we can read from or write to ram_device regions in a useful way
> during migration anyway, so the change initially looks correct to me.
> Thanks,
>=20

I ran into this problem with vGPU migration. I have very similar patch
in my local branch to test vGPU migration. This patch looks good to me.

Thanks,
Kirti


> Alex
>=20
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>  migration/ram.c | 42 ++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 40 insertions(+), 2 deletions(-)
>>
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 0e90efa09236..6404ccd046d8 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -780,6 +780,10 @@ unsigned long migration_bitmap_find_dirty(RAMState =
*rs, RAMBlock *rb,
>>      unsigned long *bitmap =3D rb->bmap;
>>      unsigned long next;
>> =20
>> +    if (memory_region_is_ram_device(rb->mr)) {
>> +        return size;
>> +    }
>> +
>>      if (rs->ram_bulk_stage && start > 0) {
>>          next =3D start + 1;
>>      } else {
>> @@ -826,6 +830,9 @@ uint64_t ram_pagesize_summary(void)
>>      uint64_t summary =3D 0;
>> =20
>>      RAMBLOCK_FOREACH(block) {
>> +        if (memory_region_is_ram_device(block->mr)) {
>> +            continue;
>> +        }
>>          summary |=3D block->page_size;
>>      }
>> =20
>> @@ -850,6 +857,9 @@ static void migration_bitmap_sync(RAMState *rs)
>>      qemu_mutex_lock(&rs->bitmap_mutex);
>>      rcu_read_lock();
>>      RAMBLOCK_FOREACH(block) {
>> +        if (memory_region_is_ram_device(block->mr)) {
>> +            continue;
>> +        }
>>          migration_bitmap_sync_range(rs, block, 0, block->used_length);
>>      }
>>      rcu_read_unlock();
>> @@ -1499,6 +1509,10 @@ static int ram_save_host_page(RAMState *rs, PageS=
earchStatus *pss,
>>      size_t pagesize_bits =3D
>>          qemu_ram_pagesize(pss->block) >> TARGET_PAGE_BITS;
>> =20
>> +    if (memory_region_is_ram_device(pss->block->mr)) {
>> +        return 0;
>> +    }
>> +
>>      do {
>>          tmppages =3D ram_save_target_page(rs, pss, last_stage);
>>          if (tmppages < 0) {
>> @@ -1588,6 +1602,9 @@ uint64_t ram_bytes_total(void)
>> =20
>>      rcu_read_lock();
>>      RAMBLOCK_FOREACH(block) {
>> +        if (memory_region_is_ram_device(block->mr)) {
>> +            continue;
>> +        }
>>          total +=3D block->used_length;
>>      }
>>      rcu_read_unlock();
>> @@ -1643,6 +1660,9 @@ static void ram_save_cleanup(void *opaque)
>>      memory_global_dirty_log_stop();
>> =20
>>      QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
>> +        if (memory_region_is_ram_device(block->mr)) {
>> +            continue;
>> +        }
>>          g_free(block->bmap);
>>          block->bmap =3D NULL;
>>          g_free(block->unsentmap);
>> @@ -1710,6 +1730,9 @@ void ram_postcopy_migrated_memory_release(Migratio=
nState *ms)
>>          unsigned long range =3D block->used_length >> TARGET_PAGE_BITS;
>>          unsigned long run_start =3D find_next_zero_bit(bitmap, range, 0=
);
>> =20
>> +        if (memory_region_is_ram_device(block->mr)) {
>> +            continue;
>> +        }
>>          while (run_start < range) {
>>              unsigned long run_end =3D find_next_bit(bitmap, range, run_=
start + 1);
>>              ram_discard_range(block->idstr, run_start << TARGET_PAGE_BI=
TS,
>> @@ -1784,8 +1807,13 @@ static int postcopy_each_ram_send_discard(Migrati=
onState *ms)
>>      int ret;
>> =20
>>      RAMBLOCK_FOREACH(block) {
>> -        PostcopyDiscardState *pds =3D
>> -            postcopy_discard_send_init(ms, block->idstr);
>> +        PostcopyDiscardState *pds;
>> +
>> +        if (memory_region_is_ram_device(block->mr)) {
>> +            continue;
>> +        }
>> +
>> +        pds =3D postcopy_discard_send_init(ms, block->idstr);
>> =20
>>          /*
>>           * Postcopy sends chunks of bitmap over the wire, but it
>> @@ -1996,6 +2024,10 @@ int ram_postcopy_send_discard_bitmap(MigrationSta=
te *ms)
>>          unsigned long *bitmap =3D block->bmap;
>>          unsigned long *unsentmap =3D block->unsentmap;
>> =20
>> +        if (memory_region_is_ram_device(block->mr)) {
>> +            continue;
>> +        }
>> +
>>          if (!unsentmap) {
>>              /* We don't have a safe way to resize the sentmap, so
>>               * if the bitmap was resized it will be NULL at this
>> @@ -2151,6 +2183,9 @@ static void ram_list_init_bitmaps(void)
>>      /* Skip setting bitmap if there is no RAM */
>>      if (ram_bytes_total()) {
>>          QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
>> +            if (memory_region_is_ram_device(block->mr)) {
>> +                continue;
>> +            }
>>              pages =3D block->max_length >> TARGET_PAGE_BITS;
>>              block->bmap =3D bitmap_new(pages);
>>              bitmap_set(block->bmap, 0, pages);
>> @@ -2227,6 +2262,9 @@ static int ram_save_setup(QEMUFile *f, void *opaqu=
e)
>>      qemu_put_be64(f, ram_bytes_total() | RAM_SAVE_FLAG_MEM_SIZE);
>> =20
>>      RAMBLOCK_FOREACH(block) {
>> +        if (memory_region_is_ram_device(block->mr)) {
>> +            continue;
>> +        }
>>          qemu_put_byte(f, strlen(block->idstr));
>>          qemu_put_buffer(f, (uint8_t *)block->idstr, strlen(block->idstr=
));
>>          qemu_put_be64(f, block->used_length);
>=20
