Received: from eggs.gnu.org ([2001:4830:134:3::10]:55928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f9CaL-00068g-RE
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:39:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f9CaI-00083q-4y
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:39:01 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58448 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1f9CaH-00083D-TW
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:38:58 -0400
Date: Thu, 19 Apr 2018 17:38:52 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180419163852.GE2730@work-vm>
References: <CAJhGHyAMGjZe+QR3BQtA1cVxkz=isQbx6kWjNR6fa5LmW3rQUg@mail.gmail.com>
	<20180416150011.55916-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180416150011.55916-1-jiangshanlai@gmail.com>
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
To: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Juan Quintela <quintela@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Samuel Ortiz <sameo@linux.intel.com>, Sebastien Boeuf <sebastien.boeuf@intel.com>, "James O . D . Hunt" <james.o.hunt@intel.com>, Xu Wang <gnawux@gmail.com>, Peng Tao <bergwolf@gmail.com>, Xiao Guangrong <xiaoguangrong@tencent.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, qemu-devel@nongnu.org

* Lai Jiangshan (jiangshanlai@gmail.com) wrote:
> 1) What's this
>=20
> When the migration capability 'bypass-shared-memory'
> is set, the shared memory will be bypassed when migration.
>=20
> It is the key feature to enable several excellent features for
> the qemu, such as qemu-local-migration, qemu-live-update,
> extremely-fast-save-restore, vm-template, vm-fast-live-clone,
> yet-another-post-copy-migration, etc..
>=20
> The philosophy behind this key feature, including the resulting
> advanced key features, is that a part of the memory management
> is separated out from the qemu, and let the other toolkits
> such as libvirt, kata-containers (https://github.com/kata-containers)
> runv(https://github.com/hyperhq/runv/) or some multiple cooperative
> qemu commands directly access to it, manage it, provide features on it.
>=20
> 2) Status in real world
>=20
> The hyperhq(http://hyper.sh  http://hypercontainer.io/)
> introduced the feature vm-template(vm-fast-live-clone)
> to the hyper container for several years, it works perfect.
> (see https://github.com/hyperhq/runv/pull/297).
>=20
> The feature vm-template makes the containers(VMs) can
> be started in 130ms and save 80M memory for every
> container(VM). So that the hyper containers are fast
> and high-density as normal containers.
>=20
> kata-containers project (https://github.com/kata-containers)
> which was launched by hyper, intel and friends and which descended
> from runv (and clear-container) should have this feature enabled.
> Unfortunately, due to the code confliction between runv&cc,
> this feature was temporary disabled and it is being brought
> back by hyper and intel team.
> 3) How to use and bring up advanced features.
>=20
> In current qemu command line, shared memory has
> to be configured via memory-object.
>=20
> a) feature: qemu-local-migration, qemu-live-update
> Set the mem-path on the tmpfs and set share=3Don for it when
> start the vm. example:
> -object \
> memory-backend-file,id=3Dmem,size=3D128M,mem-path=3D/dev/shm/memory,sha=
re=3Don \
> -numa node,nodeid=3D0,cpus=3D0-7,memdev=3Dmem
>=20
> when you want to migrate the vm locally (after fixed a security bug
> of the qemu-binary, or other reason), you can start a new qemu with
> the same command line and -incoming, then you can migrate the
> vm from the old qemu to the new qemu with the migration capability
> 'bypass-shared-memory' set. The migration will migrate the device-state
> *ONLY*, the memory is the origin memory backed by tmpfs file.
>=20
> b) feature: extremely-fast-save-restore
> the same above, but the mem-path is on the persistent file system.
>=20
> c)  feature: vm-template, vm-fast-live-clone
> the template vm is started as 1), and paused when the guest reaches
> the template point(example: the guest app is ready), then the template
> vm is saved. (the qemu process of the template can be killed now, becau=
se
> we need only the memory and the device state files (in tmpfs)).
>=20
> Then we can launch one or multiple VMs base on the template vm states,
> the new VMs are started without the =E2=80=9Cshare=3Don=E2=80=9D, all t=
he new VMs share
> the initial memory from the memory file, they save a lot of memory.
> all the new VMs start from the template point, the guest app can go to
> work quickly.
>=20
> The new VM booted from template vm can=E2=80=99t become template again,
> if you need this unusual chained-template feature, you can write
> a cloneable-tmpfs kernel module for it.
>=20

I've just tried doing something similar with this patch; it's really
interesting. I used LVM snapshotting for the RAM:

cd /dev/shm
fallocate -l 20G backingfile
losetup -f ./backingfile
pvcreate /dev/loop0
vgcreate ram /dev/loop0
lvcreate -L4G -nram1 ram /dev/loop0

qemu -M pc,accel=3Dkvm -m 4G -object memory-backend-file,id=3Dmem,size=3D=
4G,mem-path=3D/dev/ram/ram1,share=3Don -numa node,memdev=3Dmem -vnc :0 -d=
rive file=3Dmy.qcow2,id=3Dd,cache=3Dnone -monitor stdio

boot the VM, and do a :
migrate_set_capability bypass-shared-memory on
migrate_set_speed 10G
migrate "exec:cat > migstream1"
q

then:
lvcreate -n ramsnap1 -s ram/ram1 -L4G
qemu -M pc,accel=3Dkvm -m 4G -object memory-backend-file,id=3Dmem,size=3D=
4G,mem-path=3D/dev/ram/ramsnap1,share=3Don -numa node,memdev=3Dmem -vnc :=
0 -drive file=3Dmy.qcow2,id=3Dd,cache=3Dnone -monitor stdio -snapshot -in=
coming "exec:cat migstream1"


lvcreate -n ramsnap2 -s ram/ram1 -L4G
qemu -M pc,accel=3Dkvm -m 4G -object memory-backend-file,id=3Dmem,size=3D=
4G,mem-path=3D/dev/ram/ramsnap2,share=3Don -numa node,memdev=3Dmem -vnc :=
1 -drive file=3Dmy.qcow2,id=3Dd,cache=3Dnone -monitor stdio -snapshot -in=
coming "exec:cat migstream1"

and I've got two separate instances of qemu restored from that stream.

It seems to work;  I wonder if we ever need things like msync() or
similar?

I've not tried creating a 2nd template with this.

> The libvirt toolkit can=E2=80=99t manage vm-template currently, in the
> hyperhq/runv, we use qemu wrapper script to do it. I hope someone add
> =E2=80=9Clibvrit managed template=E2=80=9D feature to libvirt.
>=20
> d) feature: yet-another-post-copy-migration
> It is a possible feature, no toolkit can do it well now.
> Using nbd server/client on the memory file is reluctantly Ok but
> inconvenient. A special feature for tmpfs might be needed to
> fully complete this feature.
> No one need yet another post copy migration method,
> but it is possible when some crazy man need it.
>=20
> Cc: Juan Quintela <quintela@redhat.com>
> Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> Cc: Eric Blake <eblake@redhat.com>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Sebastien Boeuf <sebastien.boeuf@intel.com>
> Cc: James O. D. Hunt <james.o.hunt@intel.com>
> Cc: Xu Wang <gnawux@gmail.com>
> Cc: Peng Tao <bergwolf@gmail.com>
> Cc: Xiao Guangrong <xiaoguangrong@tencent.com>
> Cc: Xiao Guangrong <xiaoguangrong.eric@gmail.com>
> Signed-off-by: Lai Jiangshan <jiangshanlai@gmail.com>
> ---
>=20
> Changes in V5:
>  check cappability conflict in migrate_caps_check()
>=20
> Changes in V4:
>  fixes checkpatch.pl errors
>=20
> Changes in V3:
>  rebased on upstream master
>  update the available version of the capability to
>  v2.13
>=20
> Changes in V2:
>  rebased on 2.11.1
>=20
>  migration/migration.c | 22 ++++++++++++++++++++++
>  migration/migration.h |  1 +
>  migration/ram.c       | 27 ++++++++++++++++++---------
>  qapi/migration.json   |  6 +++++-
>  4 files changed, 46 insertions(+), 10 deletions(-)
>=20
> diff --git a/migration/migration.c b/migration/migration.c
> index 52a5092add..110b40f6d4 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -736,6 +736,19 @@ static bool migrate_caps_check(bool *cap_list,
>              return false;
>          }
> =20
> +        if (cap_list[MIGRATION_CAPABILITY_BYPASS_SHARED_MEMORY]) {
> +            /* Bypass and postcopy are quite conflicting ways
> +             * to get memory in the destination.  And there
> +             * is not code to discriminate the differences and
> +             * handle the conflicts currently.  It should be possible
> +             * to fix, but it is generally useless when both ways
> +             * are used together.
> +             */
> +            error_setg(errp, "Bypass is not currently compatible "
> +                       "with postcopy");
> +            return false;
> +        }
> +

Good.

>          /* This check is reasonably expensive, so only when it's being
>           * set the first time, also it's only the destination that nee=
ds
>           * special support.
> @@ -1509,6 +1522,15 @@ bool migrate_release_ram(void)
>      return s->enabled_capabilities[MIGRATION_CAPABILITY_RELEASE_RAM];
>  }
> =20
> +bool migrate_bypass_shared_memory(void)
> +{
> +    MigrationState *s;
> +
> +    s =3D migrate_get_current();
> +
> +    return s->enabled_capabilities[MIGRATION_CAPABILITY_BYPASS_SHARED_=
MEMORY];
> +}
> +
>  bool migrate_postcopy_ram(void)
>  {
>      MigrationState *s;
> diff --git a/migration/migration.h b/migration/migration.h
> index 8d2f320c48..cfd2513ef0 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -206,6 +206,7 @@ MigrationState *migrate_get_current(void);
> =20
>  bool migrate_postcopy(void);
> =20
> +bool migrate_bypass_shared_memory(void);
>  bool migrate_release_ram(void);
>  bool migrate_postcopy_ram(void);
>  bool migrate_zero_blocks(void);
> diff --git a/migration/ram.c b/migration/ram.c
> index 0e90efa092..bca170c386 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -780,6 +780,11 @@ unsigned long migration_bitmap_find_dirty(RAMState=
 *rs, RAMBlock *rb,
>      unsigned long *bitmap =3D rb->bmap;
>      unsigned long next;
> =20
> +    /* when this ramblock is requested bypassing */
> +    if (!bitmap) {
> +        return size;
> +    }
> +
>      if (rs->ram_bulk_stage && start > 0) {
>          next =3D start + 1;
>      } else {
> @@ -850,7 +855,9 @@ static void migration_bitmap_sync(RAMState *rs)
>      qemu_mutex_lock(&rs->bitmap_mutex);
>      rcu_read_lock();
>      RAMBLOCK_FOREACH(block) {
> -        migration_bitmap_sync_range(rs, block, 0, block->used_length);
> +        if (!migrate_bypass_shared_memory() || !qemu_ram_is_shared(blo=
ck)) {
> +            migration_bitmap_sync_range(rs, block, 0, block->used_leng=
th);
> +        }
>      }
>      rcu_read_unlock();
>      qemu_mutex_unlock(&rs->bitmap_mutex);
> @@ -2132,18 +2139,12 @@ static int ram_state_init(RAMState **rsp)
>      qemu_mutex_init(&(*rsp)->src_page_req_mutex);
>      QSIMPLEQ_INIT(&(*rsp)->src_page_requests);
> =20
> -    /*
> -     * Count the total number of pages used by ram blocks not includin=
g any
> -     * gaps due to alignment or unplugs.
> -     */
> -    (*rsp)->migration_dirty_pages =3D ram_bytes_total() >> TARGET_PAGE=
_BITS;
> -
>      ram_state_reset(*rsp);
> =20
>      return 0;
>  }
> =20
> -static void ram_list_init_bitmaps(void)
> +static void ram_list_init_bitmaps(RAMState *rs)
>  {
>      RAMBlock *block;
>      unsigned long pages;
> @@ -2151,9 +2152,17 @@ static void ram_list_init_bitmaps(void)
>      /* Skip setting bitmap if there is no RAM */
>      if (ram_bytes_total()) {
>          QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
> +            if (migrate_bypass_shared_memory() && qemu_ram_is_shared(b=
lock)) {
> +                continue;
> +            }
>              pages =3D block->max_length >> TARGET_PAGE_BITS;
>              block->bmap =3D bitmap_new(pages);
>              bitmap_set(block->bmap, 0, pages);
> +            /*
> +             * Count the total number of pages used by ram blocks not
> +             * including any gaps due to alignment or unplugs.
> +             */
> +            rs->migration_dirty_pages +=3D pages;
>              if (migrate_postcopy_ram()) {
>                  block->unsentmap =3D bitmap_new(pages);
>                  bitmap_set(block->unsentmap, 0, pages);

Can you please rework this to combine with C=C3=A9dric Le Goater's=20
'discard non-migratable RAMBlocks' - it's quite similar to what you're
trying to do but for a different reason;  If you look at the v2 from
April 13, I think you can  just find somewhere to clear the
RAM_MIGRATABLE flag.

One thing I noticed; in my world I've got some code that checks if we
ever do a RAM iteration, don't find any dirty blocks but then still have=20
migration_dirty_pages being none-0; and with this patch I'm seeing that
check trigger:

   ram_find_and_save_block: no page found, yet dirty_pages=3D480

it doesn't seem to trigger without the patch.

Dave

> @@ -2169,7 +2178,7 @@ static void ram_init_bitmaps(RAMState *rs)
>      qemu_mutex_lock_ramlist();
>      rcu_read_lock();
> =20
> -    ram_list_init_bitmaps();
> +    ram_list_init_bitmaps(rs);
>      memory_global_dirty_log_start();
>      migration_bitmap_sync(rs);
> =20
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 9d0bf82cf4..45326480bd 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -357,13 +357,17 @@
>  # @dirty-bitmaps: If enabled, QEMU will migrate named dirty bitmaps.
>  #                 (since 2.12)
>  #
> +# @bypass-shared-memory: the shared memory region will be bypassed on =
migration.
> +#          This feature allows the memory region to be reused by new q=
emu(s)
> +#          or be migrated separately. (since 2.13)
> +#
>  # Since: 1.2
>  ##
>  { 'enum': 'MigrationCapability',
>    'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
>             'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ra=
m',
>             'block', 'return-path', 'pause-before-switchover', 'x-multi=
fd',
> -           'dirty-bitmaps' ] }
> +           'dirty-bitmaps', 'bypass-shared-memory' ] }
> =20
>  ##
>  # @MigrationCapabilityStatus:
> --=20
> 2.15.1 (Apple Git-101)
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
