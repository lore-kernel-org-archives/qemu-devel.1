Received: from eggs.gnu.org ([2001:4830:134:3::10]:54924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fsLCB-0005x6-Vh
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 00:56:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fsLC8-0002YX-O4
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 00:56:39 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33144 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fsLC8-0002WR-0M
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 00:56:36 -0400
Date: Wed, 22 Aug 2018 12:56:21 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180822045621.GE3324@xz-x1>
References: <20180821081029.26121-1-xiaoguangrong@tencent.com>
	<20180821081029.26121-8-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180821081029.26121-8-xiaoguangrong@tencent.com>
Subject: Re: [Qemu-devel] [PATCH v4 07/10] migration: do not
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

On Tue, Aug 21, 2018 at 04:10:26PM +0800, guangrong.xiao@gmail.com wrote:
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

You forgot to remove the line in ram_save_iterate(), didn't you? :)

> 
> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
> ---
>  migration/ram.c | 90 +++++++++++++++++++++++++++++++--------------------------
>  1 file changed, 49 insertions(+), 41 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 99ecf9b315..1d54285501 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1602,6 +1602,47 @@ static void migration_update_rates(RAMState *rs, int64_t end_time)
>      }
>  }
>  
> +static void
> +update_compress_thread_counts(const CompressParam *param, int bytes_xmit)
> +{
> +    if (param->zero_page) {
> +        ram_counters.duplicate++;
> +    }
> +    ram_counters.transferred += bytes_xmit;
> +}
> +
> +static void flush_compressed_data(RAMState *rs)

If no content change in these two functions I would rather just
declare flush_compressed_data() at the beginning of the file which is
oneliner.  What do you think?

Regards,

-- 
Peter Xu
