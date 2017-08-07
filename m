Received: from eggs.gnu.org ([2001:4830:134:3::10]:49153)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejJB-0007UY-SH
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejIw-00040b-JY
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:47:05 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  7 Aug 2017 16:45:37 +0200
Message-Id: <1502117160-24655-34-git-send-email-armbru@redhat.com>
In-Reply-To: <1502117160-24655-1-git-send-email-armbru@redhat.com>
References: <1502117160-24655-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 33/56] block: Make block_resize size
 unsigned in QAPI/QMP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, jsnow@redhat.com, pbonzini@redhat.com, marcandre.lureau@redhat.com, dgilbert@redhat.com, quintela@redhat.com, berrange@redhat.com, qemu-block@nongnu.org

Sizes should use QAPI type 'size' (uint64_t).  block_resize parameter
@size is 'int' (int64_t).  qmp_block_resize() ensures it's
non-negative before it passes it on to blk_truncate().

Change parameter @size to 'size', and update the range check
accordingly.  Just cleanup; block_resize accepts the same size values
as before.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 blockdev.c           | 7 ++++---
 qapi/block-core.json | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 960c5be..98dbe51 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2916,7 +2916,7 @@ void hmp_drive_del(Monitor *mon, const QDict *qdict)
 
 void qmp_block_resize(bool has_device, const char *device,
                       bool has_node_name, const char *node_name,
-                      int64_t size, Error **errp)
+                      uint64_t size, Error **errp)
 {
     Error *local_err = NULL;
     BlockBackend *blk = NULL;
@@ -2940,8 +2940,9 @@ void qmp_block_resize(bool has_device, const char *device,
         goto out;
     }
 
-    if (size < 0) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "size", "a >0 size");
+    if (size > INT64_MAX) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "size",
+                   "a size less than 8EiB");
         goto out;
     }
 
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 1e26cb0..2e0d53c 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1009,7 +1009,7 @@
 ##
 { 'command': 'block_resize', 'data': { '*device': 'str',
                                        '*node-name': 'str',
-                                       'size': 'int' }}
+                                       'size': 'size' }}
 
 ##
 # @NewImageMode:
-- 
2.7.5
