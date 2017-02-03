Received: from eggs.gnu.org ([2001:4830:134:3::10]:36705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cZg5n-0007nh-CK
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:48:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cZg5j-00081h-3C
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:48:07 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:43301 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1cZg5i-0007zE-Nh
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 10:48:03 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  3 Feb 2017 18:47:44 +0300
Message-Id: <20170203154757.36140-6-vsementsov@virtuozzo.com>
In-Reply-To: <20170203154757.36140-1-vsementsov@virtuozzo.com>
References: <20170203154757.36140-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 05/18] nbd/client: fix drop_sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: famz@redhat.com, jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, den@virtuozzo.com, stefanha@redhat.com

Comparison symbol is misused. It may lead to memory corruption.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nbd/client.c b/nbd/client.c
index 6caf6bda6d..351731bc63 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -94,7 +94,7 @@ static ssize_t drop_sync(QIOChannel *ioc, size_t size)
     char small[1024];
     char *buffer;
 
-    buffer = sizeof(small) < size ? small : g_malloc(MIN(65536, size));
+    buffer = sizeof(small) > size ? small : g_malloc(MIN(65536, size));
     while (size > 0) {
         ssize_t count = read_sync(ioc, buffer, MIN(65536, size));
 
-- 
2.11.0
