Received: from eggs.gnu.org ([2001:4830:134:3::10]:59967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1d6FwD-0002Gt-BM
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:32:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1d6FwA-0005Hl-8I
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:32:53 -0400
Received: from mail.ispras.ru ([83.149.199.45]:37744)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1d6FwA-0005HJ-0e
	for qemu-devel@nongnu.org; Thu, 04 May 2017 08:32:50 -0400
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20170504084135.7488.24715.stgit@PASHA-ISP>
	<20170504084159.7488.97487.stgit@PASHA-ISP>
	<45373040-0232-a324-5965-2a70d17e5c08@redhat.com>
In-Reply-To: <45373040-0232-a324-5965-2a70d17e5c08@redhat.com>
Date: Thu, 4 May 2017 15:32:53 +0300
Message-ID: <001001d2c4d2$8cec2c30$a6c48490$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH v9 04/10] replay: fix processing async
 events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Paolo Bonzini' <pbonzini@redhat.com>, 'Pavel Dovgalyuk' <pavel.dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, mst@redhat.com, jasowang@redhat.com, quintela@redhat.com, kraxel@redhat.com

> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> On 04/05/2017 10:41, Pavel Dovgalyuk wrote:
> > From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> >
> > Asynchronous events saved at checkpoints may invoke
> > callbacks when processed. These callbacks may also generate/read
> > new events (e.g. clock reads). Therefore event processing flag must be
> > reset before callback invocation.
> >
> > Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> > ---
> >  replay/replay-events.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/replay/replay-events.c b/replay/replay-events.c
> > index 94a6dcccfc..768b505f3d 100644
> > --- a/replay/replay-events.c
> > +++ b/replay/replay-events.c
> > @@ -295,13 +295,13 @@ void replay_read_events(int checkpoint)
> >          if (!event) {
> >              break;
> >          }
> > +        replay_finish_event();
> > +        read_event_kind = -1;
> >          replay_mutex_unlock();
> >          replay_run_event(event);
> >          replay_mutex_lock();
> >
> >          g_free(event);
> > -        replay_finish_event();
> > -        read_event_kind = -1;
> 
> While at it, g_free can be moved outside the lock.

There is no difference where to free the memory.
The only reason for unlocking and locking again is that replay_run_event may
try to read more data from the log.

> Also, replay_flush_events and replay_save_events are leaving the event
> in events_list while releasing the lock, and only doing QTAILQ_REMOVE
> after taking it back.  This can cause events to be processed twice.

How this could happen? If something will try to call replay_save_events again,
while in replay_save_events, then we'll have an infinite loop and notice it.
But it couldn't, because saving only occurs at checkpoints and there are no
recursive ones.

Pavel Dovgalyuk
