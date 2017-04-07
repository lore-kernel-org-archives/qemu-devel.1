Received: from eggs.gnu.org ([2001:4830:134:3::10]:59100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cwXqq-0005Ps-VQ
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 13:39:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cwXqm-0003w1-Qm
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 13:39:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cwXqm-0003vO-KZ
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 13:39:08 -0400
Date: Fri, 7 Apr 2017 18:39:02 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170407173902.GP2138@work-vm>
References: <1487734936-43472-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1487734936-43472-16-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1487734936-43472-16-git-send-email-zhang.zhanghailiang@huawei.com>
Subject: Re: [Qemu-devel] [PATCH 15/15] COLO: flush host dirty ram from cache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>
Cc: qemu-devel@nongnu.org, zhangchen.fnst@cn.fujitsu.com, lizhijian@cn.fujitsu.com, xiecl.fnst@cn.fujitsu.com, Juan Quintela <quintela@redhat.com>

* zhanghailiang (zhang.zhanghailiang@huawei.com) wrote:
> Don't need to flush all VM's ram from cache, only
> flush the dirty pages since last checkpoint
> 
> Cc: Juan Quintela <quintela@redhat.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> ---
>  migration/ram.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 6227b94..e9ba740 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2702,6 +2702,7 @@ int colo_init_ram_cache(void)
>      migration_bitmap_rcu = g_new0(struct BitmapRcu, 1);
>      migration_bitmap_rcu->bmap = bitmap_new(ram_cache_pages);
>      migration_dirty_pages = 0;
> +    memory_global_dirty_log_start();

Shouldn't there be a stop somewhere?
(Probably if you failover to the secondary and colo stops?)

>      return 0;
>  
> @@ -2750,6 +2751,15 @@ void colo_flush_ram_cache(void)
>      void *src_host;
>      ram_addr_t offset = 0;
>  
> +    memory_global_dirty_log_sync();
> +    qemu_mutex_lock(&migration_bitmap_mutex);
> +    rcu_read_lock();
> +    QLIST_FOREACH_RCU(block, &ram_list.blocks, next) {
> +        migration_bitmap_sync_range(block->offset, block->used_length);
> +    }
> +    rcu_read_unlock();
> +    qemu_mutex_unlock(&migration_bitmap_mutex);

Again this might have some fun merging with Juan's recent changes - what's
really unusual about your set is that you're using this bitmap on the destination;
I suspect Juan's recent changes that trickier.
Check 'Creating RAMState for migration' and 'Split migration bitmaps by ramblock'.

Dave
>      trace_colo_flush_ram_cache_begin(migration_dirty_pages);
>      rcu_read_lock();
>      block = QLIST_FIRST_RCU(&ram_list.blocks);
> -- 
> 1.8.3.1
> 
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
