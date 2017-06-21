Received: from eggs.gnu.org ([2001:4830:134:3::10]:50419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dNheN-0007ve-GD
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 11:34:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dNheI-0008QP-Ft
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 11:34:35 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:8791 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dNheI-0008Os-4U
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 11:34:30 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 21 Jun 2017 18:34:23 +0300
Message-Id: <20170621153424.16690-6-vsementsov@virtuozzo.com>
In-Reply-To: <20170621153424.16690-1-vsementsov@virtuozzo.com>
References: <20170621153424.16690-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 5/6] nbd/client: refactor TRACE of NBD_MAGIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, eblake@redhat.com, pbonzini@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

We are going to switch from TRACE macro to trace points,
this TRACE complicates things, this patch simplifies it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/client.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index b97143fa60..5a4825ebe0 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -426,14 +426,13 @@ static QIOChannel *nbd_receive_starttls(QIOChannel *ioc,
     return QIO_CHANNEL(tioc);
 }
 
-
 int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
                           QCryptoTLSCreds *tlscreds, const char *hostname,
                           QIOChannel **outioc,
                           off_t *size, Error **errp)
 {
     char buf[256];
-    uint64_t magic, s;
+    uint64_t nbd_magic, magic, s;
     int rc;
     bool zeroes = true;
 
@@ -461,15 +460,9 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
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
+    memcpy(&nbd_magic, buf, 8);
+    nbd_magic = be64_to_cpu(nbd_magic);
+    TRACE("Magic is 0x%" PRIx64, nbd_magic);
 
     if (memcmp(buf, "NBDMAGIC", 8) != 0) {
         error_setg(errp, "Invalid magic received");
-- 
2.11.1
