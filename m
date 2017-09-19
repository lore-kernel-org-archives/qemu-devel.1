Received: from eggs.gnu.org ([2001:4830:134:3::10]:59644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHf0-0003hx-SJ
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:29:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1duHez-0005Di-JZ
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:29:54 -0400
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:34992)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1duHez-0005DN-Ay
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 08:29:53 -0400
Received: by mail-wm0-x241.google.com with SMTP id e64so3756096wmi.2
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 05:29:53 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 19 Sep 2017 14:28:57 +0200
Message-Id: <1505824179-21541-9-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
References: <1505824179-21541-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 08/50] scsi: Refactor scsi sense interpreting
 code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Fam Zheng <famz@redhat.com>

From: Fam Zheng <famz@redhat.com>

So that it can be reused outside of iscsi.c.

Also update MAINTAINERS to include the new files in SCSI section.

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170821141008.19383-2-famz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 MAINTAINERS         |  2 ++
 block/iscsi.c       | 45 ++++-----------------------------------------
 include/scsi/scsi.h | 19 +++++++++++++++++++
 util/Makefile.objs  |  1 +
 util/scsi.c         | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 5 files changed, 78 insertions(+), 41 deletions(-)
 create mode 100644 include/scsi/scsi.h
 create mode 100644 util/scsi.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 4bd1797..c207cb0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -968,7 +968,9 @@ SCSI
 M: Paolo Bonzini <pbonzini@redhat.com>
 S: Supported
 F: include/hw/scsi/*
+F: include/scsi/*
 F: hw/scsi/*
+F: util/scsi*
 F: tests/virtio-scsi-test.c
 T: git git://github.com/bonzini/qemu.git scsi-next
 
diff --git a/block/iscsi.c b/block/iscsi.c
index 8b47d30..1e8ae5a 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -40,6 +40,7 @@
 #include "qmp-commands.h"
 #include "qapi/qmp/qstring.h"
 #include "crypto/secret.h"
+#include "scsi/scsi.h"
 
 #include <iscsi/iscsi.h>
 #include <iscsi/scsi-lowlevel.h>
@@ -209,47 +210,9 @@ static inline unsigned exp_random(double mean)
 
 static int iscsi_translate_sense(struct scsi_sense *sense)
 {
-    int ret;
-
-    switch (sense->key) {
-    case SCSI_SENSE_NOT_READY:
-        return -EBUSY;
-    case SCSI_SENSE_DATA_PROTECTION:
-        return -EACCES;
-    case SCSI_SENSE_COMMAND_ABORTED:
-        return -ECANCELED;
-    case SCSI_SENSE_ILLEGAL_REQUEST:
-        /* Parse ASCQ */
-        break;
-    default:
-        return -EIO;
-    }
-    switch (sense->ascq) {
-    case SCSI_SENSE_ASCQ_PARAMETER_LIST_LENGTH_ERROR:
-    case SCSI_SENSE_ASCQ_INVALID_OPERATION_CODE:
-    case SCSI_SENSE_ASCQ_INVALID_FIELD_IN_CDB:
-    case SCSI_SENSE_ASCQ_INVALID_FIELD_IN_PARAMETER_LIST:
-        ret = -EINVAL;
-        break;
-    case SCSI_SENSE_ASCQ_LBA_OUT_OF_RANGE:
-        ret = -ENOSPC;
-        break;
-    case SCSI_SENSE_ASCQ_LOGICAL_UNIT_NOT_SUPPORTED:
-        ret = -ENOTSUP;
-        break;
-    case SCSI_SENSE_ASCQ_MEDIUM_NOT_PRESENT:
-    case SCSI_SENSE_ASCQ_MEDIUM_NOT_PRESENT_TRAY_CLOSED:
-    case SCSI_SENSE_ASCQ_MEDIUM_NOT_PRESENT_TRAY_OPEN:
-        ret = -ENOMEDIUM;
-        break;
-    case SCSI_SENSE_ASCQ_WRITE_PROTECTED:
-        ret = -EACCES;
-        break;
-    default:
-        ret = -EIO;
-        break;
-    }
-    return ret;
+    return - scsi_sense_to_errno(sense->key,
+                                 (sense->ascq & 0xFF00) >> 8,
+                                 sense->ascq & 0xFF);
 }
 
 /* Called (via iscsi_service) with QemuMutex held.  */
diff --git a/include/scsi/scsi.h b/include/scsi/scsi.h
new file mode 100644
index 0000000..f894ace
--- /dev/null
+++ b/include/scsi/scsi.h
@@ -0,0 +1,19 @@
+/*
+ *  SCSI helpers
+ *
+ *  Copyright 2017 Red Hat, Inc.
+ *
+ *  Authors:
+ *   Fam Zheng <famz@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ */
+#ifndef QEMU_SCSI_H
+#define QEMU_SCSI_H
+
+int scsi_sense_to_errno(int key, int asc, int ascq);
+
+#endif
diff --git a/util/Makefile.objs b/util/Makefile.objs
index 50a55ec..c9e6c49 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -45,3 +45,4 @@ util-obj-y += qht.o
 util-obj-y += range.o
 util-obj-y += stats64.o
 util-obj-y += systemd.o
+util-obj-y += scsi.o
diff --git a/util/scsi.c b/util/scsi.c
new file mode 100644
index 0000000..a671079
--- /dev/null
+++ b/util/scsi.c
@@ -0,0 +1,52 @@
+/*
+ *  SCSI helpers
+ *
+ *  Copyright 2017 Red Hat, Inc.
+ *
+ *  Authors:
+ *   Fam Zheng <famz@redhat.com>
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ */
+
+#include "qemu/osdep.h"
+#include "scsi/scsi.h"
+
+int scsi_sense_to_errno(int key, int asc, int ascq)
+{
+    switch (key) {
+    case 0x02: /* NOT READY */
+        return EBUSY;
+    case 0x07: /* DATA PROTECTION */
+        return EACCES;
+    case 0x0b: /* COMMAND ABORTED */
+        return ECANCELED;
+    case 0x05: /* ILLEGAL REQUEST */
+        /* Parse ASCQ */
+        break;
+    default:
+        return EIO;
+    }
+    switch ((asc << 8) | ascq) {
+    case 0x1a00: /* PARAMETER LIST LENGTH ERROR */
+    case 0x2000: /* INVALID OPERATION CODE */
+    case 0x2400: /* INVALID FIELD IN CDB */
+    case 0x2600: /* INVALID FIELD IN PARAMETER LIST */
+        return EINVAL;
+    case 0x2100: /* LBA OUT OF RANGE */
+        return ENOSPC;
+    case 0x2500: /* LOGICAL UNIT NOT SUPPORTED */
+        return ENOTSUP;
+    case 0x3a00: /* MEDIUM NOT PRESENT */
+    case 0x3a01: /* MEDIUM NOT PRESENT TRAY CLOSED */
+    case 0x3a02: /* MEDIUM NOT PRESENT TRAY OPEN */
+        return ENOMEDIUM;
+    case 0x2700: /* WRITE PROTECTED */
+        return EACCES;
+    default:
+        return EIO;
+    }
+}
-- 
1.8.3.1
