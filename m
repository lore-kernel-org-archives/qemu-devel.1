Received: from eggs.gnu.org ([2001:4830:134:3::10]:41104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gSgwj-0005ay-JM
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 06:26:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gSgwg-0005no-DP
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 06:26:57 -0500
Received: from mail.ispras.ru ([83.149.199.45]:33116)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gSgwg-0005nW-0k
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 06:26:54 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20181010133333.24538.53169.stgit@pasha-VirtualBox>
	<20181010133511.24538.70006.stgit@pasha-VirtualBox>
	<20181128160141.GD4222@dhcp-200-186.str.redhat.com>
	<002201d48885$b2f251c0$18d6f540$@ru>
	<20181130111808.GC5106@localhost.localdomain>
In-Reply-To: <20181130111808.GC5106@localhost.localdomain>
Date: Fri, 30 Nov 2018 14:26:55 +0300
Message-ID: <002401d4889f$99ba7ba0$cd2f72e0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: ru
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
To: 'Kevin Wolf' <kwolf@redhat.com>
Cc: 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org, peter.maydell@linaro.org, war2jordan@live.com, mst@redhat.com, jasowang@redhat.com, zuban32s@gmail.com, kraxel@redhat.com, thomas.dullien@googlemail.com, artem.k.pisarenko@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, armbru@redhat.com, dgilbert@redhat.com, boost.lists@gmail.com, alex.bennee@linaro.org, rth@twiddle.net, crosthwaite.peter@gmail.com, mreitz@redhat.com, maria.klimushenkova@ispras.ru, pbonzini@redhat.com

> From: Kevin Wolf [mailto:kwolf@redhat.com]
> Am 30.11.2018 um 09:21 hat Pavel Dovgalyuk geschrieben:
> > > From: Kevin Wolf [mailto:kwolf@redhat.com]
> > > Am 10.10.2018 um 15:35 hat Pavel Dovgalyuk geschrieben:
> > > > Replay is capable of recording normal BH events, but sometimes
> > > > there are single use callbacks scheduled with aio_bh_schedule_oneshot
> > > > function. This patch enables recording and replaying such callbacks.
> > > > Block layer uses these events for calling the completion function.
> > > > Replaying these calls makes the execution deterministic.
> > > >
> > > > Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> > >
> > > What are the rules for using aio_bh_schedule_oneshot() vs.
> > > replay_bh_schedule_oneshot_event()? You are modifying one place, but if
> > > I grep for aio_bh_schedule_oneshot(), I find many other places that
> > > use it. Why is this one place special?
> >
> > This one is special, because it caused a record/replay bug.  I can't
> > validate all other places, because I don't understand block layer good
> > enough.
> >
> > That's why our current strategy is fixing replay, when it is breaks.
> > It's too hard to create the test for verifying the modification. And
> > for the current patch there was the bug which was fixed.
> 
> So nobody really understands the code, but we're just fixing symptoms
> whenever something crashes, without ever thinking about the design? And
> then the code will organically grow to maybe approximate what we wanted
> it to do?
> 
> Honestly, that's not the way to build reliable and maintainable
> software.
> 
> > The rule is the following: when the event is asynchronous and its
> > finalization affects the guest state, then this event should be
> > processed by the record/replay queue.
> 
> Are there any BHs that can never affect the guest state?

For example, qemu_bh_schedule(qmp_dispatcher_bh) in handle_qmp_command.
thread-pool.c also uses BH callbacks, but they are for creating threads,
and not for modifying the replayed guest state.

> Maybe you should really intercept this inside qemu_bh_schedule() and
> aio_bh_schedule_oneshot() to catch all instances. This would look more
> likely to address the root cause rather than twenty different special
> cases and forgetting the other hundred instances.
> 
> But why do you even need to record and replay BHs? Aren't they already
> fully deterministic if the code that schedules them is deterministic? Is
> this hinting at problems in a different part of the code, so that the
> caller isn't deterministic even though we expect it to be?

BHs may be invoked at random moments, that are not related to the executed
instructions. As we replay CPU, memory, and peripheral device state, we
must replay all invocations all BHs that affect them.

Replay must be done precisely, with instruction-level granularity.
That is why we record the moment of BH invocation for matching it in
the replay phase.

Pavel Dovgalyuk
