Received: from eggs.gnu.org ([2001:4830:134:3::10]:34333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dZkoZ-0005jz-CI
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:22:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dZkoW-0003Fx-71
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:22:55 -0400
Received: from mail-wr0-f178.google.com ([209.85.128.178]:34515)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dZkoW-0003Fg-0D
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 17:22:52 -0400
Received: by mail-wr0-f178.google.com with SMTP id 12so111340646wrb.1
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 14:22:51 -0700 (PDT)
References: <20170724181544.20292-1-brandon.carpenter@cypherpath.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ef8a8f82-12f0-af92-ee6e-f6538c4732bd@redhat.com>
Date: Mon, 24 Jul 2017 23:22:48 +0200
MIME-Version: 1.0
In-Reply-To: <20170724181544.20292-1-brandon.carpenter@cypherpath.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] io: Always remove an old channel watch
 before adding a new one.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brandon Carpenter <brandon.carpenter@cypherpath.com>, qemu-devel@nongnu.org
Cc: kraxel@redhat.com

On 24/07/2017 20:15, Brandon Carpenter wrote:
> Also set saved handle to zero when removing without adding a new watch.
> 
> Signed-off-by: Brandon Carpenter <brandon.carpenter@cypherpath.com>
> ---
>  ui/vnc-auth-vencrypt.c | 3 +++
>  ui/vnc-ws.c            | 6 ++++++
>  ui/vnc.c               | 4 ++++
>  3 files changed, 13 insertions(+)
> 
> diff --git a/ui/vnc-auth-vencrypt.c b/ui/vnc-auth-vencrypt.c
> index ffaab57550..c3eece4fa7 100644
> --- a/ui/vnc-auth-vencrypt.c
> +++ b/ui/vnc-auth-vencrypt.c
> @@ -77,6 +77,9 @@ static void vnc_tls_handshake_done(QIOTask *task,
>          vnc_client_error(vs);
>          error_free(err);
>      } else {
> +        if (vs->ioc_tag) {
> +            g_source_remove(vs->ioc_tag);
> +        }
>          vs->ioc_tag = qio_channel_add_watch(
>              vs->ioc, G_IO_IN | G_IO_OUT, vnc_client_io, vs, NULL);
>          start_auth_vencrypt_subauth(vs);
> diff --git a/ui/vnc-ws.c b/ui/vnc-ws.c
> index f530cd5474..eaf309553c 100644
> --- a/ui/vnc-ws.c
> +++ b/ui/vnc-ws.c
> @@ -36,6 +36,9 @@ static void vncws_tls_handshake_done(QIOTask *task,
>          error_free(err);
>      } else {
>          VNC_DEBUG("TLS handshake complete, starting websocket handshake\n");
> +        if (vs->ioc_tag) {
> +            g_source_remove(vs->ioc_tag);
> +        }
>          vs->ioc_tag = qio_channel_add_watch(
>              QIO_CHANNEL(vs->ioc), G_IO_IN, vncws_handshake_io, vs, NULL);
>      }
> @@ -97,6 +100,9 @@ static void vncws_handshake_done(QIOTask *task,
>      } else {
>          VNC_DEBUG("Websock handshake complete, starting VNC protocol\n");
>          vnc_start_protocol(vs);
> +        if (vs->ioc_tag) {
> +            g_source_remove(vs->ioc_tag);
> +        }
>          vs->ioc_tag = qio_channel_add_watch(
>              vs->ioc, G_IO_IN, vnc_client_io, vs, NULL);
>      }
> diff --git a/ui/vnc.c b/ui/vnc.c
> index eb91559b6b..ec86d6ad97 100644
> --- a/ui/vnc.c
> +++ b/ui/vnc.c
> @@ -1121,6 +1121,7 @@ static void vnc_disconnect_start(VncState *vs)
>      vnc_set_share_mode(vs, VNC_SHARE_MODE_DISCONNECTED);
>      if (vs->ioc_tag) {
>          g_source_remove(vs->ioc_tag);
> +        vs->ioc_tag = 0;
>      }
>      qio_channel_close(vs->ioc, NULL);
>      vs->disconnecting = TRUE;
> @@ -2931,6 +2932,9 @@ static void vnc_connect(VncDisplay *vd, QIOChannelSocket *sioc,
>      VNC_DEBUG("New client on socket %p\n", vs->sioc);
>      update_displaychangelistener(&vd->dcl, VNC_REFRESH_INTERVAL_BASE);
>      qio_channel_set_blocking(vs->ioc, false, NULL);
> +    if (vs->ioc_tag) {
> +        g_source_remove(vs->ioc_tag);
> +    }
>      if (websocket) {
>          vs->websocket = 1;
>          if (vd->tlscreds) {
> 


Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
