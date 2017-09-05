Received: from eggs.gnu.org ([2001:4830:134:3::10]:57515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dp7N7-00039L-Hd
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 02:30:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dp7N2-0006Ao-Oc
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 02:30:05 -0400
Received: from mail.cn.fujitsu.com ([183.91.158.132]:33561
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dp7N1-00069o-UV
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 02:30:00 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Tue, 5 Sep 2017 14:31:06 +0800
Message-ID: <1504593066-14023-4-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1504593066-14023-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1504593066-14023-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V6 3/3] net/colo-compare.c: Fix comments and
 scheme
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 net/colo-compare.c | 59 ++++++++++++++++++++++++++++--------------------------
 1 file changed, 31 insertions(+), 28 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index c31adc6..d5fcfea 100644
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
@@ -444,8 +444,11 @@ static int colo_old_packet_check_one_conn(Connection *conn,
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
