Received: from eggs.gnu.org ([209.51.188.92]:60763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1h17sD-0002EN-LD
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 06:04:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1h17sC-00072W-L7
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 06:04:37 -0500
Received: from mail.ispras.ru ([83.149.199.45]:33060)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1h17sC-0006tT-84
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 06:04:36 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <155074704329.32129.17530905097298071558.stgit@pasha-VirtualBox>
	<155074715265.32129.1158027635780211224.stgit@pasha-VirtualBox>
	<20190304103353.GA6059@localhost.localdomain>
	<002b01d4d284$3109aa20$931cfe60$@ru>
	<20190305095238.GB5280@dhcp-200-226.str.redhat.com>
In-Reply-To: <20190305095238.GB5280@dhcp-200-226.str.redhat.com>
Date: Tue, 5 Mar 2019 14:04:33 +0300
Message-ID: <000901d4d343$3750f8b0$a5f2ea10$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: ru
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
To: 'Kevin Wolf' <kwolf@redhat.com>
Cc: 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, artem.k.pisarenko@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, mreitz@redhat.com, maria.klimushenkova@ispras.ru, kraxel@redhat.com, thomas.dullien@googlemail.com, pbonzini@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

> From: Kevin Wolf [mailto:kwolf@redhat.com]
> Am 04.03.2019 um 13:17 hat Pavel Dovgalyuk geschrieben:
> > > From: Kevin Wolf [mailto:kwolf@redhat.com]
> > > Am 21.02.2019 um 12:05 hat Pavel Dovgalyuk geschrieben:
> > > > Replay is capable of recording normal BH events, but sometimes
> > > > there are single use callbacks scheduled with aio_bh_schedule_oneshot
> > > > function. This patch enables recording and replaying such callbacks.
> > > > Block layer uses these events for calling the completion function.
> > > > Replaying these calls makes the execution deterministic.
> > > >
> > > > Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> > > >
> > > > --
> > > >
> > > > v6:
> > > >  - moved stub function to the separate file for fixing linux-user build
> > > > v10:
> > > >  - replaced all block layer aio_bh_schedule_oneshot calls
> > > This still doesn't catch all instances, e.g. everything that goes
> > > through aio_co_schedule() is missing.
> >
> > It seems, that everything else is synchronized with blkreplay driver
> > which is mandatory when using block devices in rr mode.
> 
> Ah, yes, this is a good point. blkreplay goes through
> replay_block_event(), which is where things get synchronised, right?

Right.

> Does this mean that most of the places where you replaced a BH with your
> new function don't actually need it either because they are called
> through blkreplay and will go through replay_block_event() before
> reaching the guest?

I'm not sure, maybe some of them are going through the blkreplay driver.

> > > > @@ -1349,8 +1351,8 @@ static BlockAIOCB *blk_aio_prwv(BlockBackend *blk, int64_t offset,
> int
> > > bytes,
> > > >
> > > >      acb->has_returned = true;
> > > >      if (acb->rwco.ret != NOT_DONE) {
> > > > -        aio_bh_schedule_oneshot(blk_get_aio_context(blk),
> > > > -                                blk_aio_complete_bh, acb);
> > > > +        replay_bh_schedule_oneshot_event(blk_get_aio_context(blk),
> > > > +                                         blk_aio_complete_bh, acb);
> > > >      }
> > >
> > > This, and a few other places that you convert, are in fast paths and add
> > > some calls that are unnecessary for non-replay cases.
> >
> > I don't think that this can make a noticeable slowdown, but we can run
> > the tests if you want.
> > We have the test suite which performs disk-intensive computation.
> > It was created to measure the effect of running BH callbacks through
> > the virtual timer infrastructure.
> 
> I think this requires quite fast storage to possibly make a difference.

True.

> Or if you don't have that, maybe a ramdisk or even a null-co:// backend
> could do the trick. Maybe null-co:// is actually the best option.

We've got tests with file copying and compression on qcow2 disks.
How the null backend can be applied there?

> Anyway, if it's not too much work for you, running some tests would be
> good.
> 
> > > I wonder if we could make replay optional in ./configure and then make
> > > replay_bh_schedule_oneshot_event() a static inline function that can get
> > > optimised away at compile time if the feature is disabled.
> >
> > It is coupled with icount. However, some icount calls are also lie on
> > the fast paths and are completely useless when icount is not enabled.
> 
> Well, the common fast path is KVM, which doesn't have icount at all, so
> that might make it less critical. :-)

I see.

> I get your point, though maybe that just means that both should be
> possible to be disabled at configure time.

Right, it may be reasonable for some TCG use cases.
This could be a separate patch set, because everything changes.

Pavel Dovgalyuk
