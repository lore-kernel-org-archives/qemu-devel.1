Received: from eggs.gnu.org ([2001:4830:134:3::10]:42473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1erSAW-0000dQ-6Z
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 12:39:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1erSAS-0003Gg-TS
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 12:39:00 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:40750)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1erSAS-0003GA-M4
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 12:38:56 -0500
Received: by mail-wr0-x244.google.com with SMTP id o76so7434743wrb.7
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 09:38:56 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20180301084438.13594-1-peterx@redhat.com>
	<20180301084438.13594-15-peterx@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <53d8198d-6220-a9fb-7401-151eb08bf99e@redhat.com>
Date: Thu, 1 Mar 2018 18:38:53 +0100
MIME-Version: 1.0
In-Reply-To: <20180301084438.13594-15-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 14/15] chardev: tcp: postpone async
 connection setup
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
> This patch allows the socket chardev async connection be setup with
> non-default gcontext.  We do it by postponing the setup to machine done,
> since until then we can know which context we should run the async
> operation on.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  chardev/char-socket.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> index cd9db123f2..2b355fc7a8 100644
> --- a/chardev/char-socket.c
> +++ b/chardev/char-socket.c
> @@ -997,9 +997,8 @@ static void qmp_chardev_open_socket(Chardev *chr,
>          s->reconnect_time = reconnect;
>      }
>  
> -    if (s->reconnect_time) {
> -        tcp_chr_connect_async(chr);
> -    } else {
> +    /* If reconnect_time is set, will do that in chr_machine_done. */
> +    if (!s->reconnect_time) {
>          if (s->is_listen) {
>              char *name;
>              s->listener = qio_net_listener_new();
> @@ -1128,6 +1127,17 @@ char_socket_get_connected(Object *obj, Error **errp)
>      return s->connected;
>  }
>  
> +static int tcp_chr_machine_done_hook(Chardev *chr)
> +{
> +    SocketChardev *s = SOCKET_CHARDEV(chr);
> +
> +    if (s->reconnect_time) {
> +        tcp_chr_connect_async(chr);
> +    }
> +
> +    return 0;
> +}
> +
>  static void char_socket_class_init(ObjectClass *oc, void *data)
>  {
>      ChardevClass *cc = CHARDEV_CLASS(oc);
> @@ -1143,6 +1153,7 @@ static void char_socket_class_init(ObjectClass *oc, void *data)
>      cc->chr_add_client = tcp_chr_add_client;
>      cc->chr_add_watch = tcp_chr_add_watch;
>      cc->chr_update_read_handler = tcp_chr_update_read_handler;
> +    cc->chr_machine_done = tcp_chr_machine_done_hook;
>  
>      object_class_property_add(oc, "addr", "SocketAddress",
>                                char_socket_get_addr, NULL,
> 


Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
