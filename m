Received: from eggs.gnu.org ([2001:4830:134:3::10]:46034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fVapM-0000jv-NE
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 06:59:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fVapL-0001ps-LV
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 06:59:04 -0400
Date: Wed, 20 Jun 2018 12:58:55 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180620105854.GC3946@localhost.localdomain>
References: <cover.1528991017.git.berto@igalia.com>
	<6782db91216488e4fc1509a267a362a3f15a1aaa.1528991017.git.berto@igalia.com>
	<20180618143801.GC4667@localhost.localdomain>
	<w51in6gp213.fsf@maestria.local.igalia.com>
	<20180618161229.GD4667@localhost.localdomain>
	<w51vaaf0xnj.fsf@maestria.local.igalia.com>
	<20180619130509.GA21115@dhcp-200-186.str.redhat.com>
	<w51sh5i5047.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w51sh5i5047.fsf@maestria.local.igalia.com>
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

Am 19.06.2018 um 16:20 hat Alberto Garcia geschrieben:
> >> Wait, I think the description I gave is inaccurate:
> >> 
> >> commit_complete() calls bdrv_drop_intermediate(), and that updates the
> >> backing image name (c->role->update_filename()). If we're doing this in
> >> an intermediate node then it needs to be reopened in read-write mode,
> >> while keeping the rest of the options.
> >> 
> >> But then bdrv_reopen_commit() realizes that the backing file (from
> >> reopen_state->options) is not the current one (because there's a
> >> bdrv_mirror_top implicit filter) and attempts to remove it. And that's
> >> the root cause of the crash.
> >
> > How did the other (the real?) backing file get into
> > reopen_state->options? I don't think bdrv_drop_intermediate() wants to
> > change anything except the read-only flag, so we should surely have
> > the node name of bdrv_mirror_top there?
> 
> No, it doesn't (try to) change anything else. It cannot do it:
> bdrv_reopen() only takes flags, but keeps the current options. And the
> current options have 'backing' set to a thing different from the
> bdrv_mirror_top node.

Okay, so in theory this is expected to just work.

Actually, do we ever use bdrv_reopen() for flags other than read-only?
Maybe we should get rid of that flags nonsense and simply make it a
bdrv_reopen_set_readonly() taking a boolean.

> > > So my first impression is that we should not try to change backing
> > > files if a reopen was not requested by the user (blockdev-reopen)
> > > and perhaps we should forbid it when there are implicit nodes
> > > involved.
> > Changing the behaviour depending on who the caller is sounds like a
> > hack that relies on coincidence and may break sooner or later.
> 
> The main difference between the user calling blockdev-reopen and the
> code doing bdrv_reopen() internally is that in the former case all
> existing options are ignored (keep_old_opts = false) and in the latter
> they are kept.
> 
> This latter case can have unintended consequences, and I think they're
> all related to the fact that bs->explicit_options also keeps the options
> of its children. So if you have
> 
>    C <- B <- A
> 
> and A contains 'backing.driver=qcow2, backing.node-name=foo, ...', and
> you reopen A (keeping its options) then everything goes fine. However if
> you remove B from the chain (using e.g. block-stream) then you can't
> reopen A anymore because backing.* no longer matches the current backing
> file.
> 
> I suppose that we would need to remove the children options from
> bs->explicit_options in that case? If this all happens because of the
> user calling blockdev-reopen then we don't need to worry about it becase
> bs->explicit_options are ignored.

So the problem is that bs->explicit_options (and probably bs->options)
aren't consistent with the actual state of the graph. The fix for that
is likely not in bdrv_reopen().

I think we should already remove nested options of children from the
dicts in bdrv_open_inherit(). I'm less sure about node-name references.
Maybe instead of keeing the dicts up-to-date each time we modify the
graph, we should just get rid of those in the dicts as well, and instead
add a function that reconstructs the full dict from bs->options and the
currently attached children. This requires that the child name and the
option name match, but I think that's true. (Mostly at least - what
about quorum? But the child node handling of quorum is broken anyway.)

I'm almost sure Max has an opinion about this, too. :-)

> >> Ah, ok, I think that's related to the crash that I mentioned earlier
> >> with block-commit. Yes, it makes sense that we forbid that. I suppose
> >> that we can do this already with BLK_PERM_GRAPH_MOD ?
> >
> > Possibly. The thing with BLK_PERM_GRAPH_MOD is that nobody knows what
> > its meaning has to be so that it's actually useful, so we're not using
> > it in any meaningful way yet.
> >
> > I suspect BLK_PERM_GRAPH_MOD is the wrong tool because what we
> > actually want to protect against modification is not a BDS, but a
> > BdrvChild. But I may be wrong there.
> 
> I'll take a closer look and see what I come up with.

Okay. Maybe don't implement anything yet, but just try to come up with a
concept for discussion.

> At the moment there's 
> 
> Berto

And it's very good to have a Berto at the moment, but I think you wanted
to add something else there? ;-)

Kevin
