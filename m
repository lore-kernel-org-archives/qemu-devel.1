Received: from eggs.gnu.org ([209.51.188.92]:51587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1h0mWw-0004Oo-La
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 07:17:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1h0mWv-0006iZ-Qf
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 07:17:14 -0500
Received: from mail.ispras.ru ([83.149.199.45]:33758)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1h0mWv-0006fX-CS
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 07:17:13 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <155074704329.32129.17530905097298071558.stgit@pasha-VirtualBox>
	<155074715265.32129.1158027635780211224.stgit@pasha-VirtualBox>
	<20190304103353.GA6059@localhost.localdomain>
In-Reply-To: <20190304103353.GA6059@localhost.localdomain>
Date: Mon, 4 Mar 2019 15:17:09 +0300
Message-ID: <002b01d4d284$3109aa20$931cfe60$@ru>
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
To: 'Kevin Wolf' <kwolf@redhat.com>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, war2jordan@live.com, crosthwaite.peter@gmail.com, boost.lists@gmail.com, artem.k.pisarenko@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, mreitz@redhat.com, maria.klimushenkova@ispras.ru, kraxel@redhat.com, thomas.dullien@googlemail.com, pbonzini@redhat.com, alex.bennee@linaro.org, dgilbert@redhat.com, rth@twiddle.net

> From: Kevin Wolf [mailto:kwolf@redhat.com]
> Am 21.02.2019 um 12:05 hat Pavel Dovgalyuk geschrieben:
> > Replay is capable of recording normal BH events, but sometimes
> > there are single use callbacks scheduled with aio_bh_schedule_oneshot
> > function. This patch enables recording and replaying such callbacks.
> > Block layer uses these events for calling the completion function.
> > Replaying these calls makes the execution deterministic.
> >
> > Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> >
> > --
> >
> > v6:
> >  - moved stub function to the separate file for fixing linux-user build
> > v10:
> >  - replaced all block layer aio_bh_schedule_oneshot calls
> This still doesn't catch all instances, e.g. everything that goes
> through aio_co_schedule() is missing.

It seems, that everything else is synchronized with blkreplay driver
which is mandatory when using block devices in rr mode.

> But I fully expect this to get broken anyway all the time because nobody
> understands which function to use, and if it works for your special case
> now and we'll fix other stuff as you encouter it, maybe that's good
> enough for you.

This problem exists in every subsystem and it is ok for now, when record/replay
is not mature enough, and not familiar for others.
When virtual devices are updated, developers may miss correct loadvm/savevm
implementation. For example, loading the audio device state may miss
shift the phase of the output signal. Nobody will notice that bug
in the migration process, but it reveals when we use record/replay.

We can't cover everything with record/replay tests. Most of the new bugs
can be revealed in complex configurations after billions of executed instructions.
But when this feature will be available out of the box, we'll
at least get more smoke testing.

> 
> > @@ -1349,8 +1351,8 @@ static BlockAIOCB *blk_aio_prwv(BlockBackend *blk, int64_t offset, int
> bytes,
> >
> >      acb->has_returned = true;
> >      if (acb->rwco.ret != NOT_DONE) {
> > -        aio_bh_schedule_oneshot(blk_get_aio_context(blk),
> > -                                blk_aio_complete_bh, acb);
> > +        replay_bh_schedule_oneshot_event(blk_get_aio_context(blk),
> > +                                         blk_aio_complete_bh, acb);
> >      }
> 
> This, and a few other places that you convert, are in fast paths and add
> some calls that are unnecessary for non-replay cases.

I don't think that this can make a noticeable slowdown, but we can run
the tests if you want.
We have the test suite which performs disk-intensive computation.
It was created to measure the effect of running BH callbacks through
the virtual timer infrastructure.

> I wonder if we could make replay optional in ./configure and then make
> replay_bh_schedule_oneshot_event() a static inline function that can get
> optimised away at compile time if the feature is disabled.

It is coupled with icount. However, some icount calls are also lie on
the fast paths and are completely useless when icount is not enabled.

Pavel Dovgalyuk
