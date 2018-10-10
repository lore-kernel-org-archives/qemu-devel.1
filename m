Received: from eggs.gnu.org ([2001:4830:134:3::10]:60556)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gA54d-0006ET-7m
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 23:22:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gA54Z-0001Ng-Rt
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 23:22:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58184)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gA54Z-0001NM-K2
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 23:22:07 -0400
Date: Wed, 10 Oct 2018 11:21:55 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181010032154.GL18728@xz-x1>
References: <20181009062718.1914-1-peterx@redhat.com>
	<20181009062718.1914-3-peterx@redhat.com>
	<CAJ+F1CJwK4cC5xXviefrOFiQCcrP7fsrDwx2E9mZSg_UtFPXrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CJwK4cC5xXviefrOFiQCcrP7fsrDwx2E9mZSg_UtFPXrA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v9 2/6] monitor: resume the monitor earlier
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

On Tue, Oct 09, 2018 at 12:54:37PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Hi
> On Tue, Oct 9, 2018 at 10:28 AM Peter Xu <peterx@redhat.com> wrote:
> >
> > Currently when QMP request queue full we won't resume the monitor unt=
il
> > we have completely handled the current command.  It's not necessary
> > since even before it's handled the queue is already non-full.  Moving
> > the resume logic earlier before the command execution.
> >
> > Note that now monitor_resume() is heavy weighted after 8af6bb14a3a8 a=
nd
> > it's even possible (as pointed out by Marc-Andr=C3=A9) that the funct=
ion
> > itself may try to take the monitor lock again, so let's do the resume
> > after the monitor lock is released to avoid possible dead lock.
> >
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  monitor.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/monitor.c b/monitor.c
> > index 1f83775fff..f5911399d8 100644
> > --- a/monitor.c
> > +++ b/monitor.c
> > @@ -4149,6 +4149,12 @@ static void monitor_qmp_bh_dispatcher(void *da=
ta)
> >      need_resume =3D !qmp_oob_enabled(mon) ||
> >          mon->qmp.qmp_requests->length =3D=3D QMP_REQ_QUEUE_LEN_MAX -=
 1;
> >      qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
> > +
> > +    if (need_resume) {
> > +        /* Pairs with the monitor_suspend() in handle_qmp_command() =
*/
> > +        monitor_resume(mon);
> > +    }
>=20
> "need_resume" is only set on non-oob enabled monitors.

... or on oob-enabled monitors when queue full?

>=20
> On monitor_resume(), monitor_qmp_read() may end up being called, which
> may call handle_qmp_command().
>=20
> With regular commands, a new command is queued. But if the command is
> "exec-oob", it will dispatch immediately, thus not following the QMP
> reply ordering constrain.
>=20
> Shouldn't it be an error to call exec-oob on non-oob enabled monitors?

Do you mean a "qmp_capabilities" command to enable oob, and a
continuous "exec-oob" command?

I can't say I fully understand the scenario you mentioned, but I think
it does violate the rule if we resume the monitor before we finish
executing the "qmp_capabilities" command since that command should
still be run with "non-oob" context.  So in that case we should do the
resume after dispatching.  For the other queue-full case we shouldn't
need to, as Markus suggested.

Instead of bothering with all these, how about I drop this patch?  We
might resume the monitor a little bit later when queue full, but I
don't think that's a big deal for now.

Regards,

--=20
Peter Xu
