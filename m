Received: from eggs.gnu.org ([2001:4830:134:3::10]:53129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn7Ol-0001wE-Ol
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 14:07:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn7Ok-0001cO-R0
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 14:07:31 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 30 Aug 2017 13:07:05 -0500
Message-Id: <20170830180711.7974-6-eblake@redhat.com>
In-Reply-To: <20170830180711.7974-1-eblake@redhat.com>
References: <20170830180711.7974-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 05/11] nbd/client: fix nbd_opt_go
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

Do not send NBD_OPT_ABORT to the broken server. After sending
NBD_REP_ACK on NBD_OPT_GO server is most probably in transmission
phase, when option sending is finished.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20170804151440.320927-2-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
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
2.13.5
