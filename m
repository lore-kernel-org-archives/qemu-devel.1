Received: from eggs.gnu.org ([2001:4830:134:3::10]:50338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSisd-0007Ki-5B
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:58:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fSisZ-0003DR-C0
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 08:58:35 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 12 Jun 2018 14:58:06 +0200
Message-Id: <20180612125821.4229-4-armbru@redhat.com>
In-Reply-To: <20180612125821.4229-1-armbru@redhat.com>
References: <20180612125821.4229-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 03/18] block: Add block-specific QDict header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, eblake@redhat.com

From: Max Reitz <mreitz@redhat.com>

There are numerous QDict functions that have been introduced for and are
used only by the block layer.  Move their declarations into an own
header file to reflect that.

While qdict_extract_subqdict() is in fact used outside of the block
layer (in util/qemu-config.c), it is still a function related very
closely to how the block layer works with nested QDicts, namely by
sometimes flattening them.  Therefore, its declaration is put into this
header as well and util/qemu-config.c includes it with a comment stating
exactly which function it needs.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20180509165530.29561-7-mreitz@redhat.com>
[Copright note tweaked, superfluous includes dropped]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block.c                  |  1 +
 block/gluster.c          |  1 +
 block/iscsi.c            |  1 +
 block/nbd.c              |  1 +
 block/nfs.c              |  1 +
 block/parallels.c        |  1 +
 block/qcow.c             |  1 +
 block/qcow2.c            |  1 +
 block/qed.c              |  1 +
 block/quorum.c           |  1 +
 block/rbd.c              |  1 +
 block/sheepdog.c         |  1 +
 block/snapshot.c         |  1 +
 block/ssh.c              |  1 +
 block/vhdx.c             |  1 +
 block/vpc.c              |  1 +
 block/vvfat.c            |  1 +
 block/vxhs.c             |  1 +
 blockdev.c               |  1 +
 include/block/qdict.h    | 32 ++++++++++++++++++++++++++++++++
 include/qapi/qmp/qdict.h | 17 -----------------
 qobject/qdict.c          |  1 +
 tests/check-qdict.c      |  1 +
 tests/check-qobject.c    |  1 +
 tests/test-replication.c |  1 +
 util/qemu-config.c       |  1 +
 26 files changed, 56 insertions(+), 17 deletions(-)
 create mode 100644 include/block/qdict.h

diff --git a/block.c b/block.c
index 50887087f3..afe30caac3 100644
--- a/block.c
+++ b/block.c
@@ -27,6 +27,7 @@
 #include "block/block_int.h"
 #include "block/blockjob.h"
 #include "block/nbd.h"
+#include "block/qdict.h"
 #include "qemu/error-report.h"
 #include "module_block.h"
 #include "qemu/module.h"
diff --git a/block/gluster.c b/block/gluster.c
index 9900b6420c..b5fe7f3e87 100644
--- a/block/gluster.c
+++ b/block/gluster.c
@@ -11,6 +11,7 @@
 #include "qemu/osdep.h"
 #include <glusterfs/api/glfs.h>
 #include "block/block_int.h"
+#include "block/qdict.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
diff --git a/block/iscsi.c b/block/iscsi.c
index 7e3ea72bd2..9f00fb47a5 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -33,6 +33,7 @@
 #include "qemu/bitops.h"
 #include "qemu/bitmap.h"
 #include "block/block_int.h"
+#include "block/qdict.h"
 #include "scsi/constants.h"
 #include "qemu/iov.h"
 #include "qemu/option.h"
diff --git a/block/nbd.c b/block/nbd.c
index ff8333e3c1..d6c4c4ddbc 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -28,6 +28,7 @@
 
 #include "qemu/osdep.h"
 #include "nbd-client.h"
+#include "block/qdict.h"
 #include "qapi/error.h"
 #include "qemu/uri.h"
 #include "block/block_int.h"
diff --git a/block/nfs.c b/block/nfs.c
index 3349b67a76..3170b059b3 100644
--- a/block/nfs.c
+++ b/block/nfs.c
@@ -29,6 +29,7 @@
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 #include "block/block_int.h"
+#include "block/qdict.h"
 #include "trace.h"
 #include "qemu/iov.h"
 #include "qemu/option.h"
diff --git a/block/parallels.c b/block/parallels.c
index 6e9c37f44e..c1d9643498 100644
--- a/block/parallels.c
+++ b/block/parallels.c
@@ -31,6 +31,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "block/block_int.h"
+#include "block/qdict.h"
 #include "sysemu/block-backend.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
diff --git a/block/qcow.c b/block/qcow.c
index 1f866af0d3..8c08908fd8 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -26,6 +26,7 @@
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "block/block_int.h"
+#include "block/qdict.h"
 #include "sysemu/block-backend.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
diff --git a/block/qcow2.c b/block/qcow2.c
index 6fa5e1d71a..d2d955f984 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "block/block_int.h"
+#include "block/qdict.h"
 #include "sysemu/block-backend.h"
 #include "qemu/module.h"
 #include <zlib.h>
diff --git a/block/qed.c b/block/qed.c
index 65cfe92393..324a953cbc 100644
--- a/block/qed.c
+++ b/block/qed.c
@@ -13,6 +13,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "block/qdict.h"
 #include "qapi/error.h"
 #include "qemu/timer.h"
 #include "qemu/bswap.h"
diff --git a/block/quorum.c b/block/quorum.c
index b6476c405a..9152da8c58 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -17,6 +17,7 @@
 #include "qemu/cutils.h"
 #include "qemu/option.h"
 #include "block/block_int.h"
+#include "block/qdict.h"
 #include "qapi/error.h"
 #include "qapi/qapi-events-block.h"
 #include "qapi/qmp/qdict.h"
diff --git a/block/rbd.c b/block/rbd.c
index 40c6e4185f..9659c7361f 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -18,6 +18,7 @@
 #include "qemu/error-report.h"
 #include "qemu/option.h"
 #include "block/block_int.h"
+#include "block/qdict.h"
 #include "crypto/secret.h"
 #include "qemu/cutils.h"
 #include "qapi/qmp/qstring.h"
diff --git a/block/sheepdog.c b/block/sheepdog.c
index 7b98725af7..2e1f0e6eca 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -24,6 +24,7 @@
 #include "qemu/option.h"
 #include "qemu/sockets.h"
 #include "block/block_int.h"
+#include "block/qdict.h"
 #include "sysemu/block-backend.h"
 #include "qemu/bitops.h"
 #include "qemu/cutils.h"
diff --git a/block/snapshot.c b/block/snapshot.c
index 2953d96c06..f9903bc94e 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "block/snapshot.h"
 #include "block/block_int.h"
+#include "block/qdict.h"
 #include "qapi/error.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
diff --git a/block/ssh.c b/block/ssh.c
index 4c4fa3ccfc..eec37dd27c 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -28,6 +28,7 @@
 #include <libssh2_sftp.h>
 
 #include "block/block_int.h"
+#include "block/qdict.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/option.h"
diff --git a/block/vhdx.c b/block/vhdx.c
index 0831c5c5f4..2e32e24514 100644
--- a/block/vhdx.c
+++ b/block/vhdx.c
@@ -18,6 +18,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "block/block_int.h"
+#include "block/qdict.h"
 #include "sysemu/block-backend.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
diff --git a/block/vpc.c b/block/vpc.c
index 0ebfcd3cc8..41c8c980f1 100644
--- a/block/vpc.c
+++ b/block/vpc.c
@@ -26,6 +26,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "block/block_int.h"
+#include "block/qdict.h"
 #include "sysemu/block-backend.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
diff --git a/block/vvfat.c b/block/vvfat.c
index 662dca0114..4595f335b8 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -27,6 +27,7 @@
 #include <dirent.h>
 #include "qapi/error.h"
 #include "block/block_int.h"
+#include "block/qdict.h"
 #include "qemu/module.h"
 #include "qemu/option.h"
 #include "qemu/bswap.h"
diff --git a/block/vxhs.c b/block/vxhs.c
index 339e23218d..0cb0a007e9 100644
--- a/block/vxhs.c
+++ b/block/vxhs.c
@@ -12,6 +12,7 @@
 #include <qnio/qnio_api.h>
 #include <sys/param.h>
 #include "block/block_int.h"
+#include "block/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qstring.h"
diff --git a/blockdev.c b/blockdev.c
index 8de95be8f4..721dc9a4fc 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -35,6 +35,7 @@
 #include "sysemu/blockdev.h"
 #include "hw/block/block.h"
 #include "block/blockjob.h"
+#include "block/qdict.h"
 #include "block/throttle-groups.h"
 #include "monitor/monitor.h"
 #include "qemu/error-report.h"
diff --git a/include/block/qdict.h b/include/block/qdict.h
new file mode 100644
index 0000000000..71c037afba
--- /dev/null
+++ b/include/block/qdict.h
@@ -0,0 +1,32 @@
+/*
+ * Special QDict functions used by the block layer
+ *
+ * Copyright (c) 2013-2018 Red Hat, Inc.
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
+ * See the COPYING.LIB file in the top-level directory.
+ */
+
+#ifndef BLOCK_QDICT_H
+#define BLOCK_QDICT_H
+
+#include "qapi/qmp/qdict.h"
+
+void qdict_copy_default(QDict *dst, QDict *src, const char *key);
+void qdict_set_default_str(QDict *dst, const char *key, const char *val);
+
+void qdict_join(QDict *dest, QDict *src, bool overwrite);
+
+void qdict_extract_subqdict(QDict *src, QDict **dst, const char *start);
+void qdict_array_split(QDict *src, QList **dst);
+int qdict_array_entries(QDict *src, const char *subqdict);
+QObject *qdict_crumple(const QDict *src, Error **errp);
+void qdict_flatten(QDict *qdict);
+
+typedef struct QDictRenames {
+    const char *from;
+    const char *to;
+} QDictRenames;
+bool qdict_rename_keys(QDict *qdict, const QDictRenames *renames, Error **errp);
+
+#endif
diff --git a/include/qapi/qmp/qdict.h b/include/qapi/qmp/qdict.h
index 921a28d2d3..7f3ec10a10 100644
--- a/include/qapi/qmp/qdict.h
+++ b/include/qapi/qmp/qdict.h
@@ -67,23 +67,6 @@ int64_t qdict_get_try_int(const QDict *qdict, const char *key,
 bool qdict_get_try_bool(const QDict *qdict, const char *key, bool def_value);
 const char *qdict_get_try_str(const QDict *qdict, const char *key);
 
-void qdict_copy_default(QDict *dst, QDict *src, const char *key);
-void qdict_set_default_str(QDict *dst, const char *key, const char *val);
-
 QDict *qdict_clone_shallow(const QDict *src);
-void qdict_flatten(QDict *qdict);
-
-void qdict_extract_subqdict(QDict *src, QDict **dst, const char *start);
-void qdict_array_split(QDict *src, QList **dst);
-int qdict_array_entries(QDict *src, const char *subqdict);
-QObject *qdict_crumple(const QDict *src, Error **errp);
-
-void qdict_join(QDict *dest, QDict *src, bool overwrite);
-
-typedef struct QDictRenames {
-    const char *from;
-    const char *to;
-} QDictRenames;
-bool qdict_rename_keys(QDict *qdict, const QDictRenames *renames, Error **errp);
 
 #endif /* QDICT_H */
diff --git a/qobject/qdict.c b/qobject/qdict.c
index 22800eeceb..0554c64553 100644
--- a/qobject/qdict.c
+++ b/qobject/qdict.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "block/qdict.h"
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qbool.h"
diff --git a/tests/check-qdict.c b/tests/check-qdict.c
index eba5d3528e..93e2112b6d 100644
--- a/tests/check-qdict.c
+++ b/tests/check-qdict.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "block/qdict.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
 #include "qapi/qmp/qnum.h"
diff --git a/tests/check-qobject.c b/tests/check-qobject.c
index 5cb08fcb63..16ccbde82c 100644
--- a/tests/check-qobject.c
+++ b/tests/check-qobject.c
@@ -8,6 +8,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "block/qdict.h"
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qlist.h"
diff --git a/tests/test-replication.c b/tests/test-replication.c
index 68c0d04f2a..c8165ae954 100644
--- a/tests/test-replication.c
+++ b/tests/test-replication.c
@@ -15,6 +15,7 @@
 #include "qemu/option.h"
 #include "replication.h"
 #include "block/block_int.h"
+#include "block/qdict.h"
 #include "sysemu/block-backend.h"
 
 #define IMG_SIZE (64 * 1024 * 1024)
diff --git a/util/qemu-config.c b/util/qemu-config.c
index 14d84022dc..9d2e278e29 100644
--- a/util/qemu-config.c
+++ b/util/qemu-config.c
@@ -1,4 +1,5 @@
 #include "qemu/osdep.h"
+#include "block/qdict.h" /* for qdict_extract_subqdict() */
 #include "qapi/error.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qmp/qdict.h"
-- 
2.17.1
