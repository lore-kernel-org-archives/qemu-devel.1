Received: from eggs.gnu.org ([2001:4830:134:3::10]:40658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cg0Pt-0005S7-Aa
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 21:43:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cg0Ps-0003Qd-IQ
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 21:43:01 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 20 Feb 2017 20:42:41 -0600
Message-Id: <20170221024248.11027-2-eblake@redhat.com>
In-Reply-To: <20170221024248.11027-1-eblake@redhat.com>
References: <20170221024248.11027-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v4 1/8] nbd/client: fix drop_sync
 [CVE-2017-2630]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, vsementsov@virtuozzo.com, den@virtuozzo.com

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Comparison symbol is misused. It may lead to memory corruption.
Introduced in commit 7d3123e.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20170203154757.36140-6-vsementsov@virtuozzo.com>
[eblake: add CVE details]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 nbd/client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nbd/client.c b/nbd/client.c
index ffb0743..0d16cd1 100644
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
2.9.3
