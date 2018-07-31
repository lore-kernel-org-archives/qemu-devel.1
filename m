Received: from eggs.gnu.org ([2001:4830:134:3::10]:34680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fkWYi-0003nF-ML
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 11:27:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1fkWYh-0008Lh-B9
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 11:27:36 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:56053)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1fkWYh-0008Kp-13
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 11:27:35 -0400
Received: by mail-wm0-x243.google.com with SMTP id f21-v6so3542400wmc.5
	for <qemu-devel@nongnu.org>; Tue, 31 Jul 2018 08:27:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87o9entoku.fsf@dusky.pond.sub.org>
References: <20180731150144.14022-1-marcandre.lureau@redhat.com>
	<87o9entoku.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 31 Jul 2018 17:27:32 +0200
Message-ID: <CAJ+F1C+r8BHNxFXqX3hhbRRhy=Qnjk5HxqQKFsO2miu4XXVGQA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] monitor: temporary fix for dead-lock on
 event recursion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Tue, Jul 31, 2018 at 5:25 PM, Markus Armbruster <armbru@redhat.com> wrot=
e:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> With a Spice port chardev, it is possible to reenter
>> monitor_qapi_event_queue() (when the client disconnects for
>> example). This will dead-lock on monitor_lock.
>>
>> Instead, use some TLS variables to check for recursion and queue the
>> events.
>>
>> Fixes:
>>  (gdb) bt
>>  #0  0x00007fa69e7217fd in __lll_lock_wait () at /lib64/libpthread.so.0
>>  #1  0x00007fa69e71acf4 in pthread_mutex_lock () at /lib64/libpthread.so=
.0
>>  #2  0x0000563303567619 in qemu_mutex_lock_impl (mutex=3D0x563303d3e220 =
<monitor_lock>, file=3D0x5633036589a8 "/home/elmarco/src/qq/monitor.c", lin=
e=3D645) at /home/elmarco/src/qq/util/qemu-thread-posix.c:66
>>  #3  0x0000563302fa6c25 in monitor_qapi_event_queue (event=3DQAPI_EVENT_=
SPICE_DISCONNECTED, qdict=3D0x56330602bde0, errp=3D0x7ffc6ab5e728) at /home=
/elmarco/src/qq/monitor.c:645
>>  #4  0x0000563303549aca in qapi_event_send_spice_disconnected (server=3D=
0x563305afd630, client=3D0x563305745360, errp=3D0x563303d8d0f0 <error_abort=
>) at qapi/qapi-events-ui.c:149
>>  #5  0x00005633033e600f in channel_event (event=3D3, info=3D0x5633061b00=
50) at /home/elmarco/src/qq/ui/spice-core.c:235
>>  #6  0x00007fa69f6c86bb in reds_handle_channel_event (reds=3D<optimized =
out>, event=3D3, info=3D0x5633061b0050) at reds.c:316
>>  #7  0x00007fa69f6b193b in main_dispatcher_self_handle_channel_event (in=
fo=3D0x5633061b0050, event=3D3, self=3D0x563304e088c0) at main-dispatcher.c=
:197
>>  #8  0x00007fa69f6b193b in main_dispatcher_channel_event (self=3D0x56330=
4e088c0, event=3Devent@entry=3D3, info=3D0x5633061b0050) at main-dispatcher=
.c:197
>>  #9  0x00007fa69f6d0833 in red_stream_push_channel_event (s=3Ds@entry=3D=
0x563305ad8f50, event=3Devent@entry=3D3) at red-stream.c:414
>>  #10 0x00007fa69f6d086b in red_stream_free (s=3D0x563305ad8f50) at red-s=
tream.c:388
>>  #11 0x00007fa69f6b7ddc in red_channel_client_finalize (object=3D0x56330=
4df2360) at red-channel-client.c:347
>>  #12 0x00007fa6a56b7fb9 in g_object_unref () at /lib64/libgobject-2.0.so=
.0
>>  #13 0x00007fa69f6ba212 in red_channel_client_push (rcc=3D0x563304df2360=
) at red-channel-client.c:1341
>>  #14 0x00007fa69f68b259 in red_char_device_send_msg_to_client (client=3D=
<optimized out>, msg=3D0x5633059b6310, dev=3D0x563304e08bc0) at char-device=
.c:305
>>  #15 0x00007fa69f68b259 in red_char_device_send_msg_to_clients (msg=3D0x=
5633059b6310, dev=3D0x563304e08bc0) at char-device.c:305
>>  #16 0x00007fa69f68b259 in red_char_device_read_from_device (dev=3D0x563=
304e08bc0) at char-device.c:353
>>  #17 0x000056330317d01d in spice_chr_write (chr=3D0x563304cafe20, buf=3D=
0x563304cc50b0 "{\"timestamp\": {\"seconds\": 1532944763, \"microseconds\":=
 326636}, \"event\": \"SHUTDOWN\", \"data\": {\"guest\": false}}\r\n", len=
=3D111) at /home/elmarco/src/qq/chardev/spice.c:199
>>  #18 0x00005633034deee7 in qemu_chr_write_buffer (s=3D0x563304cafe20, bu=
f=3D0x563304cc50b0 "{\"timestamp\": {\"seconds\": 1532944763, \"microsecond=
s\": 326636}, \"event\": \"SHUTDOWN\", \"data\": {\"guest\": false}}\r\n", =
len=3D111, offset=3D0x7ffc6ab5ea70, write_all=3Dfalse) at /home/elmarco/src=
/qq/chardev/char.c:112
>>  #19 0x00005633034df054 in qemu_chr_write (s=3D0x563304cafe20, buf=3D0x5=
63304cc50b0 "{\"timestamp\": {\"seconds\": 1532944763, \"microseconds\": 32=
6636}, \"event\": \"SHUTDOWN\", \"data\": {\"guest\": false}}\r\n", len=3D1=
11, write_all=3Dfalse) at /home/elmarco/src/qq/chardev/char.c:147
>>  #20 0x00005633034e1e13 in qemu_chr_fe_write (be=3D0x563304dbb800, buf=
=3D0x563304cc50b0 "{\"timestamp\": {\"seconds\": 1532944763, \"microseconds=
\": 326636}, \"event\": \"SHUTDOWN\", \"data\": {\"guest\": false}}\r\n", l=
en=3D111) at /home/elmarco/src/qq/chardev/char-fe.c:42
>>  #21 0x0000563302fa6334 in monitor_flush_locked (mon=3D0x563304dbb800) a=
t /home/elmarco/src/qq/monitor.c:425
>>  #22 0x0000563302fa6520 in monitor_puts (mon=3D0x563304dbb800, str=3D0x5=
63305de7e9e "") at /home/elmarco/src/qq/monitor.c:468
>>  #23 0x0000563302fa680c in qmp_send_response (mon=3D0x563304dbb800, rsp=
=3D0x563304df5730) at /home/elmarco/src/qq/monitor.c:517
>>  #24 0x0000563302fa6905 in qmp_queue_response (mon=3D0x563304dbb800, rsp=
=3D0x563304df5730) at /home/elmarco/src/qq/monitor.c:538
>>  #25 0x0000563302fa6b5b in monitor_qapi_event_emit (event=3DQAPI_EVENT_S=
HUTDOWN, qdict=3D0x563304df5730) at /home/elmarco/src/qq/monitor.c:624
>>  #26 0x0000563302fa6c4b in monitor_qapi_event_queue (event=3DQAPI_EVENT_=
SHUTDOWN, qdict=3D0x563304df5730, errp=3D0x7ffc6ab5ed00) at /home/elmarco/s=
rc/qq/monitor.c:649
>>  #27 0x0000563303548cce in qapi_event_send_shutdown (guest=3Dfalse, errp=
=3D0x563303d8d0f0 <error_abort>) at qapi/qapi-events-run-state.c:58
>>  #28 0x000056330313bcd7 in main_loop_should_exit () at /home/elmarco/src=
/qq/vl.c:1822
>>  #29 0x000056330313bde3 in main_loop () at /home/elmarco/src/qq/vl.c:186=
2
>>  #30 0x0000563303143781 in main (argc=3D3, argv=3D0x7ffc6ab5f068, envp=
=3D0x7ffc6ab5f088) at /home/elmarco/src/qq/vl.c:4644
>>
>> Note that error report is now moved to the first caller, which may
>> receive an error for a recursed event. This is probably fine (95% of
>> callers use &error_abort, the rest have NULL error and ignore it)
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  monitor.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 43 insertions(+), 1 deletion(-)
>>
>> diff --git a/monitor.c b/monitor.c
>> index d8d8211ae4..4d9c1873bc 100644
>> --- a/monitor.c
>> +++ b/monitor.c
>> @@ -633,7 +633,7 @@ static void monitor_qapi_event_handler(void *opaque)=
;
>>   * applying any rate limiting if required.
>>   */
>>  static void
>> -monitor_qapi_event_queue(QAPIEvent event, QDict *qdict, Error **errp)
>> +monitor_qapi_event_queue_no_recurse(QAPIEvent event, QDict *qdict)
>
> Let's name it _no_reenter.  Can do in my tree.
>
>>  {
>>      MonitorQAPIEventConf *evconf;
>>      MonitorQAPIEventState *evstate;
>> @@ -688,6 +688,48 @@ monitor_qapi_event_queue(QAPIEvent event, QDict *qd=
ict, Error **errp)
>>      qemu_mutex_unlock(&monitor_lock);
>>  }
>>
>> +static void
>> +monitor_qapi_event_queue(QAPIEvent event, QDict *qdict, Error **errp)
>> +{
>> +    /*
>> +     * monitor_qapi_event_queue_no_recurse() is not reentrant: it
>> +     * would deadlock on monitor_lock.  Work around by queueing
>> +     * events in thread-local storage.
>> +     * TODO: remove this, make it re-enter safe.
>> +     */
>> +    static __thread bool reentered;
>> +    typedef struct MonitorQapiEvent {
>> +        QAPIEvent event;
>> +        QDict *qdict;
>> +        QSIMPLEQ_ENTRY(MonitorQapiEvent) entry;
>> +    } MonitorQapiEvent;
>> +    MonitorQapiEvent *ev;
>> +    static __thread QSIMPLEQ_HEAD(, MonitorQapiEvent) event_queue;
>
> I'd prefer this order:
>
>        typedef struct MonitorQapiEvent {
>            QAPIEvent event;
>            QDict *qdict;
>            QSIMPLEQ_ENTRY(MonitorQapiEvent) entry;
>        } MonitorQapiEvent;
>        static __thread QSIMPLEQ_HEAD(, MonitorQapiEvent) event_queue;
>        static __thread bool reentered;
>        MonitorQapiEvent *ev;
>
> Can do in my tree.
>
>> +
>> +    if (!reentered) {
>> +        QSIMPLEQ_INIT(&event_queue);
>> +    }
>> +
>> +    ev =3D g_new(MonitorQapiEvent, 1);
>> +    ev->qdict =3D qobject_ref(qdict);
>> +    ev->event =3D event;
>> +    QSIMPLEQ_INSERT_TAIL(&event_queue, ev, entry);
>> +    if (reentered) {
>> +        return;
>> +    }
>> +
>> +    reentered =3D true;
>> +
>> +    while ((ev =3D QSIMPLEQ_FIRST(&event_queue)) !=3D NULL) {
>> +        QSIMPLEQ_REMOVE_HEAD(&event_queue, entry);
>> +        monitor_qapi_event_queue_no_recurse(ev->event, ev->qdict);
>> +        qobject_unref(ev->qdict);
>> +        g_free(ev);
>> +    }
>> +
>> +    reentered =3D false;
>> +}
>> +
>>  /*
>>   * This function runs evconf->rate ns after sending a throttled
>>   * event.
>
> Preferably with these touch-ups.

np, ack

> Reviewed-by: Markus Armbruster <armbru@redhat.com>
>

thanks

--=20
Marc-Andr=C3=A9 Lureau
