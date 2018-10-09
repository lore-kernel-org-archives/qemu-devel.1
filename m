Received: from eggs.gnu.org ([2001:4830:134:3::10]:59655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g9xnB-0001b8-MO
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 15:35:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1g9xn7-0007HW-Kp
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 15:35:40 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  9 Oct 2018 21:35:22 +0200
Message-Id: <20181009193524.19052-3-kwolf@redhat.com>
In-Reply-To: <20181009193524.19052-1-kwolf@redhat.com>
References: <20181009193524.19052-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 2/4] block: Add auto-read-only option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

If a management application builds the block graph node by node, the
protocol layer doesn't inherit its read-only option from the format
layer any more, so it must be set explicitly.

Backing files should work on read-only storage, but at the same time, a
block job like commit should be able to reopen them read-write if they
are on read-write storage. However, without option inheritance, reopen
only changes the read-only option for the root node (typically the
format layer), but not the protocol layer, so reopening fails (the
format layer wants to get write permissions, but the protocol layer is
still read-only).

A simple workaround for the problem in the management tool would be to
open the protocol layer always read-write and to make only the format
layer read-only for backing files. However, sometimes the file is
actually stored on read-only storage and we don't know whether the image
can be opened read-write (for example, for NBD it depends on the server
we're trying to connect to). This adds an option that makes QEMU try to
open the image read-write, but allows it to degrade to a read-only mode
without returning an error.

The documentation for this option is consciously phrased in a way that
allows QEMU to switch to a better model eventually: Instead of trying
when the image is first opened, making the read-only flag dynamic and
changing it automatically whenever the first BLK_PERM_WRITE user is
attached or the last one is detached would be much more useful
behaviour.

Unfortunately, this more useful behaviour is also a lot harder to
implement, and libvirt needs a solution now before it can switch to
-blockdev, so let's start with this easier approach for now.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qapi/block-core.json  |  6 ++++++
 include/block/block.h |  2 ++
 block.c               | 21 ++++++++++++++++++++-
 block/vvfat.c         |  1 +
 4 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index cfb37f8c1d..3a899298de 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -3651,6 +3651,11 @@
 #                 either generally or in certain configurations. In this case,
 #                 the default value does not work and the option must be
 #                 specified explicitly.
+# @auto-read-only: if true, QEMU may ignore the @read-only option and
+#                  automatically decide whether to open the image read-only or
+#                  read-write (and switch between the modes later), e.g.
+#                  depending on whether the image file is writable or whether a
+#                  writing user is attached to the node (default: false).
 # @detect-zeroes: detect and optimize zero writes (Since 2.1)
 #                 (default: off)
 # @force-share:   force share all permission on added nodes.
@@ -3666,6 +3671,7 @@
             '*discard': 'BlockdevDiscardOptions',
             '*cache': 'BlockdevCacheOptions',
             '*read-only': 'bool',
+            '*auto-read-only': 'bool',
             '*force-share': 'bool',
             '*detect-zeroes': 'BlockdevDetectZeroesOptions' },
   'discriminator': 'driver',
diff --git a/include/block/block.h b/include/block/block.h
index b189cf422e..580b3716c3 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -115,6 +115,7 @@ typedef struct HDGeometry {
                                       select an appropriate protocol driver,
                                       ignoring the format layer */
 #define BDRV_O_NO_IO       0x10000 /* don't initialize for I/O */
+#define BDRV_O_AUTO_RDONLY 0x20000 /* degrade to read-only if opening read-write fails */
 
 #define BDRV_O_CACHE_MASK  (BDRV_O_NOCACHE | BDRV_O_NO_FLUSH)
 
@@ -125,6 +126,7 @@ typedef struct HDGeometry {
 #define BDRV_OPT_CACHE_DIRECT   "cache.direct"
 #define BDRV_OPT_CACHE_NO_FLUSH "cache.no-flush"
 #define BDRV_OPT_READ_ONLY      "read-only"
+#define BDRV_OPT_AUTO_READ_ONLY "auto-read-only"
 #define BDRV_OPT_DISCARD        "discard"
 #define BDRV_OPT_FORCE_SHARE    "force-share"
 
diff --git a/block.c b/block.c
index d7bd6d29b4..f999393e28 100644
--- a/block.c
+++ b/block.c
@@ -930,6 +930,7 @@ static void bdrv_inherited_options(int *child_flags, QDict *child_options,
 
     /* Inherit the read-only option from the parent if it's not set */
     qdict_copy_default(child_options, parent_options, BDRV_OPT_READ_ONLY);
+    qdict_copy_default(child_options, parent_options, BDRV_OPT_AUTO_READ_ONLY);
 
     /* Our block drivers take care to send flushes and respect unmap policy,
      * so we can default to enable both on lower layers regardless of the
@@ -1053,6 +1054,7 @@ static void bdrv_backing_options(int *child_flags, QDict *child_options,
 
     /* backing files always opened read-only */
     qdict_set_default_str(child_options, BDRV_OPT_READ_ONLY, "on");
+    qdict_set_default_str(child_options, BDRV_OPT_AUTO_READ_ONLY, "off");
     flags &= ~BDRV_O_COPY_ON_READ;
 
     /* snapshot=on is handled on the top layer */
@@ -1142,6 +1144,10 @@ static void update_flags_from_options(int *flags, QemuOpts *opts)
         *flags |= BDRV_O_RDWR;
     }
 
+    assert(qemu_opt_find(opts, BDRV_OPT_AUTO_READ_ONLY));
+    if (qemu_opt_get_bool_del(opts, BDRV_OPT_AUTO_READ_ONLY, false)) {
+        *flags |= BDRV_O_AUTO_RDONLY;
+    }
 }
 
 static void update_options_from_flags(QDict *options, int flags)
@@ -1156,6 +1162,10 @@ static void update_options_from_flags(QDict *options, int flags)
     if (!qdict_haskey(options, BDRV_OPT_READ_ONLY)) {
         qdict_put_bool(options, BDRV_OPT_READ_ONLY, !(flags & BDRV_O_RDWR));
     }
+    if (!qdict_haskey(options, BDRV_OPT_AUTO_READ_ONLY)) {
+        qdict_put_bool(options, BDRV_OPT_AUTO_READ_ONLY,
+                       flags & BDRV_O_AUTO_RDONLY);
+    }
 }
 
 static void bdrv_assign_node_name(BlockDriverState *bs,
@@ -1329,6 +1339,11 @@ QemuOptsList bdrv_runtime_opts = {
             .help = "Node is opened in read-only mode",
         },
         {
+            .name = BDRV_OPT_AUTO_READ_ONLY,
+            .type = QEMU_OPT_BOOL,
+            .help = "Node can become read-only if opening read-write fails",
+        },
+        {
             .name = "detect-zeroes",
             .type = QEMU_OPT_STRING,
             .help = "try to optimize zero writes (off, on, unmap)",
@@ -1430,7 +1445,9 @@ static int bdrv_open_common(BlockDriverState *bs, BlockBackend *file,
     assert(atomic_read(&bs->copy_on_read) == 0);
 
     if (bs->open_flags & BDRV_O_COPY_ON_READ) {
-        if (!bs->read_only) {
+        if ((bs->open_flags & (BDRV_O_RDWR | BDRV_O_AUTO_RDONLY))
+            == BDRV_O_RDWR)
+        {
             bdrv_enable_copy_on_read(bs);
         } else {
             error_setg(errp, "Can't use copy-on-read on read-only device");
@@ -2486,6 +2503,8 @@ BlockDriverState *bdrv_open_blockdev_ref(BlockdevRef *ref, Error **errp)
         qdict_set_default_str(qdict, BDRV_OPT_CACHE_DIRECT, "off");
         qdict_set_default_str(qdict, BDRV_OPT_CACHE_NO_FLUSH, "off");
         qdict_set_default_str(qdict, BDRV_OPT_READ_ONLY, "off");
+        qdict_set_default_str(qdict, BDRV_OPT_AUTO_READ_ONLY, "off");
+
     }
 
     bs = bdrv_open_inherit(NULL, reference, qdict, 0, NULL, NULL, errp);
diff --git a/block/vvfat.c b/block/vvfat.c
index f2e7d501cf..98ba5e2bac 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -3130,6 +3130,7 @@ static void vvfat_qcow_options(int *child_flags, QDict *child_options,
                                int parent_flags, QDict *parent_options)
 {
     qdict_set_default_str(child_options, BDRV_OPT_READ_ONLY, "off");
+    qdict_set_default_str(child_options, BDRV_OPT_AUTO_READ_ONLY, "off");
     qdict_set_default_str(child_options, BDRV_OPT_CACHE_NO_FLUSH, "on");
 }
 
-- 
2.13.6
