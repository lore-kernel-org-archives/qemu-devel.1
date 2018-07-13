Received: from eggs.gnu.org ([2001:4830:134:3::10]:58714)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fe27n-0003T0-TU
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 13:45:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fe27j-0005sJ-F1
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 13:44:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59830 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fe27j-0005s0-8H
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 13:44:55 -0400
Date: Fri, 13 Jul 2018 18:44:46 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180713174445.GC2434@work-vm>
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
	<20180604095520.8563-8-xiaoguangrong@tencent.com>
	<20180619073650.GB14814@xz-mi>
	<5745f752-50b5-0645-21a7-3336ea0dd5c2@gmail.com>
	<20180711082143.GB15615@xz-mi>
	<ad3157b1-5a18-9fac-d863-22c4aee485e0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad3157b1-5a18-9fac-d863-22c4aee485e0@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 07/12] migration: hold the lock only if it
 is really needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Guangrong <guangrong.xiao@gmail.com>
Cc: Peter Xu <peterx@redhat.com>, pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>

* Xiao Guangrong (guangrong.xiao@gmail.com) wrote:
> 
> 
> On 07/11/2018 04:21 PM, Peter Xu wrote:
> > On Thu, Jun 28, 2018 at 05:33:58PM +0800, Xiao Guangrong wrote:
> > > 
> > > 
> > > On 06/19/2018 03:36 PM, Peter Xu wrote:
> > > > On Mon, Jun 04, 2018 at 05:55:15PM +0800, guangrong.xiao@gmail.com wrote:
> > > > > From: Xiao Guangrong <xiaoguangrong@tencent.com>
> > > > > 
> > > > > Try to hold src_page_req_mutex only if the queue is not
> > > > > empty
> > > > 
> > > > Pure question: how much this patch would help?  Basically if you are
> > > > running compression tests then I think it means you are with precopy
> > > > (since postcopy cannot work with compression yet), then here the lock
> > > > has no contention at all.
> > > 
> > > Yes, you are right, however we can observe it is in the top functions
> > > (after revert this patch):
> > > 
> > > Samples: 29K of event 'cycles', Event count (approx.): 22263412260
> > > +   7.99%  kqemu  qemu-system-x86_64       [.] ram_bytes_total
> > > +   6.95%  kqemu  [kernel.kallsyms]        [k] copy_user_enhanced_fast_string
> > > +   6.23%  kqemu  qemu-system-x86_64       [.] qemu_put_qemu_file
> > > +   6.20%  kqemu  qemu-system-x86_64       [.] qemu_event_set
> > > +   5.80%  kqemu  qemu-system-x86_64       [.] __ring_put
> > > +   4.82%  kqemu  qemu-system-x86_64       [.] compress_thread_data_done
> > > +   4.11%  kqemu  qemu-system-x86_64       [.] ring_is_full
> > > +   3.07%  kqemu  qemu-system-x86_64       [.] threads_submit_request_prepare
> > > +   2.83%  kqemu  qemu-system-x86_64       [.] ring_mp_get
> > > +   2.71%  kqemu  qemu-system-x86_64       [.] __ring_is_full
> > > +   2.46%  kqemu  qemu-system-x86_64       [.] buffer_zero_sse2
> > > +   2.40%  kqemu  qemu-system-x86_64       [.] add_to_iovec
> > > +   2.21%  kqemu  qemu-system-x86_64       [.] ring_get
> > > +   1.96%  kqemu  [kernel.kallsyms]        [k] __lock_acquire
> > > +   1.90%  kqemu  libc-2.12.so             [.] memcpy
> > > +   1.55%  kqemu  qemu-system-x86_64       [.] ring_len
> > > +   1.12%  kqemu  libpthread-2.12.so       [.] pthread_mutex_unlock
> > > +   1.11%  kqemu  qemu-system-x86_64       [.] ram_find_and_save_block
> > > +   1.07%  kqemu  qemu-system-x86_64       [.] ram_save_host_page
> > > +   1.04%  kqemu  qemu-system-x86_64       [.] qemu_put_buffer
> > > +   0.97%  kqemu  qemu-system-x86_64       [.] compress_page_with_multi_thread
> > > +   0.96%  kqemu  qemu-system-x86_64       [.] ram_save_target_page
> > > +   0.93%  kqemu  libpthread-2.12.so       [.] pthread_mutex_lock
> > 
> > (sorry to respond late; I was busy with other stuff for the
> >   release...)
> > 
> 
> You're welcome. :)
> 
> > I am trying to find out anything related to unqueue_page() but I
> > failed.  Did I miss anything obvious there?
> > 
> 
> unqueue_page() was not listed here indeed, i think the function
> itself is light enough (a check then directly return) so it
> did not leave a trace here.
> 
> This perf data was got after reverting this patch, i.e, it's
> based on the lockless multithread model, then unqueue_page() is
> the only place using mutex in the main thread.
> 
> And you can see the overload of mutext was gone after applying
> this patch in the mail i replied to Dave.

I got around to playing with this patch and using 'perf top'
to see what was going on.
What I noticed was that without this patch pthread_mutex_unlock and
qemu_mutex_lock_impl were both noticeable; with the patch they'd
pretty mich vanished.  So I think it's worth it.

I ocouldn't honestly see a difference in total CPU usage or
bandwidth; but the migration code is so spiky in usage that
it's difficult to measure anyway.

So,


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
