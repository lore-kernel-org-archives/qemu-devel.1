Received: from eggs.gnu.org ([209.51.188.92]:52568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1grN4g-0008Lh-A0
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:17:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1grMpp-0006li-IK
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:01:53 -0500
Received: from fanzine.igalia.com ([91.117.99.155]:60821)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1grMpn-0006ig-MI
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 08:01:48 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20190206124902.GI12331@redhat.com>
References: <20190206124345.14942-1-berto@igalia.com>
	<20190206124902.GI12331@redhat.com>
Date: Wed, 06 Feb 2019 14:01:39 +0100
Message-ID: <w51tvhhrryk.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH] char-socket: hold chr_write_lock
 during tcp_chr_free_connection()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Wed 06 Feb 2019 01:49:02 PM CET, Daniel P. Berrang=C3=A9 wrote:
>>  (gdb) bt
>>  #0  0x00005558b842902d in object_get_class (obj=3D0x0) at qom/object.c:=
860
>>  #1  0x00005558b84f92db in qio_channel_writev_full (ioc=3D0x0, iov=3D0x7=
ffc355decf0, niov=3D1, fds=3D0x0, nfds=3D0, errp=3D0x0) at io/channel.c:76
>>  #2  0x00005558b84e0e9e in io_channel_send_full (ioc=3D0x0, buf=3D0x5558=
baf5beb0, len=3D138, fds=3D0x0, nfds=3D0) at chardev/char-io.c:123
>>  #3  0x00005558b84e4a69 in tcp_chr_write (chr=3D0x5558ba460380, buf=3D0x=
5558baf5beb0 "...", len=3D138) at chardev/char-socket.c:135
>>  #4  0x00005558b84dca55 in qemu_chr_write_buffer (s=3D0x5558ba460380, bu=
f=3D0x5558baf5beb0 "...", len=3D138, offset=3D0x7ffc355dedd0, write_all=3Df=
alse) at chardev/char.c:112
>>  #5  0x00005558b84dcbc2 in qemu_chr_write (s=3D0x5558ba460380, buf=3D0x5=
558baf5beb0 "...", len=3D138, write_all=3Dfalse) at chardev/char.c:147
>>  #6  0x00005558b84dfb26 in qemu_chr_fe_write (be=3D0x5558ba476610, buf=
=3D0x5558baf5beb0 "...", len=3D138) at chardev/char-fe.c:42
>>  #7  0x00005558b8088c86 in monitor_flush_locked (mon=3D0x5558ba476610) a=
t monitor.c:406
>>  #8  0x00005558b8088e8c in monitor_puts (mon=3D0x5558ba476610, str=3D0x5=
558ba921e49 "") at monitor.c:449
>>  #9  0x00005558b8089178 in qmp_send_response (mon=3D0x5558ba476610, rsp=
=3D0x5558bb161600) at monitor.c:498
>>  #10 0x00005558b808920c in monitor_qapi_event_emit (event=3DQAPI_EVENT_S=
HUTDOWN, qdict=3D0x5558bb161600) at monitor.c:526
>>  #11 0x00005558b8089307 in monitor_qapi_event_queue_no_reenter (event=3D=
QAPI_EVENT_SHUTDOWN, qdict=3D0x5558bb161600) at monitor.c:551
>>  #12 0x00005558b80896c0 in qapi_event_emit (event=3DQAPI_EVENT_SHUTDOWN,=
 qdict=3D0x5558bb161600) at monitor.c:626
>>  #13 0x00005558b855f23b in qapi_event_send_shutdown (guest=3Dfalse, reas=
on=3DSHUTDOWN_CAUSE_HOST_QMP_QUIT) at qapi/qapi-events-run-state.c:43
>>  #14 0x00005558b81911ef in qemu_system_shutdown (cause=3DSHUTDOWN_CAUSE_=
HOST_QMP_QUIT) at vl.c:1837
>>  #15 0x00005558b8191308 in main_loop_should_exit () at vl.c:1885
>>  #16 0x00005558b819140d in main_loop () at vl.c:1924
>>  #17 0x00005558b8198c84 in main (argc=3D18, argv=3D0x7ffc355df3f8, envp=
=3D0x7ffc355df490) at vl.c:4665
>
> This shows the main thread trace - i'd be interested to see a trace of
> the other thread which is calling tcp_chr_free_connection() to
> understand why we have 2 threads racing at all.

The other thread is already done by the time this one crashes, but you
can see what's going on if you replace the qemu_mutex_lock() call in
this patch with a trylock() + an assertion:

#0  __GI_raise (sig=3Dsig@entry=3D6) at ../sysdeps/unix/sysv/linux/raise.c:=
51
#1  0x00007fafc05e642a in __GI_abort () at abort.c:89
#2  0x00007fafc05dde67 in __assert_fail_base (fmt=3D<optimized out>, assert=
ion=3Dassertion@entry=3D0x55a4dbe78448 "qemu_mutex_trylock(&chr->chr_write_=
lock) !=3D -EBUSY",=20
    file=3Dfile@entry=3D0x55a4dbe78320 "chardev/char-socket.c", line=3Dline=
@entry=3D452,=20
    function=3Dfunction@entry=3D0x55a4dbe788d0 <__PRETTY_FUNCTION__.20007> =
"tcp_chr_disconnect") at assert.c:92
#3  0x00007fafc05ddf12 in __GI___assert_fail (assertion=3D0x55a4dbe78448 "q=
emu_mutex_trylock(&chr->chr_write_lock) !=3D -EBUSY",=20
    file=3D0x55a4dbe78320 "chardev/char-socket.c", line=3D452, function=3D0=
x55a4dbe788d0 <__PRETTY_FUNCTION__.20007> "tcp_chr_disconnect")
    at assert.c:101
#4  0x000055a4dbbbdab1 in tcp_chr_disconnect (chr=3D0x55a4dc76e380) at char=
dev/char-socket.c:452
#5  0x000055a4dbbbdca0 in tcp_chr_read (chan=3D0x55a4dc76e770, cond=3D(G_IO=
_IN | G_IO_HUP), opaque=3D0x55a4dc76e380) at chardev/char-socket.c:486
#6  0x000055a4dbbd7f76 in qio_channel_fd_source_dispatch (source=3D0x7fafac=
005000, callback=3D0x55a4dbbbdb5c <tcp_chr_read>, user_data=3D0x55a4dc76e38=
0)
    at io/channel-watch.c:84
#7  0x00007fafc3ad16aa in g_main_context_dispatch () from /lib/x86_64-linux=
-gnu/libglib-2.0.so.0
#8  0x00007fafc3ad1a60 in ?? () from /lib/x86_64-linux-gnu/libglib-2.0.so.0
#9  0x00007fafc3ad1d82 in g_main_loop_run () from /lib/x86_64-linux-gnu/lib=
glib-2.0.so.0
#10 0x000055a4db8601f9 in iothread_run (opaque=3D0x55a4dc781440) at iothrea=
d.c:74
#11 0x000055a4dbc57039 in qemu_thread_start (args=3D0x55a4dc774c10) at util=
/qemu-thread-posix.c:502
#12 0x00007fafc0958494 in start_thread (arg=3D0x7fafb23aa700) at pthread_cr=
eate.c:333
#13 0x00007fafc069aacf in clone () at ../sysdeps/unix/sysv/linux/x86_64/clo=
ne.S:97

Berto
