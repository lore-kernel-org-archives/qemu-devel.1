Received: from eggs.gnu.org ([2001:4830:134:3::10]:36781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f0NZM-0000H4-6F
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 04:33:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1f0NZL-0006EB-7F
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 04:33:32 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:35256)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1f0NZK-0006DR-Vx
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 04:33:31 -0400
Received: by mail-wr0-x233.google.com with SMTP id 80so16890616wrb.2
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 01:33:29 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180326080738.GA17789@xz-mi>
References: <20180309090006.10018-1-peterx@redhat.com>
	<20180309090006.10018-15-peterx@redhat.com>
	<CAJ+F1C+EuOA56p932r8gS_sgYfnqaqdRykFwxX-qt0U-arXS2A@mail.gmail.com>
	<20180326080738.GA17789@xz-mi>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 26 Mar 2018 10:33:27 +0200
Message-ID: <CAJ+F1C+t9kvCq-h1JogM+cm=vP8jx=ZvZVma1niHD_X3GkwiyQ@mail.gmail.com>
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

On Mon, Mar 26, 2018 at 10:07 AM, Peter Xu <peterx@redhat.com> wrote:
> On Fri, Mar 23, 2018 at 05:18:53PM +0100, Marc-Andr=C3=A9 Lureau wrote:
>
> [...]
>
>> > +/*
>> > + * Dispatch one single QMP request. The function will free the req_ob=
j
>> > + * and objects inside it before return.
>> > + */
>> > +static void monitor_qmp_dispatch_one(QMPRequest *req_obj)
>> >  {
>> > -    QObject *req, *rsp =3D NULL, *id =3D NULL;
>> > +    Monitor *mon, *old_mon;
>> > +    QObject *req, *rsp =3D NULL, *id;
>> >      QDict *qdict =3D NULL;
>> > -    MonitorQMP *mon_qmp =3D container_of(parser, MonitorQMP, parser);
>> > -    Monitor *old_mon, *mon =3D container_of(mon_qmp, Monitor, qmp);
>> > -
>> > -    Error *err =3D NULL;
>> > +    bool need_resume;
>> >
>> > -    req =3D json_parser_parse_err(tokens, NULL, &err);
>> > -    if (!req && !err) {
>> > -        /* json_parser_parse_err() sucks: can fail without setting @e=
rr */
>> > -        error_setg(&err, QERR_JSON_PARSING);
>> > -    }
>> > -    if (err) {
>> > -        goto err_out;
>> > -    }
>> > +    req =3D req_obj->req;
>> > +    mon =3D req_obj->mon;
>> > +    id =3D req_obj->id;
>> > +    need_resume =3D req_obj->need_resume;
>> >
>> > -    qdict =3D qobject_to_qdict(req);
>> > -    if (qdict) {
>> > -        id =3D qdict_get(qdict, "id");
>> > -        qobject_incref(id);
>> > -        qdict_del(qdict, "id");
>> > -    } /* else will fail qmp_dispatch() */
>> > +    g_free(req_obj);
>> >
>> >      if (trace_event_get_state_backends(TRACE_HANDLE_QMP_COMMAND)) {
>> >          QString *req_json =3D qobject_to_json(req);
>> > @@ -3900,7 +3932,7 @@ static void handle_qmp_command(JSONMessageParser=
 *parser, GQueue *tokens)
>> >      old_mon =3D cur_mon;
>> >      cur_mon =3D mon;
>>
>> There is another issue with this series, since cur_mon is global (and
>> not protected), an oob command may change the cur_mon while another
>> command is running in the main thread with unexpected consequences. I
>> don't have a clear idea what is the best way to solve it. Making the
>> variable per-thread, or going all the way to get rid of cur_mon (my
>> preference, but much harder)
>
> IMHO it is fine too.
>
> Note that this cur_mon operation is in monitor_qmp_dispatch_one() now,
> which is still running in main thread.  So AFAICT all the cur_mon
> references are in main thread, and monitor IOThread does not modify
> that variable at all.  Then we should probably be safe.

But monitor_qmp_dispatch_one() is called from iothread if the command
is oob, so cur_mon may be updated while another command is running in
main thread, or am I wrong?

>
> I would be far more than glad to see cur_mon go away one day.
>
> Thanks,
>
> --
> Peter Xu



--=20
Marc-Andr=C3=A9 Lureau
