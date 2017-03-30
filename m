Received: from eggs.gnu.org ([2001:4830:134:3::10]:35452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cte6Z-0004Q9-CF
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 13:43:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cte6X-000314-Lr
	for qemu-devel@nongnu.org; Thu, 30 Mar 2017 13:43:27 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 30 Mar 2017 19:43:12 +0200
Message-Id: <1490895797-29094-5-git-send-email-armbru@redhat.com>
In-Reply-To: <1490895797-29094-1-git-send-email-armbru@redhat.com>
References: <1490895797-29094-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v3 for-2.9 4/9] block: Document -drive
 problematic code and bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, pbonzini@redhat.com

-blockdev and blockdev_add convert their arguments via QObject to
BlockdevOptions for qmp_blockdev_add(), which converts them back to
QObject, then to a flattened QDict.  The QDict's members are typed
according to the QAPI schema.

-drive converts its argument via QemuOpts to a (flat) QDict.  This
QDict's members are all QString.

Thus, the QType of a flat QDict member depends on whether it comes
from -drive or -blockdev/blockdev_add, except when the QAPI type maps
to QString, which is the case for 'str' and enumeration types.

The block layer core extracts generic configuration from the flat
QDict, and the block driver extracts driver-specific configuration.

Both commonly do so by converting (parts of) the flat QDict to
QemuOpts, which turns all values into strings.  Not exactly elegant,
but correct.

However, A few places access the flat QDict directly:

* Most of them access members that are always QString.  Correct.

* bdrv_open_inherit() accesses a boolean, carefully.  Correct.

* nfs_config() uses a QObject input visitor.  Correct only because the
  visited type contains nothing but QStrings.

* nbd_config() and ssh_config() use a QObject input visitor, and the
  visited types contain non-QStrings: InetSocketAddress members
  @numeric, @to, @ipv4, @ipv6.  -drive works as long as you don't try
  to use them (they're all optional).  @to is ignored anyway.

  Reproducer:
  -drive driver=ssh,server.host=h,server.port=22,server.ipv4,path=p
  -drive driver=nbd,server.type=inet,server.data.host=h,server.data.port=22,server.data.ipv4
  both fail with "Invalid parameter type for 'data.ipv4', expected: boolean"

Add suitable comments to all these places.  Mark the buggy ones FIXME.

"Fortunately", -drive's driver-specific options are entirely
undocumented.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block.c            | 48 +++++++++++++++++++++++++++++++++++++++++++++---
 block/file-posix.c |  6 ++++++
 block/nbd.c        |  8 ++++++++
 block/nfs.c        |  7 +++++++
 block/rbd.c        |  6 ++++++
 block/ssh.c        |  8 ++++++++
 6 files changed, 80 insertions(+), 3 deletions(-)

diff --git a/block.c b/block.c
index 6e906ec..927ba89 100644
--- a/block.c
+++ b/block.c
@@ -1157,6 +1157,13 @@ static int bdrv_open_common(BlockDriverState *bs, BlockBackend *file,
     if (file != NULL) {
         filename = blk_bs(file)->filename;
     } else {
+        /*
+         * Caution: while qdict_get_try_str() is fine, getting
+         * non-string types would require more care.  When @options
+         * come from -blockdev or blockdev_add, its members are typed
+         * according to the QAPI schema, but when they come from
+         * -drive, they're all QString.
+         */
         filename = qdict_get_try_str(options, "filename");
     }
 
@@ -1324,6 +1331,13 @@ static int bdrv_fill_options(QDict **options, const char *filename,
     BlockDriver *drv = NULL;
     Error *local_err = NULL;
 
+    /*
+     * Caution: while qdict_get_try_str() is fine, getting non-string
+     * types would require more care.  When @options come from
+     * -blockdev or blockdev_add, its members are typed according to
+     * the QAPI schema, but when they come from -drive, they're all
+     * QString.
+     */
     drvname = qdict_get_try_str(*options, "driver");
     if (drvname) {
         drv = bdrv_find_format(drvname);
@@ -1358,6 +1372,7 @@ static int bdrv_fill_options(QDict **options, const char *filename,
     }
 
     /* Find the right block driver */
+    /* See cautionary note on accessing @options above */
     filename = qdict_get_try_str(*options, "filename");
 
     if (!drvname && protocol) {
@@ -1987,6 +2002,13 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
     qdict_extract_subqdict(parent_options, &options, bdref_key_dot);
     g_free(bdref_key_dot);
 
+    /*
+     * Caution: while qdict_get_try_str() is fine, getting non-string
+     * types would require more care.  When @parent_options come from
+     * -blockdev or blockdev_add, its members are typed according to
+     * the QAPI schema, but when they come from -drive, they're all
+     * QString.
+     */
     reference = qdict_get_try_str(parent_options, bdref_key);
     if (reference || qdict_haskey(options, "file.filename")) {
         backing_filename[0] = '\0';
@@ -2059,6 +2081,13 @@ bdrv_open_child_bs(const char *filename, QDict *options, const char *bdref_key,
     qdict_extract_subqdict(options, &image_options, bdref_key_dot);
     g_free(bdref_key_dot);
 
+    /*
+     * Caution: while qdict_get_try_str() is fine, getting non-string
+     * types would require more care.  When @options come from
+     * -blockdev or blockdev_add, its members are typed according to
+     * the QAPI schema, but when they come from -drive, they're all
+     * QString.
+     */
     reference = qdict_get_try_str(options, bdref_key);
     if (!filename && !reference && !qdict_size(image_options)) {
         if (!allow_none) {
@@ -2274,9 +2303,13 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
         goto fail;
     }
 
-    /* Set the BDRV_O_RDWR and BDRV_O_ALLOW_RDWR flags.
-     * FIXME: we're parsing the QDict to avoid having to create a
-     * QemuOpts just for this, but neither option is optimal. */
+    /*
+     * Set the BDRV_O_RDWR and BDRV_O_ALLOW_RDWR flags.
+     * Caution: getting a boolean member of @options requires care.
+     * When @options come from -blockdev or blockdev_add, members are
+     * typed according to the QAPI schema, but when they come from
+     * -drive, they're all QString.
+     */
     if (g_strcmp0(qdict_get_try_str(options, BDRV_OPT_READ_ONLY), "on") &&
         !qdict_get_try_bool(options, BDRV_OPT_READ_ONLY, false)) {
         flags |= (BDRV_O_RDWR | BDRV_O_ALLOW_RDWR);
@@ -2298,6 +2331,7 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
     options = qdict_clone_shallow(options);
 
     /* Find the right image format driver */
+    /* See cautionary note on accessing @options above */
     drvname = qdict_get_try_str(options, "driver");
     if (drvname) {
         drv = bdrv_find_format(drvname);
@@ -2309,6 +2343,7 @@ static BlockDriverState *bdrv_open_inherit(const char *filename,
 
     assert(drvname || !(flags & BDRV_O_PROTOCOL));
 
+    /* See cautionary note on accessing @options above */
     backing = qdict_get_try_str(options, "backing");
     if (backing && *backing == '\0') {
         flags |= BDRV_O_NO_BACKING;
@@ -2787,6 +2822,13 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_state, BlockReopenQueue *queue,
         do {
             QString *new_obj = qobject_to_qstring(entry->value);
             const char *new = qstring_get_str(new_obj);
+            /*
+             * Caution: while qdict_get_try_str() is fine, getting
+             * non-string types would require more care.  When
+             * bs->options come from -blockdev or blockdev_add, its
+             * members are typed according to the QAPI schema, but
+             * when they come from -drive, they're all QString.
+             */
             const char *old = qdict_get_try_str(reopen_state->bs->options,
                                                 entry->key);
 
diff --git a/block/file-posix.c b/block/file-posix.c
index 0841a08..2acc5c4 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -2193,6 +2193,12 @@ static int hdev_open(BlockDriverState *bs, QDict *options, int flags,
     int ret;
 
 #if defined(__APPLE__) && defined(__MACH__)
+    /*
+     * Caution: while qdict_get_try_str() is fine, getting non-string
+     * types would require more care.  When @options come from -blockdev
+     * or blockdev_add, its members are typed according to the QAPI
+     * schema, but when they come from -drive, they're all QString.
+     */
     const char *filename = qdict_get_str(options, "filename");
     char bsd_path[MAXPATHLEN] = "";
     bool error_occurred = false;
diff --git a/block/nbd.c b/block/nbd.c
index 36ea617..11e3ba7 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -278,6 +278,14 @@ static SocketAddress *nbd_config(BDRVNBDState *s, QDict *options, Error **errp)
         goto done;
     }
 
+    /*
+     * FIXME .numeric, .to, .ipv4 or .ipv6 don't work with -drive
+     * server.type=inet.  .to doesn't matter, it's ignored anyway.
+     * That's because when @options come from -blockdev or
+     * blockdev_add, members are typed according to the QAPI schema,
+     * but when they come from -drive, they're all QString.  The
+     * visitor expects the former.
+     */
     iv = qobject_input_visitor_new(crumpled_addr);
     visit_type_SocketAddress(iv, NULL, &saddr, &local_err);
     if (local_err) {
diff --git a/block/nfs.c b/block/nfs.c
index 3f43f6e..42407de 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -474,6 +474,13 @@ static NFSServer *nfs_config(QDict *options, Error **errp)
         goto out;
     }
 
+    /*
+     * Caution: this works only because all scalar members of
+     * NFSServer are QString in @crumpled_addr.  The visitor expects
+     * @crumpled_addr to be typed according to the QAPI scherma.  It
+     * is when @options come from -blockdev or blockdev_add.  But when
+     * they come from -drive, they're all QString.
+     */
     iv = qobject_input_visitor_new(crumpled_addr);
     visit_type_NFSServer(iv, NULL, &server, &local_error);
     if (local_error) {
diff --git a/block/rbd.c b/block/rbd.c
index 498322b..d8208bb 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -384,6 +384,12 @@ static int qemu_rbd_create(const char *filename, QemuOpts *opts, Error **errp)
         goto exit;
     }
 
+    /*
+     * Caution: while qdict_get_try_str() is fine, getting non-string
+     * types would require more care.  When @options come from -blockdev
+     * or blockdev_add, its members are typed according to the QAPI
+     * schema, but when they come from -drive, they're all QString.
+     */
     pool       = qdict_get_try_str(options, "pool");
     conf       = qdict_get_try_str(options, "conf");
     clientname = qdict_get_try_str(options, "user");
diff --git a/block/ssh.c b/block/ssh.c
index 278e66f..471ba8a 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -601,6 +601,14 @@ static InetSocketAddress *ssh_config(QDict *options, Error **errp)
         goto out;
     }
 
+    /*
+     * FIXME .numeric, .to, .ipv4 or .ipv6 don't work with -drive.
+     * .to doesn't matter, it's ignored anyway.
+     * That's because when @options come from -blockdev or
+     * blockdev_add, members are typed according to the QAPI schema,
+     * but when they come from -drive, they're all QString.  The
+     * visitor expects the former.
+     */
     iv = qobject_input_visitor_new(crumpled_addr);
     visit_type_InetSocketAddress(iv, NULL, &inet, &local_error);
     if (local_error) {
-- 
2.7.4
