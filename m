Received: from eggs.gnu.org ([2001:4830:134:3::10]:44755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fnIRV-0008C3-Tb
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 02:59:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fnIRS-0004P3-1R
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 02:59:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36402 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fnIRR-0004Op-R1
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 02:59:33 -0400
Date: Wed, 8 Aug 2018 14:59:26 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180808065926.GL24415@xz-mi>
References: <20180807091209.13531-1-xiaoguangrong@tencent.com>
	<20180807091209.13531-10-xiaoguangrong@tencent.com>
	<20180808060506.GH24415@xz-mi>
	<2a8e132b-2944-7077-6c76-b6447d1770c5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2a8e132b-2944-7077-6c76-b6447d1770c5@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3 09/10] migration: fix calculating
 xbzrle_counters.cache_miss_rate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Guangrong <guangrong.xiao@gmail.com>
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

On Wed, Aug 08, 2018 at 02:36:51PM +0800, Xiao Guangrong wrote:
> 
> 
> On 08/08/2018 02:05 PM, Peter Xu wrote:
> > On Tue, Aug 07, 2018 at 05:12:08PM +0800, guangrong.xiao@gmail.com wrote:
> > > From: Xiao Guangrong <xiaoguangrong@tencent.com>
> > > 
> > > As Peter pointed out:
> > > | - xbzrle_counters.cache_miss is done in save_xbzrle_page(), so it's
> > > |   per-guest-page granularity
> > > |
> > > | - RAMState.iterations is done for each ram_find_and_save_block(), so
> > > |   it's per-host-page granularity
> > > |
> > > | An example is that when we migrate a 2M huge page in the guest, we
> > > | will only increase the RAMState.iterations by 1 (since
> > > | ram_find_and_save_block() will be called once), but we might increase
> > > | xbzrle_counters.cache_miss for 2M/4K=512 times (we'll call
> > > | save_xbzrle_page() that many times) if all the pages got cache miss.
> > > | Then IMHO the cache miss rate will be 512/1=51200% (while it should
> > > | actually be just 100% cache miss).
> > > 
> > > And he also suggested as xbzrle_counters.cache_miss_rate is the only
> > > user of rs->iterations we can adapt it to count guest page numbers
> > > 
> > > After that, rename 'iterations' to 'handle_pages' to better reflect
> > > its meaning
> > > 
> > > Suggested-by: Peter Xu <peterx@redhat.com>
> > > Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
> > > ---
> > >   migration/ram.c | 18 +++++++++---------
> > >   1 file changed, 9 insertions(+), 9 deletions(-)
> > > 
> > > diff --git a/migration/ram.c b/migration/ram.c
> > > index 09be01dca2..bd7c18d1f9 100644
> > > --- a/migration/ram.c
> > > +++ b/migration/ram.c
> > > @@ -300,10 +300,10 @@ struct RAMState {
> > >       uint64_t num_dirty_pages_period;
> > >       /* xbzrle misses since the beginning of the period */
> > >       uint64_t xbzrle_cache_miss_prev;
> > > -    /* number of iterations at the beginning of period */
> > > -    uint64_t iterations_prev;
> > > -    /* Iterations since start */
> > > -    uint64_t iterations;
> > > +    /* total handled pages at the beginning of period */
> > > +    uint64_t handle_pages_prev;
> > > +    /* total handled pages since start */
> > > +    uint64_t handle_pages;
> > 
> > The name is not that straightforward to me.  I would think about
> > "[guest|host]_page_count" or something better, or we just keep the old
> > naming but with a better comment would be fine too.
> 
> The filed actually indicates total pages (target pages more precisely)
> handled during live migration. 'iterations' confuses us completely.
> 
> It's target_page_count good to you?

Yes.

> 
> > 
> > >       /* number of dirty bits in the bitmap */
> > >       uint64_t migration_dirty_pages;
> > >       /* last dirty_sync_count we have seen */
> > > @@ -1587,19 +1587,19 @@ uint64_t ram_pagesize_summary(void)
> > >   static void migration_update_rates(RAMState *rs, int64_t end_time)
> > >   {
> > > -    uint64_t iter_count = rs->iterations - rs->iterations_prev;
> > > +    uint64_t page_count = rs->handle_pages - rs->handle_pages_prev;
> > >       /* calculate period counters */
> > >       ram_counters.dirty_pages_rate = rs->num_dirty_pages_period * 1000
> > >                   / (end_time - rs->time_last_bitmap_sync);
> > > -    if (!iter_count) {
> > > +    if (!page_count) {
> > >           return;
> > >       }
> > >       if (migrate_use_xbzrle()) {
> > >           xbzrle_counters.cache_miss_rate = (double)(xbzrle_counters.cache_miss -
> > > -            rs->xbzrle_cache_miss_prev) / iter_count;
> > > +            rs->xbzrle_cache_miss_prev) / page_count;
> > >           rs->xbzrle_cache_miss_prev = xbzrle_counters.cache_miss;
> > >       }
> > >   }
> > > @@ -1657,7 +1657,7 @@ static void migration_bitmap_sync(RAMState *rs)
> > >           migration_update_rates(rs, end_time);
> > > -        rs->iterations_prev = rs->iterations;
> > > +        rs->handle_pages_prev = rs->handle_pages;
> > >           /* reset period counters */
> > >           rs->time_last_bitmap_sync = end_time;
> > > @@ -3209,7 +3209,7 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
> > >               break;
> > >           }
> > > -        rs->iterations++;
> > > +        rs->handle_pages += pages;
> > 
> > So it's still counting host pages, is this your intention to only
> > change the name in the patch?
> 
> Hmm... the value returned by ram_find_and_save_block() isn't the total
> target pages posted out?

Hmm, I overlooked that. Sorry. :)

Then it looks fine to me:

Reviewed-by: Peter Xu <peterx@redhat.com>

> 
> /**
>  * ram_find_and_save_block: finds a dirty page and sends it to f
>  *
>  * Called within an RCU critical section.
>  *
>  * Returns the number of pages written where zero means no dirty pages,
>  * or negative on error
> ...
> 
>  *
>  * On systems where host-page-size > target-page-size it will send all the
>  * pages in a host page that are dirty.
>  */

Regards,

-- 
Peter Xu
