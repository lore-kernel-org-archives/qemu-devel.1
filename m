Received: from eggs.gnu.org ([2001:4830:134:3::10]:46929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fhWKF-0006NS-Nx
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 04:36:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fhWKA-000647-ND
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 04:36:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33596 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fhWKA-00063p-H3
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 04:36:10 -0400
Date: Mon, 23 Jul 2018 16:35:51 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180723083551.GK2491@xz-mi>
References: <20180719121520.30026-1-xiaoguangrong@tencent.com>
	<20180719121520.30026-9-xiaoguangrong@tencent.com>
	<20180723054903.GH2491@xz-mi>
	<5447275f-fe48-ec8f-399c-1a5530417f65@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5447275f-fe48-ec8f-399c-1a5530417f65@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 8/8] migration: do not
 flush_compressed_data at the end of each iteration
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

On Mon, Jul 23, 2018 at 04:05:21PM +0800, Xiao Guangrong wrote:
> 
> 
> On 07/23/2018 01:49 PM, Peter Xu wrote:
> > On Thu, Jul 19, 2018 at 08:15:20PM +0800, guangrong.xiao@gmail.com wrote:
> > > From: Xiao Guangrong <xiaoguangrong@tencent.com>
> > > 
> > > flush_compressed_data() needs to wait all compression threads to
> > > finish their work, after that all threads are free until the
> > > migration feeds new request to them, reducing its call can improve
> > > the throughput and use CPU resource more effectively
> > > 
> > > We do not need to flush all threads at the end of iteration, the
> > > data can be kept locally until the memory block is changed or
> > > memory migration starts over in that case we will meet a dirtied
> > > page which may still exists in compression threads's ring
> > > 
> > > Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
> > > ---
> > >   migration/ram.c | 15 ++++++++++++++-
> > >   1 file changed, 14 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/migration/ram.c b/migration/ram.c
> > > index 89305c7af5..fdab13821d 100644
> > > --- a/migration/ram.c
> > > +++ b/migration/ram.c
> > > @@ -315,6 +315,8 @@ struct RAMState {
> > >       uint64_t iterations;
> > >       /* number of dirty bits in the bitmap */
> > >       uint64_t migration_dirty_pages;
> > > +    /* last dirty_sync_count we have seen */
> > > +    uint64_t dirty_sync_count;
> > 
> > Better suffix it with "_prev" as well?  So that we can quickly
> > identify that it's only a cache and it can be different from the one
> > in the ram_counters.
> 
> Indeed, will update it.
> 
> > 
> > >       /* protects modification of the bitmap */
> > >       QemuMutex bitmap_mutex;
> > >       /* The RAMBlock used in the last src_page_requests */
> > > @@ -2532,6 +2534,7 @@ static void ram_save_cleanup(void *opaque)
> > >       }
> > >       xbzrle_cleanup();
> > > +    flush_compressed_data(*rsp);
> > 
> > Could I ask why do we need this considering that we have
> > compress_threads_save_cleanup() right down there?
> 
> Dave ask it too. :(
> 
> "This is for the error condition, if any error occurred during live migration,
> there is no chance to call ram_save_complete. After using the lockless
> multithreads model, we assert all requests have been handled before destroy
> the work threads."
> 
> That makes sure there is nothing left in the threads before doing
> compress_threads_save_cleanup() as current behavior. For lockless
> mutilthread model, we check if all requests are free before destroy
> them.

But why do we need to explicitly flush it here?  Now in
compress_threads_save_cleanup() we have qemu_fclose() on the buffers,
which logically will flush the data and clean up everything too.
Would that suffice?

> 
> > 
> > >       compress_threads_save_cleanup();
> > >       ram_state_cleanup(rsp);
> > >   }
> > > @@ -3203,6 +3206,17 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
> > >       ram_control_before_iterate(f, RAM_CONTROL_ROUND);
> > > +    /*
> > > +     * if memory migration starts over, we will meet a dirtied page which
> > > +     * may still exists in compression threads's ring, so we should flush
> > > +     * the compressed data to make sure the new page is not overwritten by
> > > +     * the old one in the destination.
> > > +     */
> > > +    if (ram_counters.dirty_sync_count != rs->dirty_sync_count) {
> > > +        rs->dirty_sync_count = ram_counters.dirty_sync_count;
> > > +        flush_compressed_data(rs);
> > > +    }
> > > +
> > >       t0 = qemu_clock_get_ns(QEMU_CLOCK_REALTIME);
> > >       i = 0;
> > >       while ((ret = qemu_file_rate_limit(f)) == 0 ||
> > > @@ -3235,7 +3249,6 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
> > >           }
> > >           i++;
> > >       }
> > > -    flush_compressed_data(rs);
> > 
> > This looks sane to me, but I'd like to see how other people would
> > think about it too...
> 
> Thank you a lot, Peter! :)

Welcome. :)

Regards,

-- 
Peter Xu
