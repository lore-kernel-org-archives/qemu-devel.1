Received: from eggs.gnu.org ([2001:4830:134:3::10]:33330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ccEhT-0002mW-GC
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 12:09:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ccEhS-0003Bz-DQ
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 12:09:35 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri, 10 Feb 2017 17:08:56 +0000
Message-Id: <20170210170910.8867-5-berrange@redhat.com>
In-Reply-To: <20170210170910.8867-1-berrange@redhat.com>
References: <20170210170910.8867-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v4 04/18] qcow: require image size to be > 1
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
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The qcow driver refuses to open images which are less than
2 bytes in size, but will happily create such images. Add
a check in the create path to avoid this discrepancy.

Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 block/qcow.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/qcow.c b/block/qcow.c
index fb738fc..744b25e 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -805,6 +805,12 @@ static int qcow_create(const char *filename, QemuOpts *opts, Error **errp)
     /* Read out options */
     total_size = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
                           BDRV_SECTOR_SIZE);
+    if (total_size == 0) {
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
