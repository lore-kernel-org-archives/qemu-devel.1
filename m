Received: from eggs.gnu.org ([2001:4830:134:3::10]:44810)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ezPP8-0008HP-7M
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 12:18:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1ezPP6-0000bk-84
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 12:18:58 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:40574)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1ezPP5-0000ba-Tx
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 12:18:56 -0400
Received: by mail-wr0-x22e.google.com with SMTP id z8so12679179wrh.7
	for <qemu-devel@nongnu.org>; Fri, 23 Mar 2018 09:18:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180309090006.10018-15-peterx@redhat.com>
References: <20180309090006.10018-1-peterx@redhat.com>
	<20180309090006.10018-15-peterx@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 23 Mar 2018 17:18:53 +0100
Message-ID: <CAJ+F1C+EuOA56p932r8gS_sgYfnqaqdRykFwxX-qt0U-arXS2A@mail.gmail.com>
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

On Fri, Mar 9, 2018 at 9:59 AM, Peter Xu <peterx@redhat.com> wrote:
> Originally QMP goes through these steps:
>
>   JSON Parser --> QMP Dispatcher --> Respond
>       /|\    (2)                (3)     |
>    (1) |                               \|/ (4)
>        +---------  main thread  --------+
>
> This patch does this:
>
>   JSON Parser     QMP Dispatcher --> Respond
>       /|\ |           /|\       (4)     |
>        |  | (2)        | (3)            |  (5)
>    (1) |  +----->      |               \|/
>        +---------  main thread  <-------+
>
> So the parsing job and the dispatching job is isolated now.  It gives us
> a chance in following up patches to totally move the parser outside.
>
> The isolation is done using one QEMUBH. Only one dispatcher QEMUBH is
> used for all the monitors.
>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c | 201 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-=
------
>  1 file changed, 178 insertions(+), 23 deletions(-)
>
> diff --git a/monitor.c b/monitor.c
> index de9343be87..5104e5db07 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -172,6 +172,13 @@ typedef struct {
>       */
>      QmpCommandList *commands;
>      bool qmp_caps[QMP_CAPABILITY__MAX];
> +    /*
> +     * Protects qmp request/response queue.  Please take monitor_lock
> +     * first when used together.
> +     */
> +    QemuMutex qmp_queue_lock;
> +    /* Input queue that holds all the parsed QMP requests */
> +    GQueue *qmp_requests;
>  } MonitorQMP;
>
>  /*
> @@ -218,6 +225,8 @@ struct Monitor {
>  /* Let's add monitor global variables to this struct. */
>  static struct {
>      IOThread *mon_iothread;
> +    /* Bottom half to dispatch the requests received from IO thread */
> +    QEMUBH *qmp_dispatcher_bh;
>  } mon_global;
>
>  /* QMP checker flags */
> @@ -600,11 +609,13 @@ static void monitor_data_init(Monitor *mon, bool sk=
ip_flush,
>  {
>      memset(mon, 0, sizeof(Monitor));
>      qemu_mutex_init(&mon->out_lock);
> +    qemu_mutex_init(&mon->qmp.qmp_queue_lock);
>      mon->outbuf =3D qstring_new();
>      /* Use *mon_cmds by default. */
>      mon->cmd_table =3D mon_cmds;
>      mon->skip_flush =3D skip_flush;
>      mon->use_io_thr =3D use_io_thr;
> +    mon->qmp.qmp_requests =3D g_queue_new();
>  }
>
>  static void monitor_data_destroy(Monitor *mon)
> @@ -617,6 +628,8 @@ static void monitor_data_destroy(Monitor *mon)
>      readline_free(mon->rs);
>      QDECREF(mon->outbuf);
>      qemu_mutex_destroy(&mon->out_lock);
> +    qemu_mutex_destroy(&mon->qmp.qmp_queue_lock);
> +    g_queue_free(mon->qmp.qmp_requests);
>  }
>
>  char *qmp_human_monitor_command(const char *command_line, bool has_cpu_i=
ndex,
> @@ -1056,6 +1069,16 @@ static void monitor_init_qmp_commands(void)
>                           qmp_marshal_qmp_capabilities, QCO_NO_OPTIONS);
>  }
>
> +static bool qmp_cap_enabled(Monitor *mon, QMPCapability cap)
> +{
> +    return mon->qmp.qmp_caps[cap];
> +}
> +
> +static bool qmp_oob_enabled(Monitor *mon)
> +{
> +    return qmp_cap_enabled(mon, QMP_CAPABILITY_OOB);
> +}
> +
>  static void qmp_caps_check(Monitor *mon, QMPCapabilityList *list,
>                             Error **errp)
>  {
> @@ -3866,30 +3889,39 @@ static void monitor_qmp_respond(Monitor *mon, QOb=
ject *rsp,
>      qobject_decref(rsp);
>  }
>
> -static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens=
)
> +struct QMPRequest {
> +    /* Owner of the request */
> +    Monitor *mon;
> +    /* "id" field of the request */
> +    QObject *id;
> +    /* Request object to be handled */
> +    QObject *req;
> +    /*
> +     * Whether we need to resume the monitor afterward.  This flag is
> +     * used to emulate the old QMP server behavior that the current
> +     * command must be completed before execution of the next one.
> +     */
> +    bool need_resume;
> +};
> +typedef struct QMPRequest QMPRequest;
> +
> +/*
> + * Dispatch one single QMP request. The function will free the req_obj
> + * and objects inside it before return.
> + */
> +static void monitor_qmp_dispatch_one(QMPRequest *req_obj)
>  {
> -    QObject *req, *rsp =3D NULL, *id =3D NULL;
> +    Monitor *mon, *old_mon;
> +    QObject *req, *rsp =3D NULL, *id;
>      QDict *qdict =3D NULL;
> -    MonitorQMP *mon_qmp =3D container_of(parser, MonitorQMP, parser);
> -    Monitor *old_mon, *mon =3D container_of(mon_qmp, Monitor, qmp);
> -
> -    Error *err =3D NULL;
> +    bool need_resume;
>
> -    req =3D json_parser_parse_err(tokens, NULL, &err);
> -    if (!req && !err) {
> -        /* json_parser_parse_err() sucks: can fail without setting @err =
*/
> -        error_setg(&err, QERR_JSON_PARSING);
> -    }
> -    if (err) {
> -        goto err_out;
> -    }
> +    req =3D req_obj->req;
> +    mon =3D req_obj->mon;
> +    id =3D req_obj->id;
> +    need_resume =3D req_obj->need_resume;
>
> -    qdict =3D qobject_to_qdict(req);
> -    if (qdict) {
> -        id =3D qdict_get(qdict, "id");
> -        qobject_incref(id);
> -        qdict_del(qdict, "id");
> -    } /* else will fail qmp_dispatch() */
> +    g_free(req_obj);
>
>      if (trace_event_get_state_backends(TRACE_HANDLE_QMP_COMMAND)) {
>          QString *req_json =3D qobject_to_json(req);
> @@ -3900,7 +3932,7 @@ static void handle_qmp_command(JSONMessageParser *p=
arser, GQueue *tokens)
>      old_mon =3D cur_mon;
>      cur_mon =3D mon;

There is another issue with this series, since cur_mon is global (and
not protected), an oob command may change the cur_mon while another
command is running in the main thread with unexpected consequences. I
don't have a clear idea what is the best way to solve it. Making the
variable per-thread, or going all the way to get rid of cur_mon (my
preference, but much harder)

>
> -    rsp =3D qmp_dispatch(cur_mon->qmp.commands, req);
> +    rsp =3D qmp_dispatch(mon->qmp.commands, req);
>
>      cur_mon =3D old_mon;
>
> @@ -3916,12 +3948,122 @@ static void handle_qmp_command(JSONMessageParser=
 *parser, GQueue *tokens)
>          }
>      }
>
> -err_out:
> -    monitor_qmp_respond(mon, rsp, err, id);
> +    /* Respond if necessary */
> +    monitor_qmp_respond(mon, rsp, NULL, id);
> +
> +    /* This pairs with the monitor_suspend() in handle_qmp_command(). */
> +    if (need_resume) {
> +        monitor_resume(mon);
> +    }
>
>      qobject_decref(req);
>  }
>
> +/*
> + * Pop one QMP request from monitor queues, return NULL if not found.
> + * We are using round-robin fashion to pop the request, to avoid
> + * processing command only on a very busy monitor.  To achieve that,
> + * when we processed one request on specific monitor, we put that
> + * monitor to the end of mon_list queue.
> + */
> +static QMPRequest *monitor_qmp_requests_pop_one(void)
> +{
> +    QMPRequest *req_obj =3D NULL;
> +    Monitor *mon;
> +
> +    qemu_mutex_lock(&monitor_lock);
> +
> +    QTAILQ_FOREACH(mon, &mon_list, entry) {
> +        qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
> +        req_obj =3D g_queue_pop_head(mon->qmp.qmp_requests);
> +        qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
> +        if (req_obj) {
> +            break;
> +        }
> +    }
> +
> +    if (req_obj) {
> +        /*
> +         * We found one request on the monitor. Degrade this monitor's
> +         * priority to lowest by re-inserting it to end of queue.
> +         */
> +        QTAILQ_REMOVE(&mon_list, mon, entry);
> +        QTAILQ_INSERT_TAIL(&mon_list, mon, entry);
> +    }
> +
> +    qemu_mutex_unlock(&monitor_lock);
> +
> +    return req_obj;
> +}
> +
> +static void monitor_qmp_bh_dispatcher(void *data)
> +{
> +    QMPRequest *req_obj =3D monitor_qmp_requests_pop_one();
> +
> +    if (req_obj) {
> +        monitor_qmp_dispatch_one(req_obj);
> +        /* Reschedule instead of looping so the main loop stays responsi=
ve */
> +        qemu_bh_schedule(mon_global.qmp_dispatcher_bh);
> +    }
> +}
> +
> +static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens=
)
> +{
> +    QObject *req, *id =3D NULL;
> +    QDict *qdict =3D NULL;
> +    MonitorQMP *mon_qmp =3D container_of(parser, MonitorQMP, parser);
> +    Monitor *mon =3D container_of(mon_qmp, Monitor, qmp);
> +    Error *err =3D NULL;
> +    QMPRequest *req_obj;
> +
> +    req =3D json_parser_parse_err(tokens, NULL, &err);
> +    if (!req && !err) {
> +        /* json_parser_parse_err() sucks: can fail without setting @err =
*/
> +        error_setg(&err, QERR_JSON_PARSING);
> +    }
> +    if (err) {
> +        monitor_qmp_respond(mon, NULL, err, NULL);
> +        qobject_decref(req);
> +        return;
> +    }
> +
> +    qdict =3D qobject_to_qdict(req);
> +    if (qdict) {
> +        id =3D qdict_get(qdict, "id");
> +        qobject_incref(id);
> +        qdict_del(qdict, "id");
> +    } /* else will fail qmp_dispatch() */
> +
> +    req_obj =3D g_new0(QMPRequest, 1);
> +    req_obj->mon =3D mon;
> +    req_obj->id =3D id;
> +    req_obj->req =3D req;
> +    req_obj->need_resume =3D false;
> +
> +    /*
> +     * If OOB is not enabled on current monitor, we'll emulate the old
> +     * behavior that we won't process current monitor any more until
> +     * it is responded.  This helps make sure that as long as OOB is
> +     * not enabled, the server will never drop any command.
> +     */
> +    if (!qmp_oob_enabled(mon)) {
> +        monitor_suspend(mon);
> +        req_obj->need_resume =3D true;
> +    }
> +
> +    /*
> +     * Put the request to the end of queue so that requests will be
> +     * handled in time order.  Ownership for req_obj, req, id,
> +     * etc. will be delivered to the handler side.
> +     */
> +    qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
> +    g_queue_push_tail(mon->qmp.qmp_requests, req_obj);
> +    qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
> +
> +    /* Kick the dispatcher routine */
> +    qemu_bh_schedule(mon_global.qmp_dispatcher_bh);
> +}
> +
>  static void monitor_qmp_read(void *opaque, const uint8_t *buf, int size)
>  {
>      Monitor *mon =3D opaque;
> @@ -4134,6 +4276,15 @@ static void monitor_iothread_init(void)
>  {
>      mon_global.mon_iothread =3D iothread_create("mon_iothread",
>                                                &error_abort);
> +
> +    /*
> +     * This MUST be on main loop thread since we have commands that
> +     * have assumption to be run on main loop thread.  It would be
> +     * nice that one day we can remove this assumption in the future.
> +     */
> +    mon_global.qmp_dispatcher_bh =3D aio_bh_new(qemu_get_aio_context(),
> +                                              monitor_qmp_bh_dispatcher,
> +                                              NULL);
>  }
>
>  void monitor_init_globals(void)
> @@ -4280,6 +4431,10 @@ void monitor_cleanup(void)
>      }
>      qemu_mutex_unlock(&monitor_lock);
>
> +    /* QEMUBHs needs to be deleted before destroying the IOThread. */
> +    qemu_bh_delete(mon_global.qmp_dispatcher_bh);
> +    mon_global.qmp_dispatcher_bh =3D NULL;
> +
>      iothread_destroy(mon_global.mon_iothread);
>      mon_global.mon_iothread =3D NULL;
>  }
> --
> 2.14.3
>
>



--=20
Marc-Andr=C3=A9 Lureau
