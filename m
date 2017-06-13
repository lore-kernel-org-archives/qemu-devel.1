Received: from eggs.gnu.org ([2001:4830:134:3::10]:57099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dKiU9-0001BW-K9
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:51:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dKiU8-0003MC-6h
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:51:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dKiU7-0003Ly-TZ
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 05:51:40 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D7912145F8F
	for <qemu-devel@nongnu.org>; Tue, 13 Jun 2017 09:51:38 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Tue, 13 Jun 2017 11:51:13 +0200
Message-Id: <20170613095120.11373-8-quintela@redhat.com>
In-Reply-To: <20170613095120.11373-1-quintela@redhat.com>
References: <20170613095120.11373-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/14] migration: Split registration functions
 from vmstate.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

They are indpendent, and nowadays almost every device register things
with qdev->vmsd.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 hw/net/vmxnet3.c             |  1 +
 hw/ppc/spapr.c               |  1 +
 hw/s390x/s390-skeys.c        |  1 +
 hw/s390x/s390-virtio-ccw.c   |  1 +
 include/migration/register.h | 56 ++++++++++++++++++++++++++++++++++++++=
++++++
 include/migration/vmstate.h  | 38 ------------------------------
 migration/block.c            |  1 +
 migration/ram.c              |  1 +
 migration/savevm.c           |  1 +
 slirp/slirp.c                |  1 +
 10 files changed, 64 insertions(+), 38 deletions(-)
 create mode 100644 include/migration/register.h

diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index 4df3110..a19a7a3 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -26,6 +26,7 @@
 #include "qemu/bswap.h"
 #include "hw/pci/msix.h"
 #include "hw/pci/msi.h"
+#include "migration/register.h"
=20
 #include "vmxnet3.h"
 #include "vmxnet_debug.h"
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 91b4057..bf2178f 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -39,6 +39,7 @@
 #include "sysemu/hw_accel.h"
 #include "kvm_ppc.h"
 #include "migration/migration.h"
+#include "migration/register.h"
 #include "mmu-hash64.h"
 #include "mmu-book3s-v3.h"
 #include "qom/cpu.h"
diff --git a/hw/s390x/s390-skeys.c b/hw/s390x/s390-skeys.c
index 35e7f63..c0de3b0 100644
--- a/hw/s390x/s390-skeys.c
+++ b/hw/s390x/s390-skeys.c
@@ -15,6 +15,7 @@
 #include "hw/s390x/storage-keys.h"
 #include "qemu/error-report.h"
 #include "sysemu/kvm.h"
+#include "migration/register.h"
=20
 #define S390_SKEYS_BUFFER_SIZE 131072  /* Room for 128k storage keys */
 #define S390_SKEYS_SAVE_FLAG_EOS 0x01
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index a806345..41ca666 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -28,6 +28,7 @@
 #include "ipl.h"
 #include "hw/s390x/s390-virtio-ccw.h"
 #include "hw/s390x/css-bridge.h"
+#include "migration/register.h"
=20
 static const char *const reset_dev_types[] =3D {
     TYPE_VIRTUAL_CSS_BRIDGE,
diff --git a/include/migration/register.h b/include/migration/register.h
new file mode 100644
index 0000000..717c617
--- /dev/null
+++ b/include/migration/register.h
@@ -0,0 +1,56 @@
+/*
+ * QEMU migration vmstate registration
+ *
+ * Copyright IBM, Corp. 2008
+ *
+ * Authors:
+ *  Anthony Liguori   <aliguori@us.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+
+#ifndef MIGRATION_REGISTER_H
+#define MIGRATION_REGISTER_H
+
+typedef void SaveStateHandler(QEMUFile *f, void *opaque);
+typedef int LoadStateHandler(QEMUFile *f, void *opaque, int version_id);
+
+typedef struct SaveVMHandlers {
+    /* This runs inside the iothread lock.  */
+    SaveStateHandler *save_state;
+
+    void (*cleanup)(void *opaque);
+    int (*save_live_complete_postcopy)(QEMUFile *f, void *opaque);
+    int (*save_live_complete_precopy)(QEMUFile *f, void *opaque);
+
+    /* This runs both outside and inside the iothread lock.  */
+    bool (*is_active)(void *opaque);
+
+    /* This runs outside the iothread lock in the migration case, and
+     * within the lock in the savevm case.  The callback had better only
+     * use data that is local to the migration thread or protected
+     * by other locks.
+     */
+    int (*save_live_iterate)(QEMUFile *f, void *opaque);
+
+    /* This runs outside the iothread lock!  */
+    int (*save_live_setup)(QEMUFile *f, void *opaque);
+    void (*save_live_pending)(QEMUFile *f, void *opaque,
+                              uint64_t threshold_size,
+                              uint64_t *non_postcopiable_pending,
+                              uint64_t *postcopiable_pending);
+    LoadStateHandler *load_state;
+} SaveVMHandlers;
+
+int register_savevm_live(DeviceState *dev,
+                         const char *idstr,
+                         int instance_id,
+                         int version_id,
+                         SaveVMHandlers *ops,
+                         void *opaque);
+
+void unregister_savevm(DeviceState *dev, const char *idstr, void *opaque=
);
+
+#endif
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index ee91dff..9ad4ba1 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -29,45 +29,7 @@
=20
 #include "migration/qjson.h"
=20
-typedef void SaveStateHandler(QEMUFile *f, void *opaque);
 typedef int LoadStateHandler(QEMUFile *f, void *opaque, int version_id);
-
-typedef struct SaveVMHandlers {
-    /* This runs inside the iothread lock.  */
-    SaveStateHandler *save_state;
-
-    void (*cleanup)(void *opaque);
-    int (*save_live_complete_postcopy)(QEMUFile *f, void *opaque);
-    int (*save_live_complete_precopy)(QEMUFile *f, void *opaque);
-
-    /* This runs both outside and inside the iothread lock.  */
-    bool (*is_active)(void *opaque);
-
-    /* This runs outside the iothread lock in the migration case, and
-     * within the lock in the savevm case.  The callback had better only
-     * use data that is local to the migration thread or protected
-     * by other locks.
-     */
-    int (*save_live_iterate)(QEMUFile *f, void *opaque);
-
-    /* This runs outside the iothread lock!  */
-    int (*save_live_setup)(QEMUFile *f, void *opaque);
-    void (*save_live_pending)(QEMUFile *f, void *opaque,
-                              uint64_t threshold_size,
-                              uint64_t *non_postcopiable_pending,
-                              uint64_t *postcopiable_pending);
-    LoadStateHandler *load_state;
-} SaveVMHandlers;
-
-int register_savevm_live(DeviceState *dev,
-                         const char *idstr,
-                         int instance_id,
-                         int version_id,
-                         SaveVMHandlers *ops,
-                         void *opaque);
-
-void unregister_savevm(DeviceState *dev, const char *idstr, void *opaque=
);
-
 typedef struct VMStateInfo VMStateInfo;
 typedef struct VMStateDescription VMStateDescription;
 typedef struct VMStateField VMStateField;
diff --git a/migration/block.c b/migration/block.c
index 114cedb..223ecaa 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -26,6 +26,7 @@
 #include "block.h"
 #include "migration/misc.h"
 #include "migration/migration.h"
+#include "migration/register.h"
 #include "sysemu/blockdev.h"
 #include "qemu-file.h"
 #include "migration/vmstate.h"
diff --git a/migration/ram.c b/migration/ram.c
index 9ffd0a5..d8b6713 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -38,6 +38,7 @@
 #include "xbzrle.h"
 #include "ram.h"
 #include "migration/migration.h"
+#include "migration/register.h"
 #include "migration/misc.h"
 #include "qemu-file.h"
 #include "migration/vmstate.h"
diff --git a/migration/savevm.c b/migration/savevm.c
index cc8e4e1..59419eb 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -37,6 +37,7 @@
 #include "migration/migration.h"
 #include "migration/snapshot.h"
 #include "migration/misc.h"
+#include "migration/register.h"
 #include "ram.h"
 #include "qemu-file-channel.h"
 #include "qemu-file.h"
diff --git a/slirp/slirp.c b/slirp/slirp.c
index 2386493..1d67568 100644
--- a/slirp/slirp.c
+++ b/slirp/slirp.c
@@ -26,6 +26,7 @@
 #include "qemu/timer.h"
 #include "qemu/error-report.h"
 #include "chardev/char-fe.h"
+#include "migration/register.h"
 #include "slirp.h"
 #include "hw/hw.h"
 #include "qemu/cutils.h"
--=20
2.9.4
