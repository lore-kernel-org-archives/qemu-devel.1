Received: from eggs.gnu.org ([2001:4830:134:3::10]:40140)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fVHUn-0008To-7H
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 10:20:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1fVHUi-0006o7-BJ
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 10:20:33 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20180619130509.GA21115@dhcp-200-186.str.redhat.com>
References: <cover.1528991017.git.berto@igalia.com>
	<6782db91216488e4fc1509a267a362a3f15a1aaa.1528991017.git.berto@igalia.com>
	<20180618143801.GC4667@localhost.localdomain>
	<w51in6gp213.fsf@maestria.local.igalia.com>
	<20180618161229.GD4667@localhost.localdomain>
	<w51vaaf0xnj.fsf@maestria.local.igalia.com>
	<20180619130509.GA21115@dhcp-200-186.str.redhat.com>
Date: Tue, 19 Jun 2018 16:20:24 +0200
Message-ID: <w51sh5i5047.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

>> Wait, I think the description I gave is inaccurate:
>> 
>> commit_complete() calls bdrv_drop_intermediate(), and that updates the
>> backing image name (c->role->update_filename()). If we're doing this in
>> an intermediate node then it needs to be reopened in read-write mode,
>> while keeping the rest of the options.
>> 
>> But then bdrv_reopen_commit() realizes that the backing file (from
>> reopen_state->options) is not the current one (because there's a
>> bdrv_mirror_top implicit filter) and attempts to remove it. And that's
>> the root cause of the crash.
>
> How did the other (the real?) backing file get into
> reopen_state->options? I don't think bdrv_drop_intermediate() wants to
> change anything except the read-only flag, so we should surely have
> the node name of bdrv_mirror_top there?

No, it doesn't (try to) change anything else. It cannot do it:
bdrv_reopen() only takes flags, but keeps the current options. And the
current options have 'backing' set to a thing different from the
bdrv_mirror_top node.

> > So my first impression is that we should not try to change backing
> > files if a reopen was not requested by the user (blockdev-reopen)
> > and perhaps we should forbid it when there are implicit nodes
> > involved.
> Changing the behaviour depending on who the caller is sounds like a
> hack that relies on coincidence and may break sooner or later.

The main difference between the user calling blockdev-reopen and the
code doing bdrv_reopen() internally is that in the former case all
existing options are ignored (keep_old_opts = false) and in the latter
they are kept.

This latter case can have unintended consequences, and I think they're
all related to the fact that bs->explicit_options also keeps the options
of its children. So if you have

   C <- B <- A

and A contains 'backing.driver=qcow2, backing.node-name=foo, ...', and
you reopen A (keeping its options) then everything goes fine. However if
you remove B from the chain (using e.g. block-stream) then you can't
reopen A anymore because backing.* no longer matches the current backing
file.

I suppose that we would need to remove the children options from
bs->explicit_options in that case? If this all happens because of the
user calling blockdev-reopen then we don't need to worry about it becase
bs->explicit_options are ignored.

>> >> >> 2) If the 'backing' option is omitted altogether then the existing
>> >> >> backing file (if any) is kept. Unlike blockdev-add this will _not_
>> >> >> open the default backing file specified in the image header.
>> >> >
>> >> > Hm... This is certainly an inconsistency. Is it unavoidable?
>> >> 
>> >> I don't think we want to open new nodes on reopen(), but one easy way
>> >> to avoid this behavior is simply to return an error if the user omits
>> >> the 'backing' option.
>> >
>> > Hm, yes, not opening new nodes is a good point.
>> >
>> > As long as find a good solution that can be consistently applied to
>> > all BlockdevRef, it should be okay. So I don't necessarily object to
>> > the special casing and just leaving them as they are by default.
>> >
>> >> But this raises a few questions. Let's say you have an image with a
>> >> backing file and you open it with blockdev-add omitting the 'backing'
>> >> option. That means the default backing file is opened.
>> >> 
>> >>   - Do you still have to specify 'backing' on reopen? I suppose you
>> >>     don't have to.
>> >
>> > You would have to. I agree it's ugly (not the least because you probably
>> > didn't assign an explicit node name, though -drive allows specifying
>> > only the node name, but still using the filename from the image file).
>> 
>> Yes it's a bit ugly, but we wouldn't be having a special case with the
>> 'backing' option.
>
> I think files I'm meanwhile tending towards your current solution
> (i.e.  default is leaving the reference as it is and you must use null
> to get rid of a backing file).

It's not necessarily a bad option. The only one that I don't like is
opening the default backing file if 'backing' is omitted.

>> >> > Do we need some way for e.g. block jobs to forbid changing the
>> >> > backing file of the subchain they are operating on?
>> >> 
>> >> Are you thinking of any particular scenario?
>> >
>> > Not specifically, but I think e.g. the commit job might get confused
>> > if you break its backing chain because it assumes that base is
>> > somewhere in the backing chain of top, and also that it called
>> > block_job_add_bdrv() on everything in the subchain it is working on.
>> >
>> > It just feels like we'd allow to break any such assumptions if we
>> > don't block graph changes there.
>> 
>> Ah, ok, I think that's related to the crash that I mentioned earlier
>> with block-commit. Yes, it makes sense that we forbid that. I suppose
>> that we can do this already with BLK_PERM_GRAPH_MOD ?
>
> Possibly. The thing with BLK_PERM_GRAPH_MOD is that nobody knows what
> its meaning has to be so that it's actually useful, so we're not using
> it in any meaningful way yet.
>
> I suspect BLK_PERM_GRAPH_MOD is the wrong tool because what we
> actually want to protect against modification is not a BDS, but a
> BdrvChild. But I may be wrong there.

I'll take a closer look and see what I come up with.

At the moment there's 

Berto
