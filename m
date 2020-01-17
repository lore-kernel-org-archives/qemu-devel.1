Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957AFC33CB1
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:05:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C0232073A
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 14:05:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a2RwvfGj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C0232073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58016 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isSFY-0002UW-M8
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 09:05:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53409)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1isSDa-0000hw-34
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:03:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1isSDW-0007BF-43
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:03:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36546
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1isSDV-0007Ag-Uj
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 09:03:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579269797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GFb40M9klzQV0G4G4Ntwz+oM754H4Cw6GE5s3OzGYPo=;
 b=a2RwvfGj+hFsMMsSSxfaiD2ncQD0XrX6uWEzlfTS0p2GMZjMhiylPT5jSlRZV/n7FustBj
 Ld9OP3vjFoCKj86T+TWbywYi2Rf+vV63gxMTHN8uJ0iqQLjFULyXh4uFiMpvl6accMV09q
 svumEEi0/qFRRqTf4vfPeq7PjOyAFf4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-90-80fNwLe2PaiS4ZvyMpTV4A-1; Fri, 17 Jan 2020 09:03:14 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E097B18AAFA1;
 Fri, 17 Jan 2020 14:03:12 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
 [10.33.200.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 249A086CB7;
 Fri, 17 Jan 2020 14:03:09 +0000 (UTC)
Date: Fri, 17 Jan 2020 15:03:07 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v3 3/4] qmp: Move dispatcher to a coroutine
Message-ID: <20200117140307.GG7394@dhcp-200-226.str.redhat.com>
References: <20200115122326.26393-1-kwolf@redhat.com>
 <20200115122326.26393-4-kwolf@redhat.com>
 <87muamjmu8.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87muamjmu8.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 80fNwLe2PaiS4ZvyMpTV4A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: stefanha@redhat.com, marcandre.lureau@gmail.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 17.01.2020 um 13:20 hat Markus Armbruster geschrieben:
> > @@ -579,9 +580,16 @@ void monitor_cleanup(void)
> >      }
> >      qemu_mutex_unlock(&monitor_lock);
> > =20
> > -    /* QEMUBHs needs to be deleted before destroying the I/O thread */
> > -    qemu_bh_delete(qmp_dispatcher_bh);
> > -    qmp_dispatcher_bh =3D NULL;
> > +    /* The dispatcher needs to stop before destroying the I/O thread *=
/
> > +    if (!atomic_mb_read(&qmp_dispatcher_co_busy)) {
> > +        aio_co_schedule(iohandler_get_aio_context(), qmp_dispatcher_co=
);
>=20
> Looks rather low-level to my (untrained!) eyes.
>=20
> > +        qmp_dispatcher_co =3D NULL;
>=20
> As we'll see below, there's a subtle reason for zapping
> qmp_dispatcher_co here.

As you complain below that the method for signalling a termination
request to the dispatcher coroutine, I think I could introduce an
additional boolean. The aio_co_schedule() can probably be simplified,
too, so that we would get something like:

    if (!atomic_mb_read(&qmp_dispatcher_co_busy)) {
        qmp_dispatcher_shutdown =3D true;
        aio_co_wake(qmp_dispatcher_co);
    }

Does this look better?

> > +    }
> > +
> > +    AIO_WAIT_WHILE(qemu_get_aio_context(),
> > +                   (aio_bh_poll(iohandler_get_aio_context()),
> > +                    atomic_mb_read(&qmp_dispatcher_co_busy)));
> > +
>=20
> Looks like it waits for @qmp_dispatcher_co_busy to become false.  The
> details are greek to me.
>=20
> aio_bh_poll()'s function comment says "These are internal functions used
> by the QEMU main loop."  This seems to be the first call outside
> util/aio-{posix,win32}.c.  Hmm.

Much of this complication comes from the fact that the monitor runs in
iohandler_ctx, which is not the main AioContext of the main loop thread
(or any thread). This makes waiting for something in this AioContext
rather complicated because nothing wil poll that AioContext if I don't
do it in the loop condition.

I would have called aio_poll(), but it's forbidden for iohandler_ctx:

    util/aio-posix.c:619: aio_poll: Assertion `in_aio_context_home_thread(c=
tx)' failed.

Maybe if we want to use aio_poll() instead of aio_bh_poll(), we could
special case iohandler_ctx in in_aio_context_home_thread().

> How exactly this implies the coroutine terminated I can't quite tell.

There is only one place which sets qmp_dispatcher_co_busy to false,
which is immediately before terminating for qmp_dispatcher_co =3D=3D NULL.

What's probably missing is setting it to true above before waking up the
dispatcher coroutine. The atomic_mb_read() needs to be atomic_xchg()
like in handle_qmp_command().

> >      if (mon_iothread) {
> >          iothread_destroy(mon_iothread);
> >          mon_iothread =3D NULL;
> > @@ -604,9 +612,9 @@ void monitor_init_globals_core(void)
> >       * have commands assuming that context.  It would be nice to get
> >       * rid of those assumptions.
> >       */
> > -    qmp_dispatcher_bh =3D aio_bh_new(iohandler_get_aio_context(),
> > -                                   monitor_qmp_bh_dispatcher,
> > -                                   NULL);
> > +    qmp_dispatcher_co =3D qemu_coroutine_create(monitor_qmp_dispatcher=
_co, NULL);
> > +    atomic_mb_set(&qmp_dispatcher_co_busy, true);
> > +    aio_co_schedule(iohandler_get_aio_context(), qmp_dispatcher_co);
>=20
> Ignorant question: why not qemu_coroutine_enter()?

Because the old code didn't run the BH right away. Should it? We're
pretty early in the initialisation of QEMU, but it should work as long
as we're allowed to call monitor_qmp_requests_pop_any_with_lock()
already.

> >  }
> > =20
> >  QemuOptsList qemu_mon_opts =3D {
> > diff --git a/monitor/qmp.c b/monitor/qmp.c
> > index b67a8e7d1f..f29a8fe497 100644
> > --- a/monitor/qmp.c
> > +++ b/monitor/qmp.c
> > @@ -133,6 +133,8 @@ static void monitor_qmp_respond(MonitorQMP *mon, QD=
ict *rsp)
> >      }
> >  }
> > =20
> > +/* Runs outside of coroutine context for OOB commands, but in coroutin=
e context
> > + * for everything else. */
>=20
> Wing this comment, please.
>=20
> Note: the precondition is asserted in do_qmp_dispatch() below.
> Asserting here is impractical, because we don't know whether this is an
> OOB command.
>=20
> >  static void monitor_qmp_dispatch(MonitorQMP *mon, QObject *req)
> >  {
> >      Monitor *old_mon;
> > @@ -211,43 +213,62 @@ static QMPRequest *monitor_qmp_requests_pop_any_w=
ith_lock(void)
> >      return req_obj;
> >  }
> > =20
> > -void monitor_qmp_bh_dispatcher(void *data)
> > +void coroutine_fn monitor_qmp_dispatcher_co(void *data)
> >  {
> > -    QMPRequest *req_obj =3D monitor_qmp_requests_pop_any_with_lock();
> > +    QMPRequest *req_obj =3D NULL;
> >      QDict *rsp;
> >      bool need_resume;
> >      MonitorQMP *mon;
> > =20
> > -    if (!req_obj) {
> > -        return;
> > -    }
> > +    while (true) {
> > +        assert(atomic_mb_read(&qmp_dispatcher_co_busy) =3D=3D true);
> > +
> > +        while (!(req_obj =3D monitor_qmp_requests_pop_any_with_lock())=
) {
> > +            /* Wait to be reentered from handle_qmp_command, or termin=
ate if
> > +             * qmp_dispatcher_co has been reset to NULL */
> > +            atomic_mb_set(&qmp_dispatcher_co_busy, false);
>=20
> Note for later: qmp_dispatcher_co_busy is false now.
>=20
> > +            if (qmp_dispatcher_co) {
> > +                qemu_coroutine_yield();
> > +            }
> > +            /* qmp_dispatcher_co may have changed if we yielded and we=
re
> > +             * reentered from monitor_cleanup() */
> > +            if (!qmp_dispatcher_co) {
> > +                return;
> > +            }
>=20
> !qmp_dispatcher_co asks the coroutine to terminate.
>=20
> monitor_init_globals_core() sets it before scheduling the newly created
> coroutine.  monitor_cleanup() clears it after scheduling the non-busy
> coroutine.
>=20
> When asked to terminate, we don't want to yield (first conditional), and
> we don't want to loop (second conditional).
>=20
> > +            assert(atomic_mb_read(&qmp_dispatcher_co_busy) =3D=3D true=
);
>=20
> How does qmp_dispatcher_co_busy become true again?  Is it the
> atomic_xchg() in handle_qmp_command() below?
>=20
> > +        }
>=20
> Looks like the purpose of the loop above is "get request if we have
> requests, else terminate if asked to, else yield".
>=20
> The initial kick (in monitor_init_globals_core()) hits "else yield".
>=20
> Subsequent kicks in handle_qmp_command() hit "get request".
>=20
> The final kick in monitor_cleanup() hits "terminate".
>=20
> Correct?

Yes.

> > =20
> > -    mon =3D req_obj->mon;
> > -    /*  qmp_oob_enabled() might change after "qmp_capabilities" */
> > -    need_resume =3D !qmp_oob_enabled(mon) ||
> > -        mon->qmp_requests->length =3D=3D QMP_REQ_QUEUE_LEN_MAX - 1;
> > -    qemu_mutex_unlock(&mon->qmp_queue_lock);
> > -    if (req_obj->req) {
> > -        QDict *qdict =3D qobject_to(QDict, req_obj->req);
> > -        QObject *id =3D qdict ? qdict_get(qdict, "id") : NULL;
> > -        trace_monitor_qmp_cmd_in_band(qobject_get_try_str(id) ?: "");
> > -        monitor_qmp_dispatch(mon, req_obj->req);
> > -    } else {
> > -        assert(req_obj->err);
> > -        rsp =3D qmp_error_response(req_obj->err);
> > -        req_obj->err =3D NULL;
> > -        monitor_qmp_respond(mon, rsp);
> > -        qobject_unref(rsp);
> > -    }
>=20
> If we get here, we have a @req_obj.
>=20
> > +        aio_co_schedule(qemu_get_aio_context(), qmp_dispatcher_co);
> > +        qemu_coroutine_yield();
>=20
> I'm confused... why do we yield here?

We're waiting for new requests in iohandler_ctx because that's where the
monitor has always been running and I don't want to make changes that I
don't fully understand myself (I think it means that AIO_WAIT_WHILE()
doesn't allow new monitor requests to run).

But the QMP command handler coroutine needs to execute in
qemu_aio_context so that the handlers can make progress during
AIO_WAIT_WHILE(), otherwise you get hangs.

So the QMP dispatcher moves back and forth between both contexts. One
for getting new requests, the other for executing handlers.

This clearly needs a comment.

> > +
> > +        mon =3D req_obj->mon;
> > +        /*  qmp_oob_enabled() might change after "qmp_capabilities" */
> > +        need_resume =3D !qmp_oob_enabled(mon) ||
> > +            mon->qmp_requests->length =3D=3D QMP_REQ_QUEUE_LEN_MAX - 1=
;
> > +        qemu_mutex_unlock(&mon->qmp_queue_lock);
> > +        if (req_obj->req) {
> > +            QDict *qdict =3D qobject_to(QDict, req_obj->req);
> > +            QObject *id =3D qdict ? qdict_get(qdict, "id") : NULL;
> > +            trace_monitor_qmp_cmd_in_band(qobject_get_try_str(id) ?: "=
");
> > +            monitor_qmp_dispatch(mon, req_obj->req);
> > +        } else {
> > +            assert(req_obj->err);
> > +            rsp =3D qmp_error_response(req_obj->err);
> > +            req_obj->err =3D NULL;
> > +            monitor_qmp_respond(mon, rsp);
> > +            qobject_unref(rsp);
> > +        }
> > =20
> > -    if (need_resume) {
> > -        /* Pairs with the monitor_suspend() in handle_qmp_command() */
> > -        monitor_resume(&mon->common);
> > -    }
> > -    qmp_request_free(req_obj);
> > +        if (need_resume) {
> > +            /* Pairs with the monitor_suspend() in handle_qmp_command(=
) */
> > +            monitor_resume(&mon->common);
> > +        }
> > +        qmp_request_free(req_obj);
>=20
> Unchanged apart from indentation.
>=20
> > =20
> > -    /* Reschedule instead of looping so the main loop stays responsive=
 */
> > -    qemu_bh_schedule(qmp_dispatcher_bh);
> > +        /* Reschedule instead of looping so the main loop stays respon=
sive */
> > +        aio_co_schedule(iohandler_get_aio_context(), qmp_dispatcher_co=
);
> > +        qemu_coroutine_yield();
>=20
> Does the comment need tweaking?  We actually loop now, just not
> immediately...

Hm, it's a loop now, but we're still rescheduling instead of directly
looping for the same reason. Suggestions how to phrase it?

> > +    }
> >  }
> > =20
> >  static void handle_qmp_command(void *opaque, QObject *req, Error *err)
> > @@ -308,7 +329,9 @@ static void handle_qmp_command(void *opaque, QObjec=
t *req, Error *err)
> >      qemu_mutex_unlock(&mon->qmp_queue_lock);
> > =20
> >      /* Kick the dispatcher routine */
> > -    qemu_bh_schedule(qmp_dispatcher_bh);
> > +    if (!atomic_xchg(&qmp_dispatcher_co_busy, true)) {
> > +        aio_co_wake(qmp_dispatcher_co);
> > +    }
> >  }
> > =20
> >  static void monitor_qmp_read(void *opaque, const uint8_t *buf, int siz=
e)
> > diff --git a/qapi/qmp-dispatch.c b/qapi/qmp-dispatch.c
> > index bc264b3c9b..6ccf19f2a2 100644
> > --- a/qapi/qmp-dispatch.c
> > +++ b/qapi/qmp-dispatch.c
> > @@ -12,6 +12,8 @@
> >   */
> > =20
> >  #include "qemu/osdep.h"
> > +
> > +#include "monitor/monitor-internal.h"
>=20
> Ugh.

Actually unused. I think I removed the offender because I thought the
same, but forgot to remove the #include.

> >  #include "qapi/error.h"
> >  #include "qapi/qmp/dispatch.h"
> >  #include "qapi/qmp/qdict.h"
> > @@ -75,6 +77,23 @@ static QDict *qmp_dispatch_check_obj(const QObject *=
request, bool allow_oob,
> >      return dict;
> >  }
> > =20
> > +typedef struct QmpDispatchBH {
> > +    QmpCommand *cmd;
> > +    QDict *args;
> > +    QObject **ret;
> > +    Error **errp;
> > +    Coroutine *co;
> > +} QmpDispatchBH;
> > +
> > +static void do_qmp_dispatch_bh(void *opaque)
> > +{
> > +    QmpDispatchBH *data =3D opaque;
> > +    data->cmd->fn(data->args, data->ret, data->errp);
> > +    aio_co_wake(data->co);
> > +}
> > +
> > +/* Runs outside of coroutine context for OOB commands, but in coroutin=
e context
> > + * for everything else. */
> >  static QObject *do_qmp_dispatch(QmpCommandList *cmds, QObject *request=
,
> >                                  bool allow_oob, Error **errp)
> >  {
> > @@ -129,7 +148,22 @@ static QObject *do_qmp_dispatch(QmpCommandList *cm=
ds, QObject *request,
> >          qobject_ref(args);
> >      }
> > =20
> > -    cmd->fn(args, &ret, &local_err);
> > +    assert(!(oob && qemu_in_coroutine()));
> > +    if ((cmd->options & QCO_COROUTINE) || !qemu_in_coroutine()) {
> > +        cmd->fn(args, &ret, &local_err);
> > +    } else {
> > +        /* Must drop out of coroutine context for this one */
> > +        QmpDispatchBH data =3D {
> > +            .cmd    =3D cmd,
> > +            .args   =3D args,
> > +            .ret    =3D &ret,
> > +            .errp   =3D &local_err,
> > +            .co     =3D qemu_coroutine_self(),
> > +        };
> > +        aio_bh_schedule_oneshot(qemu_get_aio_context(), do_qmp_dispatc=
h_bh,
> > +                                &data);
> > +        qemu_coroutine_yield();
> > +    }
> >      if (local_err) {
> >          error_propagate(errp, local_err);
> >      } else if (cmd->options & QCO_NO_SUCCESS_RESP) {
> > @@ -164,6 +198,8 @@ bool qmp_is_oob(const QDict *dict)
> >          && !qdict_haskey(dict, "execute");
> >  }
> > =20
> > +/* Runs outside of coroutine context for OOB commands, but in coroutin=
e context
> > + * for everything else. */
>=20
> Wing this comment, please.
>=20
> Note: the precondition is asserted in do_qmp_dispatch() above.  We don't
> want to assert here, because we don't want to duplicate
> do_qmp_dispatch()'s computation of "execute OOB".
>=20
> >  QDict *qmp_dispatch(QmpCommandList *cmds, QObject *request,
> >                      bool allow_oob)
> >  {
>=20
> Puh, I made it!
>=20
> My problem with this patch isn't that I don't trust it to work.  It's
> that I don't trust my ability to maintain such subtle code going
> forward.
>=20
> Me learning more about low-level coroutine stuff should help.
>=20
> Us making the code less subtle will certainly help.
>=20
> Here's one idea.  The way we make the coroutine terminate was faitly
> hard to grasp for me.  Can we use the existing communication pipe,
> namely mon->qmp_requests?  It's a queue of QMPRequest.  A QMPRequest is
> either a request object (req && !err), or an Error to be reported (!req
> && err).  We could use !req && !err to mean "terminate".

I don't think this would make things any easier. All of the
synchronisation between the monitor thread and dispatcher stays, and all
of the iohandler_ctx vs. qemu_aio_context stays, too.

The only way I see to make termination a bit more obvious would be the
additional bool to request termination that I mentioned above.

Kevin


