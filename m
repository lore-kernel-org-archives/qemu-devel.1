Received: from eggs.gnu.org ([2001:4830:134:3::10]:54779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eRzD8-0004TZ-VK
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 06:40:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eRzD3-0007WT-Hm
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 06:40:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eRzD3-0007VO-7n
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 06:40:21 -0500
Date: Thu, 21 Dec 2017 19:40:13 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20171221114013.GN10812@lemon>
References: <20171219084557.9801-1-peterx@redhat.com>
	<20171219084557.9801-17-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171219084557.9801-17-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v6 16/27] monitor: separate QMP parser and
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
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Tue, 12/19 16:45, Peter Xu wrote:
> Originally QMP goes throw these steps:
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
> The isloation is done using one QEMUBH. Only one dispatcher QEMUBH is
> used for all the monitors.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  monitor.c | 201 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-------
>  1 file changed, 178 insertions(+), 23 deletions(-)
> 
> diff --git a/monitor.c b/monitor.c
> index 5f05f2e9da..ed9a741d06 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -167,6 +167,13 @@ typedef struct {
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
> @@ -213,6 +220,8 @@ struct Monitor {
>  /* Let's add monitor global variables to this struct. */
>  static struct {
>      IOThread *mon_iothread;
> +    /* Bottom half to dispatch the requests received from IO thread */
> +    QEMUBH *qmp_dispatcher_bh;
>  } mon_global;
>  
>  /* QMP checker flags */
> @@ -580,11 +589,13 @@ static void monitor_data_init(Monitor *mon, bool skip_flush,
>  {
>      memset(mon, 0, sizeof(Monitor));
>      qemu_mutex_init(&mon->out_lock);
> +    qemu_mutex_init(&mon->qmp.qmp_queue_lock);
>      mon->outbuf = qstring_new();
>      /* Use *mon_cmds by default. */
>      mon->cmd_table = mon_cmds;
>      mon->skip_flush = skip_flush;
>      mon->use_io_thr = use_io_thr;
> +    mon->qmp.qmp_requests = g_queue_new();
>  }
>  
>  static void monitor_data_destroy(Monitor *mon)
> @@ -597,6 +608,8 @@ static void monitor_data_destroy(Monitor *mon)
>      g_free(mon->rs);
>      QDECREF(mon->outbuf);
>      qemu_mutex_destroy(&mon->out_lock);
> +    qemu_mutex_destroy(&mon->qmp.qmp_queue_lock);
> +    g_queue_free(mon->qmp.qmp_requests);
>  }
>  
>  char *qmp_human_monitor_command(const char *command_line, bool has_cpu_index,
> @@ -1036,6 +1049,16 @@ static void monitor_init_qmp_commands(void)
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
> @@ -3897,30 +3920,39 @@ static void monitor_qmp_respond(Monitor *mon, QObject *rsp,
>      qobject_decref(rsp);
>  }
>  
> -static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
> +struct QMPRequest {
> +    /* Owner of the request */
> +    Monitor *mon;
> +    /* "id" field of the request */
> +    QObject *id;
> +    /* Request object to be handled */
> +    QObject *req;
> +    /*
> +     * Whether we need to resume the monitor afterward.  This flag is
> +     * used to emulate the old QMP server behavior that only one
> +     * command is executed for each time.
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
> -    QObject *req, *rsp = NULL, *id = NULL;
> +    Monitor *mon, *old_mon;
> +    QObject *req, *rsp = NULL, *id;
>      QDict *qdict = NULL;
> -    MonitorQMP *mon_qmp = container_of(parser, MonitorQMP, parser);
> -    Monitor *old_mon, *mon = container_of(mon_qmp, Monitor, qmp);
> -
> -    Error *err = NULL;
> +    bool need_resume;
>  
> -    req = json_parser_parse_err(tokens, NULL, &err);
> -    if (!req && !err) {
> -        /* json_parser_parse_err() sucks: can fail without setting @err */
> -        error_setg(&err, QERR_JSON_PARSING);
> -    }
> -    if (err) {
> -        goto err_out;
> -    }
> +    req = req_obj->req;
> +    mon = req_obj->mon;
> +    id = req_obj->id;
> +    need_resume = req_obj->need_resume;
>  
> -    qdict = qobject_to_qdict(req);
> -    if (qdict) {
> -        id = qdict_get(qdict, "id");
> -        qobject_incref(id);
> -        qdict_del(qdict, "id");
> -    } /* else will fail qmp_dispatch() */
> +    g_free(req_obj);
>  
>      if (trace_event_get_state_backends(TRACE_HANDLE_QMP_COMMAND)) {
>          QString *req_json = qobject_to_json(req);
> @@ -3931,7 +3963,7 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
>      old_mon = cur_mon;
>      cur_mon = mon;
>  
> -    rsp = qmp_dispatch(cur_mon->qmp.commands, req);
> +    rsp = qmp_dispatch(mon->qmp.commands, req);
>  
>      cur_mon = old_mon;
>  
> @@ -3947,12 +3979,122 @@ static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
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
> + * We are using round-robin fasion to pop the request, to avoid

s/fasion/fashion/

> + * processing command only on a very busy monitor.  To achieve that,
> + * when we processed one request on specific monitor, we put that
> + * monitor to the end of mon_list queue.
> + */
> +static QMPRequest *monitor_qmp_requests_pop_one(void)
> +{
> +    QMPRequest *req_obj = NULL;
> +    Monitor *mon;
> +
> +    qemu_mutex_lock(&monitor_lock);
> +
> +    QTAILQ_FOREACH(mon, &mon_list, entry) {
> +        qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
> +        req_obj = g_queue_pop_head(mon->qmp.qmp_requests);
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
> +    QMPRequest *req_obj = monitor_qmp_requests_pop_one();
> +
> +    if (req_obj) {
> +        monitor_qmp_dispatch_one(req_obj);
> +        /* Reschedule instead of looping so the main loop stays responsive */
> +        qemu_bh_schedule(mon_global.qmp_dispatcher_bh);
> +    }
> +}
> +
> +static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
> +{
> +    QObject *req, *id = NULL;
> +    QDict *qdict = NULL;
> +    MonitorQMP *mon_qmp = container_of(parser, MonitorQMP, parser);
> +    Monitor *mon = container_of(mon_qmp, Monitor, qmp);
> +    Error *err = NULL;
> +    QMPRequest *req_obj;
> +
> +    req = json_parser_parse_err(tokens, NULL, &err);
> +    if (!req && !err) {
> +        /* json_parser_parse_err() sucks: can fail without setting @err */
> +        error_setg(&err, QERR_JSON_PARSING);
> +    }
> +    if (err) {
> +        monitor_qmp_respond(mon, NULL, err, NULL);
> +        qobject_decref(req);
> +        return;
> +    }
> +
> +    qdict = qobject_to_qdict(req);
> +    if (qdict) {
> +        id = qdict_get(qdict, "id");
> +        qobject_incref(id);
> +        qdict_del(qdict, "id");
> +    } /* else will fail qmp_dispatch() */
> +
> +    req_obj = g_new0(QMPRequest, 1);
> +    req_obj->mon = mon;
> +    req_obj->id = id;
> +    req_obj->req = req;
> +    req_obj->need_resume = false;
> +
> +    /*
> +     * If OOB is not enabled on current monitor, we'll emulate the old
> +     * behavior that we won't process current monitor any more until
> +     * it is responded.  This helps make sure that as long as OOB is
> +     * not enabled, the server will never drop any command.
> +     */
> +    if (!qmp_oob_enabled(mon)) {
> +        monitor_suspend(mon);
> +        req_obj->need_resume = true;
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
>      Monitor *mon = opaque;
> @@ -4150,6 +4292,15 @@ static void monitor_iothread_init(void)
>  {
>      mon_global.mon_iothread = iothread_create("mon_iothread",
>                                                &error_abort);
> +
> +    /*
> +     * This MUST be on main loop thread since we have commands that
> +     * have assumption to be run on main loop thread (Yeah, we'd
> +     * better remove this assumption in the future).

Assert and move this comment in monitor_qmp_bh_dispatcher?

> +     */
> +    mon_global.qmp_dispatcher_bh = aio_bh_new(qemu_get_aio_context(),
> +                                              monitor_qmp_bh_dispatcher,
> +                                              NULL);
>  }
>  

Fam
