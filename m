Received: from eggs.gnu.org ([2001:4830:134:3::10]:48821)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fSHQL-0007lY-4G
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 03:39:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fSHQI-0007jR-00
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 03:39:33 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51668 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fSHQH-0007jE-RH
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 03:39:29 -0400
Date: Mon, 11 Jun 2018 15:39:20 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180611073920.GJ7736@xz-mi>
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
	<20180604095520.8563-2-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180604095520.8563-2-xiaoguangrong@tencent.com>
Subject: Re: [Qemu-devel] [PATCH 01/12] migration: do not wait if no free
 thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>

On Mon, Jun 04, 2018 at 05:55:09PM +0800, guangrong.xiao@gmail.com wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
> 
> Instead of putting the main thread to sleep state to wait for
> free compression thread, we can directly post it out as normal
> page that reduces the latency and uses CPUs more efficiently

The feature looks good, though I'm not sure whether we should make a
capability flag for this feature since otherwise it'll be hard to
switch back to the old full-compression way no matter for what
reason.  Would that be a problem?

> 
> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
> ---
>  migration/ram.c | 34 +++++++++++++++-------------------
>  1 file changed, 15 insertions(+), 19 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 5bcbf7a9f9..0caf32ab0a 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1423,25 +1423,18 @@ static int compress_page_with_multi_thread(RAMState *rs, RAMBlock *block,
>  
>      thread_count = migrate_compress_threads();
>      qemu_mutex_lock(&comp_done_lock);

Can we drop this lock in this case?

> -    while (true) {
> -        for (idx = 0; idx < thread_count; idx++) {
> -            if (comp_param[idx].done) {
> -                comp_param[idx].done = false;
> -                bytes_xmit = qemu_put_qemu_file(rs->f, comp_param[idx].file);
> -                qemu_mutex_lock(&comp_param[idx].mutex);
> -                set_compress_params(&comp_param[idx], block, offset);
> -                qemu_cond_signal(&comp_param[idx].cond);
> -                qemu_mutex_unlock(&comp_param[idx].mutex);
> -                pages = 1;
> -                ram_counters.normal++;
> -                ram_counters.transferred += bytes_xmit;
> -                break;
> -            }
> -        }
> -        if (pages > 0) {
> +    for (idx = 0; idx < thread_count; idx++) {
> +        if (comp_param[idx].done) {
> +            comp_param[idx].done = false;
> +            bytes_xmit = qemu_put_qemu_file(rs->f, comp_param[idx].file);
> +            qemu_mutex_lock(&comp_param[idx].mutex);
> +            set_compress_params(&comp_param[idx], block, offset);
> +            qemu_cond_signal(&comp_param[idx].cond);
> +            qemu_mutex_unlock(&comp_param[idx].mutex);
> +            pages = 1;
> +            ram_counters.normal++;
> +            ram_counters.transferred += bytes_xmit;
>              break;
> -        } else {
> -            qemu_cond_wait(&comp_done_cond, &comp_done_lock);
>          }
>      }
>      qemu_mutex_unlock(&comp_done_lock);

Regards,

-- 
Peter Xu
