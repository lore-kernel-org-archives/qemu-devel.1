Received: from eggs.gnu.org ([2001:4830:134:3::10]:40475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brandon.carpenter@cypherpath.com>)
	id 1drn12-0004jX-JA
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 11:22:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brandon.carpenter@cypherpath.com>)
	id 1drn0z-0006zG-D2
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 11:22:20 -0400
Received: from mail-pg0-x229.google.com ([2607:f8b0:400e:c05::229]:33057)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <brandon.carpenter@cypherpath.com>)
	id 1drn0z-0006ys-6f
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 11:22:17 -0400
Received: by mail-pg0-x229.google.com with SMTP id u18so5253991pgo.0
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 08:22:16 -0700 (PDT)
MIME-Version: 1.0
From: Brandon Carpenter <brandon.carpenter@cypherpath.com>
Date: Tue, 12 Sep 2017 08:21:46 -0700
Message-Id: <20170912152153.7729-1-brandon.carpenter@cypherpath.com>
Content-Type: text/plain; charset="US-ASCII"
Subject: [Qemu-devel] [PATCH v3 0/7] Update websocket code to more fully
 support the RFC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, brandon.carpenter@cypherpath.com

We've been experiencing issues where the qemu websocket server closes
connections from noVNC clients for no apparent reason. Debugging shows
that certain web browsers are injecting ping and pong frames when the
connection becomes idle. Some browsers send those frames without a
payload, which also is causing closure. This patch series addresses
these issues by making the websocket server more conformant to RFC
6455 - The WebSocket Protocol.

Remembering the opcode is sufficient for handling fragmented frames from
the client, which may be introduced by an intermediary server/proxy.
Respond to pings and ignore pongs rather than close the connection as
many browsers use ping/pong to test an idle connection. Close
connections according to the RFC, including providing a reason code and
message to aid debugging of unexpected disconnects. Empty payloads
should not cause a disconnect.

While updating the websocket code, several other bugs were discovered
for which patches are also included early in the set.

Brandon Carpenter (7):
  io: Always remove an old channel watch before adding a new one
  io: Small updates in preparation for websocket changes
  io: Add support for fragmented websocket binary frames
  io: Allow empty websocket payload
  io: Ignore websocket PING and PONG frames
  io: Reply to ping frames
  io: Attempt to send websocket close messages to client

 include/io/channel-websock.h |   2 +
 io/channel-websock.c         | 282 +++++++++++++++++++++++++++----------------
 ui/vnc-auth-vencrypt.c       |   3 +
 ui/vnc-ws.c                  |   6 +
 ui/vnc.c                     |   4 +
 5 files changed, 194 insertions(+), 103 deletions(-)

-- 
2.14.1


-- 


CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, is 
for the sole use of the intended recipient(s) and may contain proprietary, 
confidential or privileged information or otherwise be protected by law. 
Any unauthorized review, use, disclosure or distribution is prohibited. If 
you are not the intended recipient, please notify the sender and destroy 
all copies and the original message.
