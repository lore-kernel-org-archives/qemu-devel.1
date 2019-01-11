Received: from eggs.gnu.org ([209.51.188.92]:40232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gi2mQ-0006TQ-Qe
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 14:47:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gi2mP-00051F-Bc
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 14:47:46 -0500
From: Eric Blake <eblake@redhat.com>
Date: Fri, 11 Jan 2019 13:47:17 -0600
Message-Id: <20190111194720.15671-6-eblake@redhat.com>
In-Reply-To: <20190111194720.15671-1-eblake@redhat.com>
References: <20190111194720.15671-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 5/8] nbd: Allow bitmap export during QMP
 nbd-server-add
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: vsementsov@virtuozzo.com, jsnow@redhat.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

With the experimental x-nbd-server-add-bitmap command, there was
a window of time where an NBD client could see the export but not
the associated dirty bitmap, which can cause a client that planned
on using the dirty bitmap to be forced to treat the entire image
as dirty as a safety fallback.  Furthermore, if the QMP client
successfully exports a disk but then fails to add the bitmap, it
has to take on the burden of removing the export.  Since we don't
allow changing the exposed dirty bitmap (whether to a different
bitmap, or removing advertisement of the bitmap), it is nicer to
make the bitmap tied to the export at the time the export is
created, with automatic failure to export if the bitmap is not
available.

The experimental command included an optional 'bitmap-export-name'
field for remapping the name exposed over NBD to be different from
the bitmap name stored on disk.  However, my libvirt demo code
for implementing differential backups on top of persistent bitmaps
did not need to take advantage of that feature (it is instead
possible to create a new temporary bitmap with the desired name,
use block-dirty-bitmap-merge to merge one or more persistent
bitmaps into the temporary, then associate the temporary with the
NBD export, if control is needed over the exported bitmap name).
Hence, I'm not copying that part of the experiment over to the
stable addition. For more details on the libvirt demo, see
https://www.redhat.com/archives/libvir-list/2018-October/msg01254.html,
https://kvmforum2018.sched.com/event/FzuB/facilitating-incremental-backup=
-eric-blake-red-hat

This patch focuses on the user interface, and reduces (but does
not completely eliminate) the window where an NBD client can see
the export but not the dirty bitmap, with less work to clean up
after errors.  Later patches will add further cleanups now that
this interface is declared stable via a single QMP command,
including removing the race window.

Update test 223 to use the new interface.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qapi/block.json            |  7 ++++++-
 blockdev-nbd.c             | 12 +++++++++++-
 hmp.c                      |  5 +++--
 tests/qemu-iotests/223     | 19 ++++++++-----------
 tests/qemu-iotests/223.out |  5 +----
 5 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/qapi/block.json b/qapi/block.json
index 11f01f28efe..3d70420f763 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -246,6 +246,10 @@
 #
 # @writable: Whether clients should be able to write to the device via t=
he
 #     NBD connection (default false).
+
+# @bitmap: Also export the dirty bitmap reachable from @device, so the
+#          NBD client can use NBD_OPT_SET_META_CONTEXT with
+#          "qemu:dirty-bitmap:NAME" to inspect the bitmap. (since 4.0)
 #
 # Returns: error if the server is not running, or export with the same n=
ame
 #          already exists.
@@ -253,7 +257,8 @@
 # Since: 1.3.0
 ##
 { 'command': 'nbd-server-add',
-  'data': {'device': 'str', '*name': 'str', '*writable': 'bool'} }
+  'data': {'device': 'str', '*name': 'str', '*writable': 'bool',
+           '*bitmap': 'str' } }

 ##
 # @NbdServerRemoveMode:
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 582ffded77f..ec8cf0ab8c3 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -140,7 +140,8 @@ void qmp_nbd_server_start(SocketAddressLegacy *addr,
 }

 void qmp_nbd_server_add(const char *device, bool has_name, const char *n=
ame,
-                        bool has_writable, bool writable, Error **errp)
+                        bool has_writable, bool writable,
+                        bool has_bitmap, const char *bitmap, Error **err=
p)
 {
     BlockDriverState *bs =3D NULL;
     BlockBackend *on_eject_blk;
@@ -185,6 +186,15 @@ void qmp_nbd_server_add(const char *device, bool has=
_name, const char *name,
      * our only way of accessing it is through nbd_export_find(), so we =
can drop
      * the strong reference that is @exp. */
     nbd_export_put(exp);
+
+    if (has_bitmap) {
+        Error *err =3D NULL;
+        nbd_export_bitmap(exp, bitmap, bitmap, &err);
+        if (err) {
+            error_propagate(errp, err);
+            nbd_export_remove(exp, NBD_SERVER_REMOVE_MODE_HARD, NULL);
+        }
+    }
 }

 void qmp_nbd_server_remove(const char *name,
diff --git a/hmp.c b/hmp.c
index 80aa5ab504b..8da5fd8760a 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2326,7 +2326,7 @@ void hmp_nbd_server_start(Monitor *mon, const QDict=
 *qdict)
         }

         qmp_nbd_server_add(info->value->device, false, NULL,
-                           true, writable, &local_err);
+                           true, writable, false, NULL, &local_err);

         if (local_err !=3D NULL) {
             qmp_nbd_server_stop(NULL);
@@ -2347,7 +2347,8 @@ void hmp_nbd_server_add(Monitor *mon, const QDict *=
qdict)
     bool writable =3D qdict_get_try_bool(qdict, "writable", false);
     Error *local_err =3D NULL;

-    qmp_nbd_server_add(device, !!name, name, true, writable, &local_err)=
;
+    qmp_nbd_server_add(device, !!name, name, true, writable,
+                       false, NULL, &local_err);
     hmp_handle_error(mon, &local_err);
 }

diff --git a/tests/qemu-iotests/223 b/tests/qemu-iotests/223
index f200e313c06..0bcc98a8677 100755
--- a/tests/qemu-iotests/223
+++ b/tests/qemu-iotests/223
@@ -126,23 +126,20 @@ _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server=
-start",
   "arguments":{"addr":{"type":"unix",
     "data":{"path":"'"$TEST_DIR/nbd"1'"}}}}' "error" # Attempt second se=
rver
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
-  "arguments":{"device":"n"}}' "return"
+  "arguments":{"device":"n", "bitmap":"b"}}' "return"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
   "arguments":{"device":"nosuch"}}' "error" # Attempt to export missing =
node
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
   "arguments":{"device":"n"}}' "error" # Attempt to export same name twi=
ce
-_send_qemu_cmd $QEMU_HANDLE '{"execute":"x-nbd-server-add-bitmap",
-  "arguments":{"name":"n", "bitmap":"b"}}' "return"
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
-  "arguments":{"device":"n", "name":"n2"}}' "return"
-_send_qemu_cmd $QEMU_HANDLE '{"execute":"x-nbd-server-add-bitmap",
-  "arguments":{"name":"n2", "bitmap":"b2"}}' "error" # Enabled vs. read-=
only
-_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-remove",
-  "arguments":{"name":"n2"}}' "return"
+  "arguments":{"device":"n", "name":"n2",
+  "bitmap":"b2"}}' "error" # enabled vs. read-only
 _send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
-  "arguments":{"device":"n", "name":"n2", "writable":true}}' "return"
-_send_qemu_cmd $QEMU_HANDLE '{"execute":"x-nbd-server-add-bitmap",
-  "arguments":{"name":"n2", "bitmap":"b2"}}' "return"
+  "arguments":{"device":"n", "name":"n2",
+  "bitmap":"b3"}}' "error" # Missing bitmap
+_send_qemu_cmd $QEMU_HANDLE '{"execute":"nbd-server-add",
+  "arguments":{"device":"n", "name":"n2", "writable":true,
+  "bitmap":"b2"}}' "return"

 echo
 echo "=3D=3D=3D Contrast normal status to large granularity dirty-bitmap=
 =3D=3D=3D"
diff --git a/tests/qemu-iotests/223.out b/tests/qemu-iotests/223.out
index 7d147291d48..ebd3935c974 100644
--- a/tests/qemu-iotests/223.out
+++ b/tests/qemu-iotests/223.out
@@ -33,11 +33,8 @@ wrote 2097152/2097152 bytes at offset 2097152
 {"return": {}}
 {"error": {"class": "GenericError", "desc": "Cannot find device=3Dnosuch=
 nor node_name=3Dnosuch"}}
 {"error": {"class": "GenericError", "desc": "NBD server already has expo=
rt named 'n'"}}
-{"return": {}}
-{"return": {}}
 {"error": {"class": "GenericError", "desc": "Enabled bitmap 'b2' incompa=
tible with readonly export"}}
-{"return": {}}
-{"return": {}}
+{"error": {"class": "GenericError", "desc": "Bitmap 'b3' is not found"}}
 {"return": {}}

 =3D=3D=3D Contrast normal status to large granularity dirty-bitmap =3D=3D=
=3D
--=20
2.20.1
