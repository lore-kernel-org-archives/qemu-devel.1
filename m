Received: from eggs.gnu.org ([2001:4830:134:3::10]:38814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eKo4w-0007kl-Od
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:23:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eKo3w-0004yg-4s
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:22:18 -0500
Date: Fri, 1 Dec 2017 13:41:31 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171201124131.GD4147@localhost.localdomain>
References: <20171130164401.29221-1-kwolf@redhat.com>
	<ce174622-1df0-bf86-452e-280dd3f7e068@redhat.com>
	<20171130182746.GF4039@localhost.localdomain>
	<cb98da75-ca77-edce-6384-d612380e4e3c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb98da75-ca77-edce-6384-d612380e4e3c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] block: Formats don't need CONSISTENT_READ
 with NO_IO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com

Am 30.11.2017 um 20:05 hat Eric Blake geschrieben:
> On 11/30/2017 12:27 PM, Kevin Wolf wrote:
> > > > @@ -1936,7 +1938,9 @@ void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
> > > >            /* bs->file always needs to be consistent because of the metadata. We
> > > >             * can never allow other users to resize or write to it. */
> > > > -        perm |= BLK_PERM_CONSISTENT_READ;
> > > > +        if (!(flags & BDRV_O_NO_IO)) {
> > > > +            perm |= BLK_PERM_CONSISTENT_READ;
> > > 
> > > I thought BDRV_O_NO_IO only means we aren't doing I/O on guest-visible data,
> > > but doesn't stop us from reading the metadata.  The comment is telling: if
> > > we can read metadata, then we depend on CONSISTENT_READ for the metadata to
> > > be stable (even if we don't care about guest data consistency).
> > 
> > Yes and no. The trouble is that at the file system level we have only a
> > single bit to describe the consistency of the whole image throughout the
> > whole block driver tree.
> > 
> > We forbid shared BLK_PERM_CONSISTENT_READ for mirror targets (which
> > aren't fully populated yet) and intermediate nodes for commit (which
> > expose corrupted data). Both scenarios are really about the data exposed
> > at the format layer, the metadata stays completely consistent.
> 
> I guess it is the block of writes/resizes that prevents metadata from
> getting inconsistent; CONSISTENT_READ does indeed make more sense if
> interpreted solely in light of will the guest read consistent data
> (and not will the format layer see consistent contents from the
> protocol layer).

Yes, that's what the write/resize locks are meant for.

Consistent read is more about "this image may not contain the useful
data you're expecting".

> > The question is what we do with this as we propagate permissions down to
> > the protocol layer. Strictly speaking, the file at the protocol layer is
> > perfectly consistent, so we might not forbid BLK_PERM_CONSISTENT_READ
> > there. But I think it's more useful to do it anyway so that image
> > locking can prevent the typical case of another process that uses qcow2
> > over file-posix again, where the file-posix node could in theory be
> > considered consistent, but the qcow2 one wouldn't.
> 
> Does that mean we need two separate permission bits, one for whether
> the guest-visible data is consistent, and one for whether the metadata
> is consistent? But as I mentioned above, blocking writes should mean
> that no one else is messing with metadata.

Even this works only in the simple case of format over protocol.

I think this becomes pretty clear when you think of the (admittedly
unlikely) case of nested qcow2. Then you need at least a bit per layer,
one for the guest-visible data, one for the top-level qcow2 metadata and
another one for the second qcow2 metadata.

> > In the end, this is just a pragmatic way to let 'qemu-img info' work
> > while the image is a mirror target or intermediate node for commit, but
> > to forbid cases where corrupted data is used.
> > 
> > Or would you argue that either 'qemu-img info' shouldn't be working or
> > reading corrupted data should be allowed in other processes?
> 
> Having qemu-img info work on a mirror target makes sense; as you pointed
> out, the metadata flushed to disk is consistent (may have leaked clusters,
> but not broken image) at any given point by the writer (it has to be, since
> the writer has to be able to recover the image if there is an abrupt
> restart).

Exactly, that's the reasoning.

> And a second reader can still manage to see inconsistent data
> when reading two separate clusters if the timing is just right, regardless
> of whether the first writer is always able to see consistent data.  So to
> some extent, it's a measure of how risky is the action? qemu-img info is
> read-only, and most of the time will just work; it is very hard to get to
> the rare race condition where two consecutive reads raced with a parallel
> writer combine to result in incorrect interpretation of the data by the
> reader.

This again is more about the write permission. You still need 'qemu-img
info -U' because there is a concurrent writer, so you have to
acknowledge the risk you're mentioning.

> I'm not opposed to your patch, but am trying to make sure that I'm not
> overlooking any problem before giving R-b.  Maybe it's just that the
> comment needs updating in v2.

Do you have a suggestion for the comment?

Kevin
