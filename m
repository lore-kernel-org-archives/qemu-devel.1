Received: from eggs.gnu.org ([209.51.188.92]:56994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gxBFF-0001xW-MY
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:52:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gxBFE-0006jN-DD
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:52:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gxBFB-0005xq-Nf
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 08:52:02 -0500
Date: Fri, 22 Feb 2019 13:51:27 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190222135127.GX25234@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <cover.1550842915.git.berto@igalia.com>
	<48f7e50413f6f222acb1bf3a9de773e387a2855a.1550842915.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <48f7e50413f6f222acb1bf3a9de773e387a2855a.1550842915.git.berto@igalia.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/3] char-socket: Lock
 tcp_chr_disconnect() and socket_reconnect_timeout()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Fri, Feb 22, 2019 at 03:46:26PM +0200, Alberto Garcia wrote:
> There's a race condition in which the tcp_chr_read() ioc handler can
> close a connection that is being written to from another thread.
>=20
> Running iotest 136 in a loop triggers this problem and crashes QEMU.
>=20
>  (gdb) bt
>  #0  0x00005558b842902d in object_get_class (obj=3D0x0) at qom/object.c=
:860
>  #1  0x00005558b84f92db in qio_channel_writev_full (ioc=3D0x0, iov=3D0x=
7ffc355decf0, niov=3D1, fds=3D0x0, nfds=3D0, errp=3D0x0) at io/channel.c:=
76
>  #2  0x00005558b84e0e9e in io_channel_send_full (ioc=3D0x0, buf=3D0x555=
8baf5beb0, len=3D138, fds=3D0x0, nfds=3D0) at chardev/char-io.c:123
>  #3  0x00005558b84e4a69 in tcp_chr_write (chr=3D0x5558ba460380, buf=3D0=
x5558baf5beb0 "...", len=3D138) at chardev/char-socket.c:135
>  #4  0x00005558b84dca55 in qemu_chr_write_buffer (s=3D0x5558ba460380, b=
uf=3D0x5558baf5beb0 "...", len=3D138, offset=3D0x7ffc355dedd0, write_all=3D=
false) at chardev/char.c:112
>  #5  0x00005558b84dcbc2 in qemu_chr_write (s=3D0x5558ba460380, buf=3D0x=
5558baf5beb0 "...", len=3D138, write_all=3Dfalse) at chardev/char.c:147
>  #6  0x00005558b84dfb26 in qemu_chr_fe_write (be=3D0x5558ba476610, buf=3D=
0x5558baf5beb0 "...", len=3D138) at chardev/char-fe.c:42
>  #7  0x00005558b8088c86 in monitor_flush_locked (mon=3D0x5558ba476610) =
at monitor.c:406
>  #8  0x00005558b8088e8c in monitor_puts (mon=3D0x5558ba476610, str=3D0x=
5558ba921e49 "") at monitor.c:449
>  #9  0x00005558b8089178 in qmp_send_response (mon=3D0x5558ba476610, rsp=
=3D0x5558bb161600) at monitor.c:498
>  #10 0x00005558b808920c in monitor_qapi_event_emit (event=3DQAPI_EVENT_=
SHUTDOWN, qdict=3D0x5558bb161600) at monitor.c:526
>  #11 0x00005558b8089307 in monitor_qapi_event_queue_no_reenter (event=3D=
QAPI_EVENT_SHUTDOWN, qdict=3D0x5558bb161600) at monitor.c:551
>  #12 0x00005558b80896c0 in qapi_event_emit (event=3DQAPI_EVENT_SHUTDOWN=
, qdict=3D0x5558bb161600) at monitor.c:626
>  #13 0x00005558b855f23b in qapi_event_send_shutdown (guest=3Dfalse, rea=
son=3DSHUTDOWN_CAUSE_HOST_QMP_QUIT) at qapi/qapi-events-run-state.c:43
>  #14 0x00005558b81911ef in qemu_system_shutdown (cause=3DSHUTDOWN_CAUSE=
_HOST_QMP_QUIT) at vl.c:1837
>  #15 0x00005558b8191308 in main_loop_should_exit () at vl.c:1885
>  #16 0x00005558b819140d in main_loop () at vl.c:1924
>  #17 0x00005558b8198c84 in main (argc=3D18, argv=3D0x7ffc355df3f8, envp=
=3D0x7ffc355df490) at vl.c:4665
>=20
> This patch adds a lock to protect tcp_chr_disconnect() and
> socket_reconnect_timeout()
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  chardev/char-socket.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
