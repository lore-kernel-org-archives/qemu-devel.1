Received: from eggs.gnu.org ([2001:4830:134:3::10]:41049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1g9PlQ-0005Ye-BF
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 03:15:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1g9PlK-00041f-0S
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 03:15:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1g9PlJ-0003z3-Mp
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 03:15:29 -0400
Date: Mon, 8 Oct 2018 15:15:23 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181008071523.GI18728@xz-x1>
References: <20180905062313.4059-1-peterx@redhat.com>
	<20180905062313.4059-3-peterx@redhat.com>
	<CAJ+F1CJJB2ZyTQ3OBJ+c49bqZMWSKqfp7UOoM7QBEhH6Exnsbg@mail.gmail.com>
	<20180929040529.GQ9560@xz-x1>
	<CAJ+F1CJhXJEwkcrOqDGXjBG+m9NJG8HK0+C0vMxpQmqxWF0MYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CJhXJEwkcrOqDGXjBG+m9NJG8HK0+C0vMxpQmqxWF0MYQ@mail.gmail.com>
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

On Tue, Oct 02, 2018 at 01:13:10PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Hi Peter
>=20
> On Sat, Sep 29, 2018 at 8:05 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Fri, Sep 28, 2018 at 04:06:30PM +0400, Marc-Andr=C3=A9 Lureau wrot=
e:
> > > Hi
> > >
> > > On Wed, Sep 5, 2018 at 10:24 AM Peter Xu <peterx@redhat.com> wrote:
> > > >
> > > > Currently when QMP request queue full we won't resume the monitor=
 until
> > > > we have completely handled the current command.  It's not necessa=
ry
> > > > since even before it's handled the queue is already non-full.  Mo=
ving
> > > > the resume logic earlier before the command execution, hence drop=
 the
> > > > need_resume local variable.
> > > >
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > ---
> > > >  monitor.c | 12 +++++-------
> > > >  1 file changed, 5 insertions(+), 7 deletions(-)
> > > >
> > > > diff --git a/monitor.c b/monitor.c
> > > > index a89bb86599..c2c9853f75 100644
> > > > --- a/monitor.c
> > > > +++ b/monitor.c
> > > > @@ -4130,7 +4130,6 @@ static void monitor_qmp_bh_dispatcher(void =
*data)
> > > >  {
> > > >      QMPRequest *req_obj =3D monitor_qmp_requests_pop_any_with_lo=
ck();
> > > >      QDict *rsp;
> > > > -    bool need_resume;
> > > >      Monitor *mon;
> > > >
> > > >      if (!req_obj) {
> > > > @@ -4139,8 +4138,11 @@ static void monitor_qmp_bh_dispatcher(void=
 *data)
> > > >
> > > >      mon =3D req_obj->mon;
> > > >      /*  qmp_oob_enabled() might change after "qmp_capabilities" =
*/
> > > > -    need_resume =3D !qmp_oob_enabled(mon) ||
> > > > -        mon->qmp.qmp_requests->length =3D=3D QMP_REQ_QUEUE_LEN_M=
AX - 1;
> > > > +    if (!qmp_oob_enabled(mon) ||
> > > > +        mon->qmp.qmp_requests->length =3D=3D QMP_REQ_QUEUE_LEN_M=
AX - 1) {
> > > > +        /* Pairs with the monitor_suspend() in handle_qmp_comman=
d() */
> > > > +        monitor_resume(mon);
> > > > +    }
> > >
> > > With spice chardev, this may result in a synchronous write.
> > > If I read it right, this may re-enter handle_qmp_command and dead-l=
ock
> > > on qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
> > >
> > > So at least I would release the lock before resuming :)
> >
> > For sure this I can do. :) Though I'd like to know more context too.
> >
> > I just noticed that we added the qemu_chr_fe_accept_input() call into
> > monitor_resume() a month ago which I completely unaware of... then th=
e
> > resuming could be a heavy-weighted function now.  I'm a bit worried o=
n
> > whether this would affect the oob thing since noting that we're still
> > in the monitor iothread (which should not block for long).  Especiall=
y
> > if you mentioned that we'll handle commands again, then could we
> > potentially run non-oob command handlers in oob context here simply
> > due to the call to monitor_resume()?
>=20
> monitor_resume() is only called from main thread, afaict.

My fault on misreading on that; yes it's only called in main thread.

>=20
> So I think the problem is rather that qemu_chr_fe_accept_input() is
> not thread safe (if the same charfe is used in a different thread,
> like mon_iothread).
>=20
> So instead of simply kicking the mon_iothread, we should probably
> schedule a BH to call accept input.

Hmm, could you help explain why we need to make
qemu_chr_fe_accept_input() thread safe?  I see that's only called in
main thread as well (besides the call in monitor_resume, it's mostly
in memory region ops), or did I misread again?

Regards,

--=20
Peter Xu
