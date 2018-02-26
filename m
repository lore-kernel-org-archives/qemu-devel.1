Received: from eggs.gnu.org ([2001:4830:134:3::10]:44362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eqJPW-00064q-Kb
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 09:05:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eqJPT-0006Tr-D6
	for qemu-devel@nongnu.org; Mon, 26 Feb 2018 09:05:46 -0500
Date: Mon, 26 Feb 2018 15:05:18 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180226140518.GA5106@localhost.localdomain>
References: <20180213202701.15858-1-eblake@redhat.com>
	<20180213202701.15858-10-eblake@redhat.com>
	<20180214120525.GB4766@localhost.localdomain>
	<afb56cfd-4f42-07e5-9a65-d929b2ea9916@redhat.com>
	<20180223170525.GF3470@localhost.localdomain>
	<010d7d4e-c6d1-f8fb-8c4c-7aa0b19a94b7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <010d7d4e-c6d1-f8fb-8c4c-7aa0b19a94b7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 09/21] null: Switch to
 .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Am 24.02.2018 um 00:38 hat Eric Blake geschrieben:
> On 02/23/2018 11:05 AM, Kevin Wolf wrote:
> > Am 23.02.2018 um 17:43 hat Eric Blake geschrieben:
> > > > OFFSET_VALID | DATA might be excusable because I can see that it's
> > > > convenient that a protocol driver refers to itself as *file instead of
> > > > returning NULL there and then the offset is valid (though it would be
> > > > pointless to actually follow the file pointer), but OFFSET_VALID without
> > > > DATA probably isn't.
> > > 
> > > So OFFSET_VALID | DATA for a protocol BDS is not just convenient, but
> > > necessary to avoid breaking qemu-img map output.  But you are also right
> > > that OFFSET_VALID without data makes little sense at a protocol layer. So
> > > with that in mind, I'm auditing all of the protocol layers to make sure
> > > OFFSET_VALID ends up as something sane.
> > 
> > That's one way to look at it.
> > 
> > The other way is that qemu-img map shouldn't ask the protocol layer for
> > its offset because it already knows the offset (it is what it passes as
> > a parameter to bdrv_co_block_status).
> > 
> > Anyway, it's probably not worth changing the interface, we should just
> > make sure that the return values of the individual drivers are
> > consistent.
> 
> Yet another inconsistency, and it's making me scratch my head today.
> 
> By the way, in my byte-based stuff that is now pending on your tree, I tried
> hard to NOT change semantics or the set of flags returned by a given driver,
> and we agreed that's why you'd accept the series as-is and make me do this
> followup exercise.  But it's looking like my followups may end up touching a
> lot of the same drivers again, now that I'm looking at what the semantics
> SHOULD be (and whatever I do end up tweaking, I will at least make sure that
> iotests is still happy with it).

Hm, that's unfortunate, but I don't think we should hold up your first
series just so we can touch the drivers only once.

> First, let's read what states the NBD spec is proposing:
> 
> > It defines the following flags for the flags field:
> > 
> >     NBD_STATE_HOLE (bit 0): if set, the block represents a hole (and future writes to that area may cause fragmentation or encounter an ENOSPC error); if clear, the block is allocated or the server could not otherwise determine its status. Note that the use of NBD_CMD_TRIM is related to this status, but that the server MAY report a hole even where NBD_CMD_TRIM has not been requested, and also that a server MAY report that the block is allocated even where NBD_CMD_TRIM has been requested.
> >     NBD_STATE_ZERO (bit 1): if set, the block contents read as all zeroes; if clear, the block contents are not known. Note that the use of NBD_CMD_WRITE_ZEROES is related to this status, but that the server MAY report zeroes even where NBD_CMD_WRITE_ZEROES has not been requested, and also that a server MAY report unknown content even where NBD_CMD_WRITE_ZEROES has been requested.
> > 
> > It is not an error for a server to report that a region of the export has both NBD_STATE_HOLE set and NBD_STATE_ZERO clear. The contents of such an area are undefined, and a client reading such an area should make no assumption as to its contents or stability.
> 
> So here's how Vladimir proposed implementing it in his series (written
> before my byte-based block status stuff went in to your tree):
> https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg04038.html
> 
> Server side (3/9):
> 
> +        int ret = bdrv_block_status_above(bs, NULL, offset, tail_bytes,
> &num,
> +                                          NULL, NULL);
> +        if (ret < 0) {
> +            return ret;
> +        }
> +
> +        flags = (ret & BDRV_BLOCK_ALLOCATED ? 0 : NBD_STATE_HOLE) |
> +                (ret & BDRV_BLOCK_ZERO      ? NBD_STATE_ZERO : 0);
> 
> Client side (6/9):
> 
> +    *pnum = extent.length >> BDRV_SECTOR_BITS;
> +    return (extent.flags & NBD_STATE_HOLE ? 0 : BDRV_BLOCK_DATA) |
> +           (extent.flags & NBD_STATE_ZERO ? BDRV_BLOCK_ZERO : 0);
> 
> Does anything there strike you as odd?

Two things I noticed while reading the above:

1. NBD doesn't consider backing files, so the definition of holes
   becomes ambiguous. Is a hole any block that isn't allocated in the
   top layer (may cause fragmentation or encounter an ENOSPC error) or
   is it any block that isn't allocated anywhere in the whole backing
   chain (may read as non-zero)?

   Considering that there is a separate NBD_STATE_ZERO and nothing
   forbids a state of NBD_STATE_HOLE without NBD_STATE_ZERO, maybe the
   former is more useful. The code you quote implements the latter.

   Maybe if we go with the former, we should add a note to the NBD spec
   that explictly says that NBD_STATE_HOLE doesn't imply any specific
   content that is returned on reads.

2. Using BDRV_BLOCK_ALLOCATED to determine NBD_STATE_HOLE seems wrong. A
   (not preallocated) zero cluster in qcow2 returns BDRV_BLOCK_ALLOCATED
   (because we don't fall through to the backing file) even though I
   think it's a hole. BDRV_BLOCK_DATA should be used there (which makes
   it consistent with the other direction).

> In isolation, they seemed fine to
> me, but side-by-side, I'm scratching my head: the server queries the block
> layer, and turns BDRV_BLOCK_ALLOCATED into !NBD_STATE_HOLE; the client side
> then takes the NBD protocol and tries to turn it back into information to
> feed the block layer, where !NBD_STATE_HOLE now feeds BDRV_BLOCK_DATA.  Why
> the different choice of bits?

Which is actually consistent in the end, becaue BDRV_BLOCK_DATA implies
BDRV_BLOCK_ALLOCATED.

Essentially, assuming a simple backing chain 'base <- overlay', we got
these combinations to represent in NBD (with my suggestion of the flags
to use):

1. Cluster allocated in overlay
   a. non-zero data                         0
   b. explicit zeroes                       0 or ZERO
2. Cluster marked zero in overlay           HOLE | ZERO
3. Cluster preallocated/zero in overlay     ZERO
4. Cluster unallocated in overlay
   a. Cluster allocated in base (non-zero)  HOLE
   b. Cluster allocated in base (zero)      HOLE or HOLE | ZERO
   c. Cluster marked zero in base           HOLE | ZERO
   d. Cluster preallocated/zero in base     HOLE | ZERO
   e. Cluster unallocated in base           HOLE | ZERO

Instead of 'base' you can read 'anywhere in the backing chain' and the
flags should stay the same.

So !BDRV_BLOCK_ALLOCATED (i.e. falling through to the backing file) does
indeed imply NBD_STATE_HOLE, but so does case 2, which is just !DATA.

> Part of the story is that right now, we document that ONLY the block layer
> sets _ALLOCATED, in io.c, as a result of the driver layer returning HOLE ||
> ZERO (there are cases where the block layer can return ZERO but not
> ALLOCATED, because the driver layer returned 0 but the block layer still
> knows that area reads as zero).  So Victor's patch matches the fact that the
> driver shouldn't set ALLOCATED.  Still, if we are tying ALLOCATED to whether
> there is a hole, then that seems like information we should be getting from
> the driver, not something synthesized after we've left the driver!

Yes, I'm getting this impression, too. If your documentation says
something like "not allocated or unknown offset" (for !OFFSET_VALID),
you should probably be using one bit more to distinguish these cases.

> Then there's the question of file-posix.c: what should it return for a hole,
> ZERO|OFFSET_VALID or DATA|ZERO|OFFSET_VALID?  The wording in block.h implies
> that if DATA is not set, then the area reads as zero to the guest, but may
> have indeterminate value on the underlying file - but we KNOW that a hole in
> a POSIX file reads as 0 rather than having indeterminate value, and
> returning DATA fits the current documentation (but doing so bleeds through
> to at least 'qemu-img map --output=json' for the raw format).

The "underlying file" for the file-posix layer (i.e. the filesystem) is
a block device. A hole in a file is defined by not mapping to anywhere
on the block device, so DATA should not be set.

DATA | ZERO would mean that the block is actually allocated on the block
device, but it still reads as zero.

The thing that is inconsistent here is OFFSET_VALID and the offset
returned because the protocol layer refers to itself there instead of
referring to the "underlying file". If done consistently, it would have
to return the offset on the block device (which is useless information
in QEMU, so I suggested not to set OFFSET_VALID there at all - but we
decided that that's too much hassle for no practical benefit).

> I think we're overloading too many things into DATA (which layer of
> the chain feeds what the guest sees, and do we have a hole or is
> storage allocated for the data).

As I understand it, DATA should only be about holes (in the sense of not
being mapped to anywhere in bs->file or any other child apart from the
backing file).

Documentation does define OFFSET_VALID without DATA, though, as
preallocation. Maybe preallocation would better be expressed as DATA,
but without ALLOCATED.

> The only uses of BDRV_BLOCK_ALLOCATED are in the computation of
> bdrv_is_allocated(), in qcow2 measure, and in qemu-img compare, which all
> really do care about the semantics of "does THIS layer provide the guest
> image, or do I defer to a backing layer".  But the question NBD wants
> answered is "do I know whether there is a hole in the storage"  There are
> also relatively few clients of BDRV_BLOCK_DATA (mirror.c, qemu-img,
> bdrv_co_block_status_above), and I wonder if some of them are more worried
> about BDRV_BLOCK_ALLOCATED instead.
> 
> I'm thinking of revamping things to still keep four bits, but with new names
> and semantics as follows:
> 
> BDRV_BLOCK_LOCAL - the guest gets this portion of the file from this BDS,
> rather than the backing chain - makes sense for format drivers, pointless
> for protocol drivers

This is the old BDRV_BLOCK_ALLOCATED.

Data almost never comes from the qcow2 layer, so what this really means
is that data doesn't come from bs->backing.

> BDRV_BLOCK_ZERO - this portion of the file reads as zeroes

Same as before.

> BDRV_BLOCK_ALLOC - this portion of the file has reserved disk space

I think this is essentially what I believe BDRV_BLOCK_DATA should have
been. "Disk space" isn't clearly defined, but "there is a mapping to a
child node (except bs->backing)" seems to be close enough to what you
have in mind.

> BDRV_BLOCK_OFFSET_VALID - offset for accessing raw data

Same as before.

As I understand it, you're just renaming the existing flags. I'm not
sure if this is a good idea, especially with ALLOC(ATED), which changes
the meaning. This is pretty confusing. I suggest MAPPED as an
alternative.

> For format drivers:
> L Z A O   read as zero, returned file is zero at offset

This is not what your definition above said. ZERO is about reading from
the node itself rather than reading from bs->file.

I interpret this as: Read as zero, space is preallocated in the image
file, content in the image file is undefined.

> L - A O   read as valid from file at offset
> L Z - O   read as zero, but returned file has hole at offset

Read as zero, no mapping into bs->file, but the offset in bs->file is
valid. Doesn't make sense, OFFSET_VALID (O) should always imply
MAPPED (A).

> L - - O   preallocated at offset but reads as garbage - bug?

Again O without A - yes, a bug.

> L Z A -   read as zero, but from unknown offset with storage

And the space is preallocated in a non-backing child, though not
necessarily zeroed.

> L - A -   read as valid, but from unknown offset (including compressed,
> encrypted)
> L Z - -   read as zero, but from unknown offset with hole
> L - - -   preallocated but no offset known - bug?

No, not preallocated, because MAPPED isn't set.

This is a block that isn't mapped to a block in any child node and
doesn't read as zero. It might be the appropriate response for the null
driver with read-zeroes=off.

> - Z A O   read defers to backing layer, but protocol layer contains
> allocated zeros at offset

No. Space is preallocated for this block, but read defers to the backing
layer and we know that the backing layer provides zeros.

This is not something that a driver should return, but
it's a valid return value from bdrv_co_block_status(). One example for
this is reading from an offset that is higher than the length of the
backing file.

> - - A O   read defers to backing layer, but preallocated at offset

Yes, this one is preallocation, finally.

> - Z - O   bug
> - - - O   bug
> - Z A -   bug

Same as '- Z A O' except that the offset can't be directly accessed in
the child node (e.g. because this is an encrypted image).

> - - A -   bug

Preallocated, but reads from backing file. Offset can't be directly
accessed in the child node.

> - Z - -   bug

Read defers to backing layer and we know it will read zeros. Like for
'- Z A O', this isn't something that a driver should return, but makes
sense as a return value of bdrv_co_block_status().

> - - - -   read defers to backing layer
> 
> For protocol drivers:
> - Z A O   read as zero, offset is allocated
> - - A O   read as data, offset is allocated
> - Z - O   read as zero, offset is hole
> - - - O   bug?
> - Z A -   read as zero, but from unknown offset with storage
> - - A -   read as valid, but from unknown offset
> - Z - -   read as zero, but from unknown offset with hole
> - - - -   can't access this portion of file

Why don't you set LOCAL? It's usually true for protocol drivers that
they don't get their data from a backing file (though in theory you
could imagine a protocol driver with backing file support).

As discussed before, OFFSET_VALID doesn't really make sense here because
we don't return offsets of the image file on the block device, but we
only decided to keep it because of convenience. But if we change
everything, then this should be changed, too.

While the offset still refers to the same node for protocol drivers,
"unknown offset" doesn't make any sense. There is no mapping involved
that could be unknown. We really only have four cases for protocols.

ZERO and MAPPED make sense this way.

Not sure about 0 (or only OFFSET_VALID), could this ever be valid? You
say "can't access this portion of file", but where would this happen?

Kevin
