Received: from eggs.gnu.org ([2001:4830:134:3::10]:41135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cifKe-0007Zl-V9
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:48:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cifKb-0004Wz-6J
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:48:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cifKb-0004Wr-0c
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 05:48:33 -0500
Date: Tue, 28 Feb 2017 10:48:28 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170228104828.GA2720@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170227201456.31814-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170227201456.31814-1-berrange@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] io: ignore case when matching websockets
 HTTP headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>, Anton Nefedov <anton.nefedov@virtuozzo.com>

On Mon, Feb 27, 2017 at 08:14:56PM +0000, Daniel P. Berrange wrote:
> According to RFC7230 Section 3.2, header field name is case-insensitive.
> Convert the header data into all lowercase before doing string matching
> on the headers.
> 
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  io/channel-websock.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/io/channel-websock.c b/io/channel-websock.c
> index a06a4a8..32b7f37 100644
> --- a/io/channel-websock.c
> +++ b/io/channel-websock.c
> @@ -33,9 +33,9 @@
>  #define QIO_CHANNEL_WEBSOCK_GUID "258EAFA5-E914-47DA-95CA-C5AB0DC85B11"
>  #define QIO_CHANNEL_WEBSOCK_GUID_LEN strlen(QIO_CHANNEL_WEBSOCK_GUID)
>  
> -#define QIO_CHANNEL_WEBSOCK_HEADER_PROTOCOL "Sec-WebSocket-Protocol"
> -#define QIO_CHANNEL_WEBSOCK_HEADER_VERSION "Sec-WebSocket-Version"
> -#define QIO_CHANNEL_WEBSOCK_HEADER_KEY "Sec-WebSocket-Key"
> +#define QIO_CHANNEL_WEBSOCK_HEADER_PROTOCOL "sec-websocket-protocol"
> +#define QIO_CHANNEL_WEBSOCK_HEADER_VERSION "sec-websocket-version"
> +#define QIO_CHANNEL_WEBSOCK_HEADER_KEY "sec-websocket-key"
>  
>  #define QIO_CHANNEL_WEBSOCK_PROTOCOL_BINARY "binary"
>  
> @@ -223,7 +223,7 @@ static int qio_channel_websock_handshake_process(QIOChannelWebsock *ioc,
>  static int qio_channel_websock_handshake_read(QIOChannelWebsock *ioc,
>                                                Error **errp)
>  {
> -    char *handshake_end;
> +    char *handshake_end, *tmp;
>      ssize_t ret;
>      /* Typical HTTP headers from novnc are 512 bytes, so limiting
>       * total header size to 4096 is easily enough. */
> @@ -249,9 +249,13 @@ static int qio_channel_websock_handshake_read(QIOChannelWebsock *ioc,
>          }
>      }
>  
> +    for (tmp = (char *)ioc->encinput.buffer; tmp < handshake_end; tmp++) {
> +        *tmp = g_ascii_tolower(*tmp);
> +    }
> +

self-nack - this does not in fact work - while it is fine to lowercase
the header keys, we must not touch the header values as some data is
case-sensitive

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
