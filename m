Received: from eggs.gnu.org ([2001:4830:134:3::10]:60464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfzq0-00068F-PB
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 22:38:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dfzpz-00057S-Qe
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 22:38:12 -0400
From: Eric Blake <eblake@redhat.com>
Date: Thu, 10 Aug 2017 21:37:58 -0500
Message-Id: <20170811023759.26390-3-eblake@redhat.com>
In-Reply-To: <20170811023759.26390-1-eblake@redhat.com>
References: <20170811023759.26390-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] HACK: define NBD_SERVER_DEBUG to force
 malicious server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

---
 nbd/server.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/nbd/server.c b/nbd/server.c
index 82a78bf439..d6fbd46370 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -919,6 +919,17 @@ static int nbd_send_reply(QIOChannel *ioc, NBDReply *reply, Error **errp)
     stl_be_p(buf + 4, reply->error);
     stq_be_p(buf + 8, reply->handle);

+    static int debug;
+    static int count;
+    if (!count++) {
+        const char *str = getenv("NBD_SERVER_DEBUG");
+        if (str) {
+            debug = atoi(str);
+        }
+    }
+    if (debug && !(count % debug)) {
+        buf[0] = 0;
+    }
     return nbd_write(ioc, buf, sizeof(buf), errp);
 }

-- 
2.13.4
