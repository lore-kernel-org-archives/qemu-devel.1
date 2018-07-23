Received: from eggs.gnu.org ([2001:4830:134:3::10]:41855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhJS-0002d7-J9
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:20:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhJR-0004Q9-5K
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:20:10 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:16:55 -0500
Message-Id: <20180723201748.25573-47-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 46/99] vhost-user: delete net client if
 necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, linzhecheng <linzhecheng@huawei.com>, Jason Wang <jasowang@redhat.com>

From: linzhecheng <linzhecheng@huawei.com>

As qemu_new_net_client create new ncs but error happens later,
ncs will be left in global net_clients list and we can't use them any
more, so we need to cleanup them.

Cc: qemu-stable@nongnu.org
Signed-off-by: linzhecheng <linzhecheng@huawei.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
(cherry picked from commit c67daf4a24442d1bb404a11a6a54dc45ea10f234)
 Conflicts:
	net/vhost-user.c
* drop functional dep on 4d0cf552
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 net/vhost-user.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/vhost-user.c b/net/vhost-user.c
index e0f16c895b..62745c06dd 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -299,7 +299,7 @@ static int net_vhost_user_init(NetClientState *peer, const char *device,
             s = DO_UPCAST(VhostUserState, nc, nc);
             if (!qemu_chr_fe_init(&s->chr, chr, &err)) {
                 error_report_err(err);
-                return -1;
+                goto err;
             }
         }
 
@@ -309,7 +309,7 @@ static int net_vhost_user_init(NetClientState *peer, const char *device,
     do {
         if (qemu_chr_fe_wait_connected(&s->chr, &err) < 0) {
             error_report_err(err);
-            return -1;
+            goto err;
         }
         qemu_chr_fe_set_handlers(&s->chr, NULL, NULL,
                                  net_vhost_user_event, NULL, nc0->name, NULL,
@@ -319,6 +319,13 @@ static int net_vhost_user_init(NetClientState *peer, const char *device,
     assert(s->vhost_net);
 
     return 0;
+
+err:
+    if (nc0) {
+        qemu_del_net_client(nc0);
+    }
+
+    return -1;
 }
 
 static Chardev *net_vhost_claim_chardev(
-- 
2.17.1
