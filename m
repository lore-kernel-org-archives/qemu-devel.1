Received: from eggs.gnu.org ([209.51.188.92]:56149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h1Trn-0004CI-Nj
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:33:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h1Trm-0000R2-69
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:33:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53378)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1h1Trl-0000Mk-Ri
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 05:33:38 -0500
Date: Wed, 6 Mar 2019 11:33:24 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190306103324.GD6818@localhost.localdomain>
References: <20190304103353.GA6059@localhost.localdomain>
	<002b01d4d284$3109aa20$931cfe60$@ru>
	<20190305095238.GB5280@dhcp-200-226.str.redhat.com>
	<000901d4d343$3750f8b0$a5f2ea10$@ru>
	<20190305111207.GE5280@dhcp-200-226.str.redhat.com>
	<001201d4d3f7$38e82db0$aab88910$@ru>
	<20190306090927.GA6818@localhost.localdomain>
	<001301d4d3fd$a19b1970$e4d14c50$@ru>
	<20190306092951.GB6818@localhost.localdomain>
	<001401d4d400$2e22fb40$8a68f1c0$@ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001401d4d400$2e22fb40$8a68f1c0$@ru>
Subject: Re: [Qemu-devel] [PATCH v13 19/25] replay: add BH oneshot event for
 block layer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Cc: 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, artem.k.pisarenko@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, mreitz@redhat.com, maria.klimushenkova@ispras.ru, kraxel@redhat.com, thomas.dullien@googlemail.com, pbonzini@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

Am 06.03.2019 um 10:37 hat Pavel Dovgalyuk geschrieben:
> > From: Kevin Wolf [mailto:kwolf@redhat.com]
> > Am 06.03.2019 um 10:18 hat Pavel Dovgalyuk geschrieben:
> > > > From: Kevin Wolf [mailto:kwolf@redhat.com]
> > > > Am 06.03.2019 um 09:33 hat Pavel Dovgalyuk geschrieben:
> > > > > > From: Kevin Wolf [mailto:kwolf@redhat.com]
> > > > > > Am 05.03.2019 um 12:04 hat Pavel Dovgalyuk geschrieben:
> > > > > > > > > > > @@ -1349,8 +1351,8 @@ static BlockAIOCB *blk_aio_prwv(BlockBackend *blk,
> > int64_t
> > > > > > offset,
> > > > > > > > int
> > > > > > > > > > bytes,
> > > > > > > > > > >
> > > > > > > > > > >      acb->has_returned = true;
> > > > > > > > > > >      if (acb->rwco.ret != NOT_DONE) {
> > > > > > > > > > > -        aio_bh_schedule_oneshot(blk_get_aio_context(blk),
> > > > > > > > > > > -                                blk_aio_complete_bh, acb);
> > > > > > > > > > > +        replay_bh_schedule_oneshot_event(blk_get_aio_context(blk),
> > > > > > > > > > > +                                         blk_aio_complete_bh, acb);
> > > > > > > > > > >      }
> > > > > > > > > >
> > > > > > > > > > This, and a few other places that you convert, are in fast paths and add
> > > > > > > > > > some calls that are unnecessary for non-replay cases.
> > > > > > > > >
> > > > > > > > > I don't think that this can make a noticeable slowdown, but we can run
> > > > > > > > > the tests if you want.
> > > > > > > > > We have the test suite which performs disk-intensive computation.
> > > > > > > > > It was created to measure the effect of running BH callbacks through
> > > > > > > > > the virtual timer infrastructure.
> > > > > > > >
> > > > > > > > I think this requires quite fast storage to possibly make a difference.
> > > > > > >
> > > > > > > True.
> > > > > > >
> > > > > > > > Or if you don't have that, maybe a ramdisk or even a null-co:// backend
> > > > > > > > could do the trick. Maybe null-co:// is actually the best option.
> > > > > > >
> > > > > > > We've got tests with file copying and compression on qcow2 disks.
> > > > > > > How the null backend can be applied there?
> > > > > >
> > > > > > With qcow2, it can't really. null-co:// would work for running something
> > > > > > like fio directly against a virtual disk, without any image format
> > > > > > involved. Getting the image format out of the way makes things even a
> > > > > > little bit faster.
> > > > > >
> > > > > > Maybe we should run a micro-benchmark fio with null-co just in addition
> > > > > > to your higher level tests?
> > > > >
> > > > > We run something like that:
> > > > >   -drive file={},if=none,id=drv,snapshot -device ide-hd,drive=drv -drive
> > > > > file={},if=none,id=tst,snapshot -device ide-hd,drive=tst -net none -monitor stdio --
> > enable-
> > > > kvm -m 2G
> > > > >
> > > > > I don't really get your idea. What should be added to the command line
> > > > > to run null-co benchmark?
> > > >
> > > > Something like:
> > > >
> > > > -drive file=null-co://,if=none,id=null -device virtio-blk,drive=null
> > >
> > > And this drive should be destination of the copy operations, right?
> > 
> > I don't know your exact benchmark, but this drive should be where the
> > high I/O rates are, yes.
> 
> Ok.
> 
> > For getting meaningful numbers, you should have I/O only on the fast
> > test disk (you're talking about a copy, where is source?), 
> 
> We used a qcow2 image as a source.

So the source is going to slow down the I/O and you won't actually test
whether the possible maximum changes.

> > you should
> > use direct I/O to get the page cache of the guest out of the way, and
> > you should make sure that multiple requests are issued in parallel.
> 
> Is this possible, if we have only conventional HDDs?

null-co:// doesn't access your disk at all, so if this is the only
virtual disk that has I/O, the conventional HDD doesn't hurt. But you're
right that you probably can't use your physical disk for high
performance benchmarks then.

I'm going to suggest once more to use fio for storage testing. Actually,
maybe I can find the time to do this myself on my system, too.

But anyway, I think it's good if you're at least aware that the test you
used so far was a low-performance test where any possible performance
degradations would be dwarved by both the slow physical disk and the
slow IDE interface to communicate with the guest (which also enforces to
have only one request at the same time).

Kevin
