Received: from eggs.gnu.org ([2001:4830:134:3::10]:51648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ecvJx-0004cS-9E
	for qemu-devel@nongnu.org; Sat, 20 Jan 2018 10:44:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ecvJw-0000E6-Dd
	for qemu-devel@nongnu.org; Sat, 20 Jan 2018 10:44:41 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Sat, 20 Jan 2018 16:44:12 +0100
Message-Id: <20180120154412.9990-7-mreitz@redhat.com>
In-Reply-To: <20180120154412.9990-1-mreitz@redhat.com>
References: <20180120154412.9990-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 6/6] block: Deprecate "backing": ""
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>

We have a clear replacement, so let's deprecate it.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json | 4 ++--
 block.c              | 4 ++++
 qemu-doc.texi        | 7 +++++++
 qemu-options.hx      | 4 ++--
 4 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 89ed2bc6a4..78de8eff63 100644
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
index 32b7887651..5ac0aba638 100644
--- a/block.c
+++ b/block.c
@@ -2600,6 +2600,10 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
     if (qobject_to(qdict_get(options, "backing"), QNull) != NULL ||
         (backing && *backing == '\0'))
     {
+        if (backing) {
+            warn_report("Use of \"backing\": \"\" is deprecated; "
+                        "use \"backing\": null instead");
+        }
         flags |= BDRV_O_NO_BACKING;
         qdict_del(options, "backing");
     }
diff --git a/qemu-doc.texi b/qemu-doc.texi
index 3e9eb819a6..d321908da8 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2773,6 +2773,13 @@ or ``ivshmem-doorbell`` device types.
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
 
diff --git a/qemu-options.hx b/qemu-options.hx
index 5ff741a4af..76e9a5b06b 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -743,8 +743,8 @@ Reference to or definition of the data source block driver node
 
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
