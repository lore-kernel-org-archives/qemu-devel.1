Received: from eggs.gnu.org ([2001:4830:134:3::10]:36732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpY7o-0000Bi-CK
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 08:08:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpY7n-0002f9-8M
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 08:08:36 -0400
Date: Tue, 14 Aug 2018 14:08:26 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180814120826.GK5025@dhcp-200-186.str.redhat.com>
References: <cover.1530270904.git.berto@igalia.com>
	<0ac388e86dec1afbff4b5e4e6ade1f1fb7b2d7ff.1530270904.git.berto@igalia.com>
	<20180814091750.GF5025@dhcp-200-186.str.redhat.com>
	<w51zhxpnrt8.fsf@maestria.local.igalia.com>
	<20180814111442.GH5025@dhcp-200-186.str.redhat.com>
	<w51wostnp8t.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w51wostnp8t.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] block: Simplify append_open_options()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 14.08.2018 um 13:48 hat Alberto Garcia geschrieben:
> >> In the case of 'backing=foo' that's clearly an option of the parent,
> >> there's no other place to put it. We could probably remove it as
> >> well, but we have to see carefully that no parent needs to keep that
> >> information. I think we want to keep child references because in
> >> general we don't allow them to be changed in reopen.
> >> 
> >> Example: you cannot pass 'file=bar' on reopen unless 'bar' was
> >> already the existing value of 'file' (i.e. you're not changing
> >> anything). We need to look for the previous value in bs->options in
> >> order to know that.
> >
> > My point is the backing=foo has the same problem: Storing it in
> > bs->options is not only redundant, but potentially incorrect because
> > we never update it when we modify the graph. There is no point in
> > keeping potentially incorrect information.
> 
> I tend to agree, but there's one reason why it's not exactly the same
> case: with "backing=foo" we know not only that the backing node name is
> 'foo', but that it was added using a reference rather than with
> backing.node-name=foo. I'm not sure if that's information that we need
> for anything, however (probably not).

Isn't the proper way to check this foo->inherits_from?

But generally, it shouldn't make a difference for most purposes which
way a node was created.

> > When you actually use that incorrect information, you've got a bug.
> > Reopen with file=bar doesn't have to check whether 'file=bar' is in
> > bs->options (because that may be outdated information), but whether
> > the BdrvChild with the name 'file' points to a node called 'bar'.
> 
> Again, this is correct if we open the BDS with
> 
>   file.node-name=bar
> 
> and then we allow reopening it with
> 
>   file=bar
> 
> Different set of options, but the result still makes sense. For this we
> need a specific check to verify that this is correct. For the current
> behavior we don't need anything now: we only allow the exact same
> option.

That's yet another case and another reason why we want to check
BdrvChild instead. If we take BlockdevOptions for blockdev-reopen, you
need to put something there for nodes that you created inline
originally, and just putting the node name there probably makes the most
sense.

Anyway, the case that I had in mind is the case where you removed a
backing file with a block job:

    base <- mid <- top

You stream top into mid, so at the end of the job, mid goes away and
base is the backing file of top. But since you opened top with
backing=mid, that's still what you get when you look at bs->options.

    base <- top
            (backing=mid)

If you now reopen top, and bdrv_reopen looks at bs->options to check
whether the operation is valid, you must specify backing=mid instead of
the correct backing=base so that reopen thinks it's unchanged.

> >> After x-blockdev-reopen is ready, 'backing' will perhaps be the
> >> first/only exception, because we'll be able to change it and the
> >> previous value doesn't matter.
> >
> > I certainly hope that it will not be the only kind of node references
> > that you can change. Adding/removing filter nodes requires to be able
> > to change more or less any kind of node references. But we'll see.
> 
> No, but anything that we allow changing has to be done on a case-by-case
> basis. You can't simply allow changing any child reference, the specific
> driver has to be modified in order to allow that.
> 
> Until the driver is changed, the current behavior prevails: if an option
> was modified, we return an error.

Makes sense to err on the safe side, though I expect that most drivers
don't need to do much more than just allowing the switch.

Maybe, if we want to keep things a bit safer, what we can do is check
that the same node is addressed when you skip all filters.

Kevin
