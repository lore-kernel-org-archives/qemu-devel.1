Received: from eggs.gnu.org ([2001:4830:134:3::10]:35312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cxToO-0005Zf-PJ
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 03:32:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cxToL-0001Pq-Jw
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 03:32:32 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3351
	helo=dggrg03-dlp.huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cxToK-0001P7-HD
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 03:32:29 -0400
References: <1487734936-43472-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1487734936-43472-8-git-send-email-zhang.zhanghailiang@huawei.com>
	<20170407170600.GD2623@work-vm>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <58EB34CF.90700@huawei.com>
Date: Mon, 10 Apr 2017 15:31:27 +0800
MIME-Version: 1.0
In-Reply-To: <20170407170600.GD2623@work-vm>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 07/15] COLO: Load PVM's dirty pages into
 SVM's RAM cache temporarily
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: xuquan8@huawei.com, qemu-devel@nongnu.org, zhangchen.fnst@cn.fujitsu.com, lizhijian@cn.fujitsu.com, xiecl.fnst@cn.fujitsu.com, Juan Quintela <quintela@redhat.com>

On 2017/4/8 1:06, Dr. David Alan Gilbert wrote:
> * zhanghailiang (zhang.zhanghailiang@huawei.com) wrote:
>> We should not load PVM's state directly into SVM, because there maybe some
>> errors happen when SVM is receving data, which will break SVM.
>>
>> We need to ensure receving all data before load the state into SVM. We use
>> an extra memory to cache these data (PVM's ram). The ram cache in secondary side
>> is initially the same as SVM/PVM's memory. And in the process of checkpoint,
>> we cache the dirty pages of PVM into this ram cache firstly, so this ram cache
>> always the same as PVM's memory at every checkpoint, then we flush this cached ram
>> to SVM after we receive all PVM's state.
> You're probably going to find this interesting to merge with Juan's recent RAM block series.
> Probably not too hard, but he's touching a lot of the same code and rearranging things.

Yes, I'll update this series on top of his series, better to send next version after his series been merged.

Thanks,
Hailiang

> Dave
>
>
>> Cc: Juan Quintela <quintela@redhat.com>
>> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
>> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> ---
>>   include/exec/ram_addr.h       |  1 +
>>   include/migration/migration.h |  4 +++
>>   migration/colo.c              | 14 +++++++++
>>   migration/ram.c               | 73 ++++++++++++++++++++++++++++++++++++++++++-
>>   4 files changed, 91 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/exec/ram_addr.h b/include/exec/ram_addr.h
>> index 3e79466..44e1190 100644
>> --- a/include/exec/ram_addr.h
>> +++ b/include/exec/ram_addr.h
>> @@ -27,6 +27,7 @@ struct RAMBlock {
>>       struct rcu_head rcu;
>>       struct MemoryRegion *mr;
>>       uint8_t *host;
>> +    uint8_t *colo_cache; /* For colo, VM's ram cache */
>>       ram_addr_t offset;
>>       ram_addr_t used_length;
>>       ram_addr_t max_length;
>> diff --git a/include/migration/migration.h b/include/migration/migration.h
>> index 1735d66..93c6148 100644
>> --- a/include/migration/migration.h
>> +++ b/include/migration/migration.h
>> @@ -379,4 +379,8 @@ int ram_save_queue_pages(MigrationState *ms, const char *rbname,
>>   PostcopyState postcopy_state_get(void);
>>   /* Set the state and return the old state */
>>   PostcopyState postcopy_state_set(PostcopyState new_state);
>> +
>> +/* ram cache */
>> +int colo_init_ram_cache(void);
>> +void colo_release_ram_cache(void);
>>   #endif
>> diff --git a/migration/colo.c b/migration/colo.c
>> index 1e3e975..edb7f00 100644
>> --- a/migration/colo.c
>> +++ b/migration/colo.c
>> @@ -551,6 +551,7 @@ void *colo_process_incoming_thread(void *opaque)
>>       uint64_t total_size;
>>       uint64_t value;
>>       Error *local_err = NULL;
>> +    int ret;
>>   
>>       qemu_sem_init(&mis->colo_incoming_sem, 0);
>>   
>> @@ -572,6 +573,12 @@ void *colo_process_incoming_thread(void *opaque)
>>        */
>>       qemu_file_set_blocking(mis->from_src_file, true);
>>   
>> +    ret = colo_init_ram_cache();
>> +    if (ret < 0) {
>> +        error_report("Failed to initialize ram cache");
>> +        goto out;
>> +    }
>> +
>>       bioc = qio_channel_buffer_new(COLO_BUFFER_BASE_SIZE);
>>       fb = qemu_fopen_channel_input(QIO_CHANNEL(bioc));
>>       object_unref(OBJECT(bioc));
>> @@ -705,11 +712,18 @@ out:
>>       if (fb) {
>>           qemu_fclose(fb);
>>       }
>> +    /*
>> +     * We can ensure BH is hold the global lock, and will join COLO
>> +     * incoming thread, so here it is not necessary to lock here again,
>> +     * Or there will be a deadlock error.
>> +     */
>> +    colo_release_ram_cache();
>>   
>>       /* Hope this not to be too long to loop here */
>>       qemu_sem_wait(&mis->colo_incoming_sem);
>>       qemu_sem_destroy(&mis->colo_incoming_sem);
>>       /* Must be called after failover BH is completed */
>> +
>>       if (mis->to_src_file) {
>>           qemu_fclose(mis->to_src_file);
>>       }
>> diff --git a/migration/ram.c b/migration/ram.c
>> index f289fcd..b588990 100644
>> --- a/migration/ram.c
>> +++ b/migration/ram.c
>> @@ -219,6 +219,7 @@ static RAMBlock *last_sent_block;
>>   static ram_addr_t last_offset;
>>   static QemuMutex migration_bitmap_mutex;
>>   static uint64_t migration_dirty_pages;
>> +static bool ram_cache_enable;
>>   static uint32_t last_version;
>>   static bool ram_bulk_stage;
>>   
>> @@ -2227,6 +2228,20 @@ static inline void *host_from_ram_block_offset(RAMBlock *block,
>>       return block->host + offset;
>>   }
>>   
>> +static inline void *colo_cache_from_block_offset(RAMBlock *block,
>> +                                                 ram_addr_t offset)
>> +{
>> +    if (!offset_in_ramblock(block, offset)) {
>> +        return NULL;
>> +    }
>> +    if (!block->colo_cache) {
>> +        error_report("%s: colo_cache is NULL in block :%s",
>> +                     __func__, block->idstr);
>> +        return NULL;
>> +    }
>> +    return block->colo_cache + offset;
>> +}
>> +
>>   /*
>>    * If a page (or a whole RDMA chunk) has been
>>    * determined to be zero, then zap it.
>> @@ -2542,7 +2557,12 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>>                        RAM_SAVE_FLAG_COMPRESS_PAGE | RAM_SAVE_FLAG_XBZRLE)) {
>>               RAMBlock *block = ram_block_from_stream(f, flags);
>>   
>> -            host = host_from_ram_block_offset(block, addr);
>> +            /* After going into COLO, we should load the Page into colo_cache */
>> +            if (ram_cache_enable) {
>> +                host = colo_cache_from_block_offset(block, addr);
>> +            } else {
>> +                host = host_from_ram_block_offset(block, addr);
>> +            }
>>               if (!host) {
>>                   error_report("Illegal RAM offset " RAM_ADDR_FMT, addr);
>>                   ret = -EINVAL;
>> @@ -2637,6 +2657,57 @@ static int ram_load(QEMUFile *f, void *opaque, int version_id)
>>       return ret;
>>   }
>>   
>> +/*
>> + * colo cache: this is for secondary VM, we cache the whole
>> + * memory of the secondary VM, it will be called after first migration.
>> + */
>> +int colo_init_ram_cache(void)
>> +{
>> +    RAMBlock *block;
>> +
>> +    rcu_read_lock();
>> +    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
>> +        block->colo_cache = qemu_anon_ram_alloc(block->used_length, NULL);
>> +        if (!block->colo_cache) {
>> +            error_report("%s: Can't alloc memory for COLO cache of block %s,"
>> +                         "size 0x" RAM_ADDR_FMT, __func__, block->idstr,
>> +                         block->used_length);
>> +            goto out_locked;
>> +        }
>> +        memcpy(block->colo_cache, block->host, block->used_length);
>> +    }
>> +    rcu_read_unlock();
>> +    ram_cache_enable = true;
>> +    return 0;
>> +
>> +out_locked:
>> +    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
>> +        if (block->colo_cache) {
>> +            qemu_anon_ram_free(block->colo_cache, block->used_length);
>> +            block->colo_cache = NULL;
>> +        }
>> +    }
>> +
>> +    rcu_read_unlock();
>> +    return -errno;
>> +}
>> +
>> +void colo_release_ram_cache(void)
>> +{
>> +    RAMBlock *block;
>> +
>> +    ram_cache_enable = false;
>> +
>> +    rcu_read_lock();
>> +    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
>> +        if (block->colo_cache) {
>> +            qemu_anon_ram_free(block->colo_cache, block->used_length);
>> +            block->colo_cache = NULL;
>> +        }
>> +    }
>> +    rcu_read_unlock();
>> +}
>> +
>>   static SaveVMHandlers savevm_ram_handlers = {
>>       .save_live_setup = ram_save_setup,
>>       .save_live_iterate = ram_save_iterate,
>> -- 
>> 1.8.3.1
>>
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
> .
>
