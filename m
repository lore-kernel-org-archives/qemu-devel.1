Received: from eggs.gnu.org ([2001:4830:134:3::10]:53991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnlUn-0000Id-1N
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dnlUj-0007MN-GD
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44216)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dnlUj-0007LH-3T
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 08:56:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 01273769E9
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 12:56:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-75.ams2.redhat.com
	[10.36.116.75])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 739577BB50
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 12:56:19 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  1 Sep 2017 14:55:49 +0200
Message-Id: <20170901125611.29295-26-armbru@redhat.com>
In-Reply-To: <20170901125611.29295-1-armbru@redhat.com>
References: <20170901125611.29295-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 25/47] qapi-schema: Collect transaction stuff in
 qapi/transaction.json
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <1503602048-12268-11-git-send-email-armbru@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 MAINTAINERS           |   1 +
 Makefile              |   1 +
 qapi-schema.json      | 151 +-------------------------------------------=
---
 qapi/transaction.json | 158 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
 4 files changed, 161 insertions(+), 150 deletions(-)
 create mode 100644 qapi/transaction.json

diff --git a/MAINTAINERS b/MAINTAINERS
index baa9859b4a..8cebd798ef 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1231,6 +1231,7 @@ S: Supported
 F: blockdev.c
 F: block/qapi.c
 F: qapi/block*.json
+F: qapi/transaction.json
 T: git git://repo.or.cz/qemu/armbru.git block-next
=20
 Dirty Bitmaps
diff --git a/Makefile b/Makefile
index 18cf670833..ea6de37197 100644
--- a/Makefile
+++ b/Makefile
@@ -419,6 +419,7 @@ qapi-modules =3D $(SRC_PATH)/qapi-schema.json $(SRC_P=
ATH)/qapi/common.json \
                $(SRC_PATH)/qapi/run-state.json \
                $(SRC_PATH)/qapi/sockets.json \
                $(SRC_PATH)/qapi/trace.json \
+               $(SRC_PATH)/qapi/transaction.json \
                $(SRC_PATH)/qapi/ui.json
=20
 qapi-types.c qapi-types.h :\
diff --git a/qapi-schema.json b/qapi-schema.json
index 21f54ea1a2..4108ef0cc8 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -88,6 +88,7 @@
 { 'include': 'qapi/rocker.json' }
 { 'include': 'qapi/ui.json' }
 { 'include': 'qapi/migration.json' }
+{ 'include': 'qapi/transaction.json' }
 { 'include': 'qapi/event.json' }
 { 'include': 'qapi/trace.json' }
 { 'include': 'qapi/introspect.json' }
@@ -1097,156 +1098,6 @@
 { 'command': 'balloon', 'data': {'value': 'int'} }
=20
 ##
-# @Abort:
-#
-# This action can be used to test transaction failure.
-#
-# Since: 1.6
-##
-{ 'struct': 'Abort',
-  'data': { } }
-
-##
-# @ActionCompletionMode:
-#
-# An enumeration of Transactional completion modes.
-#
-# @individual: Do not attempt to cancel any other Actions if any Actions=
 fail
-#              after the Transaction request succeeds. All Actions that
-#              can complete successfully will do so without waiting on o=
thers.
-#              This is the default.
-#
-# @grouped: If any Action fails after the Transaction succeeds, cancel a=
ll
-#           Actions. Actions do not complete until all Actions are ready=
 to
-#           complete. May be rejected by Actions that do not support thi=
s
-#           completion mode.
-#
-# Since: 2.5
-##
-{ 'enum': 'ActionCompletionMode',
-  'data': [ 'individual', 'grouped' ] }
-
-##
-# @TransactionAction:
-#
-# A discriminated record of operations that can be performed with
-# @transaction. Action @type can be:
-#
-# - @abort: since 1.6
-# - @block-dirty-bitmap-add: since 2.5
-# - @block-dirty-bitmap-clear: since 2.5
-# - @blockdev-backup: since 2.3
-# - @blockdev-snapshot: since 2.5
-# - @blockdev-snapshot-internal-sync: since 1.7
-# - @blockdev-snapshot-sync: since 1.1
-# - @drive-backup: since 1.6
-#
-# Since: 1.1
-##
-{ 'union': 'TransactionAction',
-  'data': {
-       'abort': 'Abort',
-       'block-dirty-bitmap-add': 'BlockDirtyBitmapAdd',
-       'block-dirty-bitmap-clear': 'BlockDirtyBitmap',
-       'blockdev-backup': 'BlockdevBackup',
-       'blockdev-snapshot': 'BlockdevSnapshot',
-       'blockdev-snapshot-internal-sync': 'BlockdevSnapshotInternal',
-       'blockdev-snapshot-sync': 'BlockdevSnapshotSync',
-       'drive-backup': 'DriveBackup'
-   } }
-
-##
-# @TransactionProperties:
-#
-# Optional arguments to modify the behavior of a Transaction.
-#
-# @completion-mode: Controls how jobs launched asynchronously by
-#                   Actions will complete or fail as a group.
-#                   See @ActionCompletionMode for details.
-#
-# Since: 2.5
-##
-{ 'struct': 'TransactionProperties',
-  'data': {
-       '*completion-mode': 'ActionCompletionMode'
-  }
-}
-
-##
-# @transaction:
-#
-# Executes a number of transactionable QMP commands atomically. If any
-# operation fails, then the entire set of actions will be abandoned and =
the
-# appropriate error returned.
-#
-# For external snapshots, the dictionary contains the device, the file t=
o use for
-# the new snapshot, and the format.  The default format, if not specifie=
d, is
-# qcow2.
-#
-# Each new snapshot defaults to being created by QEMU (wiping any
-# contents if the file already exists), but it is also possible to reuse
-# an externally-created file.  In the latter case, you should ensure tha=
t
-# the new image file has the same contents as the current one; QEMU cann=
ot
-# perform any meaningful check.  Typically this is achieved by using the
-# current image file as the backing file for the new image.
-#
-# On failure, the original disks pre-snapshot attempt will be used.
-#
-# For internal snapshots, the dictionary contains the device and the sna=
pshot's
-# name.  If an internal snapshot matching name already exists, the reque=
st will
-# be rejected.  Only some image formats support it, for example, qcow2, =
rbd,
-# and sheepdog.
-#
-# On failure, qemu will try delete the newly created internal snapshot i=
n the
-# transaction.  When an I/O error occurs during deletion, the user needs=
 to fix
-# it later with qemu-img or other command.
-#
-# @actions: List of @TransactionAction;
-#           information needed for the respective operations.
-#
-# @properties: structure of additional options to control the
-#              execution of the transaction. See @TransactionProperties
-#              for additional detail.
-#
-# Returns: nothing on success
-#
-#          Errors depend on the operations of the transaction
-#
-# Note: The transaction aborts on the first failure.  Therefore, there w=
ill be
-# information on only one failed operation returned in an error conditio=
n, and
-# subsequent actions will not have been attempted.
-#
-# Since: 1.1
-#
-# Example:
-#
-# -> { "execute": "transaction",
-#      "arguments": { "actions": [
-#          { "type": "blockdev-snapshot-sync", "data" : { "device": "ide=
-hd0",
-#                                      "snapshot-file": "/some/place/my-=
image",
-#                                      "format": "qcow2" } },
-#          { "type": "blockdev-snapshot-sync", "data" : { "node-name": "=
myfile",
-#                                      "snapshot-file": "/some/place/my-=
image2",
-#                                      "snapshot-node-name": "node3432",
-#                                      "mode": "existing",
-#                                      "format": "qcow2" } },
-#          { "type": "blockdev-snapshot-sync", "data" : { "device": "ide=
-hd1",
-#                                      "snapshot-file": "/some/place/my-=
image2",
-#                                      "mode": "existing",
-#                                      "format": "qcow2" } },
-#          { "type": "blockdev-snapshot-internal-sync", "data" : {
-#                                      "device": "ide-hd2",
-#                                      "name": "snapshot0" } } ] } }
-# <- { "return": {} }
-#
-##
-{ 'command': 'transaction',
-  'data': { 'actions': [ 'TransactionAction' ],
-            '*properties': 'TransactionProperties'
-          }
-}
-
-##
 # @human-monitor-command:
 #
 # Execute a command on the human monitor and return the output.
diff --git a/qapi/transaction.json b/qapi/transaction.json
new file mode 100644
index 0000000000..bd312792da
--- /dev/null
+++ b/qapi/transaction.json
@@ -0,0 +1,158 @@
+# -*- Mode: Python -*-
+#
+
+##
+# =3D Transactions
+##
+
+{ 'include': 'block.json' }
+
+##
+# @Abort:
+#
+# This action can be used to test transaction failure.
+#
+# Since: 1.6
+##
+{ 'struct': 'Abort',
+  'data': { } }
+
+##
+# @ActionCompletionMode:
+#
+# An enumeration of Transactional completion modes.
+#
+# @individual: Do not attempt to cancel any other Actions if any Actions=
 fail
+#              after the Transaction request succeeds. All Actions that
+#              can complete successfully will do so without waiting on o=
thers.
+#              This is the default.
+#
+# @grouped: If any Action fails after the Transaction succeeds, cancel a=
ll
+#           Actions. Actions do not complete until all Actions are ready=
 to
+#           complete. May be rejected by Actions that do not support thi=
s
+#           completion mode.
+#
+# Since: 2.5
+##
+{ 'enum': 'ActionCompletionMode',
+  'data': [ 'individual', 'grouped' ] }
+
+##
+# @TransactionAction:
+#
+# A discriminated record of operations that can be performed with
+# @transaction. Action @type can be:
+#
+# - @abort: since 1.6
+# - @block-dirty-bitmap-add: since 2.5
+# - @block-dirty-bitmap-clear: since 2.5
+# - @blockdev-backup: since 2.3
+# - @blockdev-snapshot: since 2.5
+# - @blockdev-snapshot-internal-sync: since 1.7
+# - @blockdev-snapshot-sync: since 1.1
+# - @drive-backup: since 1.6
+#
+# Since: 1.1
+##
+{ 'union': 'TransactionAction',
+  'data': {
+       'abort': 'Abort',
+       'block-dirty-bitmap-add': 'BlockDirtyBitmapAdd',
+       'block-dirty-bitmap-clear': 'BlockDirtyBitmap',
+       'blockdev-backup': 'BlockdevBackup',
+       'blockdev-snapshot': 'BlockdevSnapshot',
+       'blockdev-snapshot-internal-sync': 'BlockdevSnapshotInternal',
+       'blockdev-snapshot-sync': 'BlockdevSnapshotSync',
+       'drive-backup': 'DriveBackup'
+   } }
+
+##
+# @TransactionProperties:
+#
+# Optional arguments to modify the behavior of a Transaction.
+#
+# @completion-mode: Controls how jobs launched asynchronously by
+#                   Actions will complete or fail as a group.
+#                   See @ActionCompletionMode for details.
+#
+# Since: 2.5
+##
+{ 'struct': 'TransactionProperties',
+  'data': {
+       '*completion-mode': 'ActionCompletionMode'
+  }
+}
+
+##
+# @transaction:
+#
+# Executes a number of transactionable QMP commands atomically. If any
+# operation fails, then the entire set of actions will be abandoned and =
the
+# appropriate error returned.
+#
+# For external snapshots, the dictionary contains the device, the file t=
o use for
+# the new snapshot, and the format.  The default format, if not specifie=
d, is
+# qcow2.
+#
+# Each new snapshot defaults to being created by QEMU (wiping any
+# contents if the file already exists), but it is also possible to reuse
+# an externally-created file.  In the latter case, you should ensure tha=
t
+# the new image file has the same contents as the current one; QEMU cann=
ot
+# perform any meaningful check.  Typically this is achieved by using the
+# current image file as the backing file for the new image.
+#
+# On failure, the original disks pre-snapshot attempt will be used.
+#
+# For internal snapshots, the dictionary contains the device and the sna=
pshot's
+# name.  If an internal snapshot matching name already exists, the reque=
st will
+# be rejected.  Only some image formats support it, for example, qcow2, =
rbd,
+# and sheepdog.
+#
+# On failure, qemu will try delete the newly created internal snapshot i=
n the
+# transaction.  When an I/O error occurs during deletion, the user needs=
 to fix
+# it later with qemu-img or other command.
+#
+# @actions: List of @TransactionAction;
+#           information needed for the respective operations.
+#
+# @properties: structure of additional options to control the
+#              execution of the transaction. See @TransactionProperties
+#              for additional detail.
+#
+# Returns: nothing on success
+#
+#          Errors depend on the operations of the transaction
+#
+# Note: The transaction aborts on the first failure.  Therefore, there w=
ill be
+# information on only one failed operation returned in an error conditio=
n, and
+# subsequent actions will not have been attempted.
+#
+# Since: 1.1
+#
+# Example:
+#
+# -> { "execute": "transaction",
+#      "arguments": { "actions": [
+#          { "type": "blockdev-snapshot-sync", "data" : { "device": "ide=
-hd0",
+#                                      "snapshot-file": "/some/place/my-=
image",
+#                                      "format": "qcow2" } },
+#          { "type": "blockdev-snapshot-sync", "data" : { "node-name": "=
myfile",
+#                                      "snapshot-file": "/some/place/my-=
image2",
+#                                      "snapshot-node-name": "node3432",
+#                                      "mode": "existing",
+#                                      "format": "qcow2" } },
+#          { "type": "blockdev-snapshot-sync", "data" : { "device": "ide=
-hd1",
+#                                      "snapshot-file": "/some/place/my-=
image2",
+#                                      "mode": "existing",
+#                                      "format": "qcow2" } },
+#          { "type": "blockdev-snapshot-internal-sync", "data" : {
+#                                      "device": "ide-hd2",
+#                                      "name": "snapshot0" } } ] } }
+# <- { "return": {} }
+#
+##
+{ 'command': 'transaction',
+  'data': { 'actions': [ 'TransactionAction' ],
+            '*properties': 'TransactionProperties'
+          }
+}
--=20
2.13.5
