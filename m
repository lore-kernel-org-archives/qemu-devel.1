Received: from eggs.gnu.org ([2001:4830:134:3::10]:60941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fbQee-0006Ey-2s
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 09:20:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fbQea-0005eu-Il
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 09:20:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53878 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fbQea-0005dl-Ce
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 09:20:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5FDDD72647
	for <qemu-devel@nongnu.org>; Fri,  6 Jul 2018 13:20:03 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180704084507.14560-1-peterx@redhat.com>
	<20180704084507.14560-6-peterx@redhat.com>
	<87po0023ah.fsf@dusky.pond.sub.org> <20180706093932.GI23001@xz-mi>
Date: Fri, 06 Jul 2018 15:19:56 +0200
In-Reply-To: <20180706093932.GI23001@xz-mi> (Peter Xu's message of "Fri, 6 Jul
	2018 17:39:32 +0800")
Message-ID: <87a7r4zekj.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 5/9] monitor: suspend monitor instead of
 send CMD_DROP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

Peter Xu <peterx@redhat.com> writes:

> On Fri, Jul 06, 2018 at 10:09:58AM +0200, Markus Armbruster wrote:
>> If I understand the code correctly, the response queue
>> mon->qmp..qmp_requests gets drained into the output buffer mon->outbuf
>> by bottom half monitor_qmp_bh_responder().  The response queue remains
>> small, it's the output buffer that grows without bounds.  Your test for
>> "limit exceeded" measures the response queue.  It needs to measure the
>> output buffer instead.
>>=20
>> We could drain the response queue only when the output buffer isn't too
>> full.  I think that makes sense only if we have a compelling use for
>> keeping responses in QDict form for a longer time.
>
> Indeed.  I didn't really notice that we're having an unlimited out_buf
> there.
>
> To double confirm it's working, I firstly added some tracepoints:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/monitor.c b/monitor.c
> index 9eb9f06599..18ab609eab 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -375,6 +375,7 @@ static void monitor_qmp_cleanup_req_queue_locked(Moni=
tor *mon)
>      while (!g_queue_is_empty(mon->qmp.qmp_requests)) {
>          qmp_request_free(g_queue_pop_head(mon->qmp.qmp_requests));
>      }
> +    trace_monitor_qmp_request_queue(mon, 0);
>  }
>
>  /* Caller must hold the mon->qmp.qmp_lock */
> @@ -383,6 +384,7 @@ static void monitor_qmp_cleanup_resp_queue_locked(Mon=
itor *mon)
>      while (!g_queue_is_empty(mon->qmp.qmp_responses)) {
>          qobject_unref((QDict *)g_queue_pop_head(mon->qmp.qmp_responses));
>      }
> +    trace_monitor_qmp_response_queue(mon, 0);
>  }
>
>  static void monitor_qmp_cleanup_queues(Monitor *mon)
> @@ -408,6 +410,7 @@ static void monitor_qmp_try_resume_locked(Monitor *mo=
n)
>      if (mon->qmp.need_resume) {
>          monitor_resume(mon);
>          mon->qmp.need_resume =3D false;
> +        trace_monitor_qmp_resume(mon);
>      }
>  }
>
> @@ -555,6 +558,7 @@ static void qmp_queue_response(Monitor *mon, QDict *r=
sp)
>           */
>          qemu_mutex_lock(&mon->qmp.qmp_lock);
>          g_queue_push_tail(mon->qmp.qmp_responses, qobject_ref(rsp));
> +        trace_monitor_qmp_response_queue(mon, mon->qmp.qmp_responses->le=
ngth);
>          qemu_mutex_unlock(&mon->qmp.qmp_lock);
>          qemu_bh_schedule(qmp_respond_bh);
>      } else {
> @@ -578,6 +582,7 @@ static QDict *monitor_qmp_response_pop_one(Monitor *m=
on)
>
>      qemu_mutex_lock(&mon->qmp.qmp_lock);
>      data =3D g_queue_pop_head(mon->qmp.qmp_responses);
> +    trace_monitor_qmp_response_queue(mon, mon->qmp.qmp_responses->length=
);
>      /* In case if we were suspended due to response queue full */
>      monitor_qmp_try_resume_locked(mon);
>      qemu_mutex_unlock(&mon->qmp.qmp_lock);
> @@ -4183,6 +4188,7 @@ static QMPRequest *monitor_qmp_requests_pop_any(voi=
d)
>      QTAILQ_FOREACH(mon, &mon_list, entry) {
>          qemu_mutex_lock(&mon->qmp.qmp_lock);
>          req_obj =3D g_queue_pop_head(mon->qmp.qmp_requests);
> +        trace_monitor_qmp_request_queue(mon, mon->qmp.qmp_requests->leng=
th);
>          qemu_mutex_unlock(&mon->qmp.qmp_lock);
>          if (req_obj) {
>              break;
> @@ -4239,6 +4245,7 @@ static void monitor_qmp_suspend_locked(Monitor *mon)
>      assert(mon->qmp.need_resume =3D=3D false);
>      monitor_suspend(mon);
>      mon->qmp.need_resume =3D true;
> +    trace_monitor_qmp_suspend(mon);
>  }
>
>  static void handle_qmp_command(JSONMessageParser *parser, GQueue *tokens)
> @@ -4312,6 +4319,7 @@ static void handle_qmp_command(JSONMessageParser *p=
arser, GQueue *tokens)
>       * etc. will be delivered to the handler side.
>       */
>      g_queue_push_tail(mon->qmp.qmp_requests, req_obj);
> +    trace_monitor_qmp_request_queue(mon, mon->qmp.qmp_requests->length);
>      qemu_mutex_unlock(&mon->qmp.qmp_lock);
>
>      /* Kick the dispatcher routine */
> diff --git a/trace-events b/trace-events
> index c445f54773..bd9dade938 100644
> --- a/trace-events
> +++ b/trace-events
> @@ -50,6 +50,10 @@ handle_qmp_command(void *mon, const char *req) "mon %p=
 req: %s"
>  monitor_suspend(void *ptr, int cnt) "mon %p: %d"
>  monitor_qmp_cmd_in_band(const char *id) "%s"
>  monitor_qmp_cmd_out_of_band(const char *id) "%s"
> +monitor_qmp_suspend(void *mon) "mon=3D%p"
> +monitor_qmp_resume(void *mon) "mon=3D%p"
> +monitor_qmp_request_queue(void *mon, int len) "mon=3D%p len=3D%d"
> +monitor_qmp_response_queue(void *mon, int len) "mon=3D%p len=3D%d"
>
>  # dma-helpers.c
>  dma_blk_io(void *dbs, void *bs, int64_t offset, bool to_dev) "dbs=3D%p b=
s=3D%p offset=3D%" PRId64 " to_dev=3D%d"
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Then, I explicitly hanged the response BH by:
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> diff --git a/monitor.c b/monitor.c
> index 18ab609eab..1f38084a4c 100644
> --- a/monitor.c
> +++ b/monitor.c
> @@ -560,7 +560,7 @@ static void qmp_queue_response(Monitor *mon, QDict *r=
sp)
>          g_queue_push_tail(mon->qmp.qmp_responses, qobject_ref(rsp));
>          trace_monitor_qmp_response_queue(mon, mon->qmp.qmp_responses->le=
ngth);
>          qemu_mutex_unlock(&mon->qmp.qmp_lock);
> -        qemu_bh_schedule(qmp_respond_bh);
> +        //qemu_bh_schedule(qmp_respond_bh);
>      } else {
>          /*
>           * Not using monitor I/O thread, i.e. we are in the main thread.

This stops draining of the response queue into the output buffer.

> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Then this is what I got for command:
>
> $ cat cmd_list | qemu-system-x86_64 -qmp stdio -nographic -nodefaults -tr=
ace enable=3D"monitor_qmp*"
>
> Result:
>
> 9815@1530867603.464498:monitor_qmp_response_queue mon=3D0x55de6bfc4800 le=
n=3D1
> 9815@1530867603.464782:monitor_qmp_suspend mon=3D0x55de6bfc4800
> 9815@1530867603.464788:monitor_qmp_request_queue mon=3D0x55de6bfc4800 len=
=3D1
> 9815@1530867603.489017:monitor_qmp_request_queue mon=3D0x55de6bfc4800 len=
=3D0
> 9815@1530867603.489030:monitor_qmp_cmd_in_band
> 9815@1530867603.489050:monitor_qmp_response_queue mon=3D0x55de6bfc4800 le=
n=3D2
> 9815@1530867603.489057:monitor_qmp_resume mon=3D0x55de6bfc4800         <-=
------ [0]
> 9815@1530867603.489099:monitor_qmp_request_queue mon=3D0x55de6bfc4800 len=
=3D0
> 9815@1530867603.489205:monitor_qmp_request_queue mon=3D0x55de6bfc4800 len=
=3D1
> 9815@1530867603.489311:monitor_qmp_request_queue mon=3D0x55de6bfc4800 len=
=3D0
> 9815@1530867603.489317:monitor_qmp_cmd_in_band
> 9815@1530867603.489329:monitor_qmp_request_queue mon=3D0x55de6bfc4800 len=
=3D1
> 9815@1530867603.489419:monitor_qmp_response_queue mon=3D0x55de6bfc4800 le=
n=3D3
> 9815@1530867603.489432:monitor_qmp_request_queue mon=3D0x55de6bfc4800 len=
=3D0
> 9815@1530867603.489437:monitor_qmp_cmd_in_band
> 9815@1530867603.489450:monitor_qmp_response_queue mon=3D0x55de6bfc4800 le=
n=3D4
> 9815@1530867603.489459:monitor_qmp_request_queue mon=3D0x55de6bfc4800 len=
=3D0
> 9815@1530867603.489465:monitor_qmp_request_queue mon=3D0x55de6bfc4800 len=
=3D1
> 9815@1530867603.489468:monitor_qmp_request_queue mon=3D0x55de6bfc4800 len=
=3D0
> 9815@1530867603.489471:monitor_qmp_cmd_in_band
> 9815@1530867603.489484:monitor_qmp_response_queue mon=3D0x55de6bfc4800 le=
n=3D5
> 9815@1530867603.489492:monitor_qmp_request_queue mon=3D0x55de6bfc4800 len=
=3D0
> 9815@1530867603.489575:monitor_qmp_request_queue mon=3D0x55de6bfc4800 len=
=3D1
> 9815@1530867603.489584:monitor_qmp_request_queue mon=3D0x55de6bfc4800 len=
=3D0
> 9815@1530867603.489595:monitor_qmp_cmd_in_band
> 9815@1530867603.489614:monitor_qmp_response_queue mon=3D0x55de6bfc4800 le=
n=3D6
> 9815@1530867603.489624:monitor_qmp_request_queue mon=3D0x55de6bfc4800 len=
=3D0
> 9815@1530867603.489693:monitor_qmp_request_queue mon=3D0x55de6bfc4800 len=
=3D1
> 9815@1530867603.489703:monitor_qmp_request_queue mon=3D0x55de6bfc4800 len=
=3D0
> 9815@1530867603.489708:monitor_qmp_cmd_in_band
> 9815@1530867603.489725:monitor_qmp_response_queue mon=3D0x55de6bfc4800 le=
n=3D7
> 9815@1530867603.489736:monitor_qmp_request_queue mon=3D0x55de6bfc4800 len=
=3D0
> 9815@1530867603.489818:monitor_qmp_suspend mon=3D0x55de6bfc4800  <-------=
------[1]
> 9815@1530867603.489823:monitor_qmp_request_queue mon=3D0x55de6bfc4800 len=
=3D1
> 9815@1530867603.489837:monitor_qmp_request_queue mon=3D0x55de6bfc4800 len=
=3D0
> 9815@1530867603.489847:monitor_qmp_cmd_in_band
> 9815@1530867603.489874:monitor_qmp_response_queue mon=3D0x55de6bfc4800 le=
n=3D8
> 9815@1530867603.489892:monitor_qmp_request_queue mon=3D0x55de6bfc4800 len=
=3D0
> [hangs here]
>
> I think we have [1] right after response queue reaches N-1, I suppose
> that means current patch is working.  Note that the suspend at [0] is
> only the first "qmp_capability" command, since before we enable OOB
> we'll still emulate the old monitor so that's by design.

Your experiment shows the patch succeeds at limiting the response queue
length.  However, the "response queue mon->qmp..qmp_requests gets
drained into the output buffer mon->outbuf by bottom half
monitor_qmp_bh_responder().  The response queue remains small, it's the
output buffer that grows without bounds".

To demonstrate that, let me add another tracepoint:

diff --git a/monitor.c b/monitor.c
index 3bea239bc7..e35e15b43e 100644
--- a/monitor.c
+++ b/monitor.c
@@ -451,6 +451,7 @@ static void monitor_flush_locked(Monitor *mon)
=20
     buf =3D qstring_get_str(mon->outbuf);
     len =3D qstring_get_length(mon->outbuf);
+    trace_monitor_flush_locked(mon, len);
=20
     if (len && !mon->mux_out) {
         rc =3D qemu_chr_fe_write(&mon->chr, (const uint8_t *) buf, len);
diff --git a/trace-events b/trace-events
index bd9dade938..b6d5d28041 100644
--- a/trace-events
+++ b/trace-events
@@ -54,6 +54,7 @@ monitor_qmp_suspend(void *mon) "mon=3D%p"
 monitor_qmp_resume(void *mon) "mon=3D%p"
 monitor_qmp_request_queue(void *mon, int len) "mon=3D%p len=3D%d"
 monitor_qmp_response_queue(void *mon, int len) "mon=3D%p len=3D%d"
+monitor_flush_locked(void *mon, int len) "mon=3D%p len=3D%d"
=20
 # dma-helpers.c
 dma_blk_io(void *dbs, void *bs, int64_t offset, bool to_dev) "dbs=3D%p bs=
=3D%p offset=3D%" PRId64 " to_dev=3D%d"

Start this QEMU:

    $ upstream-qemu -chardev socket,id=3Dqmp,path=3Dtest-qmp,server=3Don,wa=
it=3Doff -mon mode=3Dcontrol,chardev=3Dqmp -display none -nodefaults -trace=
 enable=3D"monitor_qmp*" -trace enable=3Dmonitor_flush_locked
    3236@1530882919.092979:monitor_qmp_response_queue mon=3D0x56192215baf0 =
len=3D1
    3236@1530882919.093018:monitor_qmp_response_queue mon=3D0x56192215baf0 =
len=3D2
    3236@1530882919.093076:monitor_qmp_response_queue mon=3D0x56192215baf0 =
len=3D1
    3236@1530882919.093095:monitor_flush_locked mon=3D0x56192215baf0 len=3D=
107
    3236@1530882919.093103:monitor_qmp_response_queue mon=3D0x56192215baf0 =
len=3D0
    3236@1530882919.093112:monitor_flush_locked mon=3D0x56192215baf0 len=3D=
82
    3236@1530882919.093118:monitor_qmp_response_queue mon=3D0x56192215baf0 =
len=3D0

Now let me feed a couple of commands to that without reading any of
their responses.  To do that, run in another terminal:

    $ socat -u STDIO UNIX:test-qmp
    { "execute": "qmp_capabilities", "arguments": { "enable": ["oob"] } }

Note that -u makes socat use the first address (STDIO) only for reading,
and the second one (the QMP socket) only for writing.  This QMP client
fails to read any responses.  QEMU prints:

    3236@1530882921.894996:monitor_qmp_response_queue mon=3D0x56192215baf0 =
len=3D1
    3236@1530882921.895049:monitor_qmp_response_queue mon=3D0x56192215baf0 =
len=3D0
    3236@1530882921.895171:monitor_flush_locked mon=3D0x56192215baf0 len=3D=
136
    3236@1530882921.895221:monitor_qmp_response_queue mon=3D0x56192215baf0 =
len=3D0
    3236@1530882923.954233:monitor_qmp_suspend mon=3D0x56192215baf0
    3236@1530882923.954262:monitor_qmp_request_queue mon=3D0x56192215baf0 l=
en=3D1
    3236@1530882923.954314:monitor_qmp_request_queue mon=3D0x56192215baf0 l=
en=3D0
    3236@1530882923.954341:monitor_qmp_cmd_in_band=20
    3236@1530882923.954407:monitor_qmp_response_queue mon=3D0x56192215baf0 =
len=3D1
    3236@1530882923.954430:monitor_qmp_resume mon=3D0x56192215baf0
    3236@1530882923.954476:monitor_qmp_request_queue mon=3D0x56192215baf0 l=
en=3D0
    3236@1530882923.954501:monitor_qmp_response_queue mon=3D0x56192215baf0 =
len=3D0
    3236@1530882923.954548:monitor_flush_locked mon=3D0x56192215baf0 len=3D=
16
    3236@1530882923.954587:monitor_qmp_response_queue mon=3D0x56192215baf0 =
len=3D0

Back in socat, execute a few commands, one after the other, with short
pauses in between:

    { "execute": "query-qmp-schema" }
    { "execute": "query-qmp-schema" }
    { "execute": "query-qmp-schema" }
    { "execute": "query-qmp-schema" }
    { "execute": "query-qmp-schema" }
    { "execute": "quit" }

QEMU prints:

    3236@1530882931.529666:monitor_qmp_request_queue mon=3D0x56192215baf0 l=
en=3D1
    3236@1530882931.529768:monitor_qmp_request_queue mon=3D0x56192215baf0 l=
en=3D0
    3236@1530882931.529799:monitor_qmp_cmd_in_band=20
    3236@1530882931.537403:monitor_qmp_response_queue mon=3D0x56192215baf0 =
len=3D1
    3236@1530882931.537474:monitor_qmp_request_queue mon=3D0x56192215baf0 l=
en=3D0
    3236@1530882931.537481:monitor_qmp_response_queue mon=3D0x56192215baf0 =
len=3D0
    3236@1530882931.544809:monitor_flush_locked mon=3D0x56192215baf0 len=3D=
129073
    3236@1530882931.548465:monitor_qmp_response_queue mon=3D0x56192215baf0 =
len=3D0
    3236@1530882935.345300:monitor_qmp_request_queue mon=3D0x56192215baf0 l=
en=3D1
    3236@1530882935.345399:monitor_qmp_request_queue mon=3D0x56192215baf0 l=
en=3D0
    3236@1530882935.345431:monitor_qmp_cmd_in_band=20
    3236@1530882935.355347:monitor_qmp_response_queue mon=3D0x56192215baf0 =
len=3D1
    3236@1530882935.355453:monitor_qmp_response_queue mon=3D0x56192215baf0 =
len=3D0
    3236@1530882935.355513:monitor_qmp_request_queue mon=3D0x56192215baf0 l=
en=3D0
    3236@1530882935.366228:monitor_flush_locked mon=3D0x56192215baf0 len=3D=
129073
    3236@1530882935.369826:monitor_qmp_response_queue mon=3D0x56192215baf0 =
len=3D0
    3236@1530882936.985228:monitor_qmp_request_queue mon=3D0x56192215baf0 l=
en=3D1
    3236@1530882936.985338:monitor_qmp_request_queue mon=3D0x56192215baf0 l=
en=3D0
    3236@1530882936.985371:monitor_qmp_cmd_in_band=20
    3236@1530882936.991813:monitor_qmp_response_queue mon=3D0x56192215baf0 =
len=3D1
    3236@1530882936.991893:monitor_qmp_request_queue mon=3D0x56192215baf0 l=
en=3D0
    3236@1530882936.991900:monitor_qmp_response_queue mon=3D0x56192215baf0 =
len=3D0
    3236@1530882936.999026:monitor_flush_locked mon=3D0x56192215baf0 len=3D=
148514
    3236@1530882937.002865:monitor_qmp_response_queue mon=3D0x56192215baf0 =
len=3D0
    3236@1530882937.905712:monitor_qmp_request_queue mon=3D0x56192215baf0 l=
en=3D1
    3236@1530882937.905873:monitor_qmp_request_queue mon=3D0x56192215baf0 l=
en=3D0
    3236@1530882937.905898:monitor_qmp_cmd_in_band=20
    3236@1530882937.911889:monitor_qmp_response_queue mon=3D0x56192215baf0 =
len=3D1
    3236@1530882937.911958:monitor_qmp_request_queue mon=3D0x56192215baf0 l=
en=3D0
    3236@1530882937.911964:monitor_qmp_response_queue mon=3D0x56192215baf0 =
len=3D0
    3236@1530882937.919079:monitor_flush_locked mon=3D0x56192215baf0 len=3D=
277587
    3236@1530882937.922546:monitor_qmp_response_queue mon=3D0x56192215baf0 =
len=3D0
    3236@1530882939.313235:monitor_qmp_request_queue mon=3D0x56192215baf0 l=
en=3D1
    3236@1530882939.313551:monitor_qmp_request_queue mon=3D0x56192215baf0 l=
en=3D0
    3236@1530882939.313586:monitor_qmp_cmd_in_band=20
    3236@1530882939.323542:monitor_qmp_response_queue mon=3D0x56192215baf0 =
len=3D1
    3236@1530882939.323619:monitor_qmp_request_queue mon=3D0x56192215baf0 l=
en=3D0
    3236@1530882939.323651:monitor_qmp_response_queue mon=3D0x56192215baf0 =
len=3D0
    3236@1530882939.335255:monitor_flush_locked mon=3D0x56192215baf0 len=3D=
406660
    3236@1530882939.338829:monitor_qmp_response_queue mon=3D0x56192215baf0 =
len=3D0
    3236@1530882945.161013:monitor_qmp_request_queue mon=3D0x56192215baf0 l=
en=3D1
    3236@1530882945.161122:monitor_qmp_request_queue mon=3D0x56192215baf0 l=
en=3D0
    3236@1530882945.161153:monitor_qmp_cmd_in_band=20
    3236@1530882945.163191:monitor_qmp_response_queue mon=3D0x56192215baf0 =
len=3D1
    3236@1530882945.163283:monitor_qmp_response_queue mon=3D0x56192215baf0 =
len=3D2
    3236@1530882945.163360:monitor_qmp_response_queue mon=3D0x56192215baf0 =
len=3D1
    3236@1530882945.163407:monitor_flush_locked mon=3D0x56192215baf0 len=3D=
406676
    3236@1530882945.163439:monitor_qmp_response_queue mon=3D0x56192215baf0 =
len=3D0
    3236@1530882945.163489:monitor_flush_locked mon=3D0x56192215baf0 len=3D=
406787
    3236@1530882945.163518:monitor_qmp_response_queue mon=3D0x56192215baf0 =
len=3D0
    3236@1530882945.163695:monitor_qmp_response_queue mon=3D0x56192215baf0 =
len=3D0
    3236@1530882945.163725:monitor_flush_locked mon=3D0x56192215baf0 len=3D=
406787
    3236@1530882945.163866:monitor_qmp_request_queue mon=3D0x56192215baf0 l=
en=3D0
    3236@1530882945.163879:monitor_qmp_response_queue mon=3D0x56192215baf0 =
len=3D0

The response queue length stays small (the bottom half drains it just
fine), but the output buffer keeps growing.

>> Marc-Andr=C3=A9 has a patch to cut out the response queue.  Whether it s=
till
>> makes sense I don't know.
>> [PATCH v3 03/38] Revert "qmp: isolate responses into io thread"
>
> I think we discussed this before, I agree with Marc-Andre that most of
> the codes that are related to response flushing should be thread safe
> now.  Actually it was not when we started to draft the out-of-band
> thing, and that's the major reason why I refactored my old code to
> explicitly separate the dispatcher and the responder, so that
> responder can be isolated and be together with the parser.
>
> I don't have obvious reason to remove this layer of isolation if it
> works well (and actually the code is not that much, and IMHO the
> response queue is a clear interface that maybe we can use in the
> future too), I think my major concern now is that we're in rc phase
> for QEMU-3.0 so that it at least seems to be a big change to monitor
> layer.  We might consider to revert back to no-responder way if we
> really want, but I guess we'd better do as much testing as when we
> started to play with out-of-band to make sure we won't miss anything
> important (and I guess the patch will need a non-trivial rebase after
> we worked upon the queues recently).  Considering that, I don't really
> see much help on removing that layer.  Or, do we have any other reason
> to remove the response queue that I'm not aware of?

I think we first need to figure out where we want to go.  That includes
how to provide flow control.  Then we can decide how far to go in 3.0,
and whether we need to detour.
