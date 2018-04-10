Received: from eggs.gnu.org ([2001:4830:134:3::10]:41644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f5nVw-0003Ax-59
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 03:16:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f5nVs-0004eP-T0
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 03:16:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52960 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f5nVs-0004e5-M0
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 03:16:20 -0400
Date: Tue, 10 Apr 2018 15:15:57 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180410071557.GE27604@xz-mi>
References: <20180309090006.10018-15-peterx@redhat.com>
	<CAJ+F1C+EuOA56p932r8gS_sgYfnqaqdRykFwxX-qt0U-arXS2A@mail.gmail.com>
	<20180326080738.GA17789@xz-mi>
	<CAJ+F1C+t9kvCq-h1JogM+cm=vP8jx=ZvZVma1niHD_X3GkwiyQ@mail.gmail.com>
	<20180326090822.GC17789@xz-mi>
	<CAJ+F1CJ5KKfATgp2dOUhuRCcwV8V95nbebhd_fcqJgbMejc1-A@mail.gmail.com>
	<20180328040209.GA29554@xz-mi>
	<CAJ+F1CJj+V30nGcUWvFntEiPu-D=PDuczHSZAxAmYiJwJVpc7A@mail.gmail.com>
	<20180408030236.GC10540@xz-mi>
	<CAJ+F1CJqqH6Opsf6TNUKRcsfgPws0xJyaHNLbB+4MrBVY2Wdog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1CJqqH6Opsf6TNUKRcsfgPws0xJyaHNLbB+4MrBVY2Wdog@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 14/23] monitor: separate QMP parser and
 dispatcher
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Mon, Apr 09, 2018 at 11:19:43AM +0200, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Sun, Apr 8, 2018 at 5:02 AM, Peter Xu <peterx@redhat.com> wrote:
> > On Wed, Apr 04, 2018 at 03:58:56PM +0200, Marc-Andr=C3=A9 Lureau wrot=
e:
> >> Hi Peter
> >>
> >> On Wed, Mar 28, 2018 at 6:02 AM, Peter Xu <peterx@redhat.com> wrote:
> >> > On Mon, Mar 26, 2018 at 11:46:13AM +0200, Marc-Andr=C3=A9 Lureau w=
rote:
> >> >> Hi
> >> >>
> >> >> On Mon, Mar 26, 2018 at 11:08 AM, Peter Xu <peterx@redhat.com> wr=
ote:
> >> >> > On Mon, Mar 26, 2018 at 10:33:27AM +0200, Marc-Andr=C3=A9 Lurea=
u wrote:
> >> >> >> Hi
> >> >> >>
> >> >> >> On Mon, Mar 26, 2018 at 10:07 AM, Peter Xu <peterx@redhat.com>=
 wrote:
> >> >> >> > On Fri, Mar 23, 2018 at 05:18:53PM +0100, Marc-Andr=C3=A9 Lu=
reau wrote:
> >> >> >> >
> >> >> >> > [...]
> >> >> >> >
> >> >> >> >> > +/*
> >> >> >> >> > + * Dispatch one single QMP request. The function will fr=
ee the req_obj
> >> >> >> >> > + * and objects inside it before return.
> >> >> >> >> > + */
> >> >> >> >> > +static void monitor_qmp_dispatch_one(QMPRequest *req_obj=
)
> >> >> >> >> >  {
> >> >> >> >> > -    QObject *req, *rsp =3D NULL, *id =3D NULL;
> >> >> >> >> > +    Monitor *mon, *old_mon;
> >> >> >> >> > +    QObject *req, *rsp =3D NULL, *id;
> >> >> >> >> >      QDict *qdict =3D NULL;
> >> >> >> >> > -    MonitorQMP *mon_qmp =3D container_of(parser, Monitor=
QMP, parser);
> >> >> >> >> > -    Monitor *old_mon, *mon =3D container_of(mon_qmp, Mon=
itor, qmp);
> >> >> >> >> > -
> >> >> >> >> > -    Error *err =3D NULL;
> >> >> >> >> > +    bool need_resume;
> >> >> >> >> >
> >> >> >> >> > -    req =3D json_parser_parse_err(tokens, NULL, &err);
> >> >> >> >> > -    if (!req && !err) {
> >> >> >> >> > -        /* json_parser_parse_err() sucks: can fail witho=
ut setting @err */
> >> >> >> >> > -        error_setg(&err, QERR_JSON_PARSING);
> >> >> >> >> > -    }
> >> >> >> >> > -    if (err) {
> >> >> >> >> > -        goto err_out;
> >> >> >> >> > -    }
> >> >> >> >> > +    req =3D req_obj->req;
> >> >> >> >> > +    mon =3D req_obj->mon;
> >> >> >> >> > +    id =3D req_obj->id;
> >> >> >> >> > +    need_resume =3D req_obj->need_resume;
> >> >> >> >> >
> >> >> >> >> > -    qdict =3D qobject_to_qdict(req);
> >> >> >> >> > -    if (qdict) {
> >> >> >> >> > -        id =3D qdict_get(qdict, "id");
> >> >> >> >> > -        qobject_incref(id);
> >> >> >> >> > -        qdict_del(qdict, "id");
> >> >> >> >> > -    } /* else will fail qmp_dispatch() */
> >> >> >> >> > +    g_free(req_obj);
> >> >> >> >> >
> >> >> >> >> >      if (trace_event_get_state_backends(TRACE_HANDLE_QMP_=
COMMAND)) {
> >> >> >> >> >          QString *req_json =3D qobject_to_json(req);
> >> >> >> >> > @@ -3900,7 +3932,7 @@ static void handle_qmp_command(JSON=
MessageParser *parser, GQueue *tokens)
> >> >> >> >> >      old_mon =3D cur_mon;
> >> >> >> >> >      cur_mon =3D mon;
> >> >> >> >>
> >> >> >> >> There is another issue with this series, since cur_mon is g=
lobal (and
> >> >> >> >> not protected), an oob command may change the cur_mon while=
 another
> >> >> >> >> command is running in the main thread with unexpected conse=
quences. I
> >> >> >> >> don't have a clear idea what is the best way to solve it. M=
aking the
> >> >> >> >> variable per-thread, or going all the way to get rid of cur=
_mon (my
> >> >> >> >> preference, but much harder)
> >> >> >> >
> >> >> >> > IMHO it is fine too.
> >> >> >> >
> >> >> >> > Note that this cur_mon operation is in monitor_qmp_dispatch_=
one() now,
> >> >> >> > which is still running in main thread.  So AFAICT all the cu=
r_mon
> >> >> >> > references are in main thread, and monitor IOThread does not=
 modify
> >> >> >> > that variable at all.  Then we should probably be safe.
> >> >> >>
> >> >> >> But monitor_qmp_dispatch_one() is called from iothread if the =
command
> >> >> >> is oob, so cur_mon may be updated while another command is run=
ning in
> >> >> >> main thread, or am I wrong?
> >> >> >
> >> >> > You are right. I missed that, sorry...
> >> >> >
> >> >> > Would this be a simple workaround (but hopefully efficient) sol=
ution?
> >> >> >
> >> >> > diff --git a/monitor.c b/monitor.c
> >> >> > index 77f4c41cfa..99641c0c6d 100644
> >> >> > --- a/monitor.c
> >> >> > +++ b/monitor.c
> >> >> > @@ -4023,7 +4023,7 @@ typedef struct QMPRequest QMPRequest;
> >> >> >   * Dispatch one single QMP request. The function will free the=
 req_obj
> >> >> >   * and objects inside it before return.
> >> >> >   */
> >> >> > -static void monitor_qmp_dispatch_one(QMPRequest *req_obj)
> >> >> > +static void monitor_qmp_dispatch_one(QMPRequest *req_obj, bool=
 hack_curmon)
> >> >> >  {
> >> >> >      Monitor *mon, *old_mon;
> >> >> >      QObject *req, *rsp =3D NULL, *id;
> >> >> > @@ -4043,12 +4043,16 @@ static void monitor_qmp_dispatch_one(QM=
PRequest *req_obj)
> >> >> >          QDECREF(req_json);
> >> >> >      }
> >> >> >
> >> >> > -    old_mon =3D cur_mon;
> >> >> > -    cur_mon =3D mon;
> >> >> > +    if (hack_curmon) {
> >> >> > +        old_mon =3D cur_mon;
> >> >> > +        cur_mon =3D mon;
> >> >> > +    }
> >> >> >
> >> >> >      rsp =3D qmp_dispatch(mon->qmp.commands, req);
> >> >> >
> >> >> > -    cur_mon =3D old_mon;
> >> >> > +    if (hack_curmon) {
> >> >> > +        cur_mon =3D old_mon;
> >> >> > +    }
> >> >> >
> >> >> >      if (mon->qmp.commands =3D=3D &qmp_cap_negotiation_commands=
) {
> >> >> >          qdict =3D qdict_get_qdict(qobject_to(QDict, rsp), "err=
or");
> >> >> > @@ -4116,7 +4120,7 @@ static void monitor_qmp_bh_dispatcher(voi=
d *data)
> >> >> >
> >> >> >      if (req_obj) {
> >> >> >          trace_monitor_qmp_cmd_in_band(qobject_get_try_str(req_=
obj->id) ?: "");
> >> >> > -        monitor_qmp_dispatch_one(req_obj);
> >> >> > +        monitor_qmp_dispatch_one(req_obj, true);
> >> >> >          /* Reschedule instead of looping so the main loop stay=
s responsive */
> >> >> >          qemu_bh_schedule(mon_global.qmp_dispatcher_bh);
> >> >> >      }
> >> >> > @@ -4175,7 +4179,7 @@ static void handle_qmp_command(JSONMessag=
eParser *parser, GQueue *tokens)
> >> >> >          /* Out-Of-Band (OOB) requests are executed directly in=
 parser. */
> >> >> >          trace_monitor_qmp_cmd_out_of_band(qobject_get_try_str(=
req_obj->id)
> >> >> >                                            ?: "");
> >> >> > -        monitor_qmp_dispatch_one(req_obj);
> >> >> > +        monitor_qmp_dispatch_one(req_obj, false);
> >> >> >          return;
> >> >> >      }
> >> >> >
> >> >> > Then we forbit touching that evil cur_mon in OOB-capable comman=
d
> >> >> > handlers.  Thanks,
> >> >>
> >> >> That's not easy to enforce though, afaict it is being used for:
> >> >> - error reporting decision
> >> >
> >> > IMO this should not be a problem, since any QMP handler (including
> >> > OOB-capable ones) will be with an Error** there, so logically spea=
king
> >> > people should never call things like error_report() in that.
> >> >
> >> >> - file & socket lookup (fd: & /dev/fdset etc)
> >> >
> >> > I suppose only very rare commands will use it?  It'll be a big pro=
blem
> >> > to solve when we want to completely remove cur_mon though.
> >> >
> >> >> - the current state of the monitor / list of commands, cpu_path, =
capabilities..
> >> >
> >> > This is very rare to be used too?  Most commands should not use th=
em AFAIU.
> >> >
> >> >>
> >> >> Wouldn't it be simpler to make it per-thread? I think it could al=
so
> >> >> use helpers to push/pop the current monitor.
> >> >
> >> > Anyway I think yes this is still a good option (though the cur_mon
> >> > logic will be a bit more complicated).
> >> >
> >> > Do you plan to post some patch about this, or do you want me to do
> >> > this?  I suppose we'll change the qemu_thread_create() a bit to pa=
ss
> >> > the cur_mon inside, and I suppose this might be better material af=
ter
> >> > 2.12 release if OOB is off now.
> >>
> >> Have you looked at making cur_mon per-thread?
> >
> > Above was my idea, nothing else has been done.
> >
> > Please feel free to post a patch for this, or I'll do this after 2.12
> > release.
>=20
> If it's fixed after 2.12, I think we should document the race as a know=
n issue.

Do you mean this page?

https://wiki.qemu.org/Planning/2.12

To be simpler, I'll see whether I can post the patches soon, and
whether that can be accepted as 2.12 material.

--=20
Peter Xu
