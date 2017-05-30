Received: from eggs.gnu.org ([2001:4830:134:3::10]:54293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dFiAp-0005Q4-1H
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:31:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dFiAm-0000PD-4c
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:31:02 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:1281 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dFiAl-0000NB-It
	for qemu-devel@nongnu.org; Tue, 30 May 2017 10:30:59 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 30 May 2017 17:30:40 +0300
Message-Id: <20170530143052.165002-8-vsementsov@virtuozzo.com>
In-Reply-To: <20170530143052.165002-1-vsementsov@virtuozzo.com>
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 07/19] nbd/server: nbd_negotiate: fix error path
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

Current code will return 0 on this write_sync fail, as rc is 0
after successful nbd_negotiate_options. Fix this.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/server.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/nbd/server.c b/nbd/server.c
index 3d4cd3d21c..984fad4bdb 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -607,7 +607,8 @@ static coroutine_fn int nbd_negotiate(NBDClient *client)
         stq_be_p(buf + 18, client->exp->size);
         stw_be_p(buf + 26, client->exp->nbdflags | myflags);
         len = client->no_zeroes ? 10 : sizeof(buf) - 18;
-        if (write_sync(client->ioc, buf + 18, len, NULL) < 0) {
+        rc = write_sync(client->ioc, buf + 18, len, NULL);
+        if (rc < 0) {
             LOG("write failed");
             goto fail;
         }
-- 
2.11.1
