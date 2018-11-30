Received: from eggs.gnu.org ([2001:4830:134:3::10]:33542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gSgO6-00042a-Ep
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 05:51:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gSgO3-00043h-8z
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 05:51:10 -0500
Received: from mail.ispras.ru ([83.149.199.45]:57314)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gSgO2-00040L-RM
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 05:51:07 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20181010133333.24538.53169.stgit@pasha-VirtualBox>
	<20181010133357.24538.19180.stgit@pasha-VirtualBox>
	<20181128154538.GB4222@dhcp-200-186.str.redhat.com>
	<002101d48882$0905fb60$1b11f220$@ru>
	<20181130100157.GB5106@localhost.localdomain>
In-Reply-To: <20181130100157.GB5106@localhost.localdomain>
Date: Fri, 30 Nov 2018 13:51:09 +0300
Message-ID: <002301d4889a$9a5c0510$cf140f30$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH v7 04/19] replay: don't drain/flush bdrv
 queue while RR is working
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Kevin Wolf' <kwolf@redhat.com>
Cc: 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org, peter.maydell@linaro.org, war2jordan@live.com, mst@redhat.com, jasowang@redhat.com, zuban32s@gmail.com, kraxel@redhat.com, thomas.dullien@googlemail.com, artem.k.pisarenko@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, armbru@redhat.com, dgilbert@redhat.com, boost.lists@gmail.com, alex.bennee@linaro.org, rth@twiddle.net, crosthwaite.peter@gmail.com, mreitz@redhat.com, maria.klimushenkova@ispras.ru, pbonzini@redhat.com

> From: Kevin Wolf [mailto:kwolf@redhat.com]
> Am 30.11.2018 um 08:55 hat Pavel Dovgalyuk geschrieben:
> > > From: Kevin Wolf [mailto:kwolf@redhat.com]
> > > Am 10.10.2018 um 15:33 hat Pavel Dovgalyuk geschrieben:
> > > > In record/replay mode bdrv queue is controlled by replay mechanism.
> > > > It does not allow saving or loading the snapshots
> > > > when bdrv queue is not empty. Stopping the VM is not blocked by nonempty
> > > > queue, but flushing the queue is still impossible there,
> > > > because it may cause deadlocks in replay mode.
> > > > This patch disables bdrv_drain_all and bdrv_flush_all in
> > > > record/replay mode.
> > > >
> > > > Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> > >
> > > Disabling bdrv_flush_all() shouldn't make a big difference in replay
> > > mode, so I agree with that.
> > >
> > > But does the bdrv_drain_all() change mean that bdrv_drain_all_begin()
> > > can return while there are still requests in flight? This sounds like
> > > something that could break some existing code, because the meaning of
> > > the function is that if it returns success, no requests are in flight
> > > any more.
> > >
> > > What would move the request forward in the replay case once it has been
> > > created? Does this also involve some user interaction? Or may we process
> > > the next event in a drain callback of blkreplay or something?
> >
> > You are right - there are some operation that can't be performed at any
> > time during the replay, because of unfinished block requests.
> >
> > One of these is creating the VM snapshot. I've added a check in another
> > patch, which prevents snapshotting while the event queue (which holds
> > the block requests) is not empty.
> >
> > There could also be other things, that will be fixed when we try to use it.
> >
> > Moving replay forward until the queue is empty is not a good idea, because
> > step-by-step debugging should be available and work without skipping the instructions.
> 
> So if the idea is that in replay mode, bdrv_drain_all_begin() is only
> called when there are no requests in flight anyway (because callers
> catch this situation earler), can we make this an assertion that the
> block device is already quiesced?

Maybe it's behavior changed in the latest version?
We observed that bdrv_drain_all hangs, when there is a block request in
the queue. Therefore we decided that stopping with non-empty queue
is better than skipping some steps.

> Skipping drain without knowing that there are no requests in flight
> feels simply wrong, and I'm almost sure it will result in bugs. On the
> other hand, if we know that no requests are in flight, there's no real
> point in skipping.

What bugs can happen?

Pavel Dovgalyuk
