Received: from eggs.gnu.org ([2001:4830:134:3::10]:46594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <karl.beldan@gmail.com>) id 1fAkUV-00042g-CP
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 19:03:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <karl.beldan@gmail.com>) id 1fAkUU-0007U4-2T
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 19:03:23 -0400
Date: Mon, 23 Apr 2018 23:03:05 +0000
From: Karl Beldan <karl.beldan@gmail.com>
Message-ID: <20180423230305.tw2ygcs62px3eafc@gobelin>
References: <20180423211420.6917-1-karl.beldan+oss@gmail.com>
	<adc0b504-419f-ae24-c1dc-7f303f3844f9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adc0b504-419f-ae24-c1dc-7f303f3844f9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/block/nand: Fix bad offset in
 nand_blk_load for on-drive OOB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-stable <qemu-stable@nongnu.org>

On Mon, Apr 23, 2018 at 05:14:03PM -0500, Eric Blake wrote:
> On 04/23/2018 04:14 PM, Karl Beldan wrote:
> > The logic wants 512-byte aligned blk ops.
> 
> The commit you are referencing mentions that the code permits 256, 512,
> or 2048-byte alignment, based on the configuration of the hardware it is
> emulating.  The whole file is hard to read, and I'm not surprised if
> what I thought was a patch with no semantic change didn't quite succeed.
> 
> > To switch to byte-based block accesses, the fixed commit changed the
> > blk read offset,
> > 	PAGE_START(addr) >> 9
> > with
> > 	PAGE_START(addr)
> > which min alignment, for on-drive OOB, is the min OOB size.
> > Consequently the reads are offset by PAGE_START(addr) & 0x1ff.
> 
> Do you have a call trace where a caller is passing in an addr that is
> not aligned to 512?  I agree that the old code was 512-aligned by virtue

PAGE(addr)       is ((addr) >> ADDR_SHIFT)
PAGE_START(page) is (PAGE(page) * (PAGE_SIZE + OOB_SIZE))

Take the 2nd page, i.e page 1.


> of the old interface; but the new code SHOULD be able to call into the
> block layer with whatever alignment it needs, where the block layer will
> do a larger read to satisfy block constraints, as needed (that is, if a
> caller requests a 256-byte read of a device that requires 512-alignment,
> blk_pread() will automatically widen out to a 512-byte read).
> 

Indeed the block layer handles said alignements, but then you'd have to
not add the offset twice. Keeping the logic homogenous seemed natural.


> > 
> > Fixes: 9fc0d361cc41 ("nand: Switch to byte-based block access")
> > Cc: Eric Blake <eblake@redhat.com>
> > Signed-off-by: Karl Beldan <karl.beldan+oss@gmail.com>
> 
> CC: qemu-stable@nongnu.org
> 
> > ---
> >  hw/block/nand.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/hw/block/nand.c b/hw/block/nand.c
> > index 919cb9b803..ed587f60f0 100644
> > --- a/hw/block/nand.c
> > +++ b/hw/block/nand.c
> > @@ -788,7 +788,7 @@ static void glue(nand_blk_load_, PAGE_SIZE)(NANDFlashState *s,
> >                              OOB_SIZE);
> >              s->ioaddr = s->io + SECTOR_OFFSET(s->addr) + offset;
> >          } else {
> > -            if (blk_pread(s->blk, PAGE_START(addr), s->io,
> > +            if (blk_pread(s->blk, PAGE_START(addr) & ~0x1ff, s->io,
> >                            (PAGE_SECTORS + 2) << BDRV_SECTOR_BITS) < 0) {
> 
> I don't like the magic number masking.  This should probably be written
> QEMU_ALIGN_DOWN(PAGE_START(addr), BDRV_SECTOR_SIZE).
> 

There are many other occurences in this file of said "magic" number.
In general or for ulterior "rework" of the driver everybody would agree
on this , however doing that for _this_ fix would convey another intent
as some other places in the code where this sector size mask is used,
which isn't the case, so I'd very much keep it homogenous/coherent.

> I would like to see some actual numbers from a backtrace to make sure
> we're doing this right, but my initial evaluation is done by assuming,
> for the sake of argument, that we're using a 256-byte page size (as that
> is most likely to be unaligned to a 512-byte boundary).  I see that we
> can call into nand_blk_load_256() during processing of
> NAND_CMD_RANDOMREAD2 from nand_command(), although it gets harder to
> audit without an actual call trace whether addr and offset have 512-byte
> alignments at that point.  But without analysis of whether this is an
> actual possibility, let's assume we can somehow trigger a code path that
> calls nand_blk_load_256(s, 768, 1).
> 
> Before 9fc0d361cc41, this called:
> 
>             if (blk_read(s->blk, PAGE_START(addr) >> 9,
>                          s->io, (PAGE_SECTORS + 2)) < 0) {
> 
> or, tracing macro-expansion
> 
> blk_read(s->blk, (PAGE(addr) * (PAGE_SIZE + OOB_SIZE)) >> 9,
>                   s->io, (1 + 2))
> 
> blk_read(s->blk, (((addr) >> 8) * (256 + (1 << (PAGE_SHIFT - 5)))) >> 9,
>                   s->io, (1 + 2))
> 
> blk_read(s->blk, (((addr) >> 8) * (256 + 8)) >> 9,
>                   s->io, 3)
> 
> 
> which, for our given addr of 768, results in
> blk_read(s->blk, 792 >> 9, s->io, 3)
> 
> or the 1536 bytes starting at offset 512 (which includes offset 792 that
> we are interested in).
> 
> And indeed, post-patch, it now results in trying to read 1536 bytes, but
> starting at offset 792 rather than offset 512.
> 
> So it looks like the fix is correct, once it is spelled in a more
> obvious way rather than with a magic number, and that the fact that this
> has been broken since 2.7 means that this device is not getting much
> actual testing :(
> 

Still on my initial remark wrt magic.

The pitfall becomes apparent very quickly, but only happens for on-disk
OOB, and Linux/nandsim is a hard contender.


Regards, 
Karl
