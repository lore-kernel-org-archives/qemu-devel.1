Received: from eggs.gnu.org ([2001:4830:134:3::10]:47408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpXHo-0003Pu-4F
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 07:14:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fpXHm-0006i5-Tr
	for qemu-devel@nongnu.org; Tue, 14 Aug 2018 07:14:52 -0400
Date: Tue, 14 Aug 2018 13:14:42 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180814111442.GH5025@dhcp-200-186.str.redhat.com>
References: <cover.1530270904.git.berto@igalia.com>
	<0ac388e86dec1afbff4b5e4e6ade1f1fb7b2d7ff.1530270904.git.berto@igalia.com>
	<20180814091750.GF5025@dhcp-200-186.str.redhat.com>
	<w51zhxpnrt8.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w51zhxpnrt8.fsf@maestria.local.igalia.com>
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

Am 14.08.2018 um 12:52 hat Alberto Garcia geschrieben:
> On Tue 14 Aug 2018 11:17:50 AM CEST, Kevin Wolf wrote:
> > Am 29.06.2018 um 13:37 hat Alberto Garcia geschrieben:
> >> This function returns a BDS's driver-specific options, excluding also
> >> those from its children. Since we have just removed all children
> >> options from bs->options there's no need to do this last step.
> >> 
> >> We allow references to children, though ("backing": "node0"), so those
> >> we still have to remove.
> >> 
> >> Signed-off-by: Alberto Garcia <berto@igalia.com>
> >
> > Hmm, yes, but if I compare this with the example you gave in an earlier
> > patch:
> >
> >       $ qemu-img create -f qcow2 hd0.qcow2 10M
> >       $ qemu-img create -f qcow2 -b hd0.qcow2 hd1.qcow2
> >       $ qemu-img create -f qcow2 -b hd1.qcow2 hd2.qcow2
> >
> >       $ $QEMU -drive file=hd2.qcow2,node-name=hd2,backing.node-name=hd1
> >
> >     This opens a chain of images hd0 <- hd1 <- hd2. Now let's remove hd1
> >     using block_stream:
> >
> >       (qemu) block_stream hd2 0 hd0.qcow2
> >
> >     After this hd2 contains backing.node-name=hd1, which is no longer
> >     correct because hd1 doesn't exist anymore.
> >
> > Doesn't backing=hd1 actually result in the same kind of inconsistency?
> > That is, bs->option will still have backing=hd1, but in reality we
> > reference hd0 now?
> >
> > Should we get rid of child references in bs->(explicit_)options as
> > well?
> 
> I don't think so, at least not in general.
> 
> The main difference is that if you set backing.node-name=foo then it
> means that 'node-name=foo' is an option of the child, the option doesn't
> belong in the parent at all. So once it's transferred to the child
> there's no reason why it shoud remain in the parent. It's redundant and
> can interfere with the reopen operation (e.g. you change the option in
> the child but when you reopen the parent it will try to revert the child
> option to the previous value).

That's a rather reopen-centric point of view, though.

Redundant information isn't nice already, but what really makes it a
problem is that it's potentially incorrect information because it isn't
kept up to date. There is no point in keeping incorrect information, so
I agree that deleting it is best.

> In the case of 'backing=foo' that's clearly an option of the parent,
> there's no other place to put it. We could probably remove it as well,
> but we have to see carefully that no parent needs to keep that
> information. I think we want to keep child references because in general
> we don't allow them to be changed in reopen.
> 
> Example: you cannot pass 'file=bar' on reopen unless 'bar' was already
> the existing value of 'file' (i.e. you're not changing anything). We
> need to look for the previous value in bs->options in order to know
> that.

My point is the backing=foo has the same problem: Storing it in
bs->options is not only redundant, but potentially incorrect because we
never update it when we modify the graph. There is no point in keeping
potentially incorrect information.

When you actually use that incorrect information, you've got a bug.
Reopen with file=bar doesn't have to check whether 'file=bar' is in
bs->options (because that may be outdated information), but whether the
BdrvChild with the name 'file' points to a node called 'bar'.

Getting rid of the potentially incorrect information will make it more
obvious what you have to check to make things work correctly.

> After x-blockdev-reopen is ready, 'backing' will perhaps be the
> first/only exception, because we'll be able to change it and the
> previous value doesn't matter.

I certainly hope that it will not be the only kind of node references
that you can change. Adding/removing filter nodes requires to be able to
change more or less any kind of node references. But we'll see.

Kevin
