Received: from eggs.gnu.org ([2001:4830:134:3::10]:34278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cGgwL-0004Bg-CK
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 01:51:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cGgwK-00032f-Bg
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 01:51:53 -0500
Date: Tue, 13 Dec 2016 14:51:41 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20161213065141.GA2165@lemon>
References: <87oa0q1t21.fsf@dusky.pond.sub.org> <20161207025457.GB30227@lemon>
	<20161207094832.GA4773@noname.str.redhat.com>
	<20161207100339.GB2286@lemon> <87shpybnbc.fsf@dusky.pond.sub.org>
	<20161208134759.GA32226@lemon> <87wpf52qru.fsf@dusky.pond.sub.org>
	<20161212144307.GA21817@lemon> <87zik1xazy.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zik1xazy.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [Qemu-block]  Meeting notes on -blockdev,
 dynamic backend reconfiguration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Mon, 12/12 19:23, Markus Armbruster wrote:
> Fam Zheng <famz@redhat.com> writes:
> 
> > On Mon, 12/12 14:58, Markus Armbruster wrote:
> >> Fam Zheng <famz@redhat.com> writes:
> >> 
> >> > On Thu, 12/08 13:46, Markus Armbruster wrote:
> >> >> Fam Zheng <famz@redhat.com> writes:
> >> >> 
> >> >> > On Wed, 12/07 10:48, Kevin Wolf wrote:
> >> >> >> > If so I think there is no race to worry about, mirror-filter should go
> >> >> >> > away only after a QMP command.
> >> >> >> 
> >> >> >> Currently, a mirror job goes away whenever it is done. This is not
> >> >> >> directly tied to a QMP command.
> >> >> >
> >> >> > Ah right, block-job-complete is only "start to complete" and the job goes away
> >> >> > at some later point. I thought this is "the" QMP command but it is not.
> >> >> >
> >> >> >> 
> >> >> >> Of course, in the new job API we want an explicit job-delete, so in
> >> >> >> that case it wouldn't happen, but we need to keep the old case for
> >> >> >> compatibility.
> >> >> >
> >> >> > Another possibility is to add a placeholder node in the right location first
> >> >> > then fill in the actual throttling node once created. QMP owns the placeholder
> >> >> > node so it won't suddenly vanish when mirror job goes away.
> >> >> 
> >> >> I'm not sure I understand this idea.  Could you explain it in a bit more
> >> >> detail, perhaps even with a bit of ASCII art?
> >> >
> >> > OK, I'll base on your version:
> >> >
> >> > == Basic dynamic reconfiguration operation ==
> >> >
> >> > The two primitives are "insert placeholder" and bdrv_replace_child;
> >> >
> >> > A placeholder BDS is a dummy "pass through everything" filter. Inserting
> >> > placeholder is something like:
> >> >
> >> >     void bdrv_insert_placeholder(BdrvChild *child) {
> >> >         BlockDriverState *ph = bdrv_new_placeholder();
> >> >         ph->file->bs = child->bs;
> >> >         child->bs = ph;
> >> >     }
> >> >
> >> > Consider:
> >> >
> >> >           BB
> >> >           |
> >> >     mirror-filter
> >> >           |
> >> >          BDS
> >> >
> >> > Add a throttle filter under BB while the mirror job is running.  First step,
> >> > create the dummy _placeholder_ node and throttle-filter node (the existence of
> >> > placeholder node can be an implementation detail hidden from user):
> >> >
> >> >     placeholder = bdrv_insert_placeholder(BB->root);
> >> >     throttle_filter = bdrv_create_throttle_filter(placeholder);
> >> >
> >> > we get:
> >> >
> >> >           BB     throttle-filter
> >> >           |     /
> >> >      placeholder
> >> >           |
> >> >     mirror-filter
> >> >           |
> >> >          BDS
> >> >
> >> > Second step, move throttle filter in:
> >> >
> >> >     bdrv_replace_child(BB->root, throttle_filter);
> >> >     bdrv_replace_child(throttle_filter->file, throttle_filter->file->bs->file->bs);
> >> >     bdrv_unref(placeholder);
> >> >
> >> > we get:
> >> >
> >> >           BB
> >> >           |
> >> >    throttle-filter
> >> >           |
> >> >     mirror-filter
> >> >           |
> >> >          BDS
> >> >
> >> > Does this make us safe from racing with mirror-filter disappearing?
> >> 
> >> Thanks!  I figure your placeholder node does immunize the splicing in of
> >> the throttle-filter against the removal of mirror-filter.
> >> 
> >> Given a specific dynamic reconfiguration, where do we have to put
> >> placeholder nodes to immunize it against arbitrary other dynamic
> >> changes?
> >
> > Generally, a placeholder node is essentially an insertion to the middle of an
> > existing edge, namely to change:
> >
> >          NodeA
> >        /   |   \
> >       /    |    \
> >  [...]   NodeB   [...]
> >
> > into:
> >
> >          NodeA
> >        /   |   \
> >       /    |    \
> >  [...]  p-holdr  [...]
> >            |
> >            |
> >          NodeB
> >
> > and the operation is safe because of BQL. Our later bdrv_replace_child()
> > operations on it will always work because a dynamic reconfiguration won't delete
> > the placeholder node in any case.
> >
> > On the other hand, concurrent dynamic changes could yield usual outcomes from
> > user PoV (like the involved node is no longer in the same place or disappears),
> > but I think it is still in some degree under user's control. E.g. a
> > mirror-filter won't go away automatically until user does
> > block-job-complete/cancel.
> 
> I think I understand how we can safely insert a placeholder.  My
> question is: *where* do we have to insert placeholders before a certain
> dynamic reconfiguration to make that reconfiguration safe?

The placeholder will mainly protect "insertions" and therefore the location
woule be on edge where we insert a new filter.

Removing a node doesn't need placeholder protection.

Updating a node (to a different type) probably doesn't need that either but I'm
not 100% sure.

Fam
