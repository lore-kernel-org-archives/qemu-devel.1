Received: from eggs.gnu.org ([2001:4830:134:3::10]:55631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <root@ucloud.localdomain>) id 1e6aK4-0005Hp-9U
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 06:51:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <root@ucloud.localdomain>) id 1e6aJy-0000bj-Lp
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 06:51:08 -0400
Received: from [120.132.1.243] (port=37761 helo=ucloud.localdomain)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <root@ucloud.localdomain>) id 1e6aJy-0000ay-7s
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 06:51:02 -0400
From: Zhi Yong Wu <zhiyong.wu@ucloud.cn>
Date: Tue, 24 Oct 2017 03:29:54 +0800
Message-Id: <1508786994-32643-1-git-send-email-zhiyong.wu@ucloud.cn>
Subject: [Qemu-devel] [PATCH] COLO: remove the operation to clear connection
 list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: zhiyong.wu@ucloud.cn

When hash table is created with g_hash_table_new_full(),
the free function has been registered. So it isn't necessary
since g_hash_table_remove_all() will call connection_destroy()
for each connection struct automatically.

Signed-off-by: Zhi Yong Wu <zhiyong.wu@ucloud.cn>
---
 net/colo.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/net/colo.c b/net/colo.c
index 28ce7c8..668abb7 100644
--- a/net/colo.c
+++ b/net/colo.c
@@ -197,12 +197,6 @@ Connection *connection_get(GHashTable *connection_track_table,
             trace_colo_proxy_main("colo proxy connection hashtable full,"
                                   " clear it");
             connection_hashtable_reset(connection_track_table);
-            /*
-             * clear the conn_list
-             */
-            while (!g_queue_is_empty(conn_list)) {
-                connection_destroy(g_queue_pop_head(conn_list));
-            }
         }
 
         g_hash_table_insert(connection_track_table, new_key, conn);
-- 
1.7.1
