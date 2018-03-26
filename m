Received: from eggs.gnu.org ([2001:4830:134:3::10]:40432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1f0Njl-0007sa-5A
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 04:44:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1f0Nji-0002VD-2X
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 04:44:17 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:36868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1f0Njh-0002Uv-S6
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 04:44:14 -0400
Received: by mail-it0-f67.google.com with SMTP id p67-v6so9720107itc.2
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 01:44:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180326063901.27425-3-peterx@redhat.com>
References: <20180326063901.27425-1-peterx@redhat.com>
	<20180326063901.27425-3-peterx@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 26 Mar 2018 10:44:12 +0200
Message-ID: <CAMxuvaz9+bSR80zNFgnQMPEFtz0CFrBu2+wM8tXm7knqXw-dLQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.12 2/8] qmp: cleanup qmp queues
 properly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Mon, Mar 26, 2018 at 8:38 AM, Peter Xu <peterx@redhat.com> wrote:
> Marc-Andr=C3=A9 Lureau reported that we can have this happen:
>
> 1. client1 connects, send command C1
> 2. client1 disconnects before getting response for C1
> 3. client2 connects, who might receive response of C1
>
> However client2 should not receive remaining responses for client1.
>
> Basically, we should clean up the request/response queue elements when:
>
> - before a session established
> - after a session is closed
> - before destroying the queues
>
> Some helpers are introduced to achieve that.  We need to make sure we're
> with the lock when operating on those queues.
>
> Reported-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  monitor.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++----------=
------
>  1 file changed, 59 insertions(+), 20 deletions(-)
>
> diff --git a/monitor.c b/monitor.c
> index 849fa23bf9..eba98df9da 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -234,6 +234,22 @@ static struct {
>      QEMUBH *qmp_respond_bh;
>  } mon_global;
>
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
>  /* QMP checker flags */
>  #define QMP_ACCEPT_UNKNOWNS 1
>
> @@ -310,6 +326,43 @@ int monitor_read_password(Monitor *mon, ReadLineFunc=
 *readline_func,
>      }
>  }
>
> +static void qmp_request_free(QMPRequest *req)
> +{
> +    qobject_decref(req->id);
> +    qobject_decref(req->req);
> +    g_free(req);
> +}
> +
> +static void qmp_response_free(QObject *obj)
> +{
> +    qobject_decref(obj);
> +}
> +
> +/* Must with the mon->qmp.qmp_queue_lock held */
> +static void monitor_qmp_cleanup_req_queue_locked(Monitor *mon)
> +{
> +    while (!g_queue_is_empty(mon->qmp.qmp_requests)) {
> +        qmp_request_free(g_queue_pop_head(mon->qmp.qmp_requests));
> +    }
> +}
> +
> +/* Must with the mon->qmp.qmp_queue_lock held */
> +static void monitor_qmp_cleanup_resp_queue_locked(Monitor *mon)
> +{
> +    while (!g_queue_is_empty(mon->qmp.qmp_responses)) {
> +        qmp_response_free(g_queue_pop_head(mon->qmp.qmp_responses));
> +    }
> +}
> +
> +static void monitor_qmp_cleanup_queues(Monitor *mon)
> +{
> +    qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
> +    monitor_qmp_cleanup_req_queue_locked(mon);
> +    monitor_qmp_cleanup_resp_queue_locked(mon);
> +    qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
> +}
> +
> +
>  static void monitor_flush_locked(Monitor *mon);
>
>  static gboolean monitor_unblocked(GIOChannel *chan, GIOCondition cond,
> @@ -497,7 +550,7 @@ static void monitor_qmp_bh_responder(void *opaque)
>              break;
>          }
>          monitor_json_emitter_raw(response.mon, response.data);
> -        qobject_decref(response.data);
> +        qmp_response_free(response.data);
>      }
>  }
>
> @@ -701,6 +754,8 @@ static void monitor_data_destroy(Monitor *mon)
>      QDECREF(mon->outbuf);
>      qemu_mutex_destroy(&mon->out_lock);
>      qemu_mutex_destroy(&mon->qmp.qmp_queue_lock);
> +    monitor_qmp_cleanup_req_queue_locked(mon);
> +    monitor_qmp_cleanup_resp_queue_locked(mon);
>      g_queue_free(mon->qmp.qmp_requests);
>      g_queue_free(mon->qmp.qmp_responses);
>  }
> @@ -4009,22 +4064,6 @@ static void monitor_qmp_respond(Monitor *mon, QObj=
ect *rsp,
>      qobject_decref(rsp);
>  }
>
> -struct QMPRequest {
> -    /* Owner of the request */
> -    Monitor *mon;
> -    /* "id" field of the request */
> -    QObject *id;
> -    /* Request object to be handled */
> -    QObject *req;
> -    /*
> -     * Whether we need to resume the monitor afterward.  This flag is
> -     * used to emulate the old QMP server behavior that the current
> -     * command must be completed before execution of the next one.
> -     */
> -    bool need_resume;
> -};
> -typedef struct QMPRequest QMPRequest;
> -
>  /*
>   * Dispatch one single QMP request. The function will free the req_obj
>   * and objects inside it before return.
> @@ -4191,9 +4230,7 @@ static void handle_qmp_command(JSONMessageParser *p=
arser, GQueue *tokens)
>              qapi_event_send_command_dropped(id,
>                                              COMMAND_DROP_REASON_QUEUE_FU=
LL,
>                                              &error_abort);
> -            qobject_decref(id);
> -            qobject_decref(req);
> -            g_free(req_obj);
> +            qmp_request_free(req_obj);
>              return;
>          }
>      }
> @@ -4327,6 +4364,7 @@ static void monitor_qmp_event(void *opaque, int eve=
nt)
>
>      switch (event) {
>      case CHR_EVENT_OPENED:
> +        monitor_qmp_cleanup_queues(mon);
>          mon->qmp.commands =3D &qmp_cap_negotiation_commands;
>          monitor_qmp_caps_reset(mon);
>          data =3D get_qmp_greeting(mon);
> @@ -4335,6 +4373,7 @@ static void monitor_qmp_event(void *opaque, int eve=
nt)
>          mon_refcount++;
>          break;
>      case CHR_EVENT_CLOSED:
> +        monitor_qmp_cleanup_queues(mon);
>          json_message_parser_destroy(&mon->qmp.parser);
>          json_message_parser_init(&mon->qmp.parser, handle_qmp_command);
>          mon_refcount--;
> --
> 2.14.3
>
