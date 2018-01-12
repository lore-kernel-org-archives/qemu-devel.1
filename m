Received: from eggs.gnu.org ([2001:4830:134:3::10]:33446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eZtdQ-0003TG-7U
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 02:20:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eZtdN-00052l-3d
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 02:20:16 -0500
Received: from mail.ispras.ru ([83.149.199.45]:34278)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eZtdM-0004wu-QV
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 02:20:13 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20180111082452.27295.85707.stgit@pasha-VirtualBox>
	<20180111082744.27295.25934.stgit@pasha-VirtualBox>
	<621213e6-91cc-908e-225f-efb898bb6747@redhat.com>
In-Reply-To: <621213e6-91cc-908e-225f-efb898bb6747@redhat.com>
Date: Fri, 12 Jan 2018 10:20:11 +0300
Message-ID: <001701d38b75$c8e80640$5ab812c0$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [RFC PATCH v3 30/30] replay: don't process async
 events when warping the clock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Paolo Bonzini' <pbonzini@redhat.com>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, boost.lists@gmail.com, quintela@redhat.com, jasowang@redhat.com, mst@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, kraxel@redhat.com, alex.bennee@linaro.org

> From: Paolo Bonzini [mailto:paolo.bonzini@gmail.com] On Behalf Of Paolo Bonzini
> On 11/01/2018 09:27, Pavel Dovgalyuk wrote:
> > Virtual clock is wapred from iothread and vcpu thread. When the hardware
> > events associated with warp checkpoint, then interrupt delivering may be
> > non-deterministic if checkpoint is processed in different threads in record
> > and replay.
> > This patch disables event processing for clock warp checkpoint and leaves
> > all hardware events to other checkpoints (e.g., virtual clock).
> >
> > Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
> > ---
> >  replay/replay.c |    7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >
> > diff --git a/replay/replay.c b/replay/replay.c
> > index b9c496a..cc43c38 100644
> > --- a/replay/replay.c
> > +++ b/replay/replay.c
> > @@ -211,7 +211,12 @@ bool replay_checkpoint(ReplayCheckpoint checkpoint)
> >      } else if (replay_mode == REPLAY_MODE_RECORD) {
> >          g_assert(replay_mutex_locked());
> >          replay_put_event(EVENT_CHECKPOINT + checkpoint);
> > -        replay_save_events(checkpoint);
> > +        /* This checkpoint belongs to several threads.
> > +           Processing events from different threads is
> > +           non-deterministic */
> > +        if (checkpoint != CHECKPOINT_CLOCK_WARP_START) {
> > +            replay_save_events(checkpoint);
> > +        }
> >          res = true;
> >      }
> >  out:
> >
> 
> Please add an assertion in replay_read_event that the read_checkpoint is
> never CHECKPOINT_CLOCK_WARP_START. 

Ok.
 
> Why is the checkpoint still needed?

Because it synchronizes the warp itself.

Pavel Dovgalyuk
