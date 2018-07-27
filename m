Received: from eggs.gnu.org ([2001:4830:134:3::10]:37365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fj477-0003w5-S8
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 10:53:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fj476-0000Ph-UX
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 10:53:05 -0400
Date: Fri, 27 Jul 2018 16:52:54 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180727145254.GE4355@localhost.localdomain>
References: <20180727033402.13513-1-famz@redhat.com>
	<20180727102938.GD4355@localhost.localdomain>
	<CAK1Eb9m2Fzs8_1Swm5Z8qbPdK=qUShX5zhZQ0Wtqx=LOBT8HnQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK1Eb9m2Fzs8_1Swm5Z8qbPdK=qUShX5zhZQ0Wtqx=LOBT8HnQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH RFC for-3.0-rc3 0/3] qemu-img: Disable copy
 offloading by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu block <qemu-block@nongnu.org>

Am 27.07.2018 um 14:14 hat Fam Zheng geschrieben:
> On Fri, Jul 27, 2018 at 6:29 PM Kevin Wolf <kwolf@redhat.com> wrote:
> >
> > Am 27.07.2018 um 05:33 hat Fam Zheng geschrieben:
> > > Kevin pointed out that both glibc and kernel provides a slow fallback of
> > > copy_file_range which hurts thin provisioning. This is particularly true for
> > > thin LVs, because host_device driver cannot get allocation info from the
> > > volume, and copy_file_range is called on every sectors, making the dst fully
> > > allocated.
> > >
> > > NFS mount points also doesn't support SEEK_DATA well, so the allocation
> > > information is unknown to QEMU.
> > >
> > > That leaves only iscsi:// which seems to do what we want so far, but it is a
> > > smaller use case.
> > >
> > > Add an option to qemu-img convert, "-C", to enable (attempting) copy offloading
> > > explicitly. And mark it incompatible with "-S" and "-c".
> >
> > Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> >
> > Not sure why you made this an RFC only, but I think we absolutely need
> > this. People are used to using 'qemu-img convert' to compact images and
> > this would regress with automatic copy offloading.
> >
> > Do you think we need more discussion?
> 
> I think merging this for 3.0 is the right thing do to.

Thanks, applied to the block branch.

> What worries me is the general usability of the feature. We could
> probably explore ideas about how we can better take advantage of copy
> offloading. I don't think counting on the user to make the right
> decision between disk efficiency (thin provisioning) and BW efficiency
> (copy offloading) will ever work.

Ultimately it is a decision that QEMU can't make, though. The user needs
to tell us at least whether they are trying to compact the image or
whether they just want to get it copied as fast as possible.

Even if we know this, of course, we may still be lacking information
about the storage to make the best decision.

> Even if we don't care about breaking the default '-S 4k' behavior, the
> lack of SEEK_DATA/SEEK_HOLE support on host NFS and block devices will
> make it very hard to use.

I hope that NFS 4.2 will gain some ground in the future. Without it,
thin provisioning with raw images on NFS is basically impossible.

I'm not aware of problems with block devices?

> Making it worse, if the network to NFS server is good enough, convert
> with pread64/pwrite64 with host page cache is also more efficient than
> copy_file_range, so we'll be slower by trying to play clever. :(

Really? I could understand not being much faster, but being actually
slower sounds wrong. Are we slower because of overhead in
copy_file_range() itself or something during preparation?

Kevin
