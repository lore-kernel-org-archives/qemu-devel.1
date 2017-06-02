Received: from eggs.gnu.org ([2001:4830:134:3::10]:35978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dGo5Q-0001FX-I7
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 11:02:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dGo5L-0002fu-MQ
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 11:02:00 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:41401 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dGo5L-0002ez-Bk
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 11:01:55 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  2 Jun 2017 18:01:47 +0300
Message-Id: <20170602150150.258222-10-vsementsov@virtuozzo.com>
In-Reply-To: <20170602150150.258222-1-vsementsov@virtuozzo.com>
References: <20170602150150.258222-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 09/12] nbd/server: nbd_negotiate: fix error
 path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Current code will return 0 on this nbd_write fail, as rc is 0
after successful nbd_negotiate_options. Fix this.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 nbd/server.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/nbd/server.c b/nbd/server.c
index d376563527..ec163ad829 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -607,7 +607,8 @@ static coroutine_fn int nbd_negotiate(NBDClient *client)
         stq_be_p(buf + 18, client->exp->size);
         stw_be_p(buf + 26, client->exp->nbdflags | myflags);
         len = client->no_zeroes ? 10 : sizeof(buf) - 18;
-        if (nbd_write(client->ioc, buf + 18, len, NULL) < 0) {
+        rc = nbd_write(client->ioc, buf + 18, len, NULL);
+        if (rc < 0) {
             LOG("write failed");
             goto fail;
         }
-- 
2.11.1
