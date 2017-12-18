Received: from eggs.gnu.org ([2001:4830:134:3::10]:50331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eR0qW-0006Sj-4Y
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 14:13:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eR0qS-0005Ic-2Q
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 14:13:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55008)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eR0qR-0005H1-Pb
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 14:12:59 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E56BF5FD51
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 19:12:58 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 18 Dec 2017 19:12:22 +0000
Message-Id: <20171218191228.31018-8-berrange@redhat.com>
In-Reply-To: <20171218191228.31018-1-berrange@redhat.com>
References: <20171218191228.31018-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v1 07/13] ui: correctly reset framebuffer
 update state after processing dirty regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, P J P <ppandit@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

According to the RFB protocol, a client sends one or more framebuffer update
requests to the server. The server can reply with a single framebuffer update
response, that covers all previously received requests. Once the client has
read this update from the server, it may send further framebuffer update
requests to monitor future changes. The client is free to delay sending the
framebuffer update request if it needs to throttle the amount of data it is
reading from the server.

The QEMU VNC server, however, has never correctly handled the framebuffer
update requests. Once QEMU has received an update request, it will continue to
send client updates forever, even if the client hasn't asked for further
updates. This prevents the client from throttling back data it gets from the
server. This change fixes the flawed logic such that after a set of updates are
sent out, QEMU waits for a further update request before sending more data.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 ui/vnc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index d3b04f1166..51fbf0449d 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1031,7 +1031,7 @@ static int vnc_update_client(VncState *vs, int has_dirty)
     }
 
     vnc_job_push(job);
-    vs->update = VNC_STATE_UPDATE_INCREMENTAL;
+    vs->update = VNC_STATE_UPDATE_NONE;
     vs->has_dirty = 0;
     return n;
 }
-- 
2.14.3
