Received: from eggs.gnu.org ([209.51.188.92]:33799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gx9lK-0003Q9-CG
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 07:17:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gx9lJ-0003ca-CI
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 07:17:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60812)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gx9lI-0003aQ-Vk
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 07:17:05 -0500
Date: Fri, 22 Feb 2019 12:16:57 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190222121657.GP25234@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <cover.1550836631.git.berto@igalia.com>
	<a36c45f857a395a1d1bbcc67beae47e437569ab4.1550836631.git.berto@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a36c45f857a395a1d1bbcc67beae47e437569ab4.1550836631.git.berto@igalia.com>
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
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

On Fri, Feb 22, 2019 at 01:59:12PM +0200, Alberto Garcia wrote:
> There's a race condition in which the tcp_chr_read() ioc handler can
> close a connection that is being written to from another thread.
> 
> Running iotest 136 in a loop triggers this problem and crashes QEMU.
> 
>  (gdb) bt
>  #0  0x00005558b842902d in object_get_class (obj=0x0) at qom/object.c:860
>  #1  0x00005558b84f92db in qio_channel_writev_full (ioc=0x0, iov=0x7ffc355decf0, niov=1, fds=0x0, nfds=0, errp=0x0) at io/channel.c:76
>  #2  0x00005558b84e0e9e in io_channel_send_full (ioc=0x0, buf=0x5558baf5beb0, len=138, fds=0x0, nfds=0) at chardev/char-io.c:123
>  #3  0x00005558b84e4a69 in tcp_chr_write (chr=0x5558ba460380, buf=0x5558baf5beb0 "...", len=138) at chardev/char-socket.c:135
>  #4  0x00005558b84dca55 in qemu_chr_write_buffer (s=0x5558ba460380, buf=0x5558baf5beb0 "...", len=138, offset=0x7ffc355dedd0, write_all=false) at chardev/char.c:112
>  #5  0x00005558b84dcbc2 in qemu_chr_write (s=0x5558ba460380, buf=0x5558baf5beb0 "...", len=138, write_all=false) at chardev/char.c:147
>  #6  0x00005558b84dfb26 in qemu_chr_fe_write (be=0x5558ba476610, buf=0x5558baf5beb0 "...", len=138) at chardev/char-fe.c:42
>  #7  0x00005558b8088c86 in monitor_flush_locked (mon=0x5558ba476610) at monitor.c:406
>  #8  0x00005558b8088e8c in monitor_puts (mon=0x5558ba476610, str=0x5558ba921e49 "") at monitor.c:449
>  #9  0x00005558b8089178 in qmp_send_response (mon=0x5558ba476610, rsp=0x5558bb161600) at monitor.c:498
>  #10 0x00005558b808920c in monitor_qapi_event_emit (event=QAPI_EVENT_SHUTDOWN, qdict=0x5558bb161600) at monitor.c:526
>  #11 0x00005558b8089307 in monitor_qapi_event_queue_no_reenter (event=QAPI_EVENT_SHUTDOWN, qdict=0x5558bb161600) at monitor.c:551
>  #12 0x00005558b80896c0 in qapi_event_emit (event=QAPI_EVENT_SHUTDOWN, qdict=0x5558bb161600) at monitor.c:626
>  #13 0x00005558b855f23b in qapi_event_send_shutdown (guest=false, reason=SHUTDOWN_CAUSE_HOST_QMP_QUIT) at qapi/qapi-events-run-state.c:43
>  #14 0x00005558b81911ef in qemu_system_shutdown (cause=SHUTDOWN_CAUSE_HOST_QMP_QUIT) at vl.c:1837
>  #15 0x00005558b8191308 in main_loop_should_exit () at vl.c:1885
>  #16 0x00005558b819140d in main_loop () at vl.c:1924
>  #17 0x00005558b8198c84 in main (argc=18, argv=0x7ffc355df3f8, envp=0x7ffc355df490) at vl.c:4665
> 
> This patch adds a lock to protect tcp_chr_disconnect() and
> socket_reconnect_timeout()

Can you think of any way to test this in the unit tests ?  I can understand
if its too difficult but just curious if there's any viable option ?

> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 4fcdd8aedd..67c2eeac6d 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -172,7 +172,9 @@ static int tcp_chr_write(Chardev *chr, const uint8_t *buf, int len)
>  
>          if (ret < 0 && errno != EAGAIN) {
>              if (tcp_chr_read_poll(chr) <= 0) {
> +                qemu_mutex_unlock(&chr->chr_write_lock);
>                  tcp_chr_disconnect(chr);
> +                qemu_mutex_lock(&chr->chr_write_lock);

The idea of unlock & relocking here, just so tcp_chr_disconnect can
also acquire locks, doesn't make me too happy. This is really an
anti-pattern to me.

I think we should rename the existing method to be
tcp_chr_disconnect_locked() and document that it must only
be called with the write lock held, and call that from
here.

Then introduce a new wrapper for all the other callers to
carry on using which does the locking

 static void tcp_chr_disconnect(Chardev *chr)
 {
    qemu_mutex_lock(&chr->chr_write_lock);
    tcp_chr_disconnect_locked(chr);
    qemu_mutex_unlock(&chr->chr_write_lock);
 }
  
Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
