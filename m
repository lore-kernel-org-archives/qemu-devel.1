Received: from eggs.gnu.org ([2001:4830:134:3::10]:48704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cZJEr-0000qT-Up
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:24:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1cZJEq-0003kZ-KC
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:23:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1cZJEq-0003kI-Bx
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 10:23:56 -0500
References: <20170202123045.GA24714@chaz.gmail.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <8ec657d7-3f46-1caa-9961-7127b0d99e12@redhat.com>
Date: Thu, 2 Feb 2017 16:23:53 +0100
MIME-Version: 1.0
In-Reply-To: <20170202123045.GA24714@chaz.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qcow2] how to avoid qemu doing
 lseek(SEEK_DATA/SEEK_HOLE)?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stephane Chazelas <stephane.chazelas@gmail.com>
Cc: qemu-devel@nongnu.org

On 02/02/17 13:30, Stephane Chazelas wrote:
> Hello,
> 
> since qemu-2.7.0, doing synchronised I/O in a VM (tested with
> Ubuntu 16.04 amd64 VM)  while the disk is backed by a qcow2
> file sitting on a ZFS filesystem (zfs on Linux on Debian jessie
> (PVE)), the performances are dreadful:
> 
> # time dd if=/dev/zero count=1000  of=b oflag=dsync
> 1000+0 records in
> 1000+0 records out
> 512000 bytes (512 kB, 500 KiB) copied, 21.9908 s, 23.3 kB/s
> dd if=/dev/zero count=1000 of=b oflag=dsync  0.00s user 0.04s system 0% cpu 21.992 total
> 
> (22 seconds to write that half megabyte). Same with O_SYNC or
> O_DIRECT, or doing fsync() or sync_file_range() after each
> write().
> 
> I first noticed it for dpkg unpacking kernel headers where dpkg
> does a sync_file_range() after each file is extracted.
> 
> Note that it doesn't happen when writing anything else than
> zeroes (like tr '\0' x < /dev/zero | dd count=1000  of=b
> oflag=dsync). In the case of the kernel headers, I suppose the
> zeroes come from the non-filled parts of the ext4 blocks.
> 
> Doing strace -fc on the qemu process, 98% of the time is spent
> in the lseek() system call.
> 
> That's the lseek(SEEK_DATA) followed by lseek(SEEK_HOLE) done by
> find_allocation() called to find out whether sectors are within
> a hole in a sparse file.
> 
> #0  lseek64 () at ../sysdeps/unix/syscall-template.S:81
> #1  0x0000561287cf4ca8 in find_allocation (bs=0x7fd898d70000, hole=<synthetic pointer>, data=<synthetic pointer>, start=<optimized out>)
>     at block/raw-posix.c:1702
> #2  raw_co_get_block_status (bs=0x7fd898d70000, sector_num=<optimized out>, nb_sectors=40, pnum=0x7fd80dd05aac, file=0x7fd80dd05ab0) at block/raw-posix.c:1765
> #3  0x0000561287cfae92 in bdrv_co_get_block_status (bs=0x7fd898d70000, sector_num=sector_num@entry=1303680, nb_sectors=40, pnum=pnum@entry=0x7fd80dd05aac,
>     file=file@entry=0x7fd80dd05ab0) at block/io.c:1709
> #4  0x0000561287cfafaa in bdrv_co_get_block_status (bs=bs@entry=0x7fd898d66000, sector_num=sector_num@entry=33974144, nb_sectors=<optimized out>,
>     nb_sectors@entry=40, pnum=pnum@entry=0x7fd80dd05bbc, file=file@entry=0x7fd80dd05bc0) at block/io.c:1742
> #5  0x0000561287cfb0bb in bdrv_co_get_block_status_above (file=0x7fd80dd05bc0, pnum=0x7fd80dd05bbc, nb_sectors=40, sector_num=33974144, base=0x0,
>     bs=<optimized out>) at block/io.c:1776
> #6  bdrv_get_block_status_above_co_entry (opaque=opaque@entry=0x7fd80dd05b40) at block/io.c:1792
> #7  0x0000561287cfae08 in bdrv_get_block_status_above (bs=0x7fd898d66000, base=base@entry=0x0, sector_num=<optimized out>, nb_sectors=nb_sectors@entry=40,
>     pnum=pnum@entry=0x7fd80dd05bbc, file=file@entry=0x7fd80dd05bc0) at block/io.c:1824
> #8  0x0000561287cd372d in is_zero_sectors (bs=<optimized out>, start=<optimized out>, count=40) at block/qcow2.c:2428
> #9  0x0000561287cd38ed in is_zero_sectors (count=<optimized out>, start=<optimized out>, bs=<optimized out>) at block/qcow2.c:2471
> #10 qcow2_co_pwrite_zeroes (bs=0x7fd898d66000, offset=33974144, count=24576, flags=2724114573) at block/qcow2.c:2452
> #11 0x0000561287cfcb7f in bdrv_co_do_pwrite_zeroes (bs=bs@entry=0x7fd898d66000, offset=offset@entry=17394782208, count=count@entry=4096,
>     flags=flags@entry=BDRV_REQ_ZERO_WRITE) at block/io.c:1218
> #12 0x0000561287cfd0cb in bdrv_aligned_pwritev (bs=0x7fd898d66000, req=<optimized out>, offset=17394782208, bytes=4096, align=1, qiov=0x0,
>     flags=<optimized out>) at block/io.c:1320
> #13 0x0000561287cfe450 in bdrv_co_do_zero_pwritev (req=<optimized out>, flags=<optimized out>, bytes=<optimized out>, offset=<optimized out>,
>     bs=<optimized out>) at block/io.c:1422
> #14 bdrv_co_pwritev (child=0x15, offset=17394782208, bytes=4096, qiov=0x7fd8a25eb08d <lseek64+45>, qiov@entry=0x0, flags=231758512) at block/io.c:1492
> #15 0x0000561287cefdc7 in blk_co_pwritev (blk=0x7fd898cad540, offset=17394782208, bytes=4096, qiov=0x0, flags=<optimized out>) at block/block-backend.c:788
> #16 0x0000561287cefeeb in blk_aio_write_entry (opaque=0x7fd812941440) at block/block-backend.c:982
> #17 0x0000561287d67c7a in coroutine_trampoline (i0=<optimized out>, i1=<optimized out>) at util/coroutine-ucontext.c:78
> 
> Now, performance is really bad on ZFS for those lseek().
> I believe that's https://github.com/zfsonlinux/zfs/issues/4306
> 
> Until that's fixed in ZFS, I need to find a way to avoid those
> lseek()s in the first place.
> 
> One way is to downgrade to 2.6.2 where those lseek()s are not
> called. The change that introduced them seems to be:
> 
> https://github.com/qemu/qemu/commit/2928abce6d1d426d37c0a9bd5f85fb95cf33f709
> (and there have been further changes to improve it later).
> 
> If I understand correctly, that change was about preventing data
> from being allocated when the user is writing unaligned zeroes.
> 
> I suppose the idea is that if something is trying to write
> zeroes in the middle of an _allocated_ qcow2 cluster, but the
> corresponding sectors in the file underneath are in a hole, we
> don't want to write those zeros as that would allocate the data
> at the file level.
> 
> I can see it makes sense, but in my case, the little space
> efficiency it brings is largely overshadowed by the sharp
> decrease in performance.
> 
> For now, I work around it by changing the "#ifdef SEEK_DATA"
> to "#if 0" in find_allocation().
> 
> Note that passing detect-zeroes=off or detect-zeroes=unmap (with
> discard) doesn't help (even though FALLOC_FL_PUNCH_HOLE is
> supported on ZFS on Linux).
> 
> Is there any other way I could use to prevent those lseek()s
> without having to rebuild qemu?

My suggestion will likely be incredibly lame, but let's hope it at least
directs some attention to your query.

You didn't mention what qcow2 features you use -- vmstate, snapshots,
backing files (chains of them), compression?

Since commit 2928abce6d1d only modifies "block/qcow2.c", you could
switch / convert the images to "raw". "raw" still benefits from sparse
files (which ZFS-on-Linux apparently supports). Sparse files (i.e., the
disk space savings) are the most important feature to me at least.

Thanks (and sorry again about the lame idea... you likely have good
reasons for qcow2...)
Laszlo

> 
> Would you consider adding an option to disable that behaviour
> (skip checking allocation at file level for qcow2 image)?
> 
> Thanks,
> Stephane
> 
> 
