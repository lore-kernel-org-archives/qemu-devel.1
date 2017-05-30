Received: from eggs.gnu.org ([2001:4830:134:3::10]:54292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dFiAp-0005Q3-0n
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:31:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dFiAm-0000QJ-WC
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:31:02 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:6896 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dFiAm-0000Ne-0s
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:31:00 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 30 May 2017 17:30:51 +0300
Message-Id: <20170530143052.165002-19-vsementsov@virtuozzo.com>
In-Reply-To: <20170530143052.165002-1-vsementsov@virtuozzo.com>
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 18/19] nbd/client: refactor TRACE of NBD_MAGIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, berrange@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/client.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index 3d15596120..52f7981c9c 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -426,6 +426,21 @@ static QIOChannel *nbd_receive_starttls(QIOChannel *ioc,
     return QIO_CHANNEL(tioc);
 }
 
+static const char *nbd_magic_to_string(char *out, const char *in,
+                                       size_t count)
+{
+    size_t i;
+
+    for (i = 0; i < count; ++i) {
+        if (in[i] == '\0') {
+            out[i] = '\0';
+            break;
+        }
+        out[i] = qemu_isprint(in[i]) ? in[i] : '.';
+    }
+
+    return out;
+}
 
 int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
                           QCryptoTLSCreds *tlscreds, const char *hostname,
@@ -433,6 +448,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
                           off_t *size, Error **errp)
 {
     char buf[256];
+    char print_buf[256];
     uint64_t magic, s;
     int rc;
     bool zeroes = true;
@@ -461,15 +477,7 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
         goto fail;
     }
 
-    TRACE("Magic is %c%c%c%c%c%c%c%c",
-          qemu_isprint(buf[0]) ? buf[0] : '.',
-          qemu_isprint(buf[1]) ? buf[1] : '.',
-          qemu_isprint(buf[2]) ? buf[2] : '.',
-          qemu_isprint(buf[3]) ? buf[3] : '.',
-          qemu_isprint(buf[4]) ? buf[4] : '.',
-          qemu_isprint(buf[5]) ? buf[5] : '.',
-          qemu_isprint(buf[6]) ? buf[6] : '.',
-          qemu_isprint(buf[7]) ? buf[7] : '.');
+    TRACE("Magic is %s", nbd_magic_to_string(print_buf, buf, 9));
 
     if (memcmp(buf, "NBDMAGIC", 8) != 0) {
         error_setg(errp, "Invalid magic received");
-- 
2.11.1
