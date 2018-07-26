Received: from eggs.gnu.org ([2001:4830:134:3::10]:57775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fikhw-0003eE-Lf
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 14:09:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fikhv-0007CP-Gw
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 14:09:48 -0400
Date: Thu, 26 Jul 2018 20:09:37 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180726180937.GK4215@localhost.localdomain>
References: <20180726113337.23144-1-kwolf@redhat.com>
	<605ad10a-13c0-7f62-1c71-a8afe9021ee6@redhat.com>
	<20180726150655.GG4215@localhost.localdomain>
	<6cdde651-acdc-e6eb-63fc-e7efe8136710@redhat.com>
	<20180726153356.GH4215@localhost.localdomain>
	<9eb742d5-42c7-29da-b06f-e41873d1d645@redhat.com>
	<CAMRbyyvWsSTCfNaDJDFwqECsErJHc3=Z+SEaRea0rro95AwUgA@mail.gmail.com>
	<20180726165823.GJ4215@localhost.localdomain>
	<CAMRbyyuTtC8YUgn-GECRsV=NqUBudHte8XfkSeF2rftpf701vQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMRbyyuTtC8YUgn-GECRsV=NqUBudHte8XfkSeF2rftpf701vQ@mail.gmail.com>
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
To: Nir Soffer <nsoffer@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, pbonzini@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, Idan Shaby <ishaby@redhat.com>

Am 26.07.2018 um 19:34 hat Nir Soffer geschrieben:
> On Thu, Jul 26, 2018 at 7:58 PM Kevin Wolf <kwolf@redhat.com> wrote:
> > Am 26.07.2018 um 18:46 hat Nir Soffer geschrieben:
> > > I don't think we should depend on undocumented kernel code.
> >
> > Yes, the man page says "filesystem blocks" instead of just "blocks". If
> > you're in a nit-picking mood, that excludes block devices. But I think
> > it's pretty obvious what the intended meaning is and how it consistently
> > extends to block devices, and the code confirms it.
> >
> > That's by far not "undocumented kernel code" in my book.
> 
> Maybe it is more correct to say this is poorly documented.
> 
> The manual is very specific about supported filesystems, but there
> nothing about block devices:

Well, as specific as "_at least_ the following filesystems" can be.

>        Not all filesystems support FALLOC_FL_PUNCH_HOLE; if a filesystem
>        doesn't support the operation, an error is returned.  The operation
> is
>        supported  on  at  least  the  following filesystems:
> 
>        *  XFS (since Linux 2.6.38)
>        *  ext4 (since Linux 3.0)
>        *  Btrfs (since Linux 3.7)
>        *  tmpfs(5) (since Linux 3.5)
> 
> I expect to see something like:
> 
>     * block devices (since Linux 4.9)

Yup, the man page does need an update. But it says "at least", so
technically it's not wrong.

> Anyway this looks the same level of documentation as FALLOC_FL_ZERO_RANGE,
> so if we are ok with using it, FALLOC_FL_PUNCH_HOLE is fine.
> 
> Does this change mean that oVirt can start to enable discard for VM when
> disks are using wipe-after-delete?
> 
> Currently we disable discard if a disk is marked for wiping, since
> discard does not guarantee that discarded ranges are zeroed.

How do you wipe the disk? Does this really involve a write_zeroes
operation in qemu? But even if so, we always implemented that correctly
(modulo (mostly theoretical?) inaccuracy of BLKDISCARDZEROS in older
kernels). This patch fixes that we fall back to inefficient explicit
zero writing instead of offloading with recent kernels, but we didn't
just discard.

The explanation I've heard before from your team was that you're wiping
the disk with regular writes, but they feared that this doesn't take
effect for blocks that have previously been discarded. This is bullshit
without any basis in reality and has never been correct. When you zero
out data regions, they read as zeros, period. It doens't make any
difference whether the block had been discarded previously.

So either way, I feel like I already explained it to your team a
thousand times, but once again: Get rid of that behaviour yesterday. It
doesn't make sense and it never made sense.

Kevin
