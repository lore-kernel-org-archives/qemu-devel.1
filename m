Received: from eggs.gnu.org ([2001:4830:134:3::10]:50270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eZICk-0007hP-JF
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 10:22:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eZICh-00081U-DE
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 10:22:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eZICh-000811-4C
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 10:22:11 -0500
Date: Wed, 10 Jan 2018 15:22:00 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20180110152200.GE3205@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20180110151322.16119-1-edgar.kaziakhmedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180110151322.16119-1-edgar.kaziakhmedov@virtuozzo.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/1] io/channel-websock: handle
 continuous reads without any data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
Cc: qemu-devel@nongnu.org, den@openvz.org

On Wed, Jan 10, 2018 at 06:13:22PM +0300, Edgar Kaziakhmedov wrote:
> According to the current implementation of websocket protocol in QEMU,
> qio_channel_websock_handshake_io tries to read handshake from the
> channel to start communication over socket. But this approach
> doesn't cover scenario when socket was closed while handshaking.
> Therefore, if G_IO_IN is caught and qio_channel_read returns zero,
> error has to be set and connection has to be done.
> 
> Such behaviour causes 100% CPU load in main QEMU loop, because main loop
> poll continues to receive and handle G_IO_IN events from websocket.
> 
> Step to reproduce 100% CPU load:
> 1) start qemu with the simplest configuration
> $ qemu -vnc [::1]:1,websocket=7500
> 2) open any vnc listener (which doesn't follow websocket protocol)
> $ vncviewer :7500
> 3) kill listener
> 4) qemu main thread eats 100% CPU
> 
> Signed-off-by: Edgar Kaziakhmedov <edgar.kaziakhmedov@virtuozzo.com>
> ---
>  io/channel-websock.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/io/channel-websock.c b/io/channel-websock.c
> index 87ebdebfc0..384c34b390 100644
> --- a/io/channel-websock.c
> +++ b/io/channel-websock.c
> @@ -81,6 +81,11 @@
>      QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_COMMON         \
>      "Connection: close\r\n"                          \
>      "\r\n"
> +#define QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_EOF        \
> +    "HTTP/1.1 403 Request Entity End Of File\r\n"    \
> +    QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_COMMON         \
> +    "Connection: close\r\n"                          \
> +    "\r\n"
>  #define QIO_CHANNEL_WEBSOCK_HANDSHAKE_DELIM "\r\n"
>  #define QIO_CHANNEL_WEBSOCK_HANDSHAKE_END "\r\n\r\n"
>  #define QIO_CHANNEL_WEBSOCK_SUPPORTED_VERSION "13"
> @@ -502,9 +507,14 @@ static int qio_channel_websock_handshake_read(QIOChannelWebsock *ioc,
>              error_setg(errp,
>                         "End of headers not found in first 4096 bytes");
>              return 1;
> -        } else {
> -            return 0;
> +        } else if (ret == 0) {
> +            qio_channel_websock_handshake_send_res_err(
> +                ioc, QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_EOF);
> +            error_setg(errp,
> +                       "End of headers not found before connection closed");
> +            return -1;

Opps, my suggestion was slightly flawed - if we return -1, then we don't
need to call qio_channel_websock_handshake_send_res_err(), since we'll
just close the connection immediately.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
