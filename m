Received: from eggs.gnu.org ([2001:4830:134:3::10]:46334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g7GkI-0006QT-8a
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 05:13:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g7GkH-0003fR-0d
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 05:13:34 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:35334)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1g7GkG-0003dD-4C
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 05:13:32 -0400
Received: by mail-wr1-x442.google.com with SMTP id w5-v6so1305621wrt.2
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 02:13:23 -0700 (PDT)
MIME-Version: 1.0
References: <20180905062313.4059-1-peterx@redhat.com>
	<20180905062313.4059-3-peterx@redhat.com>
	<CAJ+F1CJJB2ZyTQ3OBJ+c49bqZMWSKqfp7UOoM7QBEhH6Exnsbg@mail.gmail.com>
	<20180929040529.GQ9560@xz-x1>
In-Reply-To: <20180929040529.GQ9560@xz-x1>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 2 Oct 2018 13:13:10 +0400
Message-ID: <CAJ+F1CJhXJEwkcrOqDGXjBG+m9NJG8HK0+C0vMxpQmqxWF0MYQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 2/6] monitor: resume the monitor earlier
 if needed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

Hi Peter

On Sat, Sep 29, 2018 at 8:05 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Fri, Sep 28, 2018 at 04:06:30PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> >
> > On Wed, Sep 5, 2018 at 10:24 AM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > Currently when QMP request queue full we won't resume the monitor unt=
il
> > > we have completely handled the current command.  It's not necessary
> > > since even before it's handled the queue is already non-full.  Moving
> > > the resume logic earlier before the command execution, hence drop the
> > > need_resume local variable.
> > >
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  monitor.c | 12 +++++-------
> > >  1 file changed, 5 insertions(+), 7 deletions(-)
> > >
> > > diff --git a/monitor.c b/monitor.c
> > > index a89bb86599..c2c9853f75 100644
> > > --- a/monitor.c
> > > +++ b/monitor.c
> > > @@ -4130,7 +4130,6 @@ static void monitor_qmp_bh_dispatcher(void *dat=
a)
> > >  {
> > >      QMPRequest *req_obj =3D monitor_qmp_requests_pop_any_with_lock()=
;
> > >      QDict *rsp;
> > > -    bool need_resume;
> > >      Monitor *mon;
> > >
> > >      if (!req_obj) {
> > > @@ -4139,8 +4138,11 @@ static void monitor_qmp_bh_dispatcher(void *da=
ta)
> > >
> > >      mon =3D req_obj->mon;
> > >      /*  qmp_oob_enabled() might change after "qmp_capabilities" */
> > > -    need_resume =3D !qmp_oob_enabled(mon) ||
> > > -        mon->qmp.qmp_requests->length =3D=3D QMP_REQ_QUEUE_LEN_MAX -=
 1;
> > > +    if (!qmp_oob_enabled(mon) ||
> > > +        mon->qmp.qmp_requests->length =3D=3D QMP_REQ_QUEUE_LEN_MAX -=
 1) {
> > > +        /* Pairs with the monitor_suspend() in handle_qmp_command() =
*/
> > > +        monitor_resume(mon);
> > > +    }
> >
> > With spice chardev, this may result in a synchronous write.
> > If I read it right, this may re-enter handle_qmp_command and dead-lock
> > on qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
> >
> > So at least I would release the lock before resuming :)
>
> For sure this I can do. :) Though I'd like to know more context too.
>
> I just noticed that we added the qemu_chr_fe_accept_input() call into
> monitor_resume() a month ago which I completely unaware of... then the
> resuming could be a heavy-weighted function now.  I'm a bit worried on
> whether this would affect the oob thing since noting that we're still
> in the monitor iothread (which should not block for long).  Especially
> if you mentioned that we'll handle commands again, then could we
> potentially run non-oob command handlers in oob context here simply
> due to the call to monitor_resume()?

monitor_resume() is only called from main thread, afaict.

So I think the problem is rather that qemu_chr_fe_accept_input() is
not thread safe (if the same charfe is used in a different thread,
like mon_iothread).

So instead of simply kicking the mon_iothread, we should probably
schedule a BH to call accept input.

>
> I'm thinking whether we should use a QEMU bottom half or things alike
> to handle the qemu_chr_fe_accept_input(), and keep the resume and the
> stack simple.  As we seem to be facing more dead locks recently, I'm
> thinking simplifying the stack might be a nice thing to have.

Sure, if that can help :)

--=20
Marc-Andr=C3=A9 Lureau
