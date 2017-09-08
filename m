Received: from eggs.gnu.org ([2001:4830:134:3::10]:32945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dq8gq-0003l7-6U
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 22:06:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dq8gl-0002dS-DH
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 22:06:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56108)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dq8gl-0002cs-4x
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 22:06:35 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Fri,  8 Sep 2017 10:05:21 +0800
Message-Id: <1504836324-4871-16-git-send-email-jasowang@redhat.com>
In-Reply-To: <1504836324-4871-1-git-send-email-jasowang@redhat.com>
References: <1504836324-4871-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 15/18] net/colo-compare.c: Fix comments and
 scheme
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>

From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/colo-compare.c | 59 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 28 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index f480315..eee33b8 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -41,27 +41,27 @@
 #define REGULAR_PACKET_CHECK_MS 3000
 
 /*
-  + CompareState ++
-  |               |
-  +---------------+   +---------------+         +---------------+
-  |conn list      +--->conn           +--------->conn           |
-  +---------------+   +---------------+         +---------------+
-  |               |     |           |             |          |
-  +---------------+ +---v----+  +---v----+    +---v----+ +---v----+
-                    |primary |  |secondary    |primary | |secondary
-                    |packet  |  |packet  +    |packet  | |packet  +
-                    +--------+  +--------+    +--------+ +--------+
-                        |           |             |          |
-                    +---v----+  +---v----+    +---v----+ +---v----+
-                    |primary |  |secondary    |primary | |secondary
-                    |packet  |  |packet  +    |packet  | |packet  +
-                    +--------+  +--------+    +--------+ +--------+
-                        |           |             |          |
-                    +---v----+  +---v----+    +---v----+ +---v----+
-                    |primary |  |secondary    |primary | |secondary
-                    |packet  |  |packet  +    |packet  | |packet  +
-                    +--------+  +--------+    +--------+ +--------+
-*/
+ *  + CompareState ++
+ *  |               |
+ *  +---------------+   +---------------+         +---------------+
+ *  |   conn list   + - >      conn     + ------- >      conn     + -- > ......
+ *  +---------------+   +---------------+         +---------------+
+ *  |               |     |           |             |          |
+ *  +---------------+ +---v----+  +---v----+    +---v----+ +---v----+
+ *                    |primary |  |secondary    |primary | |secondary
+ *                    |packet  |  |packet  +    |packet  | |packet  +
+ *                    +--------+  +--------+    +--------+ +--------+
+ *                        |           |             |          |
+ *                    +---v----+  +---v----+    +---v----+ +---v----+
+ *                    |primary |  |secondary    |primary | |secondary
+ *                    |packet  |  |packet  +    |packet  | |packet  +
+ *                    +--------+  +--------+    +--------+ +--------+
+ *                        |           |             |          |
+ *                    +---v----+  +---v----+    +---v----+ +---v----+
+ *                    |primary |  |secondary    |primary | |secondary
+ *                    |packet  |  |packet  +    |packet  | |packet  +
+ *                    +--------+  +--------+    +--------+ +--------+
+ */
 typedef struct CompareState {
     Object parent;
 
@@ -75,14 +75,14 @@ typedef struct CompareState {
     SocketReadState sec_rs;
     bool vnet_hdr;
 
-    /* connection list: the connections belonged to this NIC could be found
-     * in this list.
-     * element type: Connection
+    /*
+     * Record the connection that through the NIC
+     * Element type: Connection
      */
     GQueue conn_list;
-    /* hashtable to save connection */
+    /* Record the connection without repetition */
     GHashTable *connection_track_table;
-    /* compare thread, a thread for each NIC */
+    /* This thread just do packet compare job */
     QemuThread thread;
 
     GMainContext *worker_context;
@@ -445,8 +445,11 @@ static int colo_old_packet_check_one_conn(Connection *conn,
                                  (GCompareFunc)colo_old_packet_check_one);
 
     if (result) {
-        /* do checkpoint will flush old packet */
-        /* TODO: colo_notify_checkpoint();*/
+        /* Do checkpoint will flush old packet */
+        /*
+         * TODO: Notify colo frame to do checkpoint.
+         * colo_compare_inconsistent_notify();
+         */
         return 0;
     }
 
-- 
2.7.4
