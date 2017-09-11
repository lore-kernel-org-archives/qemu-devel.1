Received: from eggs.gnu.org ([2001:4830:134:3::10]:34543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drKQd-00014R-OB
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 04:50:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drKQZ-0001Ob-QB
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 04:50:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1drKQZ-0001OB-GA
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 04:50:47 -0400
Date: Mon, 11 Sep 2017 09:50:43 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170911085043.GE21444@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170724184217.21381-1-brandon.carpenter@cypherpath.com>
	<20170908173801.15205-7-brandon.carpenter@cypherpath.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170908173801.15205-7-brandon.carpenter@cypherpath.com>
Subject: Re: [Qemu-devel] [PATCH v2 6/6] io: Reply to ping frames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brandon Carpenter <brandon.carpenter@cypherpath.com>
Cc: qemu-devel@nongnu.org

On Fri, Sep 08, 2017 at 10:38:01AM -0700, Brandon Carpenter wrote:
> Add an immediate ping reply (pong) to the outgoing stream when a ping
> is received. Unsolicited pongs are ignored.
> 
> Signed-off-by: Brandon Carpenter <brandon.carpenter@cypherpath.com>
> ---
>  io/channel-websock.c | 50 ++++++++++++++++++++++++++++++++------------------
>  1 file changed, 32 insertions(+), 18 deletions(-)
> 
> diff --git a/io/channel-websock.c b/io/channel-websock.c
> index 50387050d5..175f17ce6b 100644
> --- a/io/channel-websock.c
> +++ b/io/channel-websock.c
> @@ -479,7 +479,8 @@ static gboolean qio_channel_websock_handshake_io(QIOChannel *ioc,
>  }
>  
>  
> -static void qio_channel_websock_encode(QIOChannelWebsock *ioc)
> +static void qio_channel_websock_encode_buffer(QIOChannelWebsock *ioc,
> +                                              uint8_t opcode, Buffer *buffer)
>  {
>      size_t header_size;
>      union {
> @@ -487,33 +488,37 @@ static void qio_channel_websock_encode(QIOChannelWebsock *ioc)
>          QIOChannelWebsockHeader ws;
>      } header;
>  
> -    if (!ioc->rawoutput.offset) {
> -        return;
> -    }
> -
>      header.ws.b0 = QIO_CHANNEL_WEBSOCK_HEADER_FIELD_FIN |
> -        (QIO_CHANNEL_WEBSOCK_OPCODE_BINARY_FRAME &
> -         QIO_CHANNEL_WEBSOCK_HEADER_FIELD_OPCODE);
> -    if (ioc->rawoutput.offset <
> +        (opcode & QIO_CHANNEL_WEBSOCK_HEADER_FIELD_OPCODE);
> +    if (buffer->offset <
>          QIO_CHANNEL_WEBSOCK_PAYLOAD_LEN_THRESHOLD_7_BIT) {
> -        header.ws.b1 = (uint8_t)ioc->rawoutput.offset;
> +        header.ws.b1 = (uint8_t)buffer->offset;
>          header_size = QIO_CHANNEL_WEBSOCK_HEADER_LEN_7_BIT;
> -    } else if (ioc->rawoutput.offset <
> +    } else if (buffer->offset <
>                 QIO_CHANNEL_WEBSOCK_PAYLOAD_LEN_THRESHOLD_16_BIT) {
>          header.ws.b1 = QIO_CHANNEL_WEBSOCK_PAYLOAD_LEN_MAGIC_16_BIT;
> -        header.ws.u.s16.l16 = cpu_to_be16((uint16_t)ioc->rawoutput.offset);
> +        header.ws.u.s16.l16 = cpu_to_be16((uint16_t)buffer->offset);
>          header_size = QIO_CHANNEL_WEBSOCK_HEADER_LEN_16_BIT;
>      } else {
>          header.ws.b1 = QIO_CHANNEL_WEBSOCK_PAYLOAD_LEN_MAGIC_64_BIT;
> -        header.ws.u.s64.l64 = cpu_to_be64(ioc->rawoutput.offset);
> +        header.ws.u.s64.l64 = cpu_to_be64(buffer->offset);
>          header_size = QIO_CHANNEL_WEBSOCK_HEADER_LEN_64_BIT;
>      }
>      header_size -= QIO_CHANNEL_WEBSOCK_HEADER_LEN_MASK;
>  
> -    buffer_reserve(&ioc->encoutput, header_size + ioc->rawoutput.offset);
> +    buffer_reserve(&ioc->encoutput, header_size + buffer->offset);
>      buffer_append(&ioc->encoutput, header.buf, header_size);
> -    buffer_append(&ioc->encoutput, ioc->rawoutput.buffer,
> -                  ioc->rawoutput.offset);
> +    buffer_append(&ioc->encoutput, buffer->buffer, buffer->offset);
> +}
> +
> +
> +static void qio_channel_websock_encode(QIOChannelWebsock *ioc)
> +{
> +    if (!ioc->rawoutput.offset) {
> +        return;
> +    }
> +    qio_channel_websock_encode_buffer(ioc,
> +            QIO_CHANNEL_WEBSOCK_OPCODE_BINARY_FRAME, &ioc->rawoutput);
>      buffer_reset(&ioc->rawoutput);
>  }
>  
> @@ -558,7 +563,7 @@ static int qio_channel_websock_decode_header(QIOChannelWebsock *ioc,
>      /* Websocket frame sanity check:
>       * * Fragmentation is only supported for binary frames.
>       * * All frames sent by a client MUST be masked.
> -     * * Only binary encoding is supported.
> +     * * Only binary and ping/pong encoding is supported.
>       */
>      if (!fin) {
>          if (opcode != QIO_CHANNEL_WEBSOCK_OPCODE_BINARY_FRAME) {
> @@ -619,6 +624,11 @@ static int qio_channel_websock_decode_payload(QIOChannelWebsock *ioc,
>           * for purpose of unmasking, except at end of payload
>           */
>          if (ioc->encinput.offset < ioc->payload_remain) {
> +            /* Wait for the entire payload before processing control frames
> +             * because the payload will most likely be echoed back. */
> +            if (ioc->opcode & QIO_CHANNEL_WEBSOCK_CONTROL_OPCODE_MASK) {
> +                return QIO_CHANNEL_ERR_BLOCK;
> +            }
>              payload_len = ioc->encinput.offset - (ioc->encinput.offset % 4);
>          } else {
>              payload_len = ioc->payload_remain;
> @@ -641,13 +651,17 @@ static int qio_channel_websock_decode_payload(QIOChannelWebsock *ioc,
>          }
>      }
>  
> -    /* Drop the payload of ping/pong packets */
>      if (ioc->opcode == QIO_CHANNEL_WEBSOCK_OPCODE_BINARY_FRAME) {
>          if (payload_len) {
> +            /* binary frames are passed on */
>              buffer_reserve(&ioc->rawinput, payload_len);
>              buffer_append(&ioc->rawinput, ioc->encinput.buffer, payload_len);
>          }
> -    }
> +    } else if (ioc->opcode == QIO_CHANNEL_WEBSOCK_OPCODE_PING) {
> +        /* ping frames produce an immediate pong reply */
> +        qio_channel_websock_encode_buffer(ioc,
> +                QIO_CHANNEL_WEBSOCK_OPCODE_PONG, &ioc->encinput);
> +    }   /* pong frames are ignored */

So qio_channel_websock_opcode_pong() takes the PING payload and adds it
to ioc->encoutput buffer.  When the socket is later seen as writable
the event loop will write this buffer to the wire.

I'm concerned that there is no rate limiting here though, so if a large
number of PINGs are sent, and writing of the reply blocks for some reason,
encoutput will grow without bounds.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
