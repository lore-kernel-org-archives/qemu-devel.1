Received: from eggs.gnu.org ([2001:4830:134:3::10]:59748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fRIkW-00063v-NH
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 10:52:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fRIkR-00042G-Gk
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 10:52:20 -0400
Received: from mail-qt0-x22c.google.com ([2607:f8b0:400d:c0d::22c]:42676)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fRIkR-000426-Bd
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 10:52:15 -0400
Received: by mail-qt0-x22c.google.com with SMTP id y31-v6so13662043qty.9
	for <qemu-devel@nongnu.org>; Fri, 08 Jun 2018 07:52:15 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180601162749.27406-1-marcandre.lureau@redhat.com>
	<20180601162749.27406-2-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <496cef6a-35a1-5ad7-fa43-771f877c5c13@amsat.org>
Date: Fri, 8 Jun 2018 11:52:11 -0300
MIME-Version: 1.0
In-Reply-To: <20180601162749.27406-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC v2 01/12] chardev: avoid crash if no
 associated address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

On 06/01/2018 01:27 PM, Marc-André Lureau wrote:
> A socket chardev may not have associated address (when adding client
> fd manually for example). But on disconnect, updating socket filename
> expects an address and may lead to this crash:
> 
>   Thread 1 "qemu-system-x86" received signal SIGSEGV, Segmentation fault.
>   0x0000555555d8c70c in SocketAddress_to_str (prefix=0x555556043062 "disconnected:", addr=0x0, is_listen=false, is_telnet=false) at /home/elmarco/src/qq/chardev/char-socket.c:388
>   388	    switch (addr->type) {
>   (gdb) bt
>   #0  0x0000555555d8c70c in SocketAddress_to_str (prefix=0x555556043062 "disconnected:", addr=0x0, is_listen=false, is_telnet=false) at /home/elmarco/src/qq/chardev/char-socket.c:388
>   #1  0x0000555555d8c8aa in update_disconnected_filename (s=0x555556b1ed00) at /home/elmarco/src/qq/chardev/char-socket.c:419
>   #2  0x0000555555d8c959 in tcp_chr_disconnect (chr=0x555556b1ed00) at /home/elmarco/src/qq/chardev/char-socket.c:438
>   #3  0x0000555555d8cba1 in tcp_chr_hup (channel=0x555556b75690, cond=G_IO_HUP, opaque=0x555556b1ed00) at /home/elmarco/src/qq/chardev/char-socket.c:482
>   #4  0x0000555555da596e in qio_channel_fd_source_dispatch (source=0x555556bb68b0, callback=0x555555d8cb58 <tcp_chr_hup>, user_data=0x555556b1ed00) at /home/elmarco/src/qq/io/channel-watch.c:84
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  chardev/char-socket.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index 159e69c3b1..f1b7907798 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -416,8 +416,11 @@ static void update_disconnected_filename(SocketChardev *s)
>      Chardev *chr = CHARDEV(s);
>  
>      g_free(chr->filename);
> -    chr->filename = SocketAddress_to_str("disconnected:", s->addr,
> -                                         s->is_listen, s->is_telnet);
> +    chr->filename = NULL;
> +    if (s->addr) {

Isn't it more robust to add this check in SocketAddress_to_str()?

    static char *SocketAddress_to_str(const char *prefix, SocketAddress
*addr,
                                      bool is_listen, bool is_telnet)
    {
        if (!addr) {
            return NULL;
        }
        switch (addr->type) {
            ...

> +        chr->filename = SocketAddress_to_str("disconnected:", s->addr,
> +                                             s->is_listen, s->is_telnet);
> +    }
>  }
>  
>  /* NB may be called even if tcp_chr_connect has not been
> 
