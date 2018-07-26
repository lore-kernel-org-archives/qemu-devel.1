Received: from eggs.gnu.org ([2001:4830:134:3::10]:44904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fiYq9-0007WJ-Ix
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 01:29:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fiYq6-0007FK-JF
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 01:29:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55214 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fiYq6-0007Dw-Cc
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 01:29:26 -0400
Date: Thu, 26 Jul 2018 13:29:15 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180726052915.GK2479@xz-mi>
References: <20180719121520.30026-1-xiaoguangrong@tencent.com>
	<20180719121520.30026-4-xiaoguangrong@tencent.com>
	<20180723043634.GC2491@xz-mi>
	<8ae4beeb-0c6d-04a1-189a-972bcf342656@gmail.com>
	<20180723080559.GI2491@xz-mi> <20180725164401.GD2365@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180725164401.GD2365@work-vm>
Subject: Re: [Qemu-devel] [PATCH v2 3/8] migration: show the statistics of
 compression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Xiao Guangrong <guangrong.xiao@gmail.com>, pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>

On Wed, Jul 25, 2018 at 05:44:02PM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > On Mon, Jul 23, 2018 at 03:39:18PM +0800, Xiao Guangrong wrote:
> > > 
> > > 
> > > On 07/23/2018 12:36 PM, Peter Xu wrote:
> > > > On Thu, Jul 19, 2018 at 08:15:15PM +0800, guangrong.xiao@gmail.com wrote:
> > > > > @@ -1597,6 +1608,24 @@ static void migration_update_rates(RAMState *rs, int64_t end_time)
> > > > >               rs->xbzrle_cache_miss_prev) / iter_count;
> > > > >           rs->xbzrle_cache_miss_prev = xbzrle_counters.cache_miss;
> > > > >       }
> > > > > +
> > > > > +    if (migrate_use_compression()) {
> > > > > +        uint64_t comp_pages;
> > > > > +
> > > > > +        compression_counters.busy_rate = (double)(compression_counters.busy -
> > > > > +            rs->compress_thread_busy_prev) / iter_count;
> > > > 
> > > > Here I'm not sure it's correct...
> > > > 
> > > > "iter_count" stands for ramstate.iterations.  It's increased per
> > > > ram_find_and_save_block(), so IMHO it might contain multiple guest
> > > 
> > > ram_find_and_save_block() returns if a page is successfully posted and
> > > it only posts 1 page out at one time.
> > 
> > ram_find_and_save_block() calls ram_save_host_page(), and we should be
> > sending multiple guest pages in ram_save_host_page() if the host page
> > is a huge page?
> > 
> > > 
> > > > pages.  However compression_counters.busy should be per guest page.
> > > > 
> > > 
> > > Actually, it's derived from xbzrle_counters.cache_miss_rate:
> > >         xbzrle_counters.cache_miss_rate = (double)(xbzrle_counters.cache_miss -
> > >             rs->xbzrle_cache_miss_prev) / iter_count;
> > 
> > Then this is suspecious to me too...
> 
> Actually; I think this isn't totally wrong;  iter_count is the *difference* in
> iterations since the last time it was updated:
> 
>    uint64_t iter_count = rs->iterations - rs->iterations_prev;
> 
>         xbzrle_counters.cache_miss_rate = (double)(xbzrle_counters.cache_miss -
>             rs->xbzrle_cache_miss_prev) / iter_count;
> 
> so this is:
>       cache-misses-since-last-update
>       ------------------------------
>         iterations since last-update
> 
> so the 'miss_rate' is ~misses / iteration.
> Although that doesn't really correspond to time.

I'm not sure I got the idea here, the thing is that I think the
counters are for different granularities which might be problematic:

- xbzrle_counters.cache_miss is done in save_xbzrle_page(), so it's
  per-guest-page granularity

- RAMState.iterations is done for each ram_find_and_save_block(), so
  it's per-host-page granularity

An example is that when we migrate a 2M huge page in the guest, we
will only increase the RAMState.iterations by 1 (since
ram_find_and_save_block() will be called once), but we might increase
xbzrle_counters.cache_miss for 2M/4K=512 times (we'll call
save_xbzrle_page() that many times) if all the pages got cache miss.
Then IMHO the cache miss rate will be 512/1=51200% (while it should
actually be just 100% cache miss).

Regards,

-- 
Peter Xu
