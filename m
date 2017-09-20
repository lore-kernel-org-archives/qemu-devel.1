Received: from eggs.gnu.org ([2001:4830:134:3::10]:40072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brandon.carpenter@cypherpath.com>)
	id 1duiIK-0002gW-OH
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 12:56:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brandon.carpenter@cypherpath.com>)
	id 1duiIG-0005y0-Jo
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 12:56:16 -0400
Received: from mail-pf0-x22a.google.com ([2607:f8b0:400e:c00::22a]:45375)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <brandon.carpenter@cypherpath.com>)
	id 1duiIG-0005t0-9Z
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 12:56:12 -0400
Received: by mail-pf0-x22a.google.com with SMTP id z84so1823486pfi.2
	for <qemu-devel@nongnu.org>; Wed, 20 Sep 2017 09:56:10 -0700 (PDT)
Date: Wed, 20 Sep 2017 09:56:07 -0700
From: Brandon Carpenter <brandon.carpenter@cypherpath.com>
Message-Id: <1505926567.32618.0@smtp.gmail.com>
In-Reply-To: <20170912152153.7729-1-brandon.carpenter@cypherpath.com>
References: <20170912152153.7729-1-brandon.carpenter@cypherpath.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"; format=flowed
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
To: qemu-devel@nongnu.org

How are things looking, Daniel. I believe every comment from the 
previous version of the series was addressed.

I also wanted to mention that I put together a Python script, which 
acts as a proxy between noVNC and qemu, and can inject various frame 
types, fragment frames, and shutdown the socket in various ways to help 
exercise the different code paths. I would be happy to post it here to 
help test the changes.

Thanks,
--
Brandon Carpenter | Software Engineer
Cypherpath, Inc.
400 Columbia Point Drive Ste 101 | Richland, Washington USA
Office: (650) 713-3060

On Tue, Sep 12, 2017 at 8:21 AM, Brandon Carpenter 
<brandon.carpenter@cypherpath.com> wrote:
> We've been experiencing issues where the qemu websocket server closes
> connections from noVNC clients for no apparent reason. Debugging shows
> that certain web browsers are injecting ping and pong frames when the
> connection becomes idle. Some browsers send those frames without a
> payload, which also is causing closure. This patch series addresses
> these issues by making the websocket server more conformant to RFC
> 6455 - The WebSocket Protocol.
> 
> Remembering the opcode is sufficient for handling fragmented frames 
> from
> the client, which may be introduced by an intermediary server/proxy.
> Respond to pings and ignore pongs rather than close the connection as
> many browsers use ping/pong to test an idle connection. Close
> connections according to the RFC, including providing a reason code 
> and
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
>  io/channel-websock.c         | 282 
> +++++++++++++++++++++++++++----------------
>  ui/vnc-auth-vencrypt.c       |   3 +
>  ui/vnc-ws.c                  |   6 +
>  ui/vnc.c                     |   4 +
>  5 files changed, 194 insertions(+), 103 deletions(-)
> 
> --
> 2.14.1
> 

-- 


CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, is 
for the sole use of the intended recipient(s) and may contain proprietary, 
confidential or privileged information or otherwise be protected by law. 
Any unauthorized review, use, disclosure or distribution is prohibited. If 
you are not the intended recipient, please notify the sender and destroy 
all copies and the original message.
