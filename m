Received: from eggs.gnu.org ([2001:4830:134:3::10]:48081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fnGSL-0006gN-8N
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 00:52:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fnGSI-00025b-5H
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 00:52:21 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53670 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fnGSH-00024a-VN
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 00:52:18 -0400
Date: Wed, 8 Aug 2018 12:52:09 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180808045209.GF24415@xz-mi>
References: <20180807091209.13531-1-xiaoguangrong@tencent.com>
	<20180807091209.13531-8-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180807091209.13531-8-xiaoguangrong@tencent.com>
Subject: Re: [Qemu-devel] [PATCH v3 07/10] migration: do not
 flush_compressed_data at the end of each iteration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

On Tue, Aug 07, 2018 at 05:12:06PM +0800, guangrong.xiao@gmail.com wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
> 
> flush_compressed_data() needs to wait all compression threads to
> finish their work, after that all threads are free until the
> migration feeds new request to them, reducing its call can improve
> the throughput and use CPU resource more effectively
> 
> We do not need to flush all threads at the end of iteration, the
> data can be kept locally until the memory block is changed or
> memory migration starts over in that case we will meet a dirtied
> page which may still exists in compression threads's ring
> 
> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
> ---
>  migration/ram.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 99ecf9b315..55966bc2c1 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -306,6 +306,8 @@ struct RAMState {
>      uint64_t iterations;
>      /* number of dirty bits in the bitmap */
>      uint64_t migration_dirty_pages;
> +    /* last dirty_sync_count we have seen */
> +    uint64_t dirty_sync_count_prev;
>      /* protects modification of the bitmap */
>      QemuMutex bitmap_mutex;
>      /* The RAMBlock used in the last src_page_requests */
> @@ -3173,6 +3175,17 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
>  
>      ram_control_before_iterate(f, RAM_CONTROL_ROUND);
>  
> +    /*
> +     * if memory migration starts over, we will meet a dirtied page which
> +     * may still exists in compression threads's ring, so we should flush
> +     * the compressed data to make sure the new page is not overwritten by
> +     * the old one in the destination.
> +     */
> +    if (ram_counters.dirty_sync_count != rs->dirty_sync_count_prev) {
> +        rs->dirty_sync_count_prev = ram_counters.dirty_sync_count;
> +        flush_compressed_data(rs);

AFAIU this only happens when ram_save_pending() calls
migration_bitmap_sync().  Could we just simply flush there?  Then we
can avoid that new variable.

> +    }
> +
>      t0 = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
>      i = 0;
>      while ((ret = qemu_file_rate_limit(f)) == 0 ||
> @@ -3205,7 +3218,6 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
>          }
>          i++;
>      }
> -    flush_compressed_data(rs);
>      rcu_read_unlock();
>  
>      /*
> -- 
> 2.14.4
> 

Regards,

-- 
Peter Xu
