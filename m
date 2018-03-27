Received: from eggs.gnu.org ([2001:4830:134:3::10]:52222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f0o30-0004wH-Ph
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 08:49:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f0o2w-0000vF-OR
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 08:49:54 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47018 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f0o2w-0000ug-Ja
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 08:49:50 -0400
Date: Tue, 27 Mar 2018 20:49:31 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180327124931.GP17789@xz-mi>
References: <20180313075739.11194-1-xiaoguangrong@tencent.com>
	<20180313075739.11194-7-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180313075739.11194-7-xiaoguangrong@tencent.com>
Subject: Re: [Qemu-devel] [PATCH 6/8] migration: move calling save_zero_page
 to the common place
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org

On Tue, Mar 13, 2018 at 03:57:37PM +0800, guangrong.xiao@gmail.com wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
> 
> save_zero_page() is always our first approach to try, move it to
> the common place before calling ram_save_compressed_page
> and ram_save_page
> 
> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
> ---
>  migration/ram.c | 106 ++++++++++++++++++++++++++++++++------------------------
>  1 file changed, 60 insertions(+), 46 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 839665d866..9627ce18e9 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1021,15 +1021,8 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss, bool last_stage)
>      trace_ram_save_page(block->idstr, (uint64_t)offset, p);
>  
>      XBZRLE_cache_lock();
> -    pages = save_zero_page(rs, block, offset);
> -    if (pages > 0) {
> -        /* Must let xbzrle know, otherwise a previous (now 0'd) cached
> -         * page would be stale
> -         */
> -        xbzrle_cache_zero_page(rs, current_addr);
> -        ram_release_pages(block->idstr, offset, pages);
> -    } else if (!rs->ram_bulk_stage &&
> -               !migration_in_postcopy() && migrate_use_xbzrle()) {
> +    if (!rs->ram_bulk_stage && !migration_in_postcopy() &&
> +           migrate_use_xbzrle()) {

Nit: indent problem?

[...]

> +static bool save_page_use_compression(RAMState *rs)
> +{
> +    if (!migrate_use_compression()) {
> +        return false;
> +    }
> +
> +    /*
> +     * If xbzrle is on, stop using the data compression after first
> +     * round of migration even if compression is enabled. In theory,
> +     * xbzrle can do better than compression.
> +     */
> +    if (rs->ram_bulk_stage || !migrate_use_xbzrle()) {
> +        return true;
> +    }
> +
> +    return false;
> +

Nit: remove this line?

Otherwise I'd say I like this patch... :)

Better with the nit fixed:

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu
