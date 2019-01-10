Received: from eggs.gnu.org ([209.51.188.92]:35096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghUXC-0000TR-Ug
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 02:13:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ghUXC-0001j8-6g
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 02:13:46 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu, 10 Jan 2019 01:13:28 -0600
Message-Id: <20190110071330.28136-5-eblake@redhat.com>
In-Reply-To: <20190110071330.28136-1-eblake@redhat.com>
References: <20190110071330.28136-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 4/6] nbd: Remove x-nbd-server-add-bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>

Now that nbd-server-add can do the same functionality, we no
longer need the experimental separate command.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qapi/block.json | 23 -----------------------
 blockdev-nbd.c  | 23 -----------------------
 2 files changed, 46 deletions(-)

diff --git a/qapi/block.json b/qapi/block.json
index 3d70420f763..5a79d639e8c 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -301,29 +301,6 @@
 { 'command': 'nbd-server-remove',
   'data': {'name': 'str', '*mode': 'NbdServerRemoveMode'} }

-##
-# @x-nbd-server-add-bitmap:
-#
-# Expose a dirty bitmap associated with the selected export. The bitmap =
search
-# starts at the device attached to the export, and includes all backing =
files.
-# The exported bitmap is then locked until the NBD export is removed.
-#
-# @name: Export name.
-#
-# @bitmap: Bitmap name to search for.
-#
-# @bitmap-export-name: How the bitmap will be seen by nbd clients
-#                      (default @bitmap)
-#
-# Note: the client must use NBD_OPT_SET_META_CONTEXT with a query of
-# "qemu:dirty-bitmap:NAME" (where NAME matches @bitmap-export-name) to a=
ccess
-# the exposed bitmap.
-#
-# Since: 3.0
-##
-  { 'command': 'x-nbd-server-add-bitmap',
-    'data': {'name': 'str', 'bitmap': 'str', '*bitmap-export-name': 'str=
'} }
-
 ##
 # @nbd-server-stop:
 #
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index ac7e993c35f..003ba7d7180 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -228,26 +228,3 @@ void qmp_nbd_server_stop(Error **errp)
     nbd_server_free(nbd_server);
     nbd_server =3D NULL;
 }
-
-void qmp_x_nbd_server_add_bitmap(const char *name, const char *bitmap,
-                                 bool has_bitmap_export_name,
-                                 const char *bitmap_export_name,
-                                 Error **errp)
-{
-    NBDExport *exp;
-
-    if (!nbd_server) {
-        error_setg(errp, "NBD server not running");
-        return;
-    }
-
-    exp =3D nbd_export_find(name);
-    if (exp =3D=3D NULL) {
-        error_setg(errp, "Export '%s' is not found", name);
-        return;
-    }
-
-    nbd_export_bitmap(exp, bitmap,
-                      has_bitmap_export_name ? bitmap_export_name : bitm=
ap,
-                      errp);
-}
--=20
2.20.1
