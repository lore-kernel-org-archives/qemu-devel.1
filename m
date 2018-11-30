Received: from eggs.gnu.org ([2001:4830:134:3::10]:39045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gSgoS-00020u-RM
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 06:18:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gSgoO-0001Yq-Sz
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 06:18:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1gSgoO-0001YN-Kr
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 06:18:20 -0500
Date: Fri, 30 Nov 2018 12:18:08 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181130111808.GC5106@localhost.localdomain>
References: <20181010133333.24538.53169.stgit@pasha-VirtualBox>
	<20181010133511.24538.70006.stgit@pasha-VirtualBox>
	<20181128160141.GD4222@dhcp-200-186.str.redhat.com>
	<002201d48885$b2f251c0$18d6f540$@ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002201d48885$b2f251c0$18d6f540$@ru>
Subject: Re: [Qemu-devel] [PATCH v7 17/19] replay: add BH oneshot event for
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
Cc: 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org, peter.maydell@linaro.org, war2jordan@live.com, mst@redhat.com, jasowang@redhat.com, zuban32s@gmail.com, kraxel@redhat.com, thomas.dullien@googlemail.com, artem.k.pisarenko@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, armbru@redhat.com, dgilbert@redhat.com, boost.lists@gmail.com, alex.bennee@linaro.org, rth@twiddle.net, crosthwaite.peter@gmail.com, mreitz@redhat.com, maria.klimushenkova@ispras.ru, pbonzini@redhat.com

Am 30.11.2018 um 09:21 hat Pavel Dovgalyuk geschrieben:
> > From: Kevin Wolf [mailto:kwolf@redhat.com]
> > Am 10.10.2018 um 15:35 hat Pavel Dovgalyuk geschrieben:
> > > Replay is capable of recording normal BH events, but sometimes
> > > there are single use callbacks scheduled with aio_bh_schedule_oneshot
> > > function. This patch enables recording and replaying such callbacks.
> > > Block layer uses these events for calling the completion function.
> > > Replaying these calls makes the execution deterministic.
> > >
> > > Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> > 
> > What are the rules for using aio_bh_schedule_oneshot() vs.
> > replay_bh_schedule_oneshot_event()? You are modifying one place, but if
> > I grep for aio_bh_schedule_oneshot(), I find many other places that
> > use it. Why is this one place special?
> 
> This one is special, because it caused a record/replay bug.  I can't
> validate all other places, because I don't understand block layer good
> enough.
>
> That's why our current strategy is fixing replay, when it is breaks.
> It's too hard to create the test for verifying the modification. And
> for the current patch there was the bug which was fixed.

So nobody really understands the code, but we're just fixing symptoms
whenever something crashes, without ever thinking about the design? And
then the code will organically grow to maybe approximate what we wanted
it to do?

Honestly, that's not the way to build reliable and maintainable
software.

> The rule is the following: when the event is asynchronous and its
> finalization affects the guest state, then this event should be
> processed by the record/replay queue.

Are there any BHs that can never affect the guest state?

Maybe you should really intercept this inside qemu_bh_schedule() and
aio_bh_schedule_oneshot() to catch all instances. This would look more
likely to address the root cause rather than twenty different special
cases and forgetting the other hundred instances.

But why do you even need to record and replay BHs? Aren't they already
fully deterministic if the code that schedules them is deterministic? Is
this hinting at problems in a different part of the code, so that the
caller isn't deterministic even though we expect it to be?

Kevin
