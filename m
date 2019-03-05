Received: from eggs.gnu.org ([209.51.188.92]:38771)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h18JC-0005lo-5J
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 06:32:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h187j-0008IW-Vp
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 06:20:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1h187j-00083u-M0
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 06:20:39 -0500
Date: Tue, 5 Mar 2019 12:12:07 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190305111207.GE5280@dhcp-200-226.str.redhat.com>
References: <155074704329.32129.17530905097298071558.stgit@pasha-VirtualBox>
	<155074715265.32129.1158027635780211224.stgit@pasha-VirtualBox>
	<20190304103353.GA6059@localhost.localdomain>
	<002b01d4d284$3109aa20$931cfe60$@ru>
	<20190305095238.GB5280@dhcp-200-226.str.redhat.com>
	<000901d4d343$3750f8b0$a5f2ea10$@ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000901d4d343$3750f8b0$a5f2ea10$@ru>
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

Am 05.03.2019 um 12:04 hat Pavel Dovgalyuk geschrieben:
> > > > > @@ -1349,8 +1351,8 @@ static BlockAIOCB *blk_aio_prwv(BlockBackend *blk, int64_t offset,
> > int
> > > > bytes,
> > > > >
> > > > >      acb->has_returned = true;
> > > > >      if (acb->rwco.ret != NOT_DONE) {
> > > > > -        aio_bh_schedule_oneshot(blk_get_aio_context(blk),
> > > > > -                                blk_aio_complete_bh, acb);
> > > > > +        replay_bh_schedule_oneshot_event(blk_get_aio_context(blk),
> > > > > +                                         blk_aio_complete_bh, acb);
> > > > >      }
> > > >
> > > > This, and a few other places that you convert, are in fast paths and add
> > > > some calls that are unnecessary for non-replay cases.
> > >
> > > I don't think that this can make a noticeable slowdown, but we can run
> > > the tests if you want.
> > > We have the test suite which performs disk-intensive computation.
> > > It was created to measure the effect of running BH callbacks through
> > > the virtual timer infrastructure.
> > 
> > I think this requires quite fast storage to possibly make a difference.
> 
> True.
> 
> > Or if you don't have that, maybe a ramdisk or even a null-co:// backend
> > could do the trick. Maybe null-co:// is actually the best option.
> 
> We've got tests with file copying and compression on qcow2 disks.
> How the null backend can be applied there?

With qcow2, it can't really. null-co:// would work for running something
like fio directly against a virtual disk, without any image format
involved. Getting the image format out of the way makes things even a
little bit faster.

Maybe we should run a micro-benchmark fio with null-co just in addition
to your higher level tests?

> > Anyway, if it's not too much work for you, running some tests would be
> > good.
> > 
> > > > I wonder if we could make replay optional in ./configure and then make
> > > > replay_bh_schedule_oneshot_event() a static inline function that can get
> > > > optimised away at compile time if the feature is disabled.
> > >
> > > It is coupled with icount. However, some icount calls are also lie on
> > > the fast paths and are completely useless when icount is not enabled.
> > 
> > Well, the common fast path is KVM, which doesn't have icount at all, so
> > that might make it less critical. :-)
> 
> I see.
> 
> > I get your point, though maybe that just means that both should be
> > possible to be disabled at configure time.
> 
> Right, it may be reasonable for some TCG use cases.
> This could be a separate patch set, because everything changes.

Yes, I agree.

Kevin
