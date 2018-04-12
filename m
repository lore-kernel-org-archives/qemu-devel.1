Received: from eggs.gnu.org ([2001:4830:134:3::10]:44636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiangshanlai@gmail.com>) id 1f6S4F-00007n-FN
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 22:34:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiangshanlai@gmail.com>) id 1f6S4D-0008Jj-G6
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 22:34:31 -0400
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:42469)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jiangshanlai@gmail.com>)
	id 1f6S4D-0008JO-Aq
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 22:34:29 -0400
Received: by mail-io0-x242.google.com with SMTP id d5so4645613iob.9
	for <qemu-devel@nongnu.org>; Wed, 11 Apr 2018 19:34:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180409173003.GI2449@work-vm>
References: <20180401084848.36725-1-jiangshanlai@gmail.com>
	<20180404114709.45118-1-jiangshanlai@gmail.com>
	<20180409173003.GI2449@work-vm>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Thu, 12 Apr 2018 10:34:27 +0800
Message-ID: <CAJhGHyAMGjZe+QR3BQtA1cVxkz=isQbx6kWjNR6fa5LmW3rQUg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V4] migration: add capability to bypass the
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
Cc: Samuel Ortiz <sameo@linux.intel.com>, Sebastien Boeuf <sebastien.boeuf@intel.com>, "James O . D . Hunt" <james.o.hunt@intel.com>, Xu Wang <gnawux@gmail.com>, Peng Tao <bergwolf@gmail.com>, Xiao Guangrong <xiaoguangrong@tencent.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

On Tue, Apr 10, 2018 at 1:30 AM, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
> Hi,
>
> * Lai Jiangshan (jiangshanlai@gmail.com) wrote:
>> 1) What's this
>>
>> When the migration capability 'bypass-shared-memory'
>> is set, the shared memory will be bypassed when migration.
>>
>> It is the key feature to enable several excellent features for
>> the qemu, such as qemu-local-migration, qemu-live-update,
>> extremely-fast-save-restore, vm-template, vm-fast-live-clone,
>> yet-another-post-copy-migration, etc..
>>
>> The philosophy behind this key feature, including the resulting
>> advanced key features, is that a part of the memory management
>> is separated out from the qemu, and let the other toolkits
>> such as libvirt, kata-containers (https://github.com/kata-containers)
>> runv(https://github.com/hyperhq/runv/) or some multiple cooperative
>> qemu commands directly access to it, manage it, provide features on it.
>>
>> 2) Status in real world
>>
>> The hyperhq(http://hyper.sh  http://hypercontainer.io/)
>> introduced the feature vm-template(vm-fast-live-clone)
>> to the hyper container for several years, it works perfect.
>> (see https://github.com/hyperhq/runv/pull/297).
>>
>> The feature vm-template makes the containers(VMs) can
>> be started in 130ms and save 80M memory for every
>> container(VM). So that the hyper containers are fast
>> and high-density as normal containers.
>>
>> kata-containers project (https://github.com/kata-containers)
>> which was launched by hyper, intel and friends and which descended
>> from runv (and clear-container) should have this feature enabled.
>> Unfortunately, due to the code confliction between runv&cc,
>> this feature was temporary disabled and it is being brought
>> back by hyper and intel team.
>>
>> 3) How to use and bring up advanced features.
>>
>> In current qemu command line, shared memory has
>> to be configured via memory-object.
>>
>> a) feature: qemu-local-migration, qemu-live-update
>> Set the mem-path on the tmpfs and set share=3Don for it when
>> start the vm. example:
>> -object \
>> memory-backend-file,id=3Dmem,size=3D128M,mem-path=3D/dev/shm/memory,shar=
e=3Don \
>> -numa node,nodeid=3D0,cpus=3D0-7,memdev=3Dmem
>>
>> when you want to migrate the vm locally (after fixed a security bug
>> of the qemu-binary, or other reason), you can start a new qemu with
>> the same command line and -incoming, then you can migrate the
>> vm from the old qemu to the new qemu with the migration capability
>> 'bypass-shared-memory' set. The migration will migrate the device-state
>> *ONLY*, the memory is the origin memory backed by tmpfs file.
>>
>> b) feature: extremely-fast-save-restore
>> the same above, but the mem-path is on the persistent file system.
>>
>> c)  feature: vm-template, vm-fast-live-clone
>> the template vm is started as 1), and paused when the guest reaches
>> the template point(example: the guest app is ready), then the template
>> vm is saved. (the qemu process of the template can be killed now, becaus=
e
>> we need only the memory and the device state files (in tmpfs)).
>>
>> Then we can launch one or multiple VMs base on the template vm states,
>> the new VMs are started without the =E2=80=9Cshare=3Don=E2=80=9D, all th=
e new VMs share
>> the initial memory from the memory file, they save a lot of memory.
>> all the new VMs start from the template point, the guest app can go to
>> work quickly.
>
> How do you handle the storage in this case, or giving each VM it's own
> MAC address?

The user or the upper layer tools can copy/clone the storage
(on xfs,btrfs,ceph...). The user or the upper layer tools can handle the
interface MAC itself while this patch just focus on memory.

hyper/runv clone the vm before the interfaces are inserted.
vm-template are often used along with hotplugging.

>
>> The new VM booted from template vm can=E2=80=99t become template again,
>> if you need this unusual chained-template feature, you can write
>> a cloneable-tmpfs kernel module for it.
>>
>> The libvirt toolkit can=E2=80=99t manage vm-template currently, in the
>> hyperhq/runv, we use qemu wrapper script to do it. I hope someone add
>> =E2=80=9Clibvrit managed template=E2=80=9D feature to libvirt.
>
>> d) feature: yet-another-post-copy-migration
>> It is a possible feature, no toolkit can do it well now.
>> Using nbd server/client on the memory file is reluctantly Ok but
>> inconvenient. A special feature for tmpfs might be needed to
>> fully complete this feature.
>> No one need yet another post copy migration method,
>> but it is possible when some crazy man need it.
>
> As the crazy person who did the existing postcopy; one is enough!
>

Very true. This part of comments just shows how much
potentials there are for such a simple migration capability.


> Some minor fix requests below, but this looks nice and simple.
>

Will do soon. Thank for your review.

> Shared memory is interesting because tehre are lots of different uses;
> e.g. your uses, but also vhost-user which is sharing for a completely
> different reason.
>
>> Cc: Samuel Ortiz <sameo@linux.intel.com>
>> Cc: Sebastien Boeuf <sebastien.boeuf@intel.com>
>> Cc: James O. D. Hunt <james.o.hunt@intel.com>
>> Cc: Xu Wang <gnawux@gmail.com>
>> Cc: Peng Tao <bergwolf@gmail.com>
>> Cc: Xiao Guangrong <xiaoguangrong@tencent.com>
>> Cc: Xiao Guangrong <xiaoguangrong.eric@gmail.com>
>> Signed-off-by: Lai Jiangshan <jiangshanlai@gmail.com>
>> ---
>>
>> Changes in V4:
>>  fixes checkpatch.pl errors
>>
>> Changes in V3:
>>  rebased on upstream master
>>  update the available version of the capability to
>>  v2.13
>>
>> Changes in V2:
>>  rebased on 2.11.1
>>
>>  migration/migration.c | 14 ++++++++++++++
>>  migration/migration.h |  1 +
>>  migration/ram.c       | 27 ++++++++++++++++++---------
>>  qapi/migration.json   |  6 +++++-
>>  4 files changed, 38 insertions(+), 10 deletions(-)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index 52a5092add..6a63102d7f 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -1509,6 +1509,20 @@ bool migrate_release_ram(void)
>>      return s->enabled_capabilities[MIGRATION_CAPABILITY_RELEASE_RAM];
>>  }
>>
>> +bool migrate_bypass_shared_memory(void)
>> +{
>> +    MigrationState *s;
>> +
>> +    /* it is not workable with postcopy yet. */
>> +    if (migrate_postcopy_ram()) {
>> +        return false;
>> +    }
>
> Please change this to work in the same way as the check for
> postcopy+compress in migration.c migrate_caps_check.
>
>> +    s =3D migrate_get_current();
>> +
>> +    return s->enabled_capabilities[MIGRATION_CAPABILITY_BYPASS_SHARED_M=
EMORY];
>> +}
>> +
>>  bool migrate_postcopy_ram(void)
>>  {
>>      MigrationState *s;
>> diff --git a/migration/migration.h b/migration/migration.h
>> index 8d2f320c48..cfd2513ef0 100644
>> --- a/migration/migration.h
>> +++ b/migration/migration.h
>> @@ -206,6 +206,7 @@ MigrationState *migrate_get_current(void);
>>
>>  bool migrate_postcopy(void);
>>
>> +bool migrate_bypass_shared_memory(void);
>>  bool migrate_release_ram(void);
>>  bool migrate_postcopy_ram(void);
>>  bool migrate_zero_blocks(void);
>> diff --git a/migration/ram.c b/migration/ram.c
>> index 0e90efa092..bca170c386 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -780,6 +780,11 @@ unsigned long migration_bitmap_find_dirty(RAMState =
*rs, RAMBlock *rb,
>>      unsigned long *bitmap =3D rb->bmap;
>>      unsigned long next;
>>
>> +    /* when this ramblock is requested bypassing */
>> +    if (!bitmap) {
>> +        return size;
>> +    }
>> +
>>      if (rs->ram_bulk_stage && start > 0) {
>>          next =3D start + 1;
>>      } else {
>> @@ -850,7 +855,9 @@ static void migration_bitmap_sync(RAMState *rs)
>>      qemu_mutex_lock(&rs->bitmap_mutex);
>>      rcu_read_lock();
>>      RAMBLOCK_FOREACH(block) {
>> -        migration_bitmap_sync_range(rs, block, 0, block->used_length);
>> +        if (!migrate_bypass_shared_memory() || !qemu_ram_is_shared(bloc=
k)) {
>> +            migration_bitmap_sync_range(rs, block, 0, block->used_lengt=
h);
>> +        }
>>      }
>>      rcu_read_unlock();
>>      qemu_mutex_unlock(&rs->bitmap_mutex);
>> @@ -2132,18 +2139,12 @@ static int ram_state_init(RAMState **rsp)
>>      qemu_mutex_init(&(*rsp)->src_page_req_mutex);
>>      QSIMPLEQ_INIT(&(*rsp)->src_page_requests);
>>
>> -    /*
>> -     * Count the total number of pages used by ram blocks not including=
 any
>> -     * gaps due to alignment or unplugs.
>> -     */
>> -    (*rsp)->migration_dirty_pages =3D ram_bytes_total() >> TARGET_PAGE_=
BITS;
>> -
>>      ram_state_reset(*rsp);
>>
>>      return 0;
>>  }
>>
>> -static void ram_list_init_bitmaps(void)
>> +static void ram_list_init_bitmaps(RAMState *rs)
>>  {
>>      RAMBlock *block;
>>      unsigned long pages;
>> @@ -2151,9 +2152,17 @@ static void ram_list_init_bitmaps(void)
>>      /* Skip setting bitmap if there is no RAM */
>>      if (ram_bytes_total()) {
>
> I think you need to add here a :
>    rs->migration_dirty_pages =3D 0;
>
> I don't see anywhere else that initialises it, and there is the case of
> a migration that fails, followed by a 2nd attempt.
>
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
>> 2.14.3 (Apple Git-98)
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
