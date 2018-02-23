Received: from eggs.gnu.org ([2001:4830:134:3::10]:51401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1epMvJ-00025W-Ar
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 18:38:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1epMvH-0002C2-Ik
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 18:38:41 -0500
References: <20180213202701.15858-1-eblake@redhat.com>
	<20180213202701.15858-10-eblake@redhat.com>
	<20180214120525.GB4766@localhost.localdomain>
	<afb56cfd-4f42-07e5-9a65-d929b2ea9916@redhat.com>
	<20180223170525.GF3470@localhost.localdomain>
From: Eric Blake <eblake@redhat.com>
Message-ID: <010d7d4e-c6d1-f8fb-8c4c-7aa0b19a94b7@redhat.com>
Date: Fri, 23 Feb 2018 17:38:16 -0600
MIME-Version: 1.0
In-Reply-To: <20180223170525.GF3470@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

On 02/23/2018 11:05 AM, Kevin Wolf wrote:
> Am 23.02.2018 um 17:43 hat Eric Blake geschrieben:
>>> OFFSET_VALID | DATA might be excusable because I can see that it's
>>> convenient that a protocol driver refers to itself as *file instead of
>>> returning NULL there and then the offset is valid (though it would be
>>> pointless to actually follow the file pointer), but OFFSET_VALID without
>>> DATA probably isn't.
>>
>> So OFFSET_VALID | DATA for a protocol BDS is not just convenient, but
>> necessary to avoid breaking qemu-img map output.  But you are also right
>> that OFFSET_VALID without data makes little sense at a protocol layer. So
>> with that in mind, I'm auditing all of the protocol layers to make sure
>> OFFSET_VALID ends up as something sane.
> 
> That's one way to look at it.
> 
> The other way is that qemu-img map shouldn't ask the protocol layer for
> its offset because it already knows the offset (it is what it passes as
> a parameter to bdrv_co_block_status).
> 
> Anyway, it's probably not worth changing the interface, we should just
> make sure that the return values of the individual drivers are
> consistent.

Yet another inconsistency, and it's making me scratch my head today.

By the way, in my byte-based stuff that is now pending on your tree, I 
tried hard to NOT change semantics or the set of flags returned by a 
given driver, and we agreed that's why you'd accept the series as-is and 
make me do this followup exercise.  But it's looking like my followups 
may end up touching a lot of the same drivers again, now that I'm 
looking at what the semantics SHOULD be (and whatever I do end up 
tweaking, I will at least make sure that iotests is still happy with it).

First, let's read what states the NBD spec is proposing:

> It defines the following flags for the flags field:
> 
>     NBD_STATE_HOLE (bit 0): if set, the block represents a hole (and future writes to that area may cause fragmentation or encounter an ENOSPC error); if clear, the block is allocated or the server could not otherwise determine its status. Note that the use of NBD_CMD_TRIM is related to this status, but that the server MAY report a hole even where NBD_CMD_TRIM has not been requested, and also that a server MAY report that the block is allocated even where NBD_CMD_TRIM has been requested.
>     NBD_STATE_ZERO (bit 1): if set, the block contents read as all zeroes; if clear, the block contents are not known. Note that the use of NBD_CMD_WRITE_ZEROES is related to this status, but that the server MAY report zeroes even where NBD_CMD_WRITE_ZEROES has not been requested, and also that a server MAY report unknown content even where NBD_CMD_WRITE_ZEROES has been requested.
> 
> It is not an error for a server to report that a region of the export has both NBD_STATE_HOLE set and NBD_STATE_ZERO clear. The contents of such an area are undefined, and a client reading such an area should make no assumption as to its contents or stability.

So here's how Vladimir proposed implementing it in his series (written 
before my byte-based block status stuff went in to your tree):
https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg04038.html

Server side (3/9):

+        int ret = bdrv_block_status_above(bs, NULL, offset, tail_bytes, 
&num,
+                                          NULL, NULL);
+        if (ret < 0) {
+            return ret;
+        }
+
+        flags = (ret & BDRV_BLOCK_ALLOCATED ? 0 : NBD_STATE_HOLE) |
+                (ret & BDRV_BLOCK_ZERO      ? NBD_STATE_ZERO : 0);

Client side (6/9):

+    *pnum = extent.length >> BDRV_SECTOR_BITS;
+    return (extent.flags & NBD_STATE_HOLE ? 0 : BDRV_BLOCK_DATA) |
+           (extent.flags & NBD_STATE_ZERO ? BDRV_BLOCK_ZERO : 0);

Does anything there strike you as odd?  In isolation, they seemed fine 
to me, but side-by-side, I'm scratching my head: the server queries the 
block layer, and turns BDRV_BLOCK_ALLOCATED into !NBD_STATE_HOLE; the 
client side then takes the NBD protocol and tries to turn it back into 
information to feed the block layer, where !NBD_STATE_HOLE now feeds 
BDRV_BLOCK_DATA.  Why the different choice of bits?

Part of the story is that right now, we document that ONLY the block 
layer sets _ALLOCATED, in io.c, as a result of the driver layer 
returning HOLE || ZERO (there are cases where the block layer can return 
ZERO but not ALLOCATED, because the driver layer returned 0 but the 
block layer still knows that area reads as zero).  So Victor's patch 
matches the fact that the driver shouldn't set ALLOCATED.  Still, if we 
are tying ALLOCATED to whether there is a hole, then that seems like 
information we should be getting from the driver, not something 
synthesized after we've left the driver!

Then there's the question of file-posix.c: what should it return for a 
hole, ZERO|OFFSET_VALID or DATA|ZERO|OFFSET_VALID?  The wording in 
block.h implies that if DATA is not set, then the area reads as zero to 
the guest, but may have indeterminate value on the underlying file - but 
we KNOW that a hole in a POSIX file reads as 0 rather than having 
indeterminate value, and returning DATA fits the current documentation 
(but doing so bleeds through to at least 'qemu-img map --output=json' 
for the raw format).  I think we're overloading too many things into 
DATA (which layer of the chain feeds what the guest sees, and do we have 
a hole or is storage allocated for the data).  The only uses of 
BDRV_BLOCK_ALLOCATED are in the computation of bdrv_is_allocated(), in 
qcow2 measure, and in qemu-img compare, which all really do care about 
the semantics of "does THIS layer provide the guest image, or do I defer 
to a backing layer".  But the question NBD wants answered is "do I know 
whether there is a hole in the storage"  There are also relatively few 
clients of BDRV_BLOCK_DATA (mirror.c, qemu-img, 
bdrv_co_block_status_above), and I wonder if some of them are more 
worried about BDRV_BLOCK_ALLOCATED instead.

I'm thinking of revamping things to still keep four bits, but with new 
names and semantics as follows:

BDRV_BLOCK_LOCAL - the guest gets this portion of the file from this 
BDS, rather than the backing chain - makes sense for format drivers, 
pointless for protocol drivers
BDRV_BLOCK_ZERO - this portion of the file reads as zeroes
BDRV_BLOCK_ALLOC - this portion of the file has reserved disk space
BDRV_BLOCK_OFFSET_VALID - offset for accessing raw data

For format drivers:
L Z A O   read as zero, returned file is zero at offset
L - A O   read as valid from file at offset
L Z - O   read as zero, but returned file has hole at offset
L - - O   preallocated at offset but reads as garbage - bug?
L Z A -   read as zero, but from unknown offset with storage
L - A -   read as valid, but from unknown offset (including compressed, 
encrypted)
L Z - -   read as zero, but from unknown offset with hole
L - - -   preallocated but no offset known - bug?
- Z A O   read defers to backing layer, but protocol layer contains 
allocated zeros at offset
- - A O   read defers to backing layer, but preallocated at offset
- Z - O   bug
- - - O   bug
- Z A -   bug
- - A -   bug
- Z - -   bug
- - - -   read defers to backing layer

For protocol drivers:
- Z A O   read as zero, offset is allocated
- - A O   read as data, offset is allocated
- Z - O   read as zero, offset is hole
- - - O   bug?
- Z A -   read as zero, but from unknown offset with storage
- - A -   read as valid, but from unknown offset
- Z - -   read as zero, but from unknown offset with hole
- - - -   can't access this portion of file

With the new bit definitions, any driver that returns RAW (necessarily 
with OFFSET_VALID) will have the block layer set LOCAL in addition to 
whatever the next layer returns (turning the protocol driver's response 
into the correct format layer response).  Protocol drivers can omit the 
callback and get the sane default of '- - A O' mapped in place (or would 
that be better as '- - A -'?). file-posix.c would return either '- - A 
O' (after SEEK_DATA) or '- Z - O' (after SEEK_HOLE).  NBD would map ZERO 
to NBD_STATE_ZERO, and ALLOC to !NBD_STATE_HOLE, in both server 
(block-layer-to-NBD-protocol) and client (NBD-protocol-to-block-layer). 
Format drivers would set LOCAL themselves (rather than the block layer 
synthesizing it).

bdrv_is_allocated will still let clients learn which layers are local 
without grabbing full mapping information, but is tied to the 
BDRV_BLOCK_LOCAL bit.  Optimizations made during mirror based on whether 
and qemu-img compare previously based on BDRV_BLOCK_ALLOCATED are now 
based on BDRV_BLOCK_LOCAL, those based on BDRV_BLOCK_DATA are now based 
on BDRV_BLOCK_ALLOC.

Thoughts?

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
