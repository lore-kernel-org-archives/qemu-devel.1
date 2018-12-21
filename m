Received: from eggs.gnu.org ([2001:4830:134:3::10]:53501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gaTKD-0006fc-1h
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 17:31:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gaTK3-0000FA-78
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 17:31:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41326)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1gaTK1-0000CU-7O
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 17:31:09 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 598D688E54
	for <qemu-devel@nongnu.org>; Fri, 21 Dec 2018 22:31:08 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f10356c5-c6db-8019-62e4-8ef41e607bf1@redhat.com>
Date: Fri, 21 Dec 2018 23:31:03 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fCC3xNs48QGfIpDLHHot3MaqLbK2Ttqo9"
Subject: [Qemu-devel] Segfaults in chardev due to races
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fCC3xNs48QGfIpDLHHot3MaqLbK2Ttqo9
From: Max Reitz <mreitz@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Message-ID: <f10356c5-c6db-8019-62e4-8ef41e607bf1@redhat.com>
Subject: Segfaults in chardev due to races
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

While fixing iotest 147 (which currently cannot be run in parallel),
I've noticed that after it's fixed (and does run in parallel), I see
some segfaults in chardev/char-socket.c.

They usually look like this:

#0  0x0000556f3b5765d0 in object_get_class (obj=3Dobj@entry=3D0x0) at
qom/object.c:822
#1  0x0000556f3b6162a5 in qio_channel_writev_full (ioc=3D0x0,
iov=3D0x7fffc8bc9aa0, niov=3D1, fds=3D0x0, nfds=3D0, errp=3D0x0) at io/ch=
annel.c:76
#2  0x0000556f3b6056b4 in io_channel_send_full (ioc=3D0x0,
buf=3Dbuf@entry=3D0x7fd3a4006be0, len=3Dlen@entry=3D138, fds=3D0x0, nfds=3D=
0) at
chardev/char-io.c:123
#3  0x0000556f3b60a50b in tcp_chr_write
    (chr=3D0x556f3cfa8600, buf=3D0x7fd3a4006be0 "{\"timestamp\":
{\"seconds\": 1545429461, \"microseconds\": 104325}, \"event\":
\"SHUTDOWN\", \"data\": {\"guest\": false, \"reason\":
\"host-qmp-quit\"}}\r\n", len=3D138)
    at chardev/char-socket.c:135
#4  0x0000556f3b602440 in qemu_chr_write_buffer
    (s=3Ds@entry=3D0x556f3cfa8600, buf=3Dbuf@entry=3D0x7fd3a4006be0
"{\"timestamp\": {\"seconds\": 1545429461, \"microseconds\": 104325},
\"event\": \"SHUTDOWN\", \"data\": {\"guest\": false, \"reason\":
\"host-qmp-quit\"}}\r\n", len=3D138, offset=3Doffset@entry=3D0x7fffc8bc9b=
90,
write_all=3Dfalse) at chardev/char.c:112
#5  0x0000556f3b6026ef in qemu_chr_write
    (s=3D0x556f3cfa8600, buf=3Dbuf@entry=3D0x7fd3a4006be0 "{\"timestamp\"=
:
{\"seconds\": 1545429461, \"microseconds\": 104325}, \"event\":
\"SHUTDOWN\", \"data\": {\"guest\": false, \"reason\":
\"host-qmp-quit\"}}\r\n", len=3D<optimized out>,
write_all=3Dwrite_all@entry=3Dfalse) at chardev/char.c:147
#6  0x0000556f3b6046af in qemu_chr_fe_write
    (be=3Dbe@entry=3D0x556f3cece140, buf=3Dbuf@entry=3D0x7fd3a4006be0
"{\"timestamp\": {\"seconds\": 1545429461, \"microseconds\": 104325},
\"event\": \"SHUTDOWN\", \"data\": {\"guest\": false, \"reason\":
\"host-qmp-quit\"}}\r\n", len=3D<optimized out>) at chardev/char-fe.c:42
#7  0x0000556f3b2513d8 in monitor_flush_locked
(mon=3Dmon@entry=3D0x556f3cece140) at monitor.c:406
#8  0x0000556f3b2515a9 in monitor_flush_locked (mon=3D0x556f3cece140) at
monitor.c:449
#9  0x0000556f3b2515a9 in monitor_puts (mon=3Dmon@entry=3D0x556f3cece140,=

str=3D0x556f3de59919 "") at monitor.c:449
#10 0x0000556f3b2515ef in qmp_send_response (mon=3D0x556f3cece140,
rsp=3D<optimized out>) at monitor.c:498
#11 0x0000556f3b2517ea in monitor_qapi_event_emit
(event=3Devent@entry=3DQAPI_EVENT_SHUTDOWN,
qdict=3Dqdict@entry=3D0x556f3e4613e0) at monitor.c:526
#12 0x0000556f3b251b22 in monitor_qapi_event_queue_no_reenter
(qdict=3D0x556f3e4613e0, event=3DQAPI_EVENT_SHUTDOWN) at monitor.c:551
#13 0x0000556f3b251b22 in monitor_qapi_event_queue
(event=3DQAPI_EVENT_SHUTDOWN, qdict=3D0x0) at monitor.c:627
#14 0x0000556f3b251b22 in monitor_qapi_event_queue
(event=3Devent@entry=3DQAPI_EVENT_SHUTDOWN,
qdict=3Dqdict@entry=3D0x556f3e4613e0) at monitor.c:594
#15 0x0000556f3b6563f1 in qapi_event_send_shutdown (guest=3D<optimized
out>, reason=3D<optimized out>) at qapi/qapi-events-run-state.c:49
#16 0x0000556f3b37ac07 in main_loop_should_exit () at
include/sysemu/sysemu.h:36
#17 0x0000556f3b37ac07 in main_loop () at vl.c:1909
#18 0x0000556f3b207735 in main (argc=3D<optimized out>, argv=3D<optimized=

out>, envp=3D<optimized out>) at vl.c:4661


Investigating, I saw that sometimes tcp_chr_write() is invoked in
parallel with tcp_chr_free_connection() -- from two different
AioContexts (and two different pthreads).  s->ioc is set to NULL before
s->connected is set to 0, and because these run concurrently,
tcp_chr_write() sees the s->connected as 1 and then fetches the
already-NULL s->ioc which causes the segfault.

The issue is more easily reproducible by inserting the following into
tcp_chr_free_connection() above "s->connected =3D 0;":

     for (volatile int i =3D 0; i < 1000000; i++) {
         __asm__ __volatile__ ("" ::: "memory");

     }


Then, run this command line:

$ x86_64-softmmu/qemu-system-x86_64 -qmp tcp:localhost:4242,server

And this script:

#!/usr/bin/ruby
require 'socket'
c =3D TCPSocket.new('localhost', 4242)
c.readline
c.puts("{'execute':'qmp_capabilities'}")
c.readline
c.puts("{'execute':'quit'}")
c.close

(The above backtrace was generated this way because for some reason,
after everything, I couldn't see the segfaults in 147 any more.  Huh.
But anyway, the loop I added does not yield a coroutine or anything like
that, it just enlarges the race window, so I think it still is a real
issue.)

Now I thought it would suffice to just pull "s->disconnected =3D 0;" up t=
o
the start of tcp_chr_free_connection().  But first of all I wasn't very
fond of that solution, because tcp_chr_write() says with an XXX comment
that seeing !s->disconnected is actually bad.

More importantly, though, once I did that, another segfault appeared
(again from running iotest 147 in parallel):

(gdb) bt
#0  0x00005629e4c7b29f in object_dynamic_cast_assert
    (obj=3D0x5629e6847690, typename=3Dtypename@entry=3D0x5629e4f3933b
"qio-channel-socket", file=3Dfile@entry=3D0x5629e4f423e8
"io/channel-socket.c", line=3Dline@entry=3D512,
func=3Dfunc@entry=3D0x5629e4f42b00 <__func__.20946>
"qio_channel_socket_writev") at qom/object.c:686
#1  0x00005629e4d1ded2 in qio_channel_socket_writev (ioc=3D<optimized
out>, iov=3D0x7ffe36e71c40, niov=3D1, fds=3D0x0, nfds=3D0, errp=3D0x0) at=

io/channel-socket.c:512
#2  0x00005629e4d0a6b4 in io_channel_send_full (ioc=3D0x5629e6847690,
buf=3Dbuf@entry=3D0x7f7ae4006a30, len=3Dlen@entry=3D138, fds=3D0x0, nfds=3D=
0) at
chardev/char-io.c:123
#3  0x00005629e4d0f4cb in tcp_chr_write
    (chr=3D0x5629e67dced0, buf=3D0x7f7ae4006a30 "{\"timestamp\":
{\"seconds\": 1545428667, \"microseconds\": 895334}, \"event\":
\"SHUTDOWN\", \"data\": {\"guest\": false, \"reason\":
\"host-qmp-quit\"}}\r\n", len=3D138)
    at chardev/char-socket.c:135
#4  0x00005629e4d07440 in qemu_chr_write_buffer
    (s=3Ds@entry=3D0x5629e67dced0, buf=3Dbuf@entry=3D0x7f7ae4006a30
"{\"timestamp\": {\"seconds\": 1545428667, \"microseconds\": 895334},
\"event\": \"SHUTDOWN\", \"data\": {\"guest\": false, \"reason\":
\"host-qmp-quit\"}}\r\n", len=3D138, offset=3Doffset@entry=3D0x7ffe36e71d=
30,
write_all=3Dfalse) at chardev/char.c:112
#5  0x00005629e4d076ef in qemu_chr_write
    (s=3D0x5629e67dced0, buf=3Dbuf@entry=3D0x7f7ae4006a30 "{\"timestamp\"=
:
{\"seconds\": 1545428667, \"microseconds\": 895334}, \"event\":
\"SHUTDOWN\", \"data\": {\"guest\": false, \"reason\":
\"host-qmp-quit\"}}\r\n", len=3D<optimized out>,
write_all=3Dwrite_all@entry=3Dfalse) at chardev/char.c:147
#6  0x00005629e4d096af in qemu_chr_fe_write
    (be=3Dbe@entry=3D0x5629e681da90, buf=3Dbuf@entry=3D0x7f7ae4006a30
"{\"timestamp\": {\"seconds\": 1545428667, \"microseconds\": 895334},
\"event\": \"SHUTDOWN\", \"data\": {\"guest\": false, \"reason\":
\"host-qmp-quit\"}}\r\n", len=3D<optimized out>) at chardev/char-fe.c:42
#7  0x00005629e49563d8 in monitor_flush_locked
(mon=3Dmon@entry=3D0x5629e681da90) at monitor.c:406
#8  0x00005629e49565a9 in monitor_flush_locked (mon=3D0x5629e681da90) at
monitor.c:449
#9  0x00005629e49565a9 in monitor_puts (mon=3Dmon@entry=3D0x5629e681da90,=

str=3D0x5629e768c7f9 "") at monitor.c:449
#10 0x00005629e49565ef in qmp_send_response (mon=3D0x5629e681da90,
rsp=3D<optimized out>) at monitor.c:498
#11 0x00005629e49567ea in monitor_qapi_event_emit
(event=3Devent@entry=3DQAPI_EVENT_SHUTDOWN,
qdict=3Dqdict@entry=3D0x5629e79825f0) at monitor.c:526
#12 0x00005629e4956b22 in monitor_qapi_event_queue_no_reenter
(qdict=3D0x5629e79825f0, event=3DQAPI_EVENT_SHUTDOWN) at monitor.c:551
#13 0x00005629e4956b22 in monitor_qapi_event_queue
(event=3DQAPI_EVENT_SHUTDOWN, qdict=3D0x0) at monitor.c:627
#14 0x00005629e4956b22 in monitor_qapi_event_queue
(event=3Devent@entry=3DQAPI_EVENT_SHUTDOWN,
qdict=3Dqdict@entry=3D0x5629e79825f0) at monitor.c:594
#15 0x00005629e4d5b3b1 in qapi_event_send_shutdown (guest=3D<optimized
out>, reason=3D<optimized out>) at qapi/qapi-events-run-state.c:49
#16 0x00005629e4a7fc07 in main_loop_should_exit () at
include/sysemu/sysemu.h:36
#17 0x00005629e4a7fc07 in main_loop () at vl.c:1909
#18 0x00005629e490c735 in main (argc=3D<optimized out>, argv=3D<optimized=

out>, envp=3D<optimized out>) at vl.c:4661


At this point, I decided that I've ventured far enough.  (Especially
since it's Dec 21 and 11 pm and all that.)

I suppose the issue is that QMP events are sent by one thread, and
client disconnects are handled by a different one.  So if a QMP event is
sent while a client disconnects concurrently, races may occur; and the
only protection against concurrent access appears to be the
chr_write_lock, which I don't think is enough.

Max


--fCC3xNs48QGfIpDLHHot3MaqLbK2Ttqo9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlwdaacACgkQ9AfbAGHV
z0CNbAf/f8plOwS1O7jvcORO/g5HfdRKknjUHqJKKLN19V3qg5q4ZlJj27PMU9ZZ
d3Z80ElLuXKSiY2ZQkxZi3hKmvWFogRdMI7jrepVqcOfwjX+CKnFeCUIeAI/+mdj
EtHECUFYvV9ewsHgft7quzTZ9xV+Q9tJEgPtjFx+29xqwZnsvOU3hK/7ADHyoJpf
5fg0NvYdkVktBgDgMCkh9FNAt3XKMtg1KyYsTAnl5jmk+vOc2d4hZLfYS1ZLSGch
vjDrogRXuK5yKQn+NJD9PI1T8j5F30eC872+g1ddkqQo19WaeCmM8Uzu8TcP5+HU
MpObYLC98ADnfJJtkr6fdtqR4yxvKQ==
=aMCD
-----END PGP SIGNATURE-----

--fCC3xNs48QGfIpDLHHot3MaqLbK2Ttqo9--
