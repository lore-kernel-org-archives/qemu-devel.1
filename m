Received: from eggs.gnu.org ([2001:4830:134:3::10]:43997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxiH-00069y-OG
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:08:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxiG-0004tB-T2
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:08:37 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 11 Jul 2017 18:06:53 +0200
Message-Id: <20170711160814.20941-5-mreitz@redhat.com>
In-Reply-To: <20170711160814.20941-1-mreitz@redhat.com>
References: <20170711160814.20941-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 04/85] qcow: require image size to be > 1 for
 new images
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

The qcow driver refuses to open images which are less than
2 bytes in size, but will happily create such images. Add
a check in the create path to avoid this discrepancy.

Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-id: 20170623162419.26068-5-berrange@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/qcow.c b/block/qcow.c
index 7bd94dc..49871fb 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -811,6 +811,12 @@ static int qcow_create(const char *filename, QemuOpts *opts, Error **errp)
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
2.9.4
