Received: from eggs.gnu.org ([2001:4830:134:3::10]:39645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f5Sxn-0002jS-IH
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:19:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f5Sxm-0002Pe-6x
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:19:47 -0400
Received: from mail-wr0-x22c.google.com ([2a00:1450:400c:c0c::22c]:42019)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1f5Sxl-0002PG-Sb
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 05:19:46 -0400
Received: by mail-wr0-x22c.google.com with SMTP id s18so8683248wrg.9
	for <qemu-devel@nongnu.org>; Mon, 09 Apr 2018 02:19:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180408030236.GC10540@xz-mi>
References: <20180309090006.10018-1-peterx@redhat.com>
	<20180309090006.10018-15-peterx@redhat.com>
	<CAJ+F1C+EuOA56p932r8gS_sgYfnqaqdRykFwxX-qt0U-arXS2A@mail.gmail.com>
	<20180326080738.GA17789@xz-mi>
	<CAJ+F1C+t9kvCq-h1JogM+cm=vP8jx=ZvZVma1niHD_X3GkwiyQ@mail.gmail.com>
	<20180326090822.GC17789@xz-mi>
	<CAJ+F1CJ5KKfATgp2dOUhuRCcwV8V95nbebhd_fcqJgbMejc1-A@mail.gmail.com>
	<20180328040209.GA29554@xz-mi>
	<CAJ+F1CJj+V30nGcUWvFntEiPu-D=PDuczHSZAxAmYiJwJVpc7A@mail.gmail.com>
	<20180408030236.GC10540@xz-mi>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 9 Apr 2018 11:19:43 +0200
Message-ID: <CAJ+F1CJqqH6Opsf6TNUKRcsfgPws0xJyaHNLbB+4MrBVY2Wdog@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Peter Xu <peterx@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Hi

On Sun, Apr 8, 2018 at 5:02 AM, Peter Xu <peterx@redhat.com> wrote:
> On Wed, Apr 04, 2018 at 03:58:56PM +0200, Marc-Andr=C3=A9 Lureau wrote:
>> Hi Peter
>>
>> On Wed, Mar 28, 2018 at 6:02 AM, Peter Xu <peterx@redhat.com> wrote:
>> > On Mon, Mar 26, 2018 at 11:46:13AM +0200, Marc-Andr=C3=A9 Lureau wrote=
:
>> >> Hi
>> >>
>> >> On Mon, Mar 26, 2018 at 11:08 AM, Peter Xu <peterx@redhat.com> wrote:
>> >> > On Mon, Mar 26, 2018 at 10:33:27AM +0200, Marc-Andr=C3=A9 Lureau wr=
ote:
>> >> >> Hi
>> >> >>
>> >> >> On Mon, Mar 26, 2018 at 10:07 AM, Peter Xu <peterx@redhat.com> wro=
te:
>> >> >> > On Fri, Mar 23, 2018 at 05:18:53PM +0100, Marc-Andr=C3=A9 Lureau=
 wrote:
>> >> >> >
>> >> >> > [...]
>> >> >> >
>> >> >> >> > +/*
>> >> >> >> > + * Dispatch one single QMP request. The function will free t=
he req_obj
>> >> >> >> > + * and objects inside it before return.
>> >> >> >> > + */
>> >> >> >> > +static void monitor_qmp_dispatch_one(QMPRequest *req_obj)
>> >> >> >> >  {
>> >> >> >> > -    QObject *req, *rsp =3D NULL, *id =3D NULL;
>> >> >> >> > +    Monitor *mon, *old_mon;
>> >> >> >> > +    QObject *req, *rsp =3D NULL, *id;
>> >> >> >> >      QDict *qdict =3D NULL;
>> >> >> >> > -    MonitorQMP *mon_qmp =3D container_of(parser, MonitorQMP,=
 parser);
>> >> >> >> > -    Monitor *old_mon, *mon =3D container_of(mon_qmp, Monitor=
, qmp);
>> >> >> >> > -
>> >> >> >> > -    Error *err =3D NULL;
>> >> >> >> > +    bool need_resume;
>> >> >> >> >
>> >> >> >> > -    req =3D json_parser_parse_err(tokens, NULL, &err);
>> >> >> >> > -    if (!req && !err) {
>> >> >> >> > -        /* json_parser_parse_err() sucks: can fail without s=
etting @err */
>> >> >> >> > -        error_setg(&err, QERR_JSON_PARSING);
>> >> >> >> > -    }
>> >> >> >> > -    if (err) {
>> >> >> >> > -        goto err_out;
>> >> >> >> > -    }
>> >> >> >> > +    req =3D req_obj->req;
>> >> >> >> > +    mon =3D req_obj->mon;
>> >> >> >> > +    id =3D req_obj->id;
>> >> >> >> > +    need_resume =3D req_obj->need_resume;
>> >> >> >> >
>> >> >> >> > -    qdict =3D qobject_to_qdict(req);
>> >> >> >> > -    if (qdict) {
>> >> >> >> > -        id =3D qdict_get(qdict, "id");
>> >> >> >> > -        qobject_incref(id);
>> >> >> >> > -        qdict_del(qdict, "id");
>> >> >> >> > -    } /* else will fail qmp_dispatch() */
>> >> >> >> > +    g_free(req_obj);
>> >> >> >> >
>> >> >> >> >      if (trace_event_get_state_backends(TRACE_HANDLE_QMP_COMM=
AND)) {
>> >> >> >> >          QString *req_json =3D qobject_to_json(req);
>> >> >> >> > @@ -3900,7 +3932,7 @@ static void handle_qmp_command(JSONMess=
ageParser *parser, GQueue *tokens)
>> >> >> >> >      old_mon =3D cur_mon;
>> >> >> >> >      cur_mon =3D mon;
>> >> >> >>
>> >> >> >> There is another issue with this series, since cur_mon is globa=
l (and
>> >> >> >> not protected), an oob command may change the cur_mon while ano=
ther
>> >> >> >> command is running in the main thread with unexpected consequen=
ces. I
>> >> >> >> don't have a clear idea what is the best way to solve it. Makin=
g the
>> >> >> >> variable per-thread, or going all the way to get rid of cur_mon=
 (my
>> >> >> >> preference, but much harder)
>> >> >> >
>> >> >> > IMHO it is fine too.
>> >> >> >
>> >> >> > Note that this cur_mon operation is in monitor_qmp_dispatch_one(=
) now,
>> >> >> > which is still running in main thread.  So AFAICT all the cur_mo=
n
>> >> >> > references are in main thread, and monitor IOThread does not mod=
ify
>> >> >> > that variable at all.  Then we should probably be safe.
>> >> >>
>> >> >> But monitor_qmp_dispatch_one() is called from iothread if the comm=
and
>> >> >> is oob, so cur_mon may be updated while another command is running=
 in
>> >> >> main thread, or am I wrong?
>> >> >
>> >> > You are right. I missed that, sorry...
>> >> >
>> >> > Would this be a simple workaround (but hopefully efficient) solutio=
n?
>> >> >
>> >> > diff --git a/monitor.c b/monitor.c
>> >> > index 77f4c41cfa..99641c0c6d 100644
>> >> > --- a/monitor.c
>> >> > +++ b/monitor.c
>> >> > @@ -4023,7 +4023,7 @@ typedef struct QMPRequest QMPRequest;
>> >> >   * Dispatch one single QMP request. The function will free the req=
_obj
>> >> >   * and objects inside it before return.
>> >> >   */
>> >> > -static void monitor_qmp_dispatch_one(QMPRequest *req_obj)
>> >> > +static void monitor_qmp_dispatch_one(QMPRequest *req_obj, bool hac=
k_curmon)
>> >> >  {
>> >> >      Monitor *mon, *old_mon;
>> >> >      QObject *req, *rsp =3D NULL, *id;
>> >> > @@ -4043,12 +4043,16 @@ static void monitor_qmp_dispatch_one(QMPReq=
uest *req_obj)
>> >> >          QDECREF(req_json);
>> >> >      }
>> >> >
>> >> > -    old_mon =3D cur_mon;
>> >> > -    cur_mon =3D mon;
>> >> > +    if (hack_curmon) {
>> >> > +        old_mon =3D cur_mon;
>> >> > +        cur_mon =3D mon;
>> >> > +    }
>> >> >
>> >> >      rsp =3D qmp_dispatch(mon->qmp.commands, req);
>> >> >
>> >> > -    cur_mon =3D old_mon;
>> >> > +    if (hack_curmon) {
>> >> > +        cur_mon =3D old_mon;
>> >> > +    }
>> >> >
>> >> >      if (mon->qmp.commands =3D=3D &qmp_cap_negotiation_commands) {
>> >> >          qdict =3D qdict_get_qdict(qobject_to(QDict, rsp), "error")=
;
>> >> > @@ -4116,7 +4120,7 @@ static void monitor_qmp_bh_dispatcher(void *d=
ata)
>> >> >
>> >> >      if (req_obj) {
>> >> >          trace_monitor_qmp_cmd_in_band(qobject_get_try_str(req_obj-=
>id) ?: "");
>> >> > -        monitor_qmp_dispatch_one(req_obj);
>> >> > +        monitor_qmp_dispatch_one(req_obj, true);
>> >> >          /* Reschedule instead of looping so the main loop stays re=
sponsive */
>> >> >          qemu_bh_schedule(mon_global.qmp_dispatcher_bh);
>> >> >      }
>> >> > @@ -4175,7 +4179,7 @@ static void handle_qmp_command(JSONMessagePar=
ser *parser, GQueue *tokens)
>> >> >          /* Out-Of-Band (OOB) requests are executed directly in par=
ser. */
>> >> >          trace_monitor_qmp_cmd_out_of_band(qobject_get_try_str(req_=
obj->id)
>> >> >                                            ?: "");
>> >> > -        monitor_qmp_dispatch_one(req_obj);
>> >> > +        monitor_qmp_dispatch_one(req_obj, false);
>> >> >          return;
>> >> >      }
>> >> >
>> >> > Then we forbit touching that evil cur_mon in OOB-capable command
>> >> > handlers.  Thanks,
>> >>
>> >> That's not easy to enforce though, afaict it is being used for:
>> >> - error reporting decision
>> >
>> > IMO this should not be a problem, since any QMP handler (including
>> > OOB-capable ones) will be with an Error** there, so logically speaking
>> > people should never call things like error_report() in that.
>> >
>> >> - file & socket lookup (fd: & /dev/fdset etc)
>> >
>> > I suppose only very rare commands will use it?  It'll be a big problem
>> > to solve when we want to completely remove cur_mon though.
>> >
>> >> - the current state of the monitor / list of commands, cpu_path, capa=
bilities..
>> >
>> > This is very rare to be used too?  Most commands should not use them A=
FAIU.
>> >
>> >>
>> >> Wouldn't it be simpler to make it per-thread? I think it could also
>> >> use helpers to push/pop the current monitor.
>> >
>> > Anyway I think yes this is still a good option (though the cur_mon
>> > logic will be a bit more complicated).
>> >
>> > Do you plan to post some patch about this, or do you want me to do
>> > this?  I suppose we'll change the qemu_thread_create() a bit to pass
>> > the cur_mon inside, and I suppose this might be better material after
>> > 2.12 release if OOB is off now.
>>
>> Have you looked at making cur_mon per-thread?
>
> Above was my idea, nothing else has been done.
>
> Please feel free to post a patch for this, or I'll do this after 2.12
> release.

If it's fixed after 2.12, I think we should document the race as a known is=
sue.




--=20
Marc-Andr=C3=A9 Lureau
