Received: from eggs.gnu.org ([2001:4830:134:3::10]:34950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dXGTB-0002KA-CF
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:34:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dXGTA-00060z-Do
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 20:34:33 -0400
From: John Snow <jsnow@redhat.com>
Date: Mon, 17 Jul 2017 20:34:21 -0400
Message-Id: <20170718003422.4497-2-jsnow@redhat.com>
In-Reply-To: <20170718003422.4497-1-jsnow@redhat.com>
References: <20170718003422.4497-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v5 1/2] blockdev: move BDRV_O_NO_BACKING option
 forward
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, John Snow <jsnow@redhat.com>

For both external_snapshot_prepare and qmp_drive_mirror, we eventually
append the option BDRV_O_NO_BACKING. However, we generally do so after
we create the image.

To accommodate image creation wanting to verify that a backing file
exists or not, add this option prior to create to override checking
the existence of the backing file. This prevents QEMU from trying to
re-open a backing file that's already in use (thanks to qcow2 locking).

Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockdev.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 7f53cc8..6469f16 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1710,7 +1710,8 @@ static void external_snapshot_prepare(BlkActionState *common,
         }
 
         flags = state->old_bs->open_flags;
-        flags &= ~(BDRV_O_SNAPSHOT | BDRV_O_NO_BACKING | BDRV_O_COPY_ON_READ);
+        flags &= ~(BDRV_O_SNAPSHOT | BDRV_O_COPY_ON_READ);
+        flags |= BDRV_O_NO_BACKING;
 
         /* create new image w/backing file */
         mode = s->has_mode ? s->mode : NEW_IMAGE_MODE_ABSOLUTE_PATHS;
@@ -1735,8 +1736,6 @@ static void external_snapshot_prepare(BlkActionState *common,
             qdict_put_str(options, "node-name", snapshot_node_name);
         }
         qdict_put_str(options, "driver", format);
-
-        flags |= BDRV_O_NO_BACKING;
     }
 
     state->new_bs = bdrv_open(new_image_file, snapshot_ref, options, flags,
@@ -3548,6 +3547,9 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
         backing_mode = MIRROR_OPEN_BACKING_CHAIN;
     }
 
+    /* Don't open backing image in create() */
+    flags |= BDRV_O_NO_BACKING;
+
     if ((arg->sync == MIRROR_SYNC_MODE_FULL || !source)
         && arg->mode != NEW_IMAGE_MODE_EXISTING)
     {
@@ -3587,8 +3589,7 @@ void qmp_drive_mirror(DriveMirror *arg, Error **errp)
     /* Mirroring takes care of copy-on-write using the source's backing
      * file.
      */
-    target_bs = bdrv_open(arg->target, NULL, options,
-                          flags | BDRV_O_NO_BACKING, errp);
+    target_bs = bdrv_open(arg->target, NULL, options, flags, errp);
     if (!target_bs) {
         goto out;
     }
-- 
2.9.4
