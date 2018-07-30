Received: from eggs.gnu.org ([2001:4830:134:3::10]:42269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fk82x-0001wK-27
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 09:17:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fk82s-0007vF-UQ
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 09:17:11 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52188 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fk82s-0007ul-Nk
	for qemu-devel@nongnu.org; Mon, 30 Jul 2018 09:17:06 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 31B4740201BD
	for <qemu-devel@nongnu.org>; Mon, 30 Jul 2018 13:17:06 +0000 (UTC)
Date: Mon, 30 Jul 2018 14:17:02 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180730131702.GJ1626@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180730125746.22794-1-marcandre.lureau@redhat.com>
	<20180730130526.GI1626@redhat.com>
	<CAMxuvazdTPupFNVfCy_hO3Vqh+ZCWeYfroe4EbAMVwwg7T7jZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMxuvazdTPupFNVfCy_hO3Vqh+ZCWeYfroe4EbAMVwwg7T7jZQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC] monitor: temporary fix for dead-lock
 on event recursion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Armbruster, Markus" <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On Mon, Jul 30, 2018 at 03:09:08PM +0200, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Mon, Jul 30, 2018 at 3:05 PM, Daniel P. Berrang=C3=A9 <berrange@redh=
at.com> wrote:
> > On Mon, Jul 30, 2018 at 02:57:46PM +0200, Marc-Andr=C3=A9 Lureau wrot=
e:
> >> With a Spice port chardev, it is possible to reenter
> >> monitor_qapi_event_queue() (when the client disconnects for
> >> example). This will dead-lock on monitor_lock.
> >>
> >> Instead, use some TLS variables to check for recursion and queue the
> >> events.
> >
> > I wonder if it would be clearer to just change
> > qapi_event_send_spice_disconnected() so that it use g_idle_add() to
> > send the QAPI_EVENT_SPICE_DISCONNECTED event, as I don't see a strong
> > reason to sent that sychronously. This would avoid the recursion prob=
lem.
>=20
> Yes, I seriously thought about that solution. But in the end, the bug
> is in monitor code: it should be fixed there at some point. And it
> could in theory happen with a different code path than Spice.

The question is what we consider the API contract to be for the chardevs
that are used by the monitor. eg is the chardev I/O function permitted to
emit monitor events. Given that chardevs are widely used for lots of
backends, I guess I would probably say chardevs should be allowed to
emit monitor events, which does put the burden on the monitor code to
handle recursion.

I wonder if we could still use g_idle_add() though but in a different
place. The monitor_qapi_event_queue() method already emits events
asynchronously if they are tagged as needing rate limiting. So instead
of directly calling monitor_qapi_event_emit() in the non-rate limited
branch, we could send that call via g_idle_add(), so that all events
are emitted asynchronously. This would avoid monitor_qapi_event_queue()
becoming a re-entrancy problem.

I think g_idle_add() calls are processed in the order in which they
are registered, so event orderin should still be preserved.

> >> Fixes:
> >>  (gdb) bt
> >>  #0  0x00007fa69e7217fd in __lll_lock_wait () at /lib64/libpthread.s=
o.0
> >>  #1  0x00007fa69e71acf4 in pthread_mutex_lock () at /lib64/libpthrea=
d.so.0
> >>  #2  0x0000563303567619 in qemu_mutex_lock_impl (mutex=3D0x563303d3e=
220 <monitor_lock>, file=3D0x5633036589a8 "/home/elmarco/src/qq/monitor.c=
", line=3D645) at /home/elmarco/src/qq/util/qemu-thread-posix.c:66
> >>  #3  0x0000563302fa6c25 in monitor_qapi_event_queue (event=3DQAPI_EV=
ENT_SPICE_DISCONNECTED, qdict=3D0x56330602bde0, errp=3D0x7ffc6ab5e728) at=
 /home/elmarco/src/qq/monitor.c:645
> >>  #4  0x0000563303549aca in qapi_event_send_spice_disconnected (serve=
r=3D0x563305afd630, client=3D0x563305745360, errp=3D0x563303d8d0f0 <error=
_abort>) at qapi/qapi-events-ui.c:149
> >>  #5  0x00005633033e600f in channel_event (event=3D3, info=3D0x563306=
1b0050) at /home/elmarco/src/qq/ui/spice-core.c:235
> >>  #6  0x00007fa69f6c86bb in reds_handle_channel_event (reds=3D<optimi=
zed out>, event=3D3, info=3D0x5633061b0050) at reds.c:316
> >>  #7  0x00007fa69f6b193b in main_dispatcher_self_handle_channel_event=
 (info=3D0x5633061b0050, event=3D3, self=3D0x563304e088c0) at main-dispat=
cher.c:197
> >>  #8  0x00007fa69f6b193b in main_dispatcher_channel_event (self=3D0x5=
63304e088c0, event=3Devent@entry=3D3, info=3D0x5633061b0050) at main-disp=
atcher.c:197
> >>  #9  0x00007fa69f6d0833 in red_stream_push_channel_event (s=3Ds@entr=
y=3D0x563305ad8f50, event=3Devent@entry=3D3) at red-stream.c:414
> >>  #10 0x00007fa69f6d086b in red_stream_free (s=3D0x563305ad8f50) at r=
ed-stream.c:388
> >>  #11 0x00007fa69f6b7ddc in red_channel_client_finalize (object=3D0x5=
63304df2360) at red-channel-client.c:347
> >>  #12 0x00007fa6a56b7fb9 in g_object_unref () at /lib64/libgobject-2.=
0.so.0
> >>  #13 0x00007fa69f6ba212 in red_channel_client_push (rcc=3D0x563304df=
2360) at red-channel-client.c:1341
> >>  #14 0x00007fa69f68b259 in red_char_device_send_msg_to_client (clien=
t=3D<optimized out>, msg=3D0x5633059b6310, dev=3D0x563304e08bc0) at char-=
device.c:305
> >>  #15 0x00007fa69f68b259 in red_char_device_send_msg_to_clients (msg=3D=
0x5633059b6310, dev=3D0x563304e08bc0) at char-device.c:305
> >>  #16 0x00007fa69f68b259 in red_char_device_read_from_device (dev=3D0=
x563304e08bc0) at char-device.c:353
> >>  #17 0x000056330317d01d in spice_chr_write (chr=3D0x563304cafe20, bu=
f=3D0x563304cc50b0 "{\"timestamp\": {\"seconds\": 1532944763, \"microseco=
nds\": 326636}, \"event\": \"SHUTDOWN\", \"data\": {\"guest\": false}}\r\=
n", len=3D111) at /home/elmarco/src/qq/chardev/spice.c:199
> >>  #18 0x00005633034deee7 in qemu_chr_write_buffer (s=3D0x563304cafe20=
, buf=3D0x563304cc50b0 "{\"timestamp\": {\"seconds\": 1532944763, \"micro=
seconds\": 326636}, \"event\": \"SHUTDOWN\", \"data\": {\"guest\": false}=
}\r\n", len=3D111, offset=3D0x7ffc6ab5ea70, write_all=3Dfalse) at /home/e=
lmarco/src/qq/chardev/char.c:112
> >>  #19 0x00005633034df054 in qemu_chr_write (s=3D0x563304cafe20, buf=3D=
0x563304cc50b0 "{\"timestamp\": {\"seconds\": 1532944763, \"microseconds\=
": 326636}, \"event\": \"SHUTDOWN\", \"data\": {\"guest\": false}}\r\n", =
len=3D111, write_all=3Dfalse) at /home/elmarco/src/qq/chardev/char.c:147
> >>  #20 0x00005633034e1e13 in qemu_chr_fe_write (be=3D0x563304dbb800, b=
uf=3D0x563304cc50b0 "{\"timestamp\": {\"seconds\": 1532944763, \"microsec=
onds\": 326636}, \"event\": \"SHUTDOWN\", \"data\": {\"guest\": false}}\r=
\n", len=3D111) at /home/elmarco/src/qq/chardev/char-fe.c:42
> >>  #21 0x0000563302fa6334 in monitor_flush_locked (mon=3D0x563304dbb80=
0) at /home/elmarco/src/qq/monitor.c:425
> >>  #22 0x0000563302fa6520 in monitor_puts (mon=3D0x563304dbb800, str=3D=
0x563305de7e9e "") at /home/elmarco/src/qq/monitor.c:468
> >>  #23 0x0000563302fa680c in qmp_send_response (mon=3D0x563304dbb800, =
rsp=3D0x563304df5730) at /home/elmarco/src/qq/monitor.c:517
> >>  #24 0x0000563302fa6905 in qmp_queue_response (mon=3D0x563304dbb800,=
 rsp=3D0x563304df5730) at /home/elmarco/src/qq/monitor.c:538
> >>  #25 0x0000563302fa6b5b in monitor_qapi_event_emit (event=3DQAPI_EVE=
NT_SHUTDOWN, qdict=3D0x563304df5730) at /home/elmarco/src/qq/monitor.c:62=
4
> >>  #26 0x0000563302fa6c4b in monitor_qapi_event_queue (event=3DQAPI_EV=
ENT_SHUTDOWN, qdict=3D0x563304df5730, errp=3D0x7ffc6ab5ed00) at /home/elm=
arco/src/qq/monitor.c:649
> >>  #27 0x0000563303548cce in qapi_event_send_shutdown (guest=3Dfalse, =
errp=3D0x563303d8d0f0 <error_abort>) at qapi/qapi-events-run-state.c:58
> >>  #28 0x000056330313bcd7 in main_loop_should_exit () at /home/elmarco=
/src/qq/vl.c:1822
> >>  #29 0x000056330313bde3 in main_loop () at /home/elmarco/src/qq/vl.c=
:1862
> >>  #30 0x0000563303143781 in main (argc=3D3, argv=3D0x7ffc6ab5f068, en=
vp=3D0x7ffc6ab5f088) at /home/elmarco/src/qq/vl.c:4644
> >>
> >> Note that error report is now moved to the first caller, which may
> >> receive an error for a recursed event. This is probably fine (95% of
> >> callers use &error_abort, the rest have NULL error and ignore it)
> >>
> >> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> >> ---
> >>  monitor.c | 51 ++++++++++++++++++++++++++++++++++++++++++++++++++-
> >>  1 file changed, 50 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/monitor.c b/monitor.c
> >> index d8d8211ae4..d580c5a79c 100644
> >> --- a/monitor.c
> >> +++ b/monitor.c
> >> @@ -633,7 +633,7 @@ static void monitor_qapi_event_handler(void *opa=
que);
> >>   * applying any rate limiting if required.
> >>   */
> >>  static void
> >> -monitor_qapi_event_queue(QAPIEvent event, QDict *qdict, Error **err=
p)
> >> +monitor_qapi_event_queue_no_recurse(QAPIEvent event, QDict *qdict, =
Error **errp)
> >>  {
> >>      MonitorQAPIEventConf *evconf;
> >>      MonitorQAPIEventState *evstate;
> >> @@ -688,6 +688,55 @@ monitor_qapi_event_queue(QAPIEvent event, QDict=
 *qdict, Error **errp)
> >>      qemu_mutex_unlock(&monitor_lock);
> >>  }
> >>
> >> +static void
> >> +monitor_qapi_event_queue(QAPIEvent event, QDict *qdict, Error **err=
p)
> >> +{
> >> +    Error *local_err =3D NULL;
> >> +    /*
> >> +     * If the function recurse, monitor_lock will dead-lock.
> >> +     * Instead, queue pending events in TLS.
> >> +     * TODO: remove this, make it re-enter safe.
> >> +     */
> >> +    static __thread bool recurse;
> >> +    typedef struct MonitorQapiEvent {
> >> +        QAPIEvent event;
> >> +        QDict *qdict;
> >> +        QSIMPLEQ_ENTRY(MonitorQapiEvent) entry;
> >> +    } MonitorQapiEvent;
> >> +    MonitorQapiEvent *ev;
> >> +    static __thread QSIMPLEQ_HEAD(, MonitorQapiEvent) event_queue;
> >> +
> >> +    if (!recurse) {
> >> +        QSIMPLEQ_INIT(&event_queue);
> >> +    }
> >> +
> >> +    ev =3D g_new(MonitorQapiEvent, 1);
> >> +    ev->qdict =3D qobject_ref(qdict);
> >> +    ev->event =3D event;
> >> +    QSIMPLEQ_INSERT_TAIL(&event_queue, ev, entry);
> >> +    if (recurse) {
> >> +        return;
> >> +    }
> >> +
> >> +    recurse =3D true;
> >> +
> >> +    while ((ev =3D QSIMPLEQ_FIRST(&event_queue)) !=3D NULL) {
> >> +        QSIMPLEQ_REMOVE_HEAD(&event_queue, entry);
> >> +        if (!local_err) {
> >> +            monitor_qapi_event_queue_no_recurse(ev->event, ev->qdic=
t,
> >> +                                                &local_err);
> >> +        }
> >> +        qobject_unref(ev->qdict);
> >> +        g_free(ev);
> >> +    }
> >> +
> >> +    recurse =3D false;
> >> +
> >> +    if (local_err) {
> >> +        error_propagate(errp, local_err);
> >> +    }
> >> +}
> >> +
> >>  /*
> >>   * This function runs evconf->rate ns after sending a throttled
> >>   * event.
> >> --
> >> 2.18.0.232.gb7bd9486b0
> >>
> >>
> >
> > Regards,
> > Daniel
> > --
> > |: https://berrange.com      -o-    https://www.flickr.com/photos/dbe=
rrange :|
> > |: https://libvirt.org         -o-            https://fstop138.berran=
ge.com :|
> > |: https://entangle-photo.org    -o-    https://www.instagram.com/dbe=
rrange :|

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
