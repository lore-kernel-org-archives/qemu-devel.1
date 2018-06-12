Received: from eggs.gnu.org ([2001:4830:134:3::10]:55500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fSZm9-0003S5-7I
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 23:15:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fSZm4-0004Tz-JH
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 23:15:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47048 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fSZm4-0004TK-Cp
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 23:15:12 -0400
Date: Tue, 12 Jun 2018 11:15:03 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180612031503.GL7736@xz-mi>
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
	<20180604095520.8563-2-xiaoguangrong@tencent.com>
	<20180611073920.GJ7736@xz-mi>
	<f9915861-a0bd-aa94-8796-64465cbf937c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f9915861-a0bd-aa94-8796-64465cbf937c@gmail.com>
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
To: Xiao Guangrong <guangrong.xiao@gmail.com>
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>

On Tue, Jun 12, 2018 at 10:42:25AM +0800, Xiao Guangrong wrote:
> 
> 
> On 06/11/2018 03:39 PM, Peter Xu wrote:
> > On Mon, Jun 04, 2018 at 05:55:09PM +0800, guangrong.xiao@gmail.com wrote:
> > > From: Xiao Guangrong <xiaoguangrong@tencent.com>
> > > 
> > > Instead of putting the main thread to sleep state to wait for
> > > free compression thread, we can directly post it out as normal
> > > page that reduces the latency and uses CPUs more efficiently
> > 
> > The feature looks good, though I'm not sure whether we should make a
> > capability flag for this feature since otherwise it'll be hard to
> > switch back to the old full-compression way no matter for what
> > reason.  Would that be a problem?
> > 
> 
> We assume this optimization should always be optimistic for all cases,
> particularly, we introduced the statistics of compression, then the user
> should adjust its parameters based on those statistics if anything works
> worse.

Ah, that'll be good.

> 
> Furthermore, we really need to improve this optimization if it hurts
> any case rather than leaving a option to the user. :)

Yeah, even if we make it a parameter/capability we can still turn that
on by default in new versions but keep the old behavior in old
versions. :) The major difference is that, then we can still _have_ a
way to compress every page. I'm just thinking if we don't have a
switch for that then if someone wants to measure e.g.  how a new
compression algo could help VM migration, then he/she won't be
possible to do that again since the numbers will be meaningless if
that bit is out of control on which page will be compressed.

Though I don't know how much use it'll bring...  But if that won't be
too hard, it still seems good.  Not a strong opinion.

> 
> > > 
> > > Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
> > > ---
> > >   migration/ram.c | 34 +++++++++++++++-------------------
> > >   1 file changed, 15 insertions(+), 19 deletions(-)
> > > 
> > > diff --git a/migration/ram.c b/migration/ram.c
> > > index 5bcbf7a9f9..0caf32ab0a 100644
> > > --- a/migration/ram.c
> > > +++ b/migration/ram.c
> > > @@ -1423,25 +1423,18 @@ static int compress_page_with_multi_thread(RAMState *rs, RAMBlock *block,
> > >       thread_count = migrate_compress_threads();
> > >       qemu_mutex_lock(&comp_done_lock);
> > 
> > Can we drop this lock in this case?
> 
> The lock is used to protect comp_param[].done...

IMHO it's okay?

It's used in this way:

  if (done) {
    done = false;
  }

So it only switches done from true->false.

And the compression thread is the only one that did the other switch
(false->true).  IMHO this special case will allow no-lock since as
long as "done" is true here then current thread will be the only one
to modify it, then no race at all.

> 
> Well, we are able to possibly remove it if we redesign the implementation, e.g, use atomic
> access for comp_param.done, however, it still can not work efficiently i believe. Please see
> more in the later reply to your comments in the cover-letter.

Will read that after it arrives; though I didn't receive a reply.
Have you missed clicking the "send" button? ;)

Regards,

-- 
Peter Xu
