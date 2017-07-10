Received: from eggs.gnu.org ([2001:4830:134:3::10]:54738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUXaa-0001h8-AG
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:14:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUXaZ-0002eJ-Hp
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 08:14:56 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 10 Jul 2017 07:14:30 -0500
Message-Id: <20170710121434.5047-8-eblake@redhat.com>
In-Reply-To: <20170710121434.5047-1-eblake@redhat.com>
References: <20170710121434.5047-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 07/11] nbd/client: refactor TRACE of NBD_MAGIC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

We are going to switch from TRACE macro to trace points,
this TRACE complicates things, this patch simplifies it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20170707152918.23086-7-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/client.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index b97143f..2125321 100644
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
2.9.4
