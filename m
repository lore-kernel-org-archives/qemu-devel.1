Received: from eggs.gnu.org ([2001:4830:134:3::10]:55621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fn6G6-00014B-SR
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 13:59:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fn6G3-0005Ej-Mc
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 13:59:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36426 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fn6G3-0005Ck-GF
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 13:58:59 -0400
Date: Tue, 7 Aug 2018 18:58:54 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180807175854.GR2556@work-vm>
References: <20180722193350.6028-1-zhangckid@gmail.com>
	<20180722193350.6028-8-zhangckid@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180722193350.6028-8-zhangckid@gmail.com>
Subject: Re: [Qemu-devel] [PATCH V10 07/20] COLO: Load dirty pages into
 SVM's RAM cache firstly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhang Chen <zhangckid@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

* Zhang Chen (zhangckid@gmail.com) wrote:
> We should not load PVM's state directly into SVM, because there maybe some
> errors happen when SVM is receving data, which will break SVM.
> 
> We need to ensure receving all data before load the state into SVM. We use
> an extra memory to cache these data (PVM's ram). The ram cache in secondary side
> is initially the same as SVM/PVM's memory. And in the process of checkpoint,
> we cache the dirty pages of PVM into this ram cache firstly, so this ram cache
> always the same as PVM's memory at every checkpoint, then we flush this cached ram
> to SVM after we receive all PVM's state.
> 
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> Signed-off-by: Zhang Chen <zhangckid@gmail.com>

As mentioned before you do need to update this to skip non-migratable
blocks; there are also two blank-lines inserted in this patch which
should just go in the appropriate patch.
However, with those minor things fixed:

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  include/exec/ram_addr.h |  1 +
>  migration/migration.c   |  6 +++
>  migration/ram.c         | 83 ++++++++++++++++++++++++++++++++++++++++-
>  migration/ram.h         |  4 ++
>  migration/savevm.c      |  2 +-
>  5 files changed, 93 insertions(+), 3 deletions(-)
> 
> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
> index cf4ce06248..a78c1c99a7 100644
> --- a/include/exec/ram_addr.h
> +++ b/include/exec/ram_addr.h
> @@ -27,6 +27,7 @@ struct RAMBlock {
>      struct rcu_head rcu;
>      struct MemoryRegion *mr;
>      uint8_t *host;
> +    uint8_t *colo_cache; /* For colo, VM's ram cache */
>      ram_addr_t offset;
>      ram_addr_t used_length;
>      ram_addr_t max_length;
> diff --git a/migration/migration.c b/migration/migration.c
> index c645f66f4e..d9683e06d3 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -441,6 +441,10 @@ static void process_incoming_migration_co(void *opaque)
>              error_report_err(local_err);
>              exit(EXIT_FAILURE);
>          }
> +        if (colo_init_ram_cache() < 0) {
> +            error_report("Init ram cache failed");
> +            exit(EXIT_FAILURE);
> +        }
>          mis->migration_incoming_co = qemu_coroutine_self();
>          qemu_thread_create(&mis->colo_incoming_thread, "COLO incoming",
>               colo_process_incoming_thread, mis, QEMU_THREAD_JOINABLE);
> @@ -449,6 +453,8 @@ static void process_incoming_migration_co(void *opaque)
>  
>          /* Wait checkpoint incoming thread exit before free resource */
>          qemu_thread_join(&mis->colo_incoming_thread);
> +        /* We hold the global iothread lock, so it is safe here */
> +        colo_release_ram_cache();
>      }
>  
>      if (ret < 0) {
> diff --git a/migration/ram.c b/migration/ram.c
> index 52dd678092..33ebd09d70 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3314,6 +3314,20 @@ static inline void *host_from_ram_block_offset(RAMBlock *block,
>      return block->host + offset;
>  }
>  
> +static inline void *colo_cache_from_block_offset(RAMBlock *block,
> +                                                 ram_addr_t offset)
> +{
> +    if (!offset_in_ramblock(block, offset)) {
> +        return NULL;
> +    }
> +    if (!block->colo_cache) {
> +        error_report("%s: colo_cache is NULL in block :%s",
> +                     __func__, block->idstr);
> +        return NULL;
> +    }
> +    return block->colo_cache + offset;
> +}
> +
>  /**
>   * ram_handle_compressed: handle the zero page case
>   *
> @@ -3518,6 +3532,58 @@ static void decompress_data_with_multi_threads(QEMUFile *f,
>      qemu_mutex_unlock(&decomp_done_lock);
>  }
>  
> +/*
> + * colo cache: this is for secondary VM, we cache the whole
> + * memory of the secondary VM, it is need to hold the global lock
> + * to call this helper.
> + */
> +int colo_init_ram_cache(void)
> +{
> +    RAMBlock *block;
> +
> +    rcu_read_lock();
> +    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
> +        block->colo_cache = qemu_anon_ram_alloc(block->used_length,
> +                                                NULL,
> +                                                false);
> +        if (!block->colo_cache) {
> +            error_report("%s: Can't alloc memory for COLO cache of block %s,"
> +                         "size 0x" RAM_ADDR_FMT, __func__, block->idstr,
> +                         block->used_length);
> +            goto out_locked;
> +        }
> +        memcpy(block->colo_cache, block->host, block->used_length);
> +    }
> +    rcu_read_unlock();
> +    return 0;
> +
> +out_locked:
> +    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
> +        if (block->colo_cache) {
> +            qemu_anon_ram_free(block->colo_cache, block->used_length);
> +            block->colo_cache = NULL;
> +        }
> +    }
> +
> +    rcu_read_unlock();
> +    return -errno;
> +}
> +
> +/* It is need to hold the global lock to call this helper */
> +void colo_release_ram_cache(void)
> +{
> +    RAMBlock *block;
> +
> +    rcu_read_lock();
> +    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
> +        if (block->colo_cache) {
> +            qemu_anon_ram_free(block->colo_cache, block->used_length);
> +            block->colo_cache = NULL;
> +        }
> +    }
> +    rcu_read_unlock();
> +}
> +
>  /**
>   * ram_load_setup: Setup RAM for migration incoming side
>   *
> @@ -3534,6 +3600,7 @@ static int ram_load_setup(QEMUFile *f, void *opaque)
>  
>      xbzrle_load_setup();
>      ramblock_recv_map_init();
> +
>      return 0;
>  }
>  
> @@ -3547,6 +3614,7 @@ static int ram_load_cleanup(void *opaque)
>          g_free(rb->receivedmap);
>          rb->receivedmap = NULL;
>      }
> +
>      return 0;
>  }
>  
> @@ -3784,13 +3852,24 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>                       RAM_SAVE_FLAG_COMPRESS_PAGE | RAM_SAVE_FLAG_XBZRLE)) {
>              RAMBlock *block = ram_block_from_stream(f, flags);
>  
> -            host = host_from_ram_block_offset(block, addr);
> +            /*
> +             * After going into COLO, we should load the Page into colo_cache.
> +             */
> +            if (migration_incoming_in_colo_state()) {
> +                host = colo_cache_from_block_offset(block, addr);
> +            } else {
> +                host = host_from_ram_block_offset(block, addr);
> +            }
>              if (!host) {
>                  error_report("Illegal RAM offset " RAM_ADDR_FMT, addr);
>                  ret = -EINVAL;
>                  break;
>              }
> -            ramblock_recv_bitmap_set(block, host);
> +
> +            if (!migration_incoming_in_colo_state()) {
> +                ramblock_recv_bitmap_set(block, host);
> +            }
> +
>              trace_ram_load_loop(block->idstr, (uint64_t)addr, flags, host);
>          }
>  
> diff --git a/migration/ram.h b/migration/ram.h
> index 457bf54b8c..d009480494 100644
> --- a/migration/ram.h
> +++ b/migration/ram.h
> @@ -70,4 +70,8 @@ int64_t ramblock_recv_bitmap_send(QEMUFile *file,
>                                    const char *block_name);
>  int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *rb);
>  
> +/* ram cache */
> +int colo_init_ram_cache(void);
> +void colo_release_ram_cache(void);
> +
>  #endif
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 437308877a..33e9e7cda0 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1929,7 +1929,7 @@ static int loadvm_handle_recv_bitmap(MigrationIncomingState *mis,
>  static int loadvm_process_enable_colo(MigrationIncomingState *mis)
>  {
>      migration_incoming_enable_colo();
> -    return 0;
> +    return colo_init_ram_cache();
>  }
>  
>  /*
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
