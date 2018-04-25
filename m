Received: from eggs.gnu.org ([2001:4830:134:3::10]:47292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiangshanlai@gmail.com>) id 1fBHPI-0003zm-Er
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 06:12:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiangshanlai@gmail.com>) id 1fBHPH-0002zn-H5
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 06:12:12 -0400
Received: from mail-io0-x22c.google.com ([2607:f8b0:4001:c06::22c]:33695)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jiangshanlai@gmail.com>)
	id 1fBHPH-0002ze-A4
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 06:12:11 -0400
Received: by mail-io0-x22c.google.com with SMTP id e78-v6so13618244iod.0
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 03:12:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180419163852.GE2730@work-vm>
References: <CAJhGHyAMGjZe+QR3BQtA1cVxkz=isQbx6kWjNR6fa5LmW3rQUg@mail.gmail.com>
	<20180416150011.55916-1-jiangshanlai@gmail.com>
	<20180419163852.GE2730@work-vm>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Wed, 25 Apr 2018 18:12:09 +0800
Message-ID: <CAJhGHyDqj32nKZq--aho5OTZSYr0N6r0d-5WWtpgacACWMWLBQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V5] migration: add capability to bypass the
 shared memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, Sebastien Boeuf <sebastien.boeuf@intel.com>, "James O . D . Hunt" <james.o.hunt@intel.com>, Xu Wang <gnawux@gmail.com>, Peng Tao <bergwolf@gmail.com>, Xiao Guangrong <xiaoguangrong@tencent.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, qemu-devel@nongnu.org

On Fri, Apr 20, 2018 at 12:38 AM, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:

>> -static void ram_list_init_bitmaps(void)
>> +static void ram_list_init_bitmaps(RAMState *rs)
>>  {
>>      RAMBlock *block;
>>      unsigned long pages;
>> @@ -2151,9 +2152,17 @@ static void ram_list_init_bitmaps(void)
>>      /* Skip setting bitmap if there is no RAM */
>>      if (ram_bytes_total()) {
>>          QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
>> +            if (migrate_bypass_shared_memory() && qemu_ram_is_shared(bl=
ock)) {
>> +                continue;
>> +            }
>>              pages =3D block->max_length >> TARGET_PAGE_BITS;
>>              block->bmap =3D bitmap_new(pages);
>>              bitmap_set(block->bmap, 0, pages);
>> +            /*
>> +             * Count the total number of pages used by ram blocks not
>> +             * including any gaps due to alignment or unplugs.
>> +             */
>> +            rs->migration_dirty_pages +=3D pages;
>>              if (migrate_postcopy_ram()) {
>>                  block->unsentmap =3D bitmap_new(pages);
>>                  bitmap_set(block->unsentmap, 0, pages);
>
> Can you please rework this to combine with C=C3=A9dric Le Goater's
> 'discard non-migratable RAMBlocks' - it's quite similar to what you're
> trying to do but for a different reason;  If you look at the v2 from
> April 13, I think you can  just find somewhere to clear the
> RAM_MIGRATABLE flag.

Hello Dave:

It seems we need to add new qmp/hmp command to clear/add
RAM_MIGRATABLE flag which is overkill for such a simple feature.
Please point out if there is any simple way to do so.

And this kind of memory is not "un-MIGRATABLE", the user
just decided not to migrate it/them for one of the migrations.
But they are always MIGRATABLE regardless the user migrate
them or not. So clearing/setting the flag may
cause confusion in this case. What do you think?

Bypassing is an option for every migration. For the
same vm instance, the user might migrate it out
multiple times. He wants to bypass shared memory
in some migrations and do the normal migrations in
other times. So it is better that Bypassing is an option
or capability of migration instead of ramblock.

I don't insist on avoiding using RAM_MIGRATABLE.

Thanks,
Lai

>
> One thing I noticed; in my world I've got some code that checks if we
> ever do a RAM iteration, don't find any dirty blocks but then still have
> migration_dirty_pages being none-0; and with this patch I'm seeing that
> check trigger:
>
>    ram_find_and_save_block: no page found, yet dirty_pages=3D480
>
> it doesn't seem to trigger without the patch.

Does initializing the migration_dirty_pages as you suggested help?

>
> Dave
>
>> @@ -2169,7 +2178,7 @@ static void ram_init_bitmaps(RAMState *rs)
>>      qemu_mutex_lock_ramlist();
>>      rcu_read_lock();
>>
>> -    ram_list_init_bitmaps();
>> +    ram_list_init_bitmaps(rs);
>>      memory_global_dirty_log_start();
>>      migration_bitmap_sync(rs);
>>
>> diff --git a/qapi/migration.json b/qapi/migration.json
>> index 9d0bf82cf4..45326480bd 100644
>> --- a/qapi/migration.json
>> +++ b/qapi/migration.json
>> @@ -357,13 +357,17 @@
>>  # @dirty-bitmaps: If enabled, QEMU will migrate named dirty bitmaps.
>>  #                 (since 2.12)
>>  #
>> +# @bypass-shared-memory: the shared memory region will be bypassed on m=
igration.
>> +#          This feature allows the memory region to be reused by new qe=
mu(s)
>> +#          or be migrated separately. (since 2.13)
>> +#
>>  # Since: 1.2
>>  ##
>>  { 'enum': 'MigrationCapability',
>>    'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
>>             'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram=
',
>>             'block', 'return-path', 'pause-before-switchover', 'x-multif=
d',
>> -           'dirty-bitmaps' ] }
>> +           'dirty-bitmaps', 'bypass-shared-memory' ] }
>>
>>  ##
>>  # @MigrationCapabilityStatus:
>> --
>> 2.15.1 (Apple Git-101)
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
