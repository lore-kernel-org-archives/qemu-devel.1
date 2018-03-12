Received: from eggs.gnu.org ([2001:4830:134:3::10]:45249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJU-0000hx-OQ
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJT-0005xu-MJ
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:48 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 12 Mar 2018 13:36:02 -0500
Message-Id: <20180312183628.394722-12-eblake@redhat.com>
In-Reply-To: <20180312183628.394722-1-eblake@redhat.com>
References: <20180312183628.394722-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 11/36] block: Deprecate "backing": ""
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

From: Max Reitz <mreitz@redhat.com>

We have a clear replacement, so let's deprecate it.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Message-Id: <20180224154033.29559-8-mreitz@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qemu-doc.texi        | 7 +++++++
 qapi/block-core.json | 4 ++--
 block.c              | 4 ++++
 qemu-options.hx      | 4 ++--
 4 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/qemu-doc.texi b/qemu-doc.texi
index 39e38c87ecf..f81fe40d61f 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2779,6 +2779,13 @@ support page sizes < 4096 any longer.
 The ``xlnx-ep108'' machine has been replaced by the ``xlnx-zcu102'' machine.
 The ``xlnx-zcu102'' machine has the same features and capabilites in QEMU.

+@section Block device options
+
+@subsection "backing": "" (since 2.12.0)
+
+In order to prevent QEMU from automatically opening an image's backing
+chain, use ``"backing": null'' instead.
+
 @node License
 @appendix License

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 524d51567a5..55dcc8bd85a 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1090,7 +1090,7 @@
 # @overlay: reference to the existing block device that will become
 #           the overlay of @node, as part of creating the snapshot.
 #           It must not have a current backing file (this can be
-#           achieved by passing "backing": "" to blockdev-add).
+#           achieved by passing "backing": null to blockdev-add).
 #
 # Since: 2.5
 ##
@@ -1238,7 +1238,7 @@
 #                     "node-name": "node1534",
 #                     "file": { "driver": "file",
 #                               "filename": "hd1.qcow2" },
-#                     "backing": "" } }
+#                     "backing": null } }
 #
 # <- { "return": {} }
 #
diff --git a/block.c b/block.c
index b673a004daf..e11f1355374 100644
--- a/block.c
+++ b/block.c
@@ -2649,6 +2649,10 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
     if (qobject_to(QNull, qdict_get(options, "backing")) != NULL ||
         (backing && *backing == '\0'))
     {
+        if (backing) {
+            warn_report("Use of \"backing\": \"\" is deprecated; "
+                        "use \"backing\": null instead");
+        }
         flags |= BDRV_O_NO_BACKING;
         qdict_del(options, "backing");
     }
diff --git a/qemu-options.hx b/qemu-options.hx
index 6585058c6cd..991ff4016db 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -740,8 +740,8 @@ Reference to or definition of the data source block driver node

 @item backing
 Reference to or definition of the backing file block device (default is taken
-from the image file). It is allowed to pass an empty string here in order to
-disable the default backing file.
+from the image file). It is allowed to pass @code{null} here in order to disable
+the default backing file.

 @item lazy-refcounts
 Whether to enable the lazy refcounts feature (on/off; default is taken from the
-- 
2.14.3
