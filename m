Received: from eggs.gnu.org ([209.51.188.92]:40761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1grkxH-0002gt-FE
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:47:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1grkxG-0007sF-CI
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:47:07 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:56147)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1grkxG-0007pw-3r
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 09:47:06 -0500
Received: by mail-wm1-x343.google.com with SMTP id r17so100346wmh.5
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 06:47:06 -0800 (PST)
MIME-Version: 1.0
References: <cover.1549545591.git.berto@igalia.com>
	<f404632bb16afed8ae9e5f3cfe4032b718a00491.1549545591.git.berto@igalia.com>
In-Reply-To: <f404632bb16afed8ae9e5f3cfe4032b718a00491.1549545591.git.berto@igalia.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 7 Feb 2019 15:46:53 +0100
Message-ID: <CAJ+F1CJh5vJa_py=eChkZCW-+zbuU1GmdFWcfSYg+=t8ukwYNg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] char-socket: Lock tcp_chr_disconnect()
 and socket_reconnect_timeout()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: QEMU <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

Hi

On Thu, Feb 7, 2019 at 2:25 PM Alberto Garcia <berto@igalia.com> wrote:
>
> There's a race condition in which the tcp_chr_read() ioc handler can
> close a connection that is being written to from another thread.
>
> Running iotest 136 in a loop triggers this problem and crashes QEMU.
>
>  (gdb) bt
>  #0  0x00005558b842902d in object_get_class (obj=3D0x0) at qom/object.c:8=
60
>  #1  0x00005558b84f92db in qio_channel_writev_full (ioc=3D0x0, iov=3D0x7f=
fc355decf0, niov=3D1, fds=3D0x0, nfds=3D0, errp=3D0x0) at io/channel.c:76
>  #2  0x00005558b84e0e9e in io_channel_send_full (ioc=3D0x0, buf=3D0x5558b=
af5beb0, len=3D138, fds=3D0x0, nfds=3D0) at chardev/char-io.c:123
>  #3  0x00005558b84e4a69 in tcp_chr_write (chr=3D0x5558ba460380, buf=3D0x5=
558baf5beb0 "...", len=3D138) at chardev/char-socket.c:135
>  #4  0x00005558b84dca55 in qemu_chr_write_buffer (s=3D0x5558ba460380, buf=
=3D0x5558baf5beb0 "...", len=3D138, offset=3D0x7ffc355dedd0, write_all=3Dfa=
lse) at chardev/char.c:112
>  #5  0x00005558b84dcbc2 in qemu_chr_write (s=3D0x5558ba460380, buf=3D0x55=
58baf5beb0 "...", len=3D138, write_all=3Dfalse) at chardev/char.c:147
>  #6  0x00005558b84dfb26 in qemu_chr_fe_write (be=3D0x5558ba476610, buf=3D=
0x5558baf5beb0 "...", len=3D138) at chardev/char-fe.c:42
>  #7  0x00005558b8088c86 in monitor_flush_locked (mon=3D0x5558ba476610) at=
 monitor.c:406
>  #8  0x00005558b8088e8c in monitor_puts (mon=3D0x5558ba476610, str=3D0x55=
58ba921e49 "") at monitor.c:449
>  #9  0x00005558b8089178 in qmp_send_response (mon=3D0x5558ba476610, rsp=
=3D0x5558bb161600) at monitor.c:498
>  #10 0x00005558b808920c in monitor_qapi_event_emit (event=3DQAPI_EVENT_SH=
UTDOWN, qdict=3D0x5558bb161600) at monitor.c:526
>  #11 0x00005558b8089307 in monitor_qapi_event_queue_no_reenter (event=3DQ=
API_EVENT_SHUTDOWN, qdict=3D0x5558bb161600) at monitor.c:551
>  #12 0x00005558b80896c0 in qapi_event_emit (event=3DQAPI_EVENT_SHUTDOWN, =
qdict=3D0x5558bb161600) at monitor.c:626
>  #13 0x00005558b855f23b in qapi_event_send_shutdown (guest=3Dfalse, reaso=
n=3DSHUTDOWN_CAUSE_HOST_QMP_QUIT) at qapi/qapi-events-run-state.c:43
>  #14 0x00005558b81911ef in qemu_system_shutdown (cause=3DSHUTDOWN_CAUSE_H=
OST_QMP_QUIT) at vl.c:1837
>  #15 0x00005558b8191308 in main_loop_should_exit () at vl.c:1885
>  #16 0x00005558b819140d in main_loop () at vl.c:1924
>  #17 0x00005558b8198c84 in main (argc=3D18, argv=3D0x7ffc355df3f8, envp=
=3D0x7ffc355df490) at vl.c:4665
>
> This patch adds a lock to protect tcp_chr_disconnect() and
> socket_reconnect_timeout()
>
> Signed-off-by: Alberto Garcia <berto@igalia.com>

That looks like a subset of "[Qemu-devel] Segfaults in chardev due to
races". The problem is likely to occur with other chardevs I am
afraid.


> ---
>  chardev/char-socket.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index eaa8e8b68f..5f421bdc58 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -148,7 +148,9 @@ static int tcp_chr_write(Chardev *chr, const uint8_t =
*buf, int len)
>
>          if (ret < 0 && errno !=3D EAGAIN) {
>              if (tcp_chr_read_poll(chr) <=3D 0) {
> +                qemu_mutex_unlock(&chr->chr_write_lock);
>                  tcp_chr_disconnect(chr);
> +                qemu_mutex_lock(&chr->chr_write_lock);
>                  return len;
>              } /* else let the read handler finish it properly */
>          }
> @@ -440,6 +442,13 @@ static void update_disconnected_filename(SocketChard=
ev *s)
>      }
>  }
>
> +static gboolean tcp_chr_be_event_closed(gpointer opaque)
> +{
> +    Chardev *chr =3D opaque;
> +    qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
> +    return FALSE;
> +}
> +
>  /* NB may be called even if tcp_chr_connect has not been
>   * reached, due to TLS or telnet initialization failure,
>   * so can *not* assume s->connected =3D=3D true
> @@ -447,7 +456,10 @@ static void update_disconnected_filename(SocketChard=
ev *s)
>  static void tcp_chr_disconnect(Chardev *chr)
>  {
>      SocketChardev *s =3D SOCKET_CHARDEV(chr);
> -    bool emit_close =3D s->connected;
> +    bool emit_close;
> +
> +    qemu_mutex_lock(&chr->chr_write_lock);
> +    emit_close =3D s->connected;
>
>      tcp_chr_free_connection(chr);
>
> @@ -457,11 +469,12 @@ static void tcp_chr_disconnect(Chardev *chr)
>      }
>      update_disconnected_filename(s);
>      if (emit_close) {
> -        qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
> +        qemu_idle_add(tcp_chr_be_event_closed, chr, chr->gcontext);
>      }
>      if (s->reconnect_time) {
>          qemu_chr_socket_restart_timer(chr);
>      }
> +    qemu_mutex_unlock(&chr->chr_write_lock);
>  }
>
>  static gboolean tcp_chr_read(QIOChannel *chan, GIOCondition cond, void *=
opaque)
> @@ -975,8 +988,10 @@ static gboolean socket_reconnect_timeout(gpointer op=
aque)
>      Chardev *chr =3D CHARDEV(opaque);
>      SocketChardev *s =3D SOCKET_CHARDEV(opaque);
>
> +    qemu_mutex_lock(&chr->chr_write_lock);
>      g_source_unref(s->reconnect_timer);
>      s->reconnect_timer =3D NULL;
> +    qemu_mutex_unlock(&chr->chr_write_lock);
>
>      if (chr->be_open) {
>          return false;
> --
> 2.11.0
>
>


--=20
Marc-Andr=C3=A9 Lureau
