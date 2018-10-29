Received: from eggs.gnu.org ([2001:4830:134:3::10]:44579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gH5RT-0008Mj-TM
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:10:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gH5RS-0001cP-Q1
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:10:43 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:54099)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gH5RI-0000xf-35
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 07:10:35 -0400
Received: by mail-wm1-x341.google.com with SMTP id l26-v6so7761562wmh.3
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 04:10:22 -0700 (PDT)
MIME-Version: 1.0
References: <20181009062718.1914-1-peterx@redhat.com>
	<20181009062718.1914-3-peterx@redhat.com>
	<CAJ+F1CJwK4cC5xXviefrOFiQCcrP7fsrDwx2E9mZSg_UtFPXrA@mail.gmail.com>
	<20181010032154.GL18728@xz-x1>
In-Reply-To: <20181010032154.GL18728@xz-x1>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 29 Oct 2018 15:10:08 +0400
Message-ID: <CAJ+F1C+DQcQAeOi=YipQRwC4eg=kEWEsvAvDERKmUjVDLBru=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Peter Xu <peterx@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

Hi

On Wed, Oct 10, 2018 at 7:22 AM Peter Xu <peterx@redhat.com> wrote:
>
> On Tue, Oct 09, 2018 at 12:54:37PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi
> > On Tue, Oct 9, 2018 at 10:28 AM Peter Xu <peterx@redhat.com> wrote:
> > >
> > > Currently when QMP request queue full we won't resume the monitor unt=
il
> > > we have completely handled the current command.  It's not necessary
> > > since even before it's handled the queue is already non-full.  Moving
> > > the resume logic earlier before the command execution.
> > >
> > > Note that now monitor_resume() is heavy weighted after 8af6bb14a3a8 a=
nd
> > > it's even possible (as pointed out by Marc-Andr=C3=A9) that the funct=
ion
> > > itself may try to take the monitor lock again, so let's do the resume
> > > after the monitor lock is released to avoid possible dead lock.
> > >
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  monitor.c | 10 ++++++----
> > >  1 file changed, 6 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/monitor.c b/monitor.c
> > > index 1f83775fff..f5911399d8 100644
> > > --- a/monitor.c
> > > +++ b/monitor.c
> > > @@ -4149,6 +4149,12 @@ static void monitor_qmp_bh_dispatcher(void *da=
ta)
> > >      need_resume =3D !qmp_oob_enabled(mon) ||
> > >          mon->qmp.qmp_requests->length =3D=3D QMP_REQ_QUEUE_LEN_MAX -=
 1;
> > >      qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
> > > +
> > > +    if (need_resume) {
> > > +        /* Pairs with the monitor_suspend() in handle_qmp_command() =
*/
> > > +        monitor_resume(mon);
> > > +    }
> >
> > "need_resume" is only set on non-oob enabled monitors.
>
> ... or on oob-enabled monitors when queue full?

yes, after patch 1

>
> >
> > On monitor_resume(), monitor_qmp_read() may end up being called, which
> > may call handle_qmp_command().
> >
> > With regular commands, a new command is queued. But if the command is
> > "exec-oob", it will dispatch immediately, thus not following the QMP
> > reply ordering constrain.
> >
> > Shouldn't it be an error to call exec-oob on non-oob enabled monitors?
>
> Do you mean a "qmp_capabilities" command to enable oob, and a
> continuous "exec-oob" command?

No I meant calling "exec-oob" on a monitor without oob capability. I
checked again, and it does already fail with "QMP input member
'exec-oob' is unexpected". So nevermind.

>
> I can't say I fully understand the scenario you mentioned, but I think
> it does violate the rule if we resume the monitor before we finish
> executing the "qmp_capabilities" command since that command should
> still be run with "non-oob" context.  So in that case we should do the
> resume after dispatching.  For the other queue-full case we shouldn't
> need to, as Markus suggested.
>
> Instead of bothering with all these, how about I drop this patch?  We
> might resume the monitor a little bit later when queue full, but I
> don't think that's a big deal for now.

Yes, if it's a minor optimization, we can postpone it for now.

thanks

>
> Regards,
>
> --
> Peter Xu



--=20
Marc-Andr=C3=A9 Lureau
