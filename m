Received: from eggs.gnu.org ([2001:4830:134:3::10]:44781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gSe3K-0005L7-SZ
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 03:21:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gSe3G-0007vf-T0
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 03:21:34 -0500
Received: from mail.ispras.ru ([83.149.199.45]:41638)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1gSe3G-0007u7-GJ
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 03:21:30 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20181010133333.24538.53169.stgit@pasha-VirtualBox>
	<20181010133511.24538.70006.stgit@pasha-VirtualBox>
	<20181128160141.GD4222@dhcp-200-186.str.redhat.com>
In-Reply-To: <20181128160141.GD4222@dhcp-200-186.str.redhat.com>
Date: Fri, 30 Nov 2018 11:21:30 +0300
Message-ID: <002201d48885$b2f251c0$18d6f540$@ru>
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
To: 'Kevin Wolf' <kwolf@redhat.com>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, war2jordan@live.com, mst@redhat.com, jasowang@redhat.com, zuban32s@gmail.com, kraxel@redhat.com, thomas.dullien@googlemail.com, artem.k.pisarenko@gmail.com, quintela@redhat.com, ciro.santilli@gmail.com, armbru@redhat.com, dgilbert@redhat.com, boost.lists@gmail.com, alex.bennee@linaro.org, rth@twiddle.net, crosthwaite.peter@gmail.com, mreitz@redhat.com, maria.klimushenkova@ispras.ru, pbonzini@redhat.com

> From: Kevin Wolf [mailto:kwolf@redhat.com]
> Am 10.10.2018 um 15:35 hat Pavel Dovgalyuk geschrieben:
> > Replay is capable of recording normal BH events, but sometimes
> > there are single use callbacks scheduled with aio_bh_schedule_oneshot
> > function. This patch enables recording and replaying such callbacks.
> > Block layer uses these events for calling the completion function.
> > Replaying these calls makes the execution deterministic.
> >
> > Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> 
> What are the rules for using aio_bh_schedule_oneshot() vs.
> replay_bh_schedule_oneshot_event()? You are modifying one place, but if
> I grep for aio_bh_schedule_oneshot(), I find many other places that
> use it. Why is this one place special?

This one is special, because it caused a record/replay bug.
I can't validate all other places, because I don't understand block layer
good enough.

That's why our current strategy is fixing replay, when it is breaks.
It's too hard to create the test for verifying the modification. And for the current
patch there was the bug which was fixed.

The rule is the following: when the event is asynchronous and its finalization
affects the guest state, then this event should be processed by the record/replay queue.

> 
> > --
> >
> > v6:
> >  - moved stub function to the separate file for fixing linux-user build
> > ---
> >  block/block-backend.c    |    3 ++-
> >  include/sysemu/replay.h  |    3 +++
> >  replay/replay-events.c   |   16 ++++++++++++++++
> >  replay/replay-internal.h |    1 +
> >  replay/replay.c          |    2 +-
> >  stubs/Makefile.objs      |    1 +
> >  stubs/replay-user.c      |    9 +++++++++
> >  7 files changed, 33 insertions(+), 2 deletions(-)
> >  create mode 100644 stubs/replay-user.c
> >
> > diff --git a/block/block-backend.c b/block/block-backend.c
> > index dc0cd57..04f5554 100644
> > --- a/block/block-backend.c
> > +++ b/block/block-backend.c
> > @@ -17,6 +17,7 @@
> >  #include "block/throttle-groups.h"
> >  #include "sysemu/blockdev.h"
> >  #include "sysemu/sysemu.h"
> > +#include "sysemu/replay.h"
> >  #include "qapi/error.h"
> >  #include "qapi/qapi-events-block.h"
> >  #include "qemu/id.h"
> > @@ -1379,7 +1380,7 @@ static BlockAIOCB *blk_aio_prwv(BlockBackend *blk, int64_t offset, int
> bytes,
> >
> >      acb->has_returned = true;
> >      if (acb->rwco.ret != NOT_DONE) {
> > -        aio_bh_schedule_oneshot(blk_get_aio_context(blk),
> > +        replay_bh_schedule_oneshot_event(blk_get_aio_context(blk),
> >                                  blk_aio_complete_bh, acb);
> 
> Indentation is off.

Thanks.

Pavel Dovgalyuk
