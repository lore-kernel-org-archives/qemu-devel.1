Received: from eggs.gnu.org ([2001:4830:134:3::10]:35782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gTl4O-0001Wu-DL
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:03:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1gTl4J-0001hK-C1
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:03:16 -0500
Received: from mail-qk1-f169.google.com ([209.85.222.169]:46182)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1gTl4J-0001h1-6P
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 05:03:11 -0500
Received: by mail-qk1-f169.google.com with SMTP id q1so6903710qkf.13
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 02:03:11 -0800 (PST)
MIME-Version: 1.0
References: <20181029125733.14597-1-marcandre.lureau@redhat.com>
	<20181029125733.14597-7-marcandre.lureau@redhat.com>
	<87h8fv6jwy.fsf@dusky.pond.sub.org>
In-Reply-To: <87h8fv6jwy.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Mon, 3 Dec 2018 14:02:59 +0400
Message-ID: <CAMxuvay5YayhLaawFgroDh=DLGfjCYKnq3y+SKbecvEDTj9cjw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 6/6] monitor: avoid potential dead-lock
 when cleaning up
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Armbruster, Markus" <armbru@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Bonzini, Paolo" <pbonzini@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Xu <peterx@redhat.com>

On Mon, Dec 3, 2018 at 1:26 PM Markus Armbruster <armbru@redhat.com> wrote:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
> > When a monitor is connected to a Spice chardev, the monitor cleanup
> > can dead-lock:
> >
> >  #0  0x00007f43446637fd in __lll_lock_wait () at /lib64/libpthread.so.0
> >  #1  0x00007f434465ccf4 in pthread_mutex_lock () at /lib64/libpthread.s=
o.0
> >  #2  0x0000556dd79f22ba in qemu_mutex_lock_impl (mutex=3D0x556dd81c9220=
 <monitor_lock>, file=3D0x556dd7ae3648 "/home/elmarco/src/qq/monitor.c", li=
ne=3D645) at /home/elmarco/src/qq/util/qemu-thread-posix.c:66
> >  #3  0x0000556dd7431bd5 in monitor_qapi_event_queue (event=3DQAPI_EVENT=
_SPICE_DISCONNECTED, qdict=3D0x556dd9abc850, errp=3D0x7fffb7bbddd8) at /hom=
e/elmarco/src/qq/monitor.c:645
> >  #4  0x0000556dd79d476b in qapi_event_send_spice_disconnected (server=
=3D0x556dd98ee760, client=3D0x556ddaaa8560, errp=3D0x556dd82180d0 <error_ab=
ort>) at qapi/qapi-events-ui.c:149
> >  #5  0x0000556dd7870fc1 in channel_event (event=3D3, info=3D0x556ddad1b=
590) at /home/elmarco/src/qq/ui/spice-core.c:235
> >  #6  0x00007f434560a6bb in reds_handle_channel_event (reds=3D<optimized=
 out>, event=3D3, info=3D0x556ddad1b590) at reds.c:316
> >  #7  0x00007f43455f393b in main_dispatcher_self_handle_channel_event (i=
nfo=3D0x556ddad1b590, event=3D3, self=3D0x556dd9a7d8c0) at main-dispatcher.=
c:197
> >  #8  0x00007f43455f393b in main_dispatcher_channel_event (self=3D0x556d=
d9a7d8c0, event=3Devent@entry=3D3, info=3D0x556ddad1b590) at main-dispatche=
r.c:197
> >  #9  0x00007f4345612833 in red_stream_push_channel_event (s=3Ds@entry=
=3D0x556ddae2ef40, event=3Devent@entry=3D3) at red-stream.c:414
> >  #10 0x00007f434561286b in red_stream_free (s=3D0x556ddae2ef40) at red-=
stream.c:388
> >  #11 0x00007f43455f9ddc in red_channel_client_finalize (object=3D0x556d=
d9bb21a0) at red-channel-client.c:347
> >  #12 0x00007f434b5f9fb9 in g_object_unref () at /lib64/libgobject-2.0.s=
o.0
> >  #13 0x00007f43455fc212 in red_channel_client_push (rcc=3D0x556dd9bb21a=
0) at red-channel-client.c:1341
> >  #14 0x0000556dd76081ba in spice_port_set_fe_open (chr=3D0x556dd9925e20=
, fe_open=3D0) at /home/elmarco/src/qq/chardev/spice.c:241
> >  #15 0x0000556dd796d74a in qemu_chr_fe_set_open (be=3D0x556dd9a37c00, f=
e_open=3D0) at /home/elmarco/src/qq/chardev/char-fe.c:340
> >  #16 0x0000556dd796d4d9 in qemu_chr_fe_set_handlers (b=3D0x556dd9a37c00=
, fd_can_read=3D0x0, fd_read=3D0x0, fd_event=3D0x0, be_change=3D0x0, opaque=
=3D0x0, context=3D0x0, set_open=3Dtrue) at /home/elmarco/src/qq/chardev/cha=
r-fe.c:280
> >  #17 0x0000556dd796d359 in qemu_chr_fe_deinit (b=3D0x556dd9a37c00, del=
=3Dfalse) at /home/elmarco/src/qq/chardev/char-fe.c:233
> >  #18 0x0000556dd7432240 in monitor_data_destroy (mon=3D0x556dd9a37c00) =
at /home/elmarco/src/qq/monitor.c:786
> >  #19 0x0000556dd743b968 in monitor_cleanup () at /home/elmarco/src/qq/m=
onitor.c:4683
> >  #20 0x0000556dd75ce776 in main (argc=3D3, argv=3D0x7fffb7bbe458, envp=
=3D0x7fffb7bbe478) at /home/elmarco/src/qq/vl.c:4660
> >
> > Because spice code tries to emit a "disconnected" signal on the
> > monitors. Fix this dead-lock by releasing the monitor lock for
> > flush/destroy.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  monitor.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/monitor.c b/monitor.c
> > index 7fe89daa87..b55e604a98 100644
> > --- a/monitor.c
> > +++ b/monitor.c
> > @@ -4643,8 +4643,10 @@ void monitor_cleanup(void)
> >      monitor_destroyed =3D true;
> >      QTAILQ_FOREACH_SAFE(mon, &mon_list, entry, next) {
> >          QTAILQ_REMOVE(&mon_list, mon, entry);
> > +        qemu_mutex_unlock(&monitor_lock);
> >          monitor_flush(mon);
> >          monitor_data_destroy(mon);
> > +        qemu_mutex_lock(&monitor_lock);
> >          g_free(mon);
> >      }
> >      qemu_mutex_unlock(&monitor_lock);
>
> I think a comment hinting at the reason for relinquishing the lock would
> be in order.  Perhaps
>
>            /* Permit QAPI event emission from character frontend release =
*/
>            qemu_mutex_unlock(&monitor_lock);
>
> We need to demonstrate calling monitor_flush() and
> monitor_data_destroy() without holding @monitor_lock is safe.
>
> @monitor_lock's comment states it "protects mon_list,
> monitor_qapi_event_state."  Looks plausible from how it's used.
>
> As far as I can tell, monitor_flush() and monitor_data_destroy() don't
> access mon_list and monitor_qapi_event_state.
>
> monitor_cleanup()'s loop itself is safe because it uses
> QTAILQ_FOREACH_SAFE(), unlike similar loops elsewhere.
>
> I think we're good.  I'd like you to work this argument into the commit
> message.

What about adding:

    monitor_lock protects mon_list, monitor_qapi_event_state and
    monitor_destroyed. monitor_flush() and monitor_data_destroy() don't
    access any of those variables.

    monitor_cleanup()'s loop is safe because it uses
    QTAILQ_FOREACH_SAFE(), and no further monitor can be added after
    calling monitor_cleanup() thanks to monitor_destroyed check in
    monitor_list_append().
