Received: from eggs.gnu.org ([209.51.188.92]:34899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1h1Sho-0002XV-9n
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 04:19:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1h1Shj-0001oZ-RL
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 04:19:15 -0500
Received: from mail.ispras.ru ([83.149.199.45]:36922)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1h1ShY-0001Vj-Tm
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 04:19:03 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <155074704329.32129.17530905097298071558.stgit@pasha-VirtualBox>
	<155074715265.32129.1158027635780211224.stgit@pasha-VirtualBox>
	<20190304103353.GA6059@localhost.localdomain>
	<002b01d4d284$3109aa20$931cfe60$@ru>
	<20190305095238.GB5280@dhcp-200-226.str.redhat.com>
	<000901d4d343$3750f8b0$a5f2ea10$@ru>
	<20190305111207.GE5280@dhcp-200-226.str.redhat.com>
	<001201d4d3f7$38e82db0$aab88910$@ru>
	<20190306090927.GA6818@localhost.localdomain>
In-Reply-To: <20190306090927.GA6818@localhost.localdomain>
Date: Wed, 6 Mar 2019 12:18:58 +0300
Message-ID: <001301d4d3fd$a19b1970$e4d14c50$@ru>
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
> Am 06.03.2019 um 09:33 hat Pavel Dovgalyuk geschrieben:
> > > From: Kevin Wolf [mailto:kwolf@redhat.com]
> > > Am 05.03.2019 um 12:04 hat Pavel Dovgalyuk geschrieben:
> > > > > > > > @@ -1349,8 +1351,8 @@ static BlockAIOCB *blk_aio_prwv(BlockBackend *blk, int64_t
> > > offset,
> > > > > int
> > > > > > > bytes,
> > > > > > > >
> > > > > > > >      acb->has_returned = true;
> > > > > > > >      if (acb->rwco.ret != NOT_DONE) {
> > > > > > > > -        aio_bh_schedule_oneshot(blk_get_aio_context(blk),
> > > > > > > > -                                blk_aio_complete_bh, acb);
> > > > > > > > +        replay_bh_schedule_oneshot_event(blk_get_aio_context(blk),
> > > > > > > > +                                         blk_aio_complete_bh, acb);
> > > > > > > >      }
> > > > > > >
> > > > > > > This, and a few other places that you convert, are in fast paths and add
> > > > > > > some calls that are unnecessary for non-replay cases.
> > > > > >
> > > > > > I don't think that this can make a noticeable slowdown, but we can run
> > > > > > the tests if you want.
> > > > > > We have the test suite which performs disk-intensive computation.
> > > > > > It was created to measure the effect of running BH callbacks through
> > > > > > the virtual timer infrastructure.
> > > > >
> > > > > I think this requires quite fast storage to possibly make a difference.
> > > >
> > > > True.
> > > >
> > > > > Or if you don't have that, maybe a ramdisk or even a null-co:// backend
> > > > > could do the trick. Maybe null-co:// is actually the best option.
> > > >
> > > > We've got tests with file copying and compression on qcow2 disks.
> > > > How the null backend can be applied there?
> > >
> > > With qcow2, it can't really. null-co:// would work for running something
> > > like fio directly against a virtual disk, without any image format
> > > involved. Getting the image format out of the way makes things even a
> > > little bit faster.
> > >
> > > Maybe we should run a micro-benchmark fio with null-co just in addition
> > > to your higher level tests?
> >
> > We run something like that:
> >   -drive file={},if=none,id=drv,snapshot -device ide-hd,drive=drv -drive
> > file={},if=none,id=tst,snapshot -device ide-hd,drive=tst -net none -monitor stdio --enable-
> kvm -m 2G
> >
> > I don't really get your idea. What should be added to the command line
> > to run null-co benchmark?
> 
> Something like:
> 
> -drive file=null-co://,if=none,id=null -device virtio-blk,drive=null

And this drive should be destination of the copy operations, right?

> (Testing with IDE is useless, IDE is slow, you'll never get very high
> IOPS or bandwidth with it, neither before nor after your series.)

SCSI or something else?

Pavel Dovgalyuk
