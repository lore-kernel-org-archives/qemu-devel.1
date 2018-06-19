Received: from eggs.gnu.org ([2001:4830:134:3::10]:41942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fVGK3-0003oI-V8
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:05:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fVGJx-00061m-Aw
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:05:23 -0400
Date: Tue, 19 Jun 2018 15:05:09 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180619130509.GA21115@dhcp-200-186.str.redhat.com>
References: <cover.1528991017.git.berto@igalia.com>
	<6782db91216488e4fc1509a267a362a3f15a1aaa.1528991017.git.berto@igalia.com>
	<20180618143801.GC4667@localhost.localdomain>
	<w51in6gp213.fsf@maestria.local.igalia.com>
	<20180618161229.GD4667@localhost.localdomain>
	<w51vaaf0xnj.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w51vaaf0xnj.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [RFC PATCH 06/10] block: Allow changing the
 backing file on reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

Am 19.06.2018 um 14:27 hat Alberto Garcia geschrieben:
> On Mon 18 Jun 2018 06:12:29 PM CEST, Kevin Wolf wrote:
> >> >> This patch allows the user to change the backing file of an image
> >> >> that is being reopened. Here's what it does:
> >> >> 
> >> >>  - In bdrv_reopen_queue_child(): if the 'backing' option points to an
> >> >>    image different from the current backing file then it means that
> >> >>    the latter is going be detached so it must not be put in the reopen
> >> >>    queue.
> >> >> 
> >> >>  - In bdrv_reopen_prepare(): check that the value of 'backing' points
> >> >>    to an existing node or is null. If it points to an existing node it
> >> >>    also needs to make sure that replacing the backing file will not
> >> >>    create a cycle in the node graph (i.e. you cannot reach the parent
> >> >>    from the new backing file).
> >> >> 
> >> >>  - In bdrv_reopen_commit(): perform the actual node replacement by
> >> >>    calling bdrv_set_backing_hd(). It may happen that there are
> >> >>    temporary implicit nodes between the BDS that we are reopening and
> >> >>    the backing file that we want to replace (e.g. a commit fiter node),
> >> >>    so we must skip them.
> >> >
> >> > I think we shouldn't do this. blockdev-reopen is an advanced command
> >> > that requires knowledge of the graph at the node level. Therefore we can
> >> > expect the management tool to consider filter nodes when it reconfigures
> >> > the graph. This is important because it makes a difference whether a
> >> > new node is inserted above or below the filter node.
> >> 
> >> But those nodes that the management tool knows about would not be
> >> implicit, or would they?
> >
> > Hm, you're right, they are only implicit if no node name was given. So
> > it's not as bad as I thought.
> >
> > I still think of bs->implicit as a hack to maintain compatibility for
> > legacy commands rather than something to use in new commands.
> 
> Yes, and I'm still not 100% convinced that skipping the implicit nodes
> as I'm doing here is the proper solution, so maybe I'll need to come up
> with something else.
> 
> >> The reason why I did this is because there's several places in the
> >> QEMU codebase where bdrv_reopen() is called while there's a temporary
> >> implicit node. For example, on exit bdrv_commit() needs to call
> >> bdrv_set_backing_hd() to remove intermediate nodes from the
> >> chain. This happens while bdrv_mirror_top is still there, so if we
> >> don't skip it then QEMU crashes.
> >
> > But isn't that bdrv_set_backing_hd() a separate operation? I would
> > understand that it matters if you changed the code so that it would
> > use bdrv_reopen() in order to change the backing file, but that's not
> > what it does, is it?
> 
> Wait, I think the description I gave is inaccurate:
> 
> commit_complete() calls bdrv_drop_intermediate(), and that updates the
> backing image name (c->role->update_filename()). If we're doing this in
> an intermediate node then it needs to be reopened in read-write mode,
> while keeping the rest of the options.
> 
> But then bdrv_reopen_commit() realizes that the backing file (from
> reopen_state->options) is not the current one (because there's a
> bdrv_mirror_top implicit filter) and attempts to remove it. And that's
> the root cause of the crash.

How did the other (the real?) backing file get into
reopen_state->options? I don't think bdrv_drop_intermediate() wants to
change anything except the read-only flag, so we should surely have the
node name of bdrv_mirror_top there?

> So my first impression is that we should not try to change backing files
> if a reopen was not requested by the user (blockdev-reopen) and perhaps
> we should forbid it when there are implicit nodes involved.

Changing the behaviour depending on who the caller is sounds like a hack
that relies on coincidence and may break sooner or later.

> >> >> 2) If the 'backing' option is omitted altogether then the existing
> >> >> backing file (if any) is kept. Unlike blockdev-add this will _not_
> >> >> open the default backing file specified in the image header.
> >> >
> >> > Hm... This is certainly an inconsistency. Is it unavoidable?
> >> 
> >> I don't think we want to open new nodes on reopen(), but one easy way
> >> to avoid this behavior is simply to return an error if the user omits
> >> the 'backing' option.
> >
> > Hm, yes, not opening new nodes is a good point.
> >
> > As long as find a good solution that can be consistently applied to
> > all BlockdevRef, it should be okay. So I don't necessarily object to
> > the special casing and just leaving them as they are by default.
> >
> >> But this raises a few questions. Let's say you have an image with a
> >> backing file and you open it with blockdev-add omitting the 'backing'
> >> option. That means the default backing file is opened.
> >> 
> >>   - Do you still have to specify 'backing' on reopen? I suppose you
> >>     don't have to.
> >
> > You would have to. I agree it's ugly (not the least because you probably
> > didn't assign an explicit node name, though -drive allows specifying
> > only the node name, but still using the filename from the image file).
> 
> Yes it's a bit ugly, but we wouldn't be having a special case with the
> 'backing' option.

I think files I'm meanwhile tending towards your current solution (i.e.
default is leaving the reference as it is and you must use null to get
rid of a backing file).

> >>   - If you don't have to, can QEMU tell if bs->backing is the original
> >>     backing file or a new one? I suppose it can, by checking for
> >>     'backing / backing.*' in bs->options.
> >> 
> >>   - If you omit 'backing', does the backing file still get reopened? And
> >>     more importantly, does it keep its current options or are they
> >>     supposed to be reset to their default values?
> >
> > If you make omitting it an error, then that's not really a question?
> 
> No, if you are forced to specify 'backing' then this is not a problem.
> 
> >> >> +        /* If the 'backing' option is set and it points to a different
> >> >> +         * node then it means that we want to replace the current one,
> >> >> +         * so we shouldn't put it in the reopen queue */
> >> >> +        if (child->role == &child_backing && qdict_haskey(options, "backing")) {
> >> >
> >> > I think checking child->name for "backing" makes more sense when we
> >> > also look for the "backing" key in the options QDict. This would make
> >> > generalising it for other children easier (which we probably should
> >> > do, whether in this patch or a follow-up).
> >> 
> >> Sounds reasonable.
> >> 
> >> > Do we need some way for e.g. block jobs to forbid changing the backing
> >> > file of the subchain they are operating on?
> >> 
> >> Are you thinking of any particular scenario?
> >
> > Not specifically, but I think e.g. the commit job might get confused
> > if you break its backing chain because it assumes that base is
> > somewhere in the backing chain of top, and also that it called
> > block_job_add_bdrv() on everything in the subchain it is working on.
> >
> > It just feels like we'd allow to break any such assumptions if we
> > don't block graph changes there.
> 
> Ah, ok, I think that's related to the crash that I mentioned earlier
> with block-commit. Yes, it makes sense that we forbid that. I suppose
> that we can do this already with BLK_PERM_GRAPH_MOD ?

Possibly. The thing with BLK_PERM_GRAPH_MOD is that nobody knows what
its meaning has to be so that it's actually useful, so we're not using
it in any meaningful way yet.

I suspect BLK_PERM_GRAPH_MOD is the wrong tool because what we actually
want to protect against modification is not a BDS, but a BdrvChild. But
I may be wrong there.

Kevin
