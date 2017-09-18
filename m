Received: from eggs.gnu.org ([2001:4830:134:3::10]:59372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dtxLQ-0003dD-Lp
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:48:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dtxLN-0001KA-Ea
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:48:20 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:38787)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dtxLN-0001Jt-76
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 10:48:17 -0400
Received: by mail-wr0-x243.google.com with SMTP id p37so489183wrb.5
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 07:48:17 -0700 (PDT)
Date: Mon, 18 Sep 2017 15:48:13 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170918144813.GD4141@stefanha-x1.localdomain>
References: <20170912152153.7729-1-brandon.carpenter@cypherpath.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170912152153.7729-1-brandon.carpenter@cypherpath.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/7] Update websocket code to more fully
 support the RFC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Brandon Carpenter <brandon.carpenter@cypherpath.com>
Cc: qemu-devel@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>

On Tue, Sep 12, 2017 at 08:21:46AM -0700, Brandon Carpenter wrote:
> We've been experiencing issues where the qemu websocket server closes
> connections from noVNC clients for no apparent reason. Debugging shows
> that certain web browsers are injecting ping and pong frames when the
> connection becomes idle. Some browsers send those frames without a
> payload, which also is causing closure. This patch series addresses
> these issues by making the websocket server more conformant to RFC
> 6455 - The WebSocket Protocol.
> 
> Remembering the opcode is sufficient for handling fragmented frames from
> the client, which may be introduced by an intermediary server/proxy.
> Respond to pings and ignore pongs rather than close the connection as
> many browsers use ping/pong to test an idle connection. Close
> connections according to the RFC, including providing a reason code and
> message to aid debugging of unexpected disconnects. Empty payloads
> should not cause a disconnect.
> 
> While updating the websocket code, several other bugs were discovered
> for which patches are also included early in the set.
> 
> Brandon Carpenter (7):
>   io: Always remove an old channel watch before adding a new one
>   io: Small updates in preparation for websocket changes
>   io: Add support for fragmented websocket binary frames
>   io: Allow empty websocket payload
>   io: Ignore websocket PING and PONG frames
>   io: Reply to ping frames
>   io: Attempt to send websocket close messages to client
> 
>  include/io/channel-websock.h |   2 +
>  io/channel-websock.c         | 282 +++++++++++++++++++++++++++----------------
>  ui/vnc-auth-vencrypt.c       |   3 +
>  ui/vnc-ws.c                  |   6 +
>  ui/vnc.c                     |   4 +
>  5 files changed, 194 insertions(+), 103 deletions(-)
> 
> -- 
> 2.14.1

Hi Brandon,
Thanks for the patch series!  Please CC the relevant maintainer on
future patches.  I've CCed Daniel Berrange on this email to bring your
work to his attention.

  $ scripts/get_maintainer.pl -f io/channel-websock.c
  "Daniel P. Berrange" <berrange@redhat.com> (maintainer:I/O Channels)
  qemu-devel@nongnu.org (open list:All patches CC here)

Stefan

> 
> 
> -- 
> 
> 
> CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, is 
> for the sole use of the intended recipient(s) and may contain proprietary, 
> confidential or privileged information or otherwise be protected by law. 
> Any unauthorized review, use, disclosure or distribution is prohibited. If 
> you are not the intended recipient, please notify the sender and destroy 
> all copies and the original message.
> 
