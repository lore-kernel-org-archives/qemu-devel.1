Received: from eggs.gnu.org ([2001:4830:134:3::10]:33398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drSE3-0006Sv-6W
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:10:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drSDz-0002gS-5Y
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:10:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1drSDy-0002fr-Sj
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:10:19 -0400
Date: Mon, 11 Sep 2017 18:10:15 +0100
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170911171015.GU21444@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170724184217.21381-1-brandon.carpenter@cypherpath.com>
	<20170908173801.15205-7-brandon.carpenter@cypherpath.com>
	<20170911085043.GE21444@redhat.com>
	<1505149415.1214.1@smtp.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1505149415.1214.1@smtp.gmail.com>
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

On Mon, Sep 11, 2017 at 10:03:35AM -0700, Brandon Carpenter wrote:
> On Mon, Sep 11, 2017 at 1:50 AM, Daniel P. Berrange <berrange@redhat.com>
> wrote:
> > I'm concerned that there is no rate limiting here though, so if a large
> > number of PINGs are sent, and writing of the reply blocks for some
> > reason, encoutput will grow without bounds.
> 
> That is a good point. How about something like this to fix it?
> 
> diff --git a/include/io/channel-websock.h b/include/io/channel-websock.h
> index 7c896557c5..c5a8c3e96c 100644
> --- a/include/io/channel-websock.h
> +++ b/include/io/channel-websock.h
> @@ -66,6 +66,7 @@ struct QIOChannelWebsock {
>     Error *io_err;
>     gboolean io_eof;
>     uint8_t opcode;
> + uint8_t prev_opcode;
> };
> 
> /**
> diff --git a/io/channel-websock.c b/io/channel-websock.c
> index 175f17ce6b..a9315c01fb 100644
> --- a/io/channel-websock.c
> +++ b/io/channel-websock.c
> @@ -549,6 +549,7 @@ static int
> qio_channel_websock_decode_header(QIOChannelWebsock *ioc,
>     payload_len = header->b1 & QIO_CHANNEL_WEBSOCK_HEADER_FIELD_PAYLOAD_LEN;
> 
>     /* Save or restore opcode. */
> + ioc->prev_opcode = ioc->opcode;
>     if (opcode) {
>         ioc->opcode = opcode;
>     } else {
> @@ -658,9 +659,14 @@ static int
> qio_channel_websock_decode_payload(QIOChannelWebsock *ioc,
>             buffer_append(&ioc->rawinput, ioc->encinput.buffer,
> payload_len);
>         }
>     } else if (ioc->opcode == QIO_CHANNEL_WEBSOCK_OPCODE_PING) {
> - /* ping frames produce an immediate pong reply */
> - qio_channel_websock_encode_buffer(ioc,
> - QIO_CHANNEL_WEBSOCK_OPCODE_PONG, &ioc->encinput);
> + /* Ping frames produce an immediate pong reply, unless one
> + * is already queued, in which case they are coalesced
> + * to avoid unbounded buffer growth.
> + */
> + if (!ioc->encoutput.offset || ioc->prev_opcode !=
> QIO_CHANNEL_WEBSOCK_OPCODE_PING) {
> + qio_channel_websock_encode_buffer(ioc,
> + QIO_CHANNEL_WEBSOCK_OPCODE_PONG, &ioc->encinput);
> + }

It feels like this is still dangerous - the client simply has to
interleave each "ping" with a 1 byte binary frame to get around
this limit. We need to make sure we have an absolute cap on the
output buffer size. 

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
