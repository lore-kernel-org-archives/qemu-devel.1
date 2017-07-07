Received: from eggs.gnu.org ([2001:4830:134:3::10]:40333)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dTVCH-0000s9-8M
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:29:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dTVCE-0001CB-28
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:29:33 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:36842 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dTVCD-00019z-MM
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 11:29:29 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  7 Jul 2017 18:29:14 +0300
Message-Id: <20170707152918.23086-7-vsementsov@virtuozzo.com>
In-Reply-To: <20170707152918.23086-1-vsementsov@virtuozzo.com>
References: <20170707152918.23086-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 06/10] nbd/client: refactor TRACE of
 NBD_MAGIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, eblake@redhat.com, pbonzini@redhat.com, berrange@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

We are going to switch from TRACE macro to trace points,
this TRACE complicates things, this patch simplifies it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/client.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index b97143fa60..2125321ebd 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -461,15 +461,8 @@ int nbd_receive_negotiate(QIOChannel *ioc, const char *name, uint16_t *flags,
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
+    magic = ldq_be_p(buf);
+    TRACE("Magic is 0x%" PRIx64, magic);
 
     if (memcmp(buf, "NBDMAGIC", 8) != 0) {
         error_setg(errp, "Invalid magic received");
-- 
2.11.1
