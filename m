Received: from eggs.gnu.org ([209.51.188.92]:38269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1giyfm-0004EP-JI
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 04:36:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1giyfk-0000zD-0E
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 04:36:46 -0500
Received: from mail.ispras.ru ([83.149.199.45]:60452)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1giyfj-0000y5-L3
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 04:36:43 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <154703587757.13472.3898702635363120794.stgit@pasha-VirtualBox>	<154703595509.13472.7357387659078524086.stgit@pasha-VirtualBox>
	<87wonb7eph.fsf@dusky.pond.sub.org>
In-Reply-To: <87wonb7eph.fsf@dusky.pond.sub.org>
Date: Mon, 14 Jan 2019 12:36:42 +0300
Message-ID: <000f01d4abec$a8809e60$f981db20$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [PATCH v9 13/21] replay: implement replay-seek
 command to proceed to the desired step
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Markus Armbruster' <armbru@redhat.com>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, war2jordan@live.com, pbonzini@redhat.com, crosthwaite.peter@gmail.com, ciro.santilli@gmail.com, jasowang@redhat.com, quintela@redhat.com, mreitz@redhat.com, alex.bennee@linaro.org, maria.klimushenkova@ispras.ru, mst@redhat.com, kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com, artem.k.pisarenko@gmail.com, dgilbert@redhat.com, rth@twiddle.net

> From: Markus Armbruster [mailto:armbru@redhat.com]
> Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru> writes:
> 
> > This patch adds hmp/qmp commands replay_seek/replay-seek that proceed
> > the execution to the specified step.
> > The command automatically loads nearest snapshot and replay the execution
> > to find the desired step.
> 
> "step" again.
> 
> >
> > Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
> >
> > --
> >
> > v2:
> >  - renamed replay_seek qmp command into replay-seek
> >    (suggested by Eric Blake)
> > v7:
> >  - small fixes related to Markus Armbruster's review
> > v9:
> >  - changed 'step' parameter name to 'icount'
> >  - moved json stuff to replay.json and updated the description
> >    (suggested by Markus Armbruster)
> > ---
> >  hmp-commands.hx           |   19 +++++++++
> >  hmp.h                     |    1
> >  qapi/replay.json          |   20 ++++++++++
> >  replay/replay-debugging.c |   91 +++++++++++++++++++++++++++++++++++++++++++++
> >  4 files changed, 131 insertions(+)
> >
> > diff --git a/hmp-commands.hx b/hmp-commands.hx
> > index 6d04c02..2839acc 100644
> > --- a/hmp-commands.hx
> > +++ b/hmp-commands.hx
> > @@ -1924,6 +1924,25 @@ The command is ignored when there are no replay breakpoints.
> >  ETEXI
> >
> >      {
> > +        .name       = "replay_seek",
> > +        .args_type  = "icount:i",
> > +        .params     = "icount",
> > +        .help       = "rewinds replay to the step specified by icount",
> 
> We use imperative mood in .help: "rewind".
> 
> "Rewind" suggests going backward.  The command can do that.  But it can
> also go forward.  What about:
> 
> "replay execution to the specified intruction count"
> 
> > +        .cmd        = hmp_replay_seek,
> > +    },
> > +
> > +STEXI
> > +@item replay_seek @var{icount}
> > +@findex replay_seek
> > +Automatically proceeds to the step specified by @var{icount}, when
> > +replaying the execution. The command automatically loads nearest
> > +snapshot and replay the execution to find the desired step.
> > +When there is no preceding snapshot or the execution is not replayed,
> > +then the command is ignored.
> 
> Uh, why isn't that an error?

What about this one?

Automatically proceeds to the instruction count @var{icount}, when
replaying the execution. The command automatically loads nearest
snapshot and replays the execution to find the desired instruction.
When there is no preceding snapshot or the execution is not replayed,
then the command is ignored and error message is displayed.
icount for the reference may be observed with 'info replay' command.


Pavel Dovgalyuk
