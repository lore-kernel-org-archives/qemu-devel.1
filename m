Received: from eggs.gnu.org ([2001:4830:134:3::10]:40740)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fT7vk-0000eD-Gb
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 11:43:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fT7vh-0006ef-NL
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 11:43:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57124 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fT7vh-0006c6-HJ
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 11:43:25 -0400
Date: Wed, 13 Jun 2018 16:43:14 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180613154314.GI2676@work-vm>
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
	<20180604095520.8563-2-xiaoguangrong@tencent.com>
	<20180611073920.GJ7736@xz-mi>
	<f9915861-a0bd-aa94-8796-64465cbf937c@gmail.com>
	<20180612031503.GL7736@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180612031503.GL7736@xz-mi>
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
To: Peter Xu <peterx@redhat.com>
Cc: Xiao Guangrong <guangrong.xiao@gmail.com>, pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>

* Peter Xu (peterx@redhat.com) wrote:
> On Tue, Jun 12, 2018 at 10:42:25AM +0800, Xiao Guangrong wrote:
> > 
> > 
> > On 06/11/2018 03:39 PM, Peter Xu wrote:
> > > On Mon, Jun 04, 2018 at 05:55:09PM +0800, guangrong.xiao@gmail.com wrote:
> > > > From: Xiao Guangrong <xiaoguangrong@tencent.com>
> > > > 
> > > > Instead of putting the main thread to sleep state to wait for
> > > > free compression thread, we can directly post it out as normal
> > > > page that reduces the latency and uses CPUs more efficiently
> > > 
> > > The feature looks good, though I'm not sure whether we should make a
> > > capability flag for this feature since otherwise it'll be hard to
> > > switch back to the old full-compression way no matter for what
> > > reason.  Would that be a problem?
> > > 
> > 
> > We assume this optimization should always be optimistic for all cases,
> > particularly, we introduced the statistics of compression, then the user
> > should adjust its parameters based on those statistics if anything works
> > worse.
> 
> Ah, that'll be good.
> 
> > 
> > Furthermore, we really need to improve this optimization if it hurts
> > any case rather than leaving a option to the user. :)
> 
> Yeah, even if we make it a parameter/capability we can still turn that
> on by default in new versions but keep the old behavior in old
> versions. :) The major difference is that, then we can still _have_ a
> way to compress every page. I'm just thinking if we don't have a
> switch for that then if someone wants to measure e.g.  how a new
> compression algo could help VM migration, then he/she won't be
> possible to do that again since the numbers will be meaningless if
> that bit is out of control on which page will be compressed.
> 
> Though I don't know how much use it'll bring...  But if that won't be
> too hard, it still seems good.  Not a strong opinion.

I think that is needed; it might be that some users have really awful
networking and need the compression; I'd expect that for people who turn
on compression they really expect the slowdown because they need it for
their network, so changing that is a bit odd.

Dave
> > 
> > > > 
> > > > Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
> > > > ---
> > > >   migration/ram.c | 34 +++++++++++++++-------------------
> > > >   1 file changed, 15 insertions(+), 19 deletions(-)
> > > > 
> > > > diff --git a/migration/ram.c b/migration/ram.c
> > > > index 5bcbf7a9f9..0caf32ab0a 100644
> > > > --- a/migration/ram.c
> > > > +++ b/migration/ram.c
> > > > @@ -1423,25 +1423,18 @@ static int compress_page_with_multi_thread(RAMState *rs, RAMBlock *block,
> > > >       thread_count = migrate_compress_threads();
> > > >       qemu_mutex_lock(&comp_done_lock);
> > > 
> > > Can we drop this lock in this case?
> > 
> > The lock is used to protect comp_param[].done...
> 
> IMHO it's okay?
> 
> It's used in this way:
> 
>   if (done) {
>     done = false;
>   }
> 
> So it only switches done from true->false.
> 
> And the compression thread is the only one that did the other switch
> (false->true).  IMHO this special case will allow no-lock since as
> long as "done" is true here then current thread will be the only one
> to modify it, then no race at all.
> 
> > 
> > Well, we are able to possibly remove it if we redesign the implementation, e.g, use atomic
> > access for comp_param.done, however, it still can not work efficiently i believe. Please see
> > more in the later reply to your comments in the cover-letter.
> 
> Will read that after it arrives; though I didn't receive a reply.
> Have you missed clicking the "send" button? ;)
> 
> Regards,
> 
> -- 
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
