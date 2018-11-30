Received: from eggs.gnu.org ([2001:4830:134:3::10]:55947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSqtH-0004Nq-UA
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 17:04:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gSqtG-0004C5-D8
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 17:04:03 -0500
From: Eric Blake <eblake@redhat.com>
Date: Fri, 30 Nov 2018 16:03:33 -0600
Message-Id: <20181130220344.3350618-5-eblake@redhat.com>
In-Reply-To: <20181130220344.3350618-1-eblake@redhat.com>
References: <20181130220344.3350618-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 04/14] qemu-nbd: Simplify --partition handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, nsoffer@redhat.com, rjones@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

Our open-coding of strtol handling forgot to handle overflow
conditions. What's more, since we insiste on a user-supplied
partition to be non-zero, we can use 0 rather than -1 for our
initial value to distinguish when a partition is not being
served, for slightly more optimal code.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qemu-nbd.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index 55e29bd9a7e..866e64779f1 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -546,7 +546,7 @@ int main(int argc, char **argv)
     int opt_ind = 0;
     char *end;
     int flags = BDRV_O_RDWR;
-    int partition = -1;
+    int partition = 0;
     int ret = 0;
     bool seen_cache = false;
     bool seen_discard = false;
@@ -685,13 +685,9 @@ int main(int argc, char **argv)
             flags &= ~BDRV_O_RDWR;
             break;
         case 'P':
-            partition = strtol(optarg, &end, 0);
-            if (*end) {
-                error_report("Invalid partition `%s'", optarg);
-                exit(EXIT_FAILURE);
-            }
-            if (partition < 1 || partition > 8) {
-                error_report("Invalid partition %d", partition);
+            if (qemu_strtoi(optarg, NULL, 0, &partition) < 0 ||
+                partition < 1 || partition > 8) {
+                error_report("Invalid partition %s", optarg);
                 exit(EXIT_FAILURE);
             }
             break;
@@ -1004,7 +1000,7 @@ int main(int argc, char **argv)
     }
     fd_size -= dev_offset;

-    if (partition != -1) {
+    if (partition) {
         ret = find_partition(blk, partition, &dev_offset, &fd_size);
         if (ret < 0) {
             error_report("Could not find partition %d: %s", partition,
-- 
2.17.2
