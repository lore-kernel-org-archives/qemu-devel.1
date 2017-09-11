Received: from eggs.gnu.org ([2001:4830:134:3::10]:59487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brandon.carpenter@cypherpath.com>)
	id 1drS7d-000108-KR
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:03:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brandon.carpenter@cypherpath.com>)
	id 1drS7a-0000JF-Gh
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:03:45 -0400
Received: from mail-io0-x22c.google.com ([2607:f8b0:4001:c06::22c]:35419)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <brandon.carpenter@cypherpath.com>)
	id 1drS7a-0000IU-9g
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 13:03:42 -0400
Received: by mail-io0-x22c.google.com with SMTP id g32so12799098ioj.2
	for <qemu-devel@nongnu.org>; Mon, 11 Sep 2017 10:03:40 -0700 (PDT)
Date: Mon, 11 Sep 2017 10:03:35 -0700
From: Brandon Carpenter <brandon.carpenter@cypherpath.com>
Message-Id: <1505149415.1214.1@smtp.gmail.com>
In-Reply-To: <20170911085043.GE21444@redhat.com>
References: <20170724184217.21381-1-brandon.carpenter@cypherpath.com>
	<20170908173801.15205-7-brandon.carpenter@cypherpath.com>
	<20170911085043.GE21444@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"; format=flowed
Subject: Re: [Qemu-devel] [PATCH v2 6/6] io: Reply to ping frames
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

On Mon, Sep 11, 2017 at 1:50 AM, Daniel P. Berrange 
<berrange@redhat.com> wrote:
> I'm concerned that there is no rate limiting here though, so if a 
> large number of PINGs are sent, and writing of the reply blocks for 
> some reason, encoutput will grow without bounds.

That is a good point. How about something like this to fix it?

diff --git a/include/io/channel-websock.h b/include/io/channel-websock.h
index 7c896557c5..c5a8c3e96c 100644
--- a/include/io/channel-websock.h
+++ b/include/io/channel-websock.h
@@ -66,6 +66,7 @@ struct QIOChannelWebsock {
     Error *io_err;
     gboolean io_eof;
     uint8_t opcode;
+ uint8_t prev_opcode;
 };

 /**
diff --git a/io/channel-websock.c b/io/channel-websock.c
index 175f17ce6b..a9315c01fb 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -549,6 +549,7 @@ static int 
qio_channel_websock_decode_header(QIOChannelWebsock *ioc,
     payload_len = header->b1 & 
QIO_CHANNEL_WEBSOCK_HEADER_FIELD_PAYLOAD_LEN;

     /* Save or restore opcode. */
+ ioc->prev_opcode = ioc->opcode;
     if (opcode) {
         ioc->opcode = opcode;
     } else {
@@ -658,9 +659,14 @@ static int 
qio_channel_websock_decode_payload(QIOChannelWebsock *ioc,
             buffer_append(&ioc->rawinput, ioc->encinput.buffer, 
payload_len);
         }
     } else if (ioc->opcode == QIO_CHANNEL_WEBSOCK_OPCODE_PING) {
- /* ping frames produce an immediate pong reply */
- qio_channel_websock_encode_buffer(ioc,
- QIO_CHANNEL_WEBSOCK_OPCODE_PONG, &ioc->encinput);
+ /* Ping frames produce an immediate pong reply, unless one
+ * is already queued, in which case they are coalesced
+ * to avoid unbounded buffer growth.
+ */
+ if (!ioc->encoutput.offset || ioc->prev_opcode != 
QIO_CHANNEL_WEBSOCK_OPCODE_PING) {
+ qio_channel_websock_encode_buffer(ioc,
+ QIO_CHANNEL_WEBSOCK_OPCODE_PONG, &ioc->encinput);
+ }
     } /* pong frames are ignored */

     if (payload_len) {

--
Brandon Carpenter | Software Engineer
Cypherpath, Inc.
400 Columbia Point Drive Ste 101 | Richland, Washington USA
Office: (650) 713-3060


-- 


CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, is 
for the sole use of the intended recipient(s) and may contain proprietary, 
confidential or privileged information or otherwise be protected by law. 
Any unauthorized review, use, disclosure or distribution is prohibited. If 
you are not the intended recipient, please notify the sender and destroy 
all copies and the original message.
