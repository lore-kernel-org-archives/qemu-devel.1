Received: from eggs.gnu.org ([2001:4830:134:3::10]:41676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhJI-0002Tt-OH
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:20:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhJG-00046v-JH
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:20:00 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:16:50 -0500
Message-Id: <20180723201748.25573-42-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 41/99] throttle: Fix crash on reopen
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Alberto Garcia <berto@igalia.com>, Max Reitz <mreitz@redhat.com>

From: Alberto Garcia <berto@igalia.com>

The throttle block filter can be reopened, and with this it is
possible to change the throttle group that the filter belongs to.

The way the code does that is the following:

  - On throttle_reopen_prepare(): create a new ThrottleGroupMember
    and attach it to the new throttle group.

  - On throttle_reopen_commit(): detach the old ThrottleGroupMember,
    delete it and replace it with the new one.

The problem with this is that by replacing the ThrottleGroupMember the
previous value of io_limits_disabled is lost, causing an assertion
failure in throttle_co_drain_end().

This problem can be reproduced by reopening a throttle node:

   $QEMU -monitor stdio
   -object throttle-group,id=tg0,x-iops-total=1000 \
   -blockdev node-name=hd0,driver=qcow2,file.driver=file,file.filename=hd.qcow2 \
   -blockdev node-name=root,driver=throttle,throttle-group=tg0,file=hd0,read-only=on

   (qemu) block_stream root
   block/throttle.c:214: throttle_co_drain_end: Assertion `tgm->io_limits_disabled' failed.

Since we only want to change the throttle group on reopen there's no
need to create a ThrottleGroupMember and discard the old one. It's
easier if we simply detach it from its current group and attach it to
the new one.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Message-id: 20180608151536.7378-1-berto@igalia.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
(cherry picked from commit bc33c047d1ec0b35c9cd8be62bcefae2da28654f)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/throttle.c | 54 +++++++++++++++++++++++++++++-------------------
 1 file changed, 33 insertions(+), 21 deletions(-)

diff --git a/block/throttle.c b/block/throttle.c
index 95ed06acd8..026f408aa6 100644
--- a/block/throttle.c
+++ b/block/throttle.c
@@ -36,9 +36,12 @@ static QemuOptsList throttle_opts = {
     },
 };
 
-static int throttle_configure_tgm(BlockDriverState *bs,
-                                  ThrottleGroupMember *tgm,
-                                  QDict *options, Error **errp)
+/*
+ * If this function succeeds then the throttle group name is stored in
+ * @group and must be freed by the caller.
+ * If there's an error then @group remains unmodified.
+ */
+static int throttle_parse_options(QDict *options, char **group, Error **errp)
 {
     int ret;
     const char *group_name;
@@ -63,8 +66,7 @@ static int throttle_configure_tgm(BlockDriverState *bs,
         goto fin;
     }
 
-    /* Register membership to group with name group_name */
-    throttle_group_register_tgm(tgm, group_name, bdrv_get_aio_context(bs));
+    *group = g_strdup(group_name);
     ret = 0;
 fin:
     qemu_opts_del(opts);
@@ -75,6 +77,8 @@ static int throttle_open(BlockDriverState *bs, QDict *options,
                          int flags, Error **errp)
 {
     ThrottleGroupMember *tgm = bs->opaque;
+    char *group;
+    int ret;
 
     bs->file = bdrv_open_child(NULL, options, "file", bs,
                                &child_file, false, errp);
@@ -84,7 +88,14 @@ static int throttle_open(BlockDriverState *bs, QDict *options,
     bs->supported_write_flags = bs->file->bs->supported_write_flags;
     bs->supported_zero_flags = bs->file->bs->supported_zero_flags;
 
-    return throttle_configure_tgm(bs, tgm, options, errp);
+    ret = throttle_parse_options(options, &group, errp);
+    if (ret == 0) {
+        /* Register membership to group with name group_name */
+        throttle_group_register_tgm(tgm, group, bdrv_get_aio_context(bs));
+        g_free(group);
+    }
+
+    return ret;
 }
 
 static void throttle_close(BlockDriverState *bs)
@@ -160,35 +171,36 @@ static void throttle_attach_aio_context(BlockDriverState *bs,
 static int throttle_reopen_prepare(BDRVReopenState *reopen_state,
                                    BlockReopenQueue *queue, Error **errp)
 {
-    ThrottleGroupMember *tgm;
+    int ret;
+    char *group = NULL;
 
     assert(reopen_state != NULL);
     assert(reopen_state->bs != NULL);
 
-    reopen_state->opaque = g_new0(ThrottleGroupMember, 1);
-    tgm = reopen_state->opaque;
-
-    return throttle_configure_tgm(reopen_state->bs, tgm, reopen_state->options,
-            errp);
+    ret = throttle_parse_options(reopen_state->options, &group, errp);
+    reopen_state->opaque = group;
+    return ret;
 }
 
 static void throttle_reopen_commit(BDRVReopenState *reopen_state)
 {
-    ThrottleGroupMember *old_tgm = reopen_state->bs->opaque;
-    ThrottleGroupMember *new_tgm = reopen_state->opaque;
+    BlockDriverState *bs = reopen_state->bs;
+    ThrottleGroupMember *tgm = bs->opaque;
+    char *group = reopen_state->opaque;
+
+    assert(group);
 
-    throttle_group_unregister_tgm(old_tgm);
-    g_free(old_tgm);
-    reopen_state->bs->opaque = new_tgm;
+    if (strcmp(group, throttle_group_get_name(tgm))) {
+        throttle_group_unregister_tgm(tgm);
+        throttle_group_register_tgm(tgm, group, bdrv_get_aio_context(bs));
+    }
+    g_free(reopen_state->opaque);
     reopen_state->opaque = NULL;
 }
 
 static void throttle_reopen_abort(BDRVReopenState *reopen_state)
 {
-    ThrottleGroupMember *tgm = reopen_state->opaque;
-
-    throttle_group_unregister_tgm(tgm);
-    g_free(tgm);
+    g_free(reopen_state->opaque);
     reopen_state->opaque = NULL;
 }
 
-- 
2.17.1
