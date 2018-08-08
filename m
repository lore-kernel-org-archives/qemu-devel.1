Received: from eggs.gnu.org ([2001:4830:134:3::10]:51241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fnGiV-00035q-MT
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 01:09:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fnGiR-0001VQ-6N
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 01:09:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33408 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fnGiQ-0001V8-W3
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 01:08:59 -0400
Date: Wed, 8 Aug 2018 13:08:46 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180808050846.GG24415@xz-mi>
References: <20180807091209.13531-1-xiaoguangrong@tencent.com>
	<20180807091209.13531-9-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180807091209.13531-9-xiaoguangrong@tencent.com>
Subject: Re: [Qemu-devel] [PATCH v3 08/10] migration: handle the error
 condition properly
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

On Tue, Aug 07, 2018 at 05:12:07PM +0800, guangrong.xiao@gmail.com wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
> 
> ram_find_and_save_block() can return negative if any error hanppens,
> however, it is completely ignored in current code

Could you hint me where we'll return an error?

(Anyway I agree that the error handling is not that good, mostly
 because the QEMUFile APIs does not provide proper return code, e.g.,
 qemu_put_be64 returns void)

> 
> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
> ---
>  migration/ram.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 55966bc2c1..09be01dca2 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2367,7 +2367,8 @@ static int ram_save_host_page(RAMState *rs, PageSearchStatus *pss,
>   *
>   * Called within an RCU critical section.
>   *
> - * Returns the number of pages written where zero means no dirty pages
> + * Returns the number of pages written where zero means no dirty pages,
> + * or negative on error
>   *
>   * @rs: current RAM state
>   * @last_stage: if we are at the completion stage
> @@ -3202,6 +3203,12 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
>              done = 1;
>              break;
>          }
> +
> +        if (pages < 0) {
> +            qemu_file_set_error(f, pages);
> +            break;
> +        }
> +
>          rs->iterations++;
>  
>          /* we want to check in the 1st loop, just in case it was the 1st time
> @@ -3243,7 +3250,7 @@ out:
>  /**
>   * ram_save_complete: function called to send the remaining amount of ram
>   *
> - * Returns zero to indicate success
> + * Returns zero to indicate success or negative on error
>   *
>   * Called with iothread lock
>   *
> @@ -3254,6 +3261,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>  {
>      RAMState **temp = opaque;
>      RAMState *rs = *temp;
> +    int ret = 0;
>  
>      rcu_read_lock();
>  
> @@ -3274,6 +3282,10 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>          if (pages == 0) {
>              break;
>          }
> +        if (pages < 0) {
> +            ret = pages;
> +            break;
> +        }
>      }
>  
>      flush_compressed_data(rs);
> @@ -3285,7 +3297,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>      qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
>      qemu_fflush(f);
>  
> -    return 0;
> +    return ret;
>  }
>  
>  static void ram_save_pending(QEMUFile *f, void *opaque, uint64_t max_size,
> -- 
> 2.14.4
> 

Regards,

-- 
Peter Xu
