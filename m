Received: from eggs.gnu.org ([209.51.188.92]:41598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gx9zx-0007RZ-3r
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 07:32:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gx9zv-0005b8-BQ
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 07:32:12 -0500
Received: from fanzine.igalia.com ([91.117.99.155]:44814)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1gx9zu-0005Q8-Iq
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 07:32:11 -0500
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <20190222121657.GP25234@redhat.com>
References: <cover.1550836631.git.berto@igalia.com>
	<a36c45f857a395a1d1bbcc67beae47e437569ab4.1550836631.git.berto@igalia.com>
	<20190222121657.GP25234@redhat.com>
Date: Fri, 22 Feb 2019 13:32:07 +0100
Message-ID: <w51zhqo57i0.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/3] char-socket: Lock
 tcp_chr_disconnect() and socket_reconnect_timeout()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Fri 22 Feb 2019 01:16:57 PM CET, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Feb 22, 2019 at 01:59:12PM +0200, Alberto Garcia wrote:
>> There's a race condition in which the tcp_chr_read() ioc handler can
>> close a connection that is being written to from another thread.
>>=20
>> Running iotest 136 in a loop triggers this problem and crashes QEMU.
>>=20
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
>>=20
>> This patch adds a lock to protect tcp_chr_disconnect() and
>> socket_reconnect_timeout()
>
> Can you think of any way to test this in the unit tests ?  I can
> understand if its too difficult but just curious if there's any viable
> option ?

I haven't thought about it. If anyone has a suggestion of how to
reproduce it we can add a new test later.

>>          if (ret < 0 && errno !=3D EAGAIN) {
>>              if (tcp_chr_read_poll(chr) <=3D 0) {
>> +                qemu_mutex_unlock(&chr->chr_write_lock);
>>                  tcp_chr_disconnect(chr);
>> +                qemu_mutex_lock(&chr->chr_write_lock);
>
> The idea of unlock & relocking here, just so tcp_chr_disconnect can
> also acquire locks, doesn't make me too happy. This is really an
> anti-pattern to me.

I'm not too happy about it either. I'll send a new version with
tcp_chr_disconnect_locked() as you suggest.

Berto
