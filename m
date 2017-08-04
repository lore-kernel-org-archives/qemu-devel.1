Received: from eggs.gnu.org ([2001:4830:134:3::10]:54631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ddeJN-0005UL-4T
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1ddeJJ-0007BG-TE
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:48 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:35883 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1ddeJJ-00077k-IE
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 11:14:45 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  4 Aug 2017 18:14:24 +0300
Message-Id: <20170804151440.320927-2-vsementsov@virtuozzo.com>
In-Reply-To: <20170804151440.320927-1-vsementsov@virtuozzo.com>
References: <20170804151440.320927-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 01/17] nbd/client: fix nbd_opt_go
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Do not send NBD_OPT_ABORT to the broken server. After sending
NBD_REP_ACK on NBD_OPT_GO server is most probably in transmission
phase, when option sending is finished.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 nbd/client.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/nbd/client.c b/nbd/client.c
index 0a17de80b5..f1c16b588f 100644
--- a/nbd/client.c
+++ b/nbd/client.c
@@ -399,12 +399,10 @@ static int nbd_opt_go(QIOChannel *ioc, const char *wantname,
                phase, but make sure it sent flags */
             if (len) {
                 error_setg(errp, "server sent invalid NBD_REP_ACK");
-                nbd_send_opt_abort(ioc);
                 return -1;
             }
             if (!info->flags) {
                 error_setg(errp, "broken server omitted NBD_INFO_EXPORT");
-                nbd_send_opt_abort(ioc);
                 return -1;
             }
             trace_nbd_opt_go_success();
-- 
2.11.1
