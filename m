Received: from eggs.gnu.org ([2001:4830:134:3::10]:53651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fdbQr-0004r5-Sz
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 09:14:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fdbQm-0004FS-Jd
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 09:14:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38096 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fdbQm-0004ES-CN
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 09:14:48 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D6E8081663FF
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 13:14:47 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180706121354.2021-1-marcandre.lureau@redhat.com>
	<20180706121354.2021-5-marcandre.lureau@redhat.com>
Date: Thu, 12 Jul 2018 15:14:42 +0200
In-Reply-To: <20180706121354.2021-5-marcandre.lureau@redhat.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?=
	Lureau"'s message of "Fri, 6 Jul 2018 14:13:46 +0200")
Message-ID: <87wou0lhod.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 04/12] Revert "qmp: isolate responses into
 io thread"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com

Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:

> This reverts commit abe3cd0ff7f774966da6842620806ab7576fe4f3.
>
> There is no need to add an additional queue to send the reply to the
> IOThread, because QMP response is thread safe, and chardev write path
> is thread safe. It will schedule the watcher in the associated
> IOThread.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  monitor.c | 120 ++----------------------------------------------------
>  1 file changed, 3 insertions(+), 117 deletions(-)

The diffstat speaks for itself.

The revert conflicts pretty badly, so I'm going over it hunk by hunk.

>
> diff --git a/monitor.c b/monitor.c
> index fc481d902d..462cf96f7b 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -183,8 +183,6 @@ typedef struct {
>      QemuMutex qmp_queue_lock;
>      /* Input queue that holds all the parsed QMP requests */
>      GQueue *qmp_requests;
> -    /* Output queue contains all the QMP responses in order */
> -    GQueue *qmp_responses;
>  } MonitorQMP;
>=20=20
>  /*

Not reverted:

       bool skip_flush;
       bool use_io_thr;

  +    /* We can't access guest memory when holding the lock */
       QemuMutex out_lock;
       QString *outbuf;
       guint out_watch;

Commit dc7cbcd8fae moved it elswhere.  Besides, it's a keeper.  It
shouldn't have been in commit abe3cd0ff7f in the first place.

Good.

> @@ -248,9 +246,6 @@ IOThread *mon_iothread;
>  /* Bottom half to dispatch the requests received from I/O thread */
>  QEMUBH *qmp_dispatcher_bh;
>=20=20
> -/* Bottom half to deliver the responses back to clients */
> -QEMUBH *qmp_respond_bh;
> -
>  struct QMPRequest {
>      /* Owner of the request */
>      Monitor *mon;

Not reverted:

  @@ -416,7 +421,8 @@ int monitor_fprintf(FILE *stream, const char *fmt, ..=
.)
       return 0;
   }

  -static void monitor_json_emitter(Monitor *mon, const QObject *data)
  +static void monitor_json_emitter_raw(Monitor *mon,
  +                                     QObject *data)
   {
       QString *json;

Commit 65e3fe6743a renamed it once more, to qmp_send_response().

Good.

> @@ -376,19 +371,10 @@ static void monitor_qmp_cleanup_req_queue_locked(Mo=
nitor *mon)
>      }
>  }
>=20=20
> -/* Caller must hold the mon->qmp.qmp_queue_lock */
> -static void monitor_qmp_cleanup_resp_queue_locked(Monitor *mon)
> -{
> -    while (!g_queue_is_empty(mon->qmp.qmp_responses)) {
> -        qobject_unref((QDict *)g_queue_pop_head(mon->qmp.qmp_responses));
> -    }
> -}
> -
>  static void monitor_qmp_cleanup_queues(Monitor *mon)
>  {
>      qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
>      monitor_qmp_cleanup_req_queue_locked(mon);
> -    monitor_qmp_cleanup_resp_queue_locked(mon);
>      qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
>  }
>=20=20

These are followup fixes from commit 6d2d563f8cc "qmp: cleanup qmp
queues properly".  I think you're reverting exactly its response queue
part, mostly here, but there's one more below.

Good.

> @@ -519,85 +505,6 @@ static void qmp_send_response(Monitor *mon, const QD=
ict *rsp)
>      qobject_unref(json);
>  }
>=20=20
> -static void qmp_queue_response(Monitor *mon, QDict *rsp)
> -{
> -    if (mon->use_io_thread) {
> -        /*
> -         * Push a reference to the response queue.  The I/O thread
> -         * drains that queue and emits.
> -         */
> -        qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
> -        g_queue_push_tail(mon->qmp.qmp_responses, qobject_ref(rsp));
> -        qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
> -        qemu_bh_schedule(qmp_respond_bh);
> -    } else {
> -        /*
> -         * Not using monitor I/O thread, i.e. we are in the main thread.
> -         * Emit right away.
> -         */
> -        qmp_send_response(mon, rsp);
> -    }
> -}
> -
> -struct QMPResponse {
> -    Monitor *mon;
> -    QDict *data;
> -};
> -typedef struct QMPResponse QMPResponse;
> -
> -static QDict *monitor_qmp_response_pop_one(Monitor *mon)
> -{
> -    QDict *data;
> -
> -    qemu_mutex_lock(&mon->qmp.qmp_queue_lock);
> -    data =3D g_queue_pop_head(mon->qmp.qmp_responses);
> -    qemu_mutex_unlock(&mon->qmp.qmp_queue_lock);
> -
> -    return data;
> -}
> -
> -static void monitor_qmp_response_flush(Monitor *mon)
> -{
> -    QDict *data;
> -
> -    while ((data =3D monitor_qmp_response_pop_one(mon))) {
> -        qmp_send_response(mon, data);
> -        qobject_unref(data);
> -    }
> -}
> -
> -/*
> - * Pop a QMPResponse from any monitor's response queue into @response.
> - * Return false if all the queues are empty; else true.
> - */
> -static bool monitor_qmp_response_pop_any(QMPResponse *response)
> -{
> -    Monitor *mon;
> -    QDict *data =3D NULL;
> -
> -    qemu_mutex_lock(&monitor_lock);
> -    QTAILQ_FOREACH(mon, &mon_list, entry) {
> -        data =3D monitor_qmp_response_pop_one(mon);
> -        if (data) {
> -            response->mon =3D mon;
> -            response->data =3D data;
> -            break;
> -        }
> -    }
> -    qemu_mutex_unlock(&monitor_lock);
> -    return data !=3D NULL;
> -}
> -
> -static void monitor_qmp_bh_responder(void *opaque)
> -{
> -    QMPResponse response;
> -
> -    while (monitor_qmp_response_pop_any(&response)) {
> -        qmp_send_response(response.mon, response.data);
> -        qobject_unref(response.data);
> -    }
> -}
> -
>  static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] =3D=
 {
>      /* Limit guest-triggerable events to 1 per second */
>      [QAPI_EVENT_RTC_CHANGE]        =3D { 1000 * SCALE_MS },

Again, conflicts due to followup fixes, notably

    40687eb741a monitor: rename *_pop_one to *_pop_any
    c73a843b4a8 monitor: flush qmp responses when CLOSED
    65e3fe6743a qmp: Replace monitor_json_emitter{,raw}() by qmp_{queue,sen=
d}_response()

Good, I think.

> @@ -621,7 +528,7 @@ static void monitor_qapi_event_emit(QAPIEvent event, =
QDict *qdict)
>      QTAILQ_FOREACH(mon, &mon_list, entry) {
>          if (monitor_is_qmp(mon)
>              && mon->qmp.commands !=3D &qmp_cap_negotiation_commands) {
> -            qmp_queue_response(mon, qdict);
> +            qmp_send_response(mon, qdict);
>          }
>      }
>  }

The patch you revert doesn't have a hunk here, because it achieved the
change by replacing monitor_json_emitter().  The old one became
monitor_json_emitter_raw().  Both have been renamed since.  You switch
back to the old one.

Good.

> @@ -777,7 +684,6 @@ static void monitor_data_init(Monitor *mon, bool skip=
_flush,
>      mon->skip_flush =3D skip_flush;
>      mon->use_io_thread =3D use_io_thread;
>      mon->qmp.qmp_requests =3D g_queue_new();
> -    mon->qmp.qmp_responses =3D g_queue_new();
>  }
>=20=20
>  static void monitor_data_destroy(Monitor *mon)

A hunk with out a conflict, awesome!

> @@ -792,9 +698,7 @@ static void monitor_data_destroy(Monitor *mon)
>      qemu_mutex_destroy(&mon->mon_lock);
>      qemu_mutex_destroy(&mon->qmp.qmp_queue_lock);
>      monitor_qmp_cleanup_req_queue_locked(mon);
> -    monitor_qmp_cleanup_resp_queue_locked(mon);
>      g_queue_free(mon->qmp.qmp_requests);
> -    g_queue_free(mon->qmp.qmp_responses);
>  }
>=20=20

The first deletion is due to the response queue part of 6d2d563f8cc
"qmp: cleanup qmp queues properly".  See note above.

Good.

>  char *qmp_human_monitor_command(const char *command_line, bool has_cpu_i=
ndex,
> @@ -4100,7 +4004,7 @@ static void monitor_qmp_respond(Monitor *mon, QDict=
 *rsp, QObject *id)
>              qdict_put_obj(rsp, "id", qobject_ref(id));
>          }
>=20=20
> -        qmp_queue_response(mon, rsp);
> +        qmp_send_response(mon, rsp);
>      }
>  }
>=20=20

Same argument as for monitor_qapi_event_emit().

Good.

> @@ -4395,7 +4299,7 @@ static void monitor_qmp_event(void *opaque, int eve=
nt)
>          mon->qmp.commands =3D &qmp_cap_negotiation_commands;
>          monitor_qmp_caps_reset(mon);
>          data =3D qmp_greeting(mon);
> -        qmp_queue_response(mon, data);
> +        qmp_send_response(mon, data);
>          qobject_unref(data);
>          mon_refcount++;
>          break;

Likewise.

> @@ -4406,7 +4310,6 @@ static void monitor_qmp_event(void *opaque, int eve=
nt)
>           * stdio, it's possible that stdout is still open when stdin
>           * is closed.
>           */
> -        monitor_qmp_response_flush(mon);
>          monitor_qmp_cleanup_queues(mon);
>          json_message_parser_destroy(&mon->qmp.parser);
>          json_message_parser_init(&mon->qmp.parser, handle_qmp_command);

Another bit of commit c73a843b4a8 that needs to go.

Only refactorings remain.  Perhaps c73a843b4a8 should've been split.
Doesn't matter now.

Good.

> @@ -4508,15 +4411,6 @@ static void monitor_iothread_init(void)
>      qmp_dispatcher_bh =3D aio_bh_new(iohandler_get_aio_context(),
>                                     monitor_qmp_bh_dispatcher,
>                                     NULL);
> -
> -    /*
> -     * The responder BH must be run in the monitor I/O thread, so that
> -     * monitors that are using the I/O thread have their output
> -     * written by the I/O thread.
> -     */
> -    qmp_respond_bh =3D aio_bh_new(monitor_get_aio_context(),
> -                                monitor_qmp_bh_responder,
> -                                NULL);
>  }
>=20=20

Only trivial conflicts.

>  void monitor_init_globals(void)
> @@ -4668,12 +4562,6 @@ void monitor_cleanup(void)
>       */
>      iothread_stop(mon_iothread);
>=20=20
> -    /*
> -     * Flush all response queues.  Note that even after this flush,
> -     * data may remain in output buffers.
> -     */
> -    monitor_qmp_bh_responder(NULL);
> -
>      /* Flush output buffers and destroy monitors */
>      qemu_mutex_lock(&monitor_lock);
>      QTAILQ_FOREACH_SAFE(mon, &mon_list, entry, next) {

Likewise.

> @@ -4687,8 +4575,6 @@ void monitor_cleanup(void)
>      /* QEMUBHs needs to be deleted before destroying the I/O thread */
>      qemu_bh_delete(qmp_dispatcher_bh);
>      qmp_dispatcher_bh =3D NULL;
> -    qemu_bh_delete(qmp_respond_bh);
> -    qmp_respond_bh =3D NULL;
>=20=20
>      iothread_destroy(mon_iothread);
>      mon_iothread =3D NULL;

Likewise.

Looks good to me, so
Reviewed-by: Markus Armbruster <armbru@redhat.com>

However, Peter has argued for keeping the response queue:

  For my own opinion, I'll see it a bit awkward (as I mentioned) to
  revert the response queue part.  Again, it's mostly working well
  there, we just fix things up when needed.  It's not really a big part
  of code to maintain, and it still looks sane to me to have such an
  isolation so that we can have the dispatcher totally separate from the
  chardev IO path (I'd say if I design a QMP interface from scratch,
  I'll do that from the first day).  So I am not against reverting that
  part at all, I just don't see much gain from that as well, especially
  if we want to make QMP more modular in the future.

The argument worth considering here is "isolating the dispatcher from
the chardev IO path".  Opinions?
