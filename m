Received: from eggs.gnu.org ([2001:4830:134:3::10]:42609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cW2SH-00033d-2L
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:52:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cW2SG-0002F2-Ax
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 09:52:17 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 24 Jan 2017 14:51:39 +0000
Message-Id: <20170124145152.22980-5-berrange@redhat.com>
In-Reply-To: <20170124145152.22980-1-berrange@redhat.com>
References: <20170124145152.22980-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 04/17] qcow: require image size to be > 1
 for new images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The qcow driver refuses to open images which are less than
2 bytes in size, but will happily create such images. Add
a check in the create path to avoid this discrepancy.

Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 block/qcow.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/qcow.c b/block/qcow.c
index 7540f43..101c973 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -799,6 +799,12 @@ static int qcow_create(const char *filename, QemuOpts *opts, Error **errp)
     /* Read out options */
     total_size = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
                           BDRV_SECTOR_SIZE);
+    if (total_size <= 1) {
+        error_setg(errp, "Image size is too small, cannot be zero length");
+        ret = -EINVAL;
+        goto cleanup;
+    }
+
     backing_file = qemu_opt_get_del(opts, BLOCK_OPT_BACKING_FILE);
     if (qemu_opt_get_bool_del(opts, BLOCK_OPT_ENCRYPT, false)) {
         flags |= BLOCK_FLAG_ENCRYPT;
-- 
2.9.3
