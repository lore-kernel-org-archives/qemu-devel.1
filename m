Received: from eggs.gnu.org ([2001:4830:134:3::10]:42409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1erSAL-0000WL-Uc
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 12:38:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1erSAI-0003DK-LB
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 12:38:49 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:38612)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1erSAI-0003CB-Di
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 12:38:46 -0500
Received: by mail-wm0-x243.google.com with SMTP id z9so13661897wmb.3
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 09:38:46 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20180301084438.13594-1-peterx@redhat.com>
	<20180301084438.13594-14-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7c1951fd-eb14-8b57-6408-8adc9e19d005@redhat.com>
Date: Thu, 1 Mar 2018 18:38:43 +0100
MIME-Version: 1.0
In-Reply-To: <20180301084438.13594-14-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 13/15] char: use chardev's gcontext for
 async connect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On 01/03/2018 09:44, Peter Xu wrote:
> Generalize the function to create the async QIO task connection.  Also,
> fix the context pointer to use the chardev's gcontext.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  chardev/char-socket.c | 25 ++++++++++++++-----------
>  1 file changed, 14 insertions(+), 11 deletions(-)
> 
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index bd90680f5c..cd9db123f2 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -894,11 +894,22 @@ cleanup:
>      object_unref(OBJECT(sioc));
>  }
>  
> +static void tcp_chr_connect_async(Chardev *chr)
> +{
> +    SocketChardev *s = SOCKET_CHARDEV(chr);
> +    QIOChannelSocket *sioc;
> +
> +    sioc = qio_channel_socket_new();
> +    tcp_chr_set_client_ioc_name(chr, sioc);
> +    qio_channel_socket_connect_async(sioc, s->addr,
> +                                     qemu_chr_socket_connected,
> +                                     chr, NULL, chr->gcontext);
> +}
> +
>  static gboolean socket_reconnect_timeout(gpointer opaque)
>  {
>      Chardev *chr = CHARDEV(opaque);
>      SocketChardev *s = SOCKET_CHARDEV(opaque);
> -    QIOChannelSocket *sioc;
>  
>      g_source_unref(s->reconnect_timer);
>      s->reconnect_timer = NULL;
> @@ -907,11 +918,7 @@ static gboolean socket_reconnect_timeout(gpointer opaque)
>          return false;
>      }
>  
> -    sioc = qio_channel_socket_new();
> -    tcp_chr_set_client_ioc_name(chr, sioc);
> -    qio_channel_socket_connect_async(sioc, s->addr,
> -                                     qemu_chr_socket_connected,
> -                                     chr, NULL, NULL);
> +    tcp_chr_connect_async(chr);
>  
>      return false;
>  }
> @@ -991,11 +998,7 @@ static void qmp_chardev_open_socket(Chardev *chr,
>      }
>  
>      if (s->reconnect_time) {
> -        sioc = qio_channel_socket_new();
> -        tcp_chr_set_client_ioc_name(chr, sioc);
> -        qio_channel_socket_connect_async(sioc, s->addr,
> -                                         qemu_chr_socket_connected,
> -                                         chr, NULL, NULL);
> +        tcp_chr_connect_async(chr);
>      } else {
>          if (s->is_listen) {
>              char *name;
> 


Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
