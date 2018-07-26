Received: from eggs.gnu.org ([2001:4830:134:3::10]:49285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fiiHI-00016I-PW
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 11:34:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fiiHH-0006Ip-L9
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 11:34:08 -0400
Date: Thu, 26 Jul 2018 17:33:56 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180726153356.GH4215@localhost.localdomain>
References: <20180726113337.23144-1-kwolf@redhat.com>
	<605ad10a-13c0-7f62-1c71-a8afe9021ee6@redhat.com>
	<20180726150655.GG4215@localhost.localdomain>
	<6cdde651-acdc-e6eb-63fc-e7efe8136710@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6cdde651-acdc-e6eb-63fc-e7efe8136710@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-3.0] file-posix: Fix write_zeroes with
 unmap on block devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, Nir Soffer <nsoffer@redhat.com>

Am 26.07.2018 um 17:23 hat Eric Blake geschrieben:
> On 07/26/2018 10:06 AM, Kevin Wolf wrote:
> 
> > > > +#ifdef CONFIG_FALLOCATE_PUNCH_HOLE
> > > > +    ret = do_fallocate(s->fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
> > > > +                       aiocb->aio_offset, aiocb->aio_nbytes);
> > > 
> > > Umm, doesn't this have to use FALLOC_FL_ZERO_RANGE? FALLOC_FL_PUNCH_HOLE
> > > deallocs, but is not required to write zeroes.
> > 
> > Yes, it is. See the man page:
> > 
> >      Specifying the FALLOC_FL_PUNCH_HOLE flag (available since Linux
> >      2.6.38) in mode deallocates space (i.e., creates a hole) in the byte
> >      range starting at offset and continuing for len bytes. Within the
> >      specified range, partial filesystem blocks are zeroed, and whole
> >      filesystem blocks are removed from the file. After a successful
> >      call, subsequent reads from this range will return zeroes.
> 
> That's true for file-system fds, but not for block device fds.

It is true for block device fds, too. Look at fs/block_dev.c,
specifically blkdev_fallocate():

        switch (mode) {
        case FALLOC_FL_ZERO_RANGE:
        case FALLOC_FL_ZERO_RANGE | FALLOC_FL_KEEP_SIZE: 
                error = blkdev_issue_zeroout(bdev, start >> 9, len >> 9,
                                            GFP_KERNEL, BLKDEV_ZERO_NOUNMAP);
                break;
        case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE: 
                error = blkdev_issue_zeroout(bdev, start >> 9, len >> 9,
                                             GFP_KERNEL, BLKDEV_ZERO_NOFALLBACK);
                break;
        case FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE | FALLOC_FL_NO_HIDE_STALE:
                error = blkdev_issue_discard(bdev, start >> 9, len >> 9,
                                             GFP_KERNEL, 0);
                break;
        default:
                return -EOPNOTSUPP;
        }

> As pointed out by Nir,
> 
> > https://patchwork.kernel.org/patch/9903757/
> Which says, among other things:
> 
> >> Do we also know that the blocks were discarded as we do with
> >> BLKDISCARD ?
> >
> > There never was a way to know for sure.
> >
> > ATA DSM TRIM and SCSI UNMAP are hints by definition. We attempted to
> > bend their semantics towards getting predictable behavior but ultimately
> > failed. Too many corner cases.
> >
> >> As I mentioned before. We relied on discard_zeroes_data in mkfs.ext4
> >> to make sure that inode tables are zeroed after discard.
> >
> > The point is that you shouldn't have an if (discard_zeroes_data)
> > conditional in the first place.
> >
> >  - If you need to dellocate a block range and you don't care about its
> >    contents in the future, use BLKDISCARD / FL_PUNCH_HOLE.
> >
> >  - If you need to zero a block range, use BLKZEROOUT / FL_ZERO_RANGE.
> 
> PUNCH_HOLE deallocates; but can only guarantee a read back of zero on file
> systems.

As far as I know, the comment you quoted is accurate for BLKDISCARD and
BLKZEROOUT, but not for the fallocate() flags.

> Hmm - that thread also mentions FALLOC_FL_NO_HIDE_STALE, which is a new flag
> not present/documented on Fedora 28. I wonder if it helps, too.
> 
> > 
> > FALLOC_FL_ZERO_RANGE in contrast implements write_zeroes without unmap.
> 
> I thought the opposite: FALLOC_FL_ZERO_RANGE guarantees that you read back
> 0, using whatever is most efficient under the hood (in the case of block
> devices, unmapping that reliably reads back as zero is favored).

See the code I quoted above, FALLOC_FL_ZERO_RANGE calls
blkdev_issue_zeroout() with BLKDEV_ZERO_NOUNMAP internally.

Kevin
