Received: from eggs.gnu.org ([2001:4830:134:3::10]:47506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDHYW-0004mq-81
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 17:13:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eDHYV-0005aD-0E
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 17:13:44 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 10 Nov 2017 23:13:29 +0100
Message-Id: <20171110221329.24176-4-mreitz@redhat.com>
In-Reply-To: <20171110221329.24176-1-mreitz@redhat.com>
References: <20171110221329.24176-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12 3/3] block: Deprecate "backing": ""
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>

We have a clear replacement, so let's deprecate it.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json | 4 ++--
 block.c              | 4 ++++
 qemu-doc.texi        | 7 +++++++
 qemu-options.hx      | 4 ++--
 4 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 76bf50f813..dfe4d3650c 100644
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
index bc92ddd5a0..463c4de25b 100644
--- a/block.c
+++ b/block.c
@@ -2559,6 +2559,10 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
     /* See cautionary note on accessing @options above */
     backing = qdict_get_try_str(options, "backing");
     if (qdict_is_qnull(options, "backing") || (backing && *backing == '\0')) {
+        if (backing) {
+            warn_report("Use of \"backing\": \"\" is deprecated; "
+                        "use \"backing\": null instead");
+        }
         flags |= BDRV_O_NO_BACKING;
         qdict_del(options, "backing");
     }
diff --git a/qemu-doc.texi b/qemu-doc.texi
index 8c10956a66..8f57d9ad21 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2537,6 +2537,13 @@ or ``ivshmem-doorbell`` device types.
 The ``spapr-pci-vfio-host-bridge'' device type is replaced by
 the ``spapr-pci-host-bridge'' device type.
 
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
index 3728e9b4dd..0ee1a04d00 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -731,8 +731,8 @@ Reference to or definition of the data source block driver node
 
 @item backing
 Reference to or definition of the backing file block device (default is taken
-from the image file). It is allowed to pass an empty string here in order to
-disable the default backing file.
+from the image file). It is allowed to pass @code{null} here in order to disable
+the default backing file.
 
 @item lazy-refcounts
 Whether to enable the lazy refcounts feature (on/off; default is taken from the
-- 
2.13.6
