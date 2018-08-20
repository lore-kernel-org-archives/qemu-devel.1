Received: from eggs.gnu.org ([2001:4830:134:3::10]:38627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1frogu-0002Ve-Mp
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 14:14:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1frogt-0006Q7-4N
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 14:14:12 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:33559)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1frogs-0006Og-N5
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 14:14:10 -0400
Received: by mail-wm0-x244.google.com with SMTP id i134-v6so7692466wmf.0
	for <qemu-devel@nongnu.org>; Mon, 20 Aug 2018 11:14:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180801093401.9160-1-marcandre.lureau@redhat.com>
	<871sbi8bsm.fsf@dusky.pond.sub.org>
	<CAJ+F1CJj=WPs0FOx8QJU76iFqhc11N7m+FnRG2t0USu0Jm6JTA@mail.gmail.com>
	<874lge6s4u.fsf@dusky.pond.sub.org>
	<CAJ+F1C+WmBtMG26nG0KmQCkKg9iUk6nxTi2P=t_qC22z3i5CWQ@mail.gmail.com>
	<87a7phtti5.fsf@dusky.pond.sub.org>
In-Reply-To: <87a7phtti5.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 20 Aug 2018 20:13:56 +0200
Message-ID: <CAJ+F1C+w-1ydsjDMkONdVOGVfhKUVB2bbos3+u7t1a67p8AfQQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] monitor: avoid potential dead-lock when
 cleaning up
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

Hi

On Mon, Aug 20, 2018 at 8:57 AM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>
> > Hi
> > On Wed, Aug 1, 2018 at 5:09 PM Markus Armbruster <armbru@redhat.com> wr=
ote:
> >>
> >> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
> >>
> >> > Hi
> >> >
> >> > On Wed, Aug 1, 2018 at 3:19 PM, Markus Armbruster <armbru@redhat.com=
> wrote:
> >> >> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
> >> >>
> >> >>> When a monitor is connected to a Spice chardev, the monitor cleanu=
p
> >> >>> can dead-lock:
> >> >>>
> >> >>>  #0  0x00007f43446637fd in __lll_lock_wait () at /lib64/libpthread=
.so.0
> >> >>>  #1  0x00007f434465ccf4 in pthread_mutex_lock () at /lib64/libpthr=
ead.so.0
> >> >>>  #2  0x0000556dd79f22ba in qemu_mutex_lock_impl (mutex=3D0x556dd81=
c9220 <monitor_lock>, file=3D0x556dd7ae3648 "/home/elmarco/src/qq/monitor.c=
", line=3D645) at /home/elmarco/src/qq/util/qemu-thread-posix.c:66
> >> >>>  #3  0x0000556dd7431bd5 in monitor_qapi_event_queue (event=3DQAPI_=
EVENT_SPICE_DISCONNECTED, qdict=3D0x556dd9abc850, errp=3D0x7fffb7bbddd8) at=
 /home/elmarco/src/qq/monitor.c:645
> >> >>>  #4  0x0000556dd79d476b in qapi_event_send_spice_disconnected (ser=
ver=3D0x556dd98ee760, client=3D0x556ddaaa8560, errp=3D0x556dd82180d0 <error=
_abort>) at qapi/qapi-events-ui.c:149
> >> >>>  #5  0x0000556dd7870fc1 in channel_event (event=3D3, info=3D0x556d=
dad1b590) at /home/elmarco/src/qq/ui/spice-core.c:235
> >> >>>  #6  0x00007f434560a6bb in reds_handle_channel_event (reds=3D<opti=
mized out>, event=3D3, info=3D0x556ddad1b590) at reds.c:316
> >> >>>  #7  0x00007f43455f393b in main_dispatcher_self_handle_channel_eve=
nt (info=3D0x556ddad1b590, event=3D3, self=3D0x556dd9a7d8c0) at main-dispat=
cher.c:197
> >> >>>  #8  0x00007f43455f393b in main_dispatcher_channel_event (self=3D0=
x556dd9a7d8c0, event=3Devent@entry=3D3, info=3D0x556ddad1b590) at main-disp=
atcher.c:197
> >> >>>  #9  0x00007f4345612833 in red_stream_push_channel_event (s=3Ds@en=
try=3D0x556ddae2ef40, event=3Devent@entry=3D3) at red-stream.c:414
> >> >>>  #10 0x00007f434561286b in red_stream_free (s=3D0x556ddae2ef40) at=
 red-stream.c:388
> >> >>>  #11 0x00007f43455f9ddc in red_channel_client_finalize (object=3D0=
x556dd9bb21a0) at red-channel-client.c:347
> >> >>>  #12 0x00007f434b5f9fb9 in g_object_unref () at /lib64/libgobject-=
2.0.so.0
> >> >>>  #13 0x00007f43455fc212 in red_channel_client_push (rcc=3D0x556dd9=
bb21a0) at red-channel-client.c:1341
> >> >>>  #14 0x0000556dd76081ba in spice_port_set_fe_open (chr=3D0x556dd99=
25e20, fe_open=3D0) at /home/elmarco/src/qq/chardev/spice.c:241
> >> >>>  #15 0x0000556dd796d74a in qemu_chr_fe_set_open (be=3D0x556dd9a37c=
00, fe_open=3D0) at /home/elmarco/src/qq/chardev/char-fe.c:340
> >> >>>  #16 0x0000556dd796d4d9 in qemu_chr_fe_set_handlers (b=3D0x556dd9a=
37c00, fd_can_read=3D0x0, fd_read=3D0x0, fd_event=3D0x0, be_change=3D0x0, o=
paque=3D0x0, context=3D0x0, set_open=3Dtrue) at /home/elmarco/src/qq/charde=
v/char-fe.c:280
> >> >>>  #17 0x0000556dd796d359 in qemu_chr_fe_deinit (b=3D0x556dd9a37c00,=
 del=3Dfalse) at /home/elmarco/src/qq/chardev/char-fe.c:233
> >> >>>  #18 0x0000556dd7432240 in monitor_data_destroy (mon=3D0x556dd9a37=
c00) at /home/elmarco/src/qq/monitor.c:786
> >> >>>  #19 0x0000556dd743b968 in monitor_cleanup () at /home/elmarco/src=
/qq/monitor.c:4683
> >> >>>  #20 0x0000556dd75ce776 in main (argc=3D3, argv=3D0x7fffb7bbe458, =
envp=3D0x7fffb7bbe478) at /home/elmarco/src/qq/vl.c:4660
> >> >>>
> >> >>> Because spice code tries to emit a "disconnected" signal on the
> >> >>> monitors. Fix this situation by tightening the monitor lock time t=
o
> >> >>> the monitor list removal.
> >> >>>
> >> >>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com=
>
> >> >>
> >> >> Do you think this should go into 3.0?
> >> >>
> >> >>> ---
> >> >>>  monitor.c | 22 +++++++++++++++-------
> >> >>>  1 file changed, 15 insertions(+), 7 deletions(-)
> >> >>>
> >> >>> diff --git a/monitor.c b/monitor.c
> >> >>> index 0fa0910a2a..a16a6c5311 100644
> >> >>> --- a/monitor.c
> >> >>> +++ b/monitor.c
> >> >>> @@ -4702,8 +4702,6 @@ void monitor_init(Chardev *chr, int flags)
> >> >>>
> >> >>>  void monitor_cleanup(void)
> >> >>>  {
> >> >>> -    Monitor *mon, *next;
> >> >>> -
> >> >>>      /*
> >> >>>       * We need to explicitly stop the I/O thread (but not destroy=
 it),
> >> >>>       * clean up the monitor resources, then destroy the I/O threa=
d since
> >> >>> @@ -4719,14 +4717,24 @@ void monitor_cleanup(void)
> >> >>>      monitor_qmp_bh_responder(NULL);
> >> >>>
> >> >>>      /* Flush output buffers and destroy monitors */
> >> >>> -    qemu_mutex_lock(&monitor_lock);
> >> >>> -    QTAILQ_FOREACH_SAFE(mon, &mon_list, entry, next) {
> >> >>> -        QTAILQ_REMOVE(&mon_list, mon, entry);
> >> >>> +    do {
> >> >>
> >> >> for (;;), please.
> >> >>
> >> >>> +        Monitor *mon;
> >> >>> +
> >> >>> +        qemu_mutex_lock(&monitor_lock);
> >> >>> +        mon =3D QTAILQ_FIRST(&mon_list);
> >> >>> +        if (mon) {
> >> >>> +            QTAILQ_REMOVE(&mon_list, mon, entry);
> >> >>> +        }
> >> >>> +        qemu_mutex_unlock(&monitor_lock);
> >> >>> +
> >> >>> +        if (!mon) {
> >> >>> +            break;
> >> >>> +        }
> >> >>> +
> >> >>>          monitor_flush(mon);
> >> >>>          monitor_data_destroy(mon);
> >> >>>          g_free(mon);
> >> >>> -    }
> >> >>> -    qemu_mutex_unlock(&monitor_lock);
> >> >>> +    } while (true);
> >> >>>
> >> >>>      /* QEMUBHs needs to be deleted before destroying the I/O thre=
ad */
> >> >>>      qemu_bh_delete(qmp_dispatcher_bh);
> >> >>
> >> >> Iterating safely over a list protected by a lock should be easier t=
han
> >> >> that.  Sad.
> >> >>
> >> >> Hmm, what about this:
> >> >>
> >> >> diff --git a/monitor.c b/monitor.c
> >> >> index 77861e96af..4a23f6c7bc 100644
> >> >> --- a/monitor.c
> >> >> +++ b/monitor.c
> >> >> @@ -4721,9 +4721,11 @@ void monitor_cleanup(void)
> >> >>      qemu_mutex_lock(&monitor_lock);
> >> >>      QTAILQ_FOREACH_SAFE(mon, &mon_list, entry, next) {
> >> >>          QTAILQ_REMOVE(&mon_list, mon, entry);
> >> >> +        qemu_mutex_unlock(&monitor_lock);
> >> >>          monitor_flush(mon);
> >> >>          monitor_data_destroy(mon);
> >> >>          g_free(mon);
> >> >> +        qemu_mutex_lock(&monitor_lock);
> >> >
> >> > Although unlikely, there is a chance the monitor list could be
> >> > modified while flushing/cleaning up, I suppose, in this case we coul=
d
> >> > miss the new monitors (if next is NULL).
> >>
> >> Your loop prevents that from happening while it runs, but does nothing
> >> to stop it from happening afterwards.  If we want to lock out new
> >> monitors, we need to make monitor_init() fail or impossible to call.
> >
> > Not so trivial. Is there other threads capable of calling
> > monitor_init() by the time monitor_cleanup() is called? It looks like
> > monitor_init() may only be called from the main thread.
>
> Callers:
>
> * gdbserver_start()
>
>   CLI option -gdb, HMP command gdbserver, linux user CLI option -g and
>   environment variable QEMU_GDB
>
>   The interesting one is the HMP command.  Does your loop lock it out?
>   If we run it only in the main thread, and we run the HMP command only
>   in the main thread, it obviously does.
>
> * mon_init_func()
>
>   CLI option -mon and its convenience buddies -monitor, -qmp,
>   -qmp-pretty
>
>   We don't have a monitor command to spawn off a new monitor, but we
>   could have.
>
> * qemu_chr_new_noreplay()
>
>   gdbserver_start() again, and qemu_chr_new(), which is called all over
>   the place.  I lack the time to review these calls.  Are you sure this
>   one can only run in the main thread?
>

No, I am not sure, but I would consider it a bug today. However, if
it's possible to keep using the monitor or create new monitor after
monitor_cleanup() is called, we have probably have more issues to
solve.

However, this problem is not directly related to the dead-lock fixed
here, and the problem is pre-existing.

Probably the cleanup code would have to look different if we want to
solve the init/cleanup races, but that's a different fix. Do we have
to solve it first, or can we add a FIXME?

> Synchronizing monitor creation and cleanup explicitly might be cleaner.
> I guess monitor_lock kind of sort of almost does that before your patch,
> but it can deadlock because it's too coarse.
>
> I'm afraid we need to rethink the set of locks protecting shared monitor
> state.

Yes, and probably change a bit monitor/chardev creation to be under
tighter control...

--=20
Marc-Andr=C3=A9 Lureau
