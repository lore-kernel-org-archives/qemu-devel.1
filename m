Received: from eggs.gnu.org ([2001:4830:134:3::10]:39801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ahzhanghaoyu@gmail.com>) id 1dwSDq-00075c-Te
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 08:10:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ahzhanghaoyu@gmail.com>) id 1dwSDi-0004sR-WA
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 08:10:46 -0400
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:37523)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ahzhanghaoyu@gmail.com>)
	id 1dwSDi-0004s6-Lu
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 08:10:42 -0400
Received: by mail-pg0-x241.google.com with SMTP id v5so4750301pgn.4
	for <qemu-devel@nongnu.org>; Mon, 25 Sep 2017 05:10:42 -0700 (PDT)
References: <20160809191216.GF2025@work-vm>
	<1470790447-83284-1-git-send-email-jiangshanlai@gmail.com>
From: Zhang Haoyu <ahzhanghaoyu@gmail.com>
Message-ID: <c4f5dbe8-fe33-d8b9-4c9a-3d2282332832@gmail.com>
Date: Mon, 25 Sep 2017 20:13:22 +0800
MIME-Version: 1.0
In-Reply-To: <1470790447-83284-1-git-send-email-jiangshanlai@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH V2] add migration capability to bypass the
 shared memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lai Jiangshan <jiangshanlai@gmail.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Amit Shah <amit.shah@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

If hotplug memory during migration, the calculation of migration_dirty_pages
maybe incorrect, should fixed as below,

-void migration_bitmap_extend(ram_addr_t old, ram_addr_t new)
+void migration_bitmap_extend(RAMBlock *block, ram_addr_t old, ram_addr_t new)
{
    /* called in qemu main thread, so there is
     * no writing race against this migration_bitmap
     */
-    if (migration_bitmap_rcu) {
+    if (migration_bitmap_rcu && (!migrate_bypass_shared_memory() || !qemu_ram_is_shared(block))) {
        struct BitmapRcu *old_bitmap = migration_bitmap_rcu, *bitmap;
        bitmap = g_new(struct BitmapRcu, 1);

On 2016/8/10 8:54, Lai Jiangshan wrote:
> When the migration capability 'bypass-shared-memory'
> is set, the shared memory will be bypassed when migration.
> 
> It is the key feature to enable several excellent features for
> the qemu, such as qemu-local-migration, qemu-live-update,
> extremely-fast-save-restore, vm-template, vm-fast-live-clone,
> yet-another-post-copy-migration, etc..
> 
> The philosophy behind this key feature and the advanced
> key features is that a part of the memory management is
> separated out from the qemu, and let the other toolkits
> such as libvirt, runv(https://github.com/hyperhq/runv/)
> or the next qemu-cmd directly access to it, manage it,
> provide features to it.
> 
> The hyperhq(http://hyper.sh  http://hypercontainer.io/)
> introduced the feature vm-template(vm-fast-live-clone)
> to the hyper container for several months, it works perfect.
> (see https://github.com/hyperhq/runv/pull/297)
> 
> The feature vm-template makes the containers(VMs) can
> be started in 130ms and save 80M memory for every
> container(VM). So that the hyper containers are fast
> and high-density as normal containers.
> 
> In current qemu command line, shared memory has
> to be configured via memory-object. Anyone can add a
> -mem-path-share to the qemu command line for combining
> with -mem-path for this feature. This patch doesn’t include
> this change of -mem-path-share.
> 
> Advanced features:
> 1) qemu-local-migration, qemu-live-update
> Set the mem-path on the tmpfs and set share=on for it when
> start the vm. example:
> -object \
> memory-backend-file,id=mem,size=128M,mem-path=/dev/shm/memory,share=on \
> -numa node,nodeid=0,cpus=0-7,memdev=mem
> 
> when you want to migrate the vm locally (after fixed a security bug
> of the qemu-binary, or other reason), you can start a new qemu with
> the same command line and -incoming, then you can migrate the
> vm from the old qemu to the new qemu with the migration capability
> 'bypass-shared-memory' set. The migration will migrate the device-state
> *ONLY*, the memory is the origin memory backed by tmpfs file.
> 
> 2) extremely-fast-save-restore
> the same above, but the mem-path is on the persistent file system.
> 
> 3)  vm-template, vm-fast-live-clone
> the template vm is started as 1), and paused when the guest reaches
> the template point(example: the guest app is ready), then the template
> vm is saved. (the qemu process of the template can be killed now, because
> we need only the memory and the device state files (in tmpfs)).
> 
> Then we can launch one or multiple VMs base on the template vm states,
> the new VMs are started without the “share=on”, all the new VMs share
> the initial memory from the memory file, they save a lot of memory.
> all the new VMs start from the template point, the guest app can go to
> work quickly.
> 
> The new VM booted from template vm can’t become template again,
> if you need this unusual chained-template feature, you can write
> a cloneable-tmpfs kernel module for it.
> 
> The libvirt toolkit can’t manage vm-template currently, in the
> hyperhq/runv, we use qemu wrapper script to do it. I hope someone add
> “libvrit managed template” feature to libvirt.
> 
> 4) yet-another-post-copy-migration
> It is a possible feature, no toolkit can do it well now.
> Using nbd server/client on the memory file is reluctantly Ok but
> inconvenient. A special feature for tmpfs might be needed to
> fully complete this feature.
> No one need yet another post copy migration method,
> but it is possible when some crazy man need it.
> 
> Changed from v1:
>    fix style
> 
> Signed-off-by: Lai Jiangshan <jiangshanlai@gmail.com>
> ---
>  exec.c                        |  5 +++++
>  include/exec/cpu-common.h     |  1 +
>  include/migration/migration.h |  1 +
>  migration/migration.c         |  9 +++++++++
>  migration/ram.c               | 37 ++++++++++++++++++++++++++++---------
>  qapi-schema.json              |  6 +++++-
>  qmp-commands.hx               |  3 +++
>  7 files changed, 52 insertions(+), 10 deletions(-)
> 
> diff --git a/exec.c b/exec.c
> index 8ffde75..888919a 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -1402,6 +1402,11 @@ static void qemu_ram_setup_dump(void *addr, ram_addr_t size)
>      }
>  }
>  
> +bool qemu_ram_is_shared(RAMBlock *rb)
> +{
> +    return rb->flags & RAM_SHARED;
> +}
> +
>  const char *qemu_ram_get_idstr(RAMBlock *rb)
>  {
>      return rb->idstr;
> diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
> index 952bcfe..7c18db9 100644
> --- a/include/exec/cpu-common.h
> +++ b/include/exec/cpu-common.h
> @@ -58,6 +58,7 @@ RAMBlock *qemu_ram_block_from_host(void *ptr, bool round_offset,
>  void qemu_ram_set_idstr(RAMBlock *block, const char *name, DeviceState *dev);
>  void qemu_ram_unset_idstr(RAMBlock *block);
>  const char *qemu_ram_get_idstr(RAMBlock *rb);
> +bool qemu_ram_is_shared(RAMBlock *rb);
>  
>  void cpu_physical_memory_rw(hwaddr addr, uint8_t *buf,
>                              int len, int is_write);
> diff --git a/include/migration/migration.h b/include/migration/migration.h
> index 3c96623..080b6b2 100644
> --- a/include/migration/migration.h
> +++ b/include/migration/migration.h
> @@ -290,6 +290,7 @@ void migrate_add_blocker(Error *reason);
>   */
>  void migrate_del_blocker(Error *reason);
>  
> +bool migrate_bypass_shared_memory(void);
>  bool migrate_postcopy_ram(void);
>  bool migrate_zero_blocks(void);
>  
> diff --git a/migration/migration.c b/migration/migration.c
> index 955d5ee..c87d136 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1189,6 +1189,15 @@ void qmp_migrate_set_downtime(double value, Error **errp)
>      max_downtime = (uint64_t)value;
>  }
>  
> +bool migrate_bypass_shared_memory(void)
> +{
> +    MigrationState *s;
> +
> +    s = migrate_get_current();
> +
> +    return s->enabled_capabilities[MIGRATION_CAPABILITY_BYPASS_SHARED_MEMORY];
> +}
> +
>  bool migrate_postcopy_ram(void)
>  {
>      MigrationState *s;
> diff --git a/migration/ram.c b/migration/ram.c
> index 815bc0e..f7c4081 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -605,6 +605,28 @@ static void migration_bitmap_sync_init(void)
>      num_dirty_pages_period = 0;
>      xbzrle_cache_miss_prev = 0;
>      iterations_prev = 0;
> +    migration_dirty_pages = 0;

This initialization is not necessary.

> +}
> +
> +static void migration_bitmap_init(unsigned long *bitmap)
> +{
> +    RAMBlock *block;
> +
> +    bitmap_clear(bitmap, 0, last_ram_offset() >> TARGET_PAGE_BITS);
> +    rcu_read_lock();
> +    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
> +        if (!migrate_bypass_shared_memory() || !qemu_ram_is_shared(block)) {
> +            bitmap_set(bitmap, block->offset >> TARGET_PAGE_BITS,
> +                       block->used_length >> TARGET_PAGE_BITS);
> +
> +            /*
> +             * Count the total number of pages used by ram blocks not including
> +             * any gaps due to alignment or unplugs.
> +             */
> +            migration_dirty_pages += block->used_length >> TARGET_PAGE_BITS;
> +        }
> +    }
> +    rcu_read_unlock();
>  }
>  
>  static void migration_bitmap_sync(void)
> @@ -631,7 +653,9 @@ static void migration_bitmap_sync(void)
>      qemu_mutex_lock(&migration_bitmap_mutex);
>      rcu_read_lock();
>      QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
> -        migration_bitmap_sync_range(block->offset, block->used_length);
> +        if (!migrate_bypass_shared_memory() || !qemu_ram_is_shared(block)) {
> +            migration_bitmap_sync_range(block->offset, block->used_length);
> +        }
>      }
>      rcu_read_unlock();
>      qemu_mutex_unlock(&migration_bitmap_mutex);
> @@ -1926,19 +1950,14 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>      ram_bitmap_pages = last_ram_offset() >> TARGET_PAGE_BITS;
>      migration_bitmap_rcu = g_new0(struct BitmapRcu, 1);
>      migration_bitmap_rcu->bmap = bitmap_new(ram_bitmap_pages);
> -    bitmap_set(migration_bitmap_rcu->bmap, 0, ram_bitmap_pages);
> +    migration_bitmap_init(migration_bitmap_rcu->bmap);
>  
>      if (migrate_postcopy_ram()) {
>          migration_bitmap_rcu->unsentmap = bitmap_new(ram_bitmap_pages);
> -        bitmap_set(migration_bitmap_rcu->unsentmap, 0, ram_bitmap_pages);
> +        bitmap_copy(migration_bitmap_rcu->unsentmap,
> +                    migration_bitmap_rcu->bmap, ram_bitmap_pages);
>      }
>  
> -    /*
> -     * Count the total number of pages used by ram blocks not including any
> -     * gaps due to alignment or unplugs.
> -     */
> -    migration_dirty_pages = ram_bytes_total() >> TARGET_PAGE_BITS;
> -
>      memory_global_dirty_log_start();
>      migration_bitmap_sync();
>      qemu_mutex_unlock_ramlist();
> diff --git a/qapi-schema.json b/qapi-schema.json
> index 5658723..453e6d9 100644
> --- a/qapi-schema.json
> +++ b/qapi-schema.json
> @@ -553,11 +553,15 @@
>  #          been migrated, pulling the remaining pages along as needed. NOTE: If
>  #          the migration fails during postcopy the VM will fail.  (since 2.6)
>  #
> +# @bypass-shared-memory: the shared memory region will be bypassed on migration.
> +#          This feature allows the memory region to be reused by new qemu(s)
> +#          or be migrated separately. (since 2.8)
> +#
>  # Since: 1.2
>  ##
>  { 'enum': 'MigrationCapability',
>    'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
> -           'compress', 'events', 'postcopy-ram'] }
> +           'compress', 'events', 'postcopy-ram', 'bypass-shared-memory'] }
>  
>  ##
>  # @MigrationCapabilityStatus
> diff --git a/qmp-commands.hx b/qmp-commands.hx
> index c8d360a..c31152c 100644
> --- a/qmp-commands.hx
> +++ b/qmp-commands.hx
> @@ -3723,6 +3723,7 @@ Enable/Disable migration capabilities
>  - "compress": use multiple compression threads to accelerate live migration
>  - "events": generate events for each migration state change
>  - "postcopy-ram": postcopy mode for live migration
> +- "bypass-shared-memory": bypass shared memory region
>  
>  Arguments:
>  
> @@ -3753,6 +3754,7 @@ Query current migration capabilities
>           - "compress": Multiple compression threads state (json-bool)
>           - "events": Migration state change event state (json-bool)
>           - "postcopy-ram": postcopy ram state (json-bool)
> +         - "bypass-shared-memory": bypass shared memory state (json-bool)
>  
>  Arguments:
>  
> @@ -3767,6 +3769,7 @@ Example:
>       {"state": false, "capability": "compress"},
>       {"state": true, "capability": "events"},
>       {"state": false, "capability": "postcopy-ram"}
> +     {"state": false, "capability": "bypass-shared-memory"}
>     ]}
>  
>  EQMP
> 
