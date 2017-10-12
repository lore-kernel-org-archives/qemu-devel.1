Received: from eggs.gnu.org ([2001:4830:134:3::10]:37704)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1e2cx0-0004GS-27
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 08:50:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1e2cwv-0003Zb-6p
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 08:50:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35282)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1e2cwu-0003ZD-U5
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 08:50:53 -0400
Date: Thu, 12 Oct 2017 13:50:45 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171012125045.GF5957@stefanha-x1.localdomain>
References: <20170929033844.26935-1-peterx@redhat.com>
	<20170929033844.26935-14-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170929033844.26935-14-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC v2 13/22] monitor: separate QMP parser and
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Fri, Sep 29, 2017 at 11:38:35AM +0800, Peter Xu wrote:
> Originally QMP is going throw these steps:

s/is going throw/goes through/

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
>  monitor.c | 156 +++++++++++++++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 133 insertions(+), 23 deletions(-)
> 
> diff --git a/monitor.c b/monitor.c
> index 7b76dff5ad..1e9a6cb6a5 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -208,10 +208,14 @@ struct Monitor {
>      mon_cmd_t *cmd_table;
>      QLIST_HEAD(,mon_fd_t) fds;
>      QTAILQ_ENTRY(Monitor) entry;
> +    /* Input queue that hangs all the parsed QMP requests */

s/hangs/holds/

> +static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens,
> +                               void *opaque)
> +{
> +    QObject *req, *id = NULL;
> +    QDict *qdict = NULL;
> +    Monitor *mon = opaque;
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

Is there a return statement missing here?

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
> +
> +    /*
> +     * Put the request to the end of queue so that requests will be
> +     * handled in time order.  Ownership for req_obj, req, id,
> +     * etc. will be delivered to the handler side.
> +     */
> +    g_queue_push_tail(mon->qmp_requests, req_obj);
> +
> +    /* Kick the dispatcher routine */
> +    qemu_bh_schedule(mon_global.qmp_dispatcher_bh);

How is thread-safety ensured when accessing qmp_requests?
