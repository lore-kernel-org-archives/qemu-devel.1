Received: from eggs.gnu.org ([2001:4830:134:3::10]:36935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cxlzG-0001vm-QC
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 22:56:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cxlzC-0007Ph-0E
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 22:56:58 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:34867)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1cxlzB-0007PX-SO
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 22:56:53 -0400
Received: by mail-qk0-x243.google.com with SMTP id k139so22493344qke.2
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 19:56:53 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170316092121.25672-1-marcandre.lureau@redhat.com>
	<20170316092121.25672-12-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <66460940-0862-9ad6-012e-83e81f57e101@amsat.org>
Date: Mon, 10 Apr 2017 23:56:50 -0300
MIME-Version: 1.0
In-Reply-To: <20170316092121.25672-12-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 11/21] char-socket: introduce
 update_disconnected_filename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

On 03/16/2017 06:21 AM, Marc-André Lureau wrote:
> This helper will be used in yet another place in the following patch.
>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  chardev/char-socket.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index dc3d3532a7..e3b5288af7 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -363,6 +363,15 @@ static char *SocketAddress_to_str(const char *prefix, SocketAddress *addr,
>      }
>  }
>
> +static void update_disconnected_filename(SocketChardev *s)
> +{
> +    Chardev *chr = CHARDEV(s);
> +
> +    g_free(chr->filename);
> +    chr->filename = SocketAddress_to_str("disconnected:", s->addr,
> +                                         s->is_listen, s->is_telnet);
> +}
> +
>  static void tcp_chr_disconnect(Chardev *chr)
>  {
>      SocketChardev *s = SOCKET_CHARDEV(chr);
> @@ -377,8 +386,7 @@ static void tcp_chr_disconnect(Chardev *chr)
>          s->listen_tag = qio_channel_add_watch(
>              QIO_CHANNEL(s->listen_ioc), G_IO_IN, tcp_chr_accept, chr, NULL);
>      }
> -    chr->filename = SocketAddress_to_str("disconnected:", s->addr,
> -                                         s->is_listen, s->is_telnet);
> +    update_disconnected_filename(s);
>      qemu_chr_be_event(chr, CHR_EVENT_CLOSED);
>      if (s->reconnect_time) {
>          qemu_chr_socket_restart_timer(chr);
> @@ -872,8 +880,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
>      /* be isn't opened until we get a connection */
>      *be_opened = false;
>
> -    chr->filename = SocketAddress_to_str("disconnected:",
> -                                         addr, is_listen, is_telnet);
> +    update_disconnected_filename(s);
>
>      if (is_listen) {
>          if (is_telnet) {
>
