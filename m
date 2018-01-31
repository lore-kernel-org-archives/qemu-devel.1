Received: from eggs.gnu.org ([2001:4830:134:3::10]:53211)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <klim.kireev@virtuozzo.com>) id 1egs5v-0000XY-N7
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 08:06:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <klim.kireev@virtuozzo.com>) id 1egs5r-00030s-NY
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 08:06:31 -0500
Received: from mail-db5eur01on0126.outbound.protection.outlook.com
	([104.47.2.126]:60640
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <klim.kireev@virtuozzo.com>)
	id 1egs5q-0002wi-SE
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 08:06:27 -0500
From: Klim Kireev <klim.kireev@virtuozzo.com>
Date: Wed, 31 Jan 2018 16:06:13 +0300
Message-Id: <20180131130613.30959-1-klim.kireev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] vnc: fix segfault in closed connection handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com

On one of our client's node, due to trying to read from closed ioc,
a segmentation fault occured. Corresponding backtrace:

Having analyzed the coredump, I understood that the reason is that
ioc_tag is reset on vnc_disconnect_start and ioc is cleaned
in vnc_disconnect_finish. Between these two events due to some
reasons the ioc_tag was set again and after vnc_disconnect_finish
the handler is running with freed ioc,
which led to the segmentation fault.

I suggest to check ioc_tag in vnc_disconnect_finish to prevent such
an occurrence.

Signed-off-by: Klim Kireev <klim.kireev@virtuozzo.com>
---
 ui/vnc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/ui/vnc.c b/ui/vnc.c
index 33b087221f..b8bf0180cb 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -1270,6 +1270,10 @@ void vnc_disconnect_finish(VncState *vs)
     }
     g_free(vs->lossy_rect);
 
+    if (vs->ioc_tag) {
+        g_source_remove(vs->ioc_tag);
+        vs->ioc_tag = 0;
+    }
     object_unref(OBJECT(vs->ioc));
     vs->ioc = NULL;
     object_unref(OBJECT(vs->sioc));
-- 
2.14.3
