Received: from eggs.gnu.org ([2001:4830:134:3::10]:34382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gYAOA-0004n1-98
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 08:53:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gYAO8-00088w-H7
	for qemu-devel@nongnu.org; Sat, 15 Dec 2018 08:53:54 -0500
From: Eric Blake <eblake@redhat.com>
Date: Sat, 15 Dec 2018 07:53:09 -0600
Message-Id: <20181215135324.152629-8-eblake@redhat.com>
In-Reply-To: <20181215135324.152629-1-eblake@redhat.com>
References: <20181215135324.152629-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v2 07/22] qemu-nbd: Avoid strtol open-coding
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: nsoffer@redhat.com, jsnow@redhat.com, rjones@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

Our copy-and-pasted open-coding of strtol handling forgot to
handle overflow conditions.  Use qemu_strto*() instead.

In the case of --partition, since we insist on a user-supplied
partition to be non-zero, we can use 0 rather than -1 for our
initial value to distinguish when a partition is not being
served, for slightly more optimal code.

The error messages for out-of-bounds values are less specific,
but should not be a terrible loss in quality.

Signed-off-by: Eric Blake <eblake@redhat.com>

---
v2: Retitle, catch more uses of strtol
[Hmm - this depends on int64_t and off_t being compatible; if they
aren't that way on all platforms, I'll need a temporary variable]
---
 qemu-nbd.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/qemu-nbd.c b/qemu-nbd.c
index 2807e132396..e3f739671b5 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -544,9 +544,8 @@ int main(int argc, char **argv)
     };
     int ch;
     int opt_ind = 0;
-    char *end;
     int flags = BDRV_O_RDWR;
-    int partition = -1;
+    int partition = 0;
     int ret = 0;
     bool seen_cache = false;
     bool seen_discard = false;
@@ -657,13 +656,9 @@ int main(int argc, char **argv)
             port = optarg;
             break;
         case 'o':
-                dev_offset = strtoll (optarg, &end, 0);
-            if (*end) {
-                error_report("Invalid offset `%s'", optarg);
-                exit(EXIT_FAILURE);
-            }
-            if (dev_offset < 0) {
-                error_report("Offset must be positive `%s'", optarg);
+            if (qemu_strtoi64(optarg, NULL, 0, &dev_offset) < 0 ||
+                dev_offset < 0) {
+                error_report("Invalid offset '%s'", optarg);
                 exit(EXIT_FAILURE);
             }
             break;
@@ -685,13 +680,9 @@ int main(int argc, char **argv)
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
+                error_report("Invalid partition '%s'", optarg);
                 exit(EXIT_FAILURE);
             }
             break;
@@ -709,15 +700,11 @@ int main(int argc, char **argv)
             device = optarg;
             break;
         case 'e':
-            shared = strtol(optarg, &end, 0);
-            if (*end) {
+            if (qemu_strtoi(optarg, NULL, 0, &shared) < 0 ||
+                shared < 1) {
                 error_report("Invalid shared device number '%s'", optarg);
                 exit(EXIT_FAILURE);
             }
-            if (shared < 1) {
-                error_report("Shared device number must be greater than 0");
-                exit(EXIT_FAILURE);
-            }
             break;
         case 'f':
             fmt = optarg;
@@ -1006,7 +993,7 @@ int main(int argc, char **argv)
     }
     fd_size -= dev_offset;

-    if (partition != -1) {
+    if (partition) {
         ret = find_partition(blk, partition, &dev_offset, &fd_size);
         if (ret < 0) {
             error_report("Could not find partition %d: %s", partition,
-- 
2.17.2
