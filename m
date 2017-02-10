Received: from eggs.gnu.org ([2001:4830:134:3::10]:37763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ccAL1-0005tp-AY
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 07:30:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1ccAKy-0001Z5-69
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 07:30:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1ccAKx-0001XX-Pv
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 07:30:04 -0500
Date: Fri, 10 Feb 2017 12:29:58 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170210122958.GD3567@work-vm>
References: <20170203152321.19739-1-pbutsykin@virtuozzo.com>
	<20170203152321.19739-4-pbutsykin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170203152321.19739-4-pbutsykin@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] migration: discard non-dirty ram
 pages after the start of postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Butsykin <pbutsykin@virtuozzo.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, armbru@redhat.com, den@openvz.org

* Pavel Butsykin (pbutsykin@virtuozzo.com) wrote:
> After the start of postcopy migration there are some non-dirty pages which have
> already been migrated. These pages are no longer needed on the source vm so that
> we can free them and it doen't hurt to complete the migration.
> 
> Signed-off-by: Pavel Butsykin <pbutsykin@virtuozzo.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  include/migration/migration.h |  1 +
>  migration/migration.c         |  4 ++++
>  migration/ram.c               | 19 +++++++++++++++++++
>  3 files changed, 24 insertions(+)
> 
> diff --git a/include/migration/migration.h b/include/migration/migration.h
> index 401fbe1f77..3a5f8c469e 100644
> --- a/include/migration/migration.h
> +++ b/include/migration/migration.h
> @@ -288,6 +288,7 @@ int ram_postcopy_send_discard_bitmap(MigrationState *ms);
>  int ram_discard_range(MigrationIncomingState *mis, const char *block_name,
>                        uint64_t start, size_t length);
>  int ram_postcopy_incoming_init(MigrationIncomingState *mis);
> +void ram_postcopy_migrated_memory_release(MigrationState *ms);
>  
>  /**
>   * @migrate_add_blocker - prevent migration from proceeding
> diff --git a/migration/migration.c b/migration/migration.c
> index 8d5a5f8a6e..a9aa6a0f8b 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1713,6 +1713,10 @@ static int postcopy_start(MigrationState *ms, bool *old_vm_running)
>       */
>      qemu_savevm_send_ping(ms->to_dst_file, 4);
>  
> +    if (migrate_release_ram()) {
> +        ram_postcopy_migrated_memory_release(ms);
> +    }
> +
>      ret = qemu_file_get_error(ms->to_dst_file);
>      if (ret) {
>          error_report("postcopy_start: Migration stream errored");
> diff --git a/migration/ram.c b/migration/ram.c
> index 5a43f716d1..ae1f10b145 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1562,6 +1562,25 @@ void ram_debug_dump_bitmap(unsigned long *todump, bool expected)
>  
>  /* **** functions for postcopy ***** */
>  
> +void ram_postcopy_migrated_memory_release(MigrationState *ms)
> +{
> +    struct RAMBlock *block;
> +    unsigned long *bitmap = atomic_rcu_read(&migration_bitmap_rcu)->bmap;
> +
> +    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
> +        unsigned long first = block->offset >> TARGET_PAGE_BITS;
> +        unsigned long range = first + (block->used_length >> TARGET_PAGE_BITS);
> +        unsigned long run_start = find_next_zero_bit(bitmap, range, first);
> +
> +        while (run_start < range) {
> +            unsigned long run_end = find_next_bit(bitmap, range, run_start + 1);
> +            ram_discard_range(NULL, block->idstr, run_start << TARGET_PAGE_BITS,
> +                              (run_end - run_start) << TARGET_PAGE_BITS);
> +            run_start = find_next_zero_bit(bitmap, range, run_end + 1);
> +        }
> +    }
> +}
> +
>  /*
>   * Callback from postcopy_each_ram_send_discard for each RAMBlock
>   * Note: At this point the 'unsentmap' is the processed bitmap combined
> -- 
> 2.11.0
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
