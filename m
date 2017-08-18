Received: from eggs.gnu.org ([2001:4830:134:3::10]:54730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dii3W-00066l-8e
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:15:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dii3U-0005kg-GR
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:15:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dii3U-0005kG-75
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 10:15:20 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4E63E267D5
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 14:15:19 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Fri, 18 Aug 2017 22:15:10 +0800
Message-Id: <20170818141512.15205-2-famz@redhat.com>
In-Reply-To: <20170818141512.15205-1-famz@redhat.com>
References: <20170818141512.15205-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/3] scsi: Refactor scsi sense interpreting
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
Cc: Paolo Bonzini <pbonzini@redhat.com>

So that it can be reused outside of iscsi.c.

Also update MAINTAINERS to include the new files in SCSI section.

Signed-off-by: Fam Zheng <famz@redhat.com>
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
index ccee28b12d..2a4e5036ae 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -969,7 +969,9 @@ SCSI
 M: Paolo Bonzini <pbonzini@redhat.com>
 S: Supported
 F: include/hw/scsi/*
+F: include/scsi/*
 F: hw/scsi/*
+F: util/scsi*
 F: tests/virtio-scsi-test.c
 T: git git://github.com/bonzini/qemu.git scsi-next
 
diff --git a/block/iscsi.c b/block/iscsi.c
index d557c99668..4bed63cd6d 100644
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
index 0000000000..f894ace4bf
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
index 50a55ecc75..c9e6c493d3 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -45,3 +45,4 @@ util-obj-y += qht.o
 util-obj-y += range.o
 util-obj-y += stats64.o
 util-obj-y += systemd.o
+util-obj-y += scsi.o
diff --git a/util/scsi.c b/util/scsi.c
new file mode 100644
index 0000000000..92ca436cd0
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
+    case 0x02: /* SCSI_SENSE_NOT_READY */
+        return EBUSY;
+    case 0x07: /* SCSI_SENSE_DATA_PROTECTION */
+        return EACCES;
+    case 0x0b: /* SCSI_SENSE_COMMAND_ABORTED */
+        return ECANCELED;
+    case 0x05: /* SCSI_SENSE_ILLEGAL_REQUEST */
+        /* Parse ASCQ */
+        break;
+    default:
+        return EIO;
+    }
+    switch ((asc << 8) | ascq) {
+    case 0x1a00: /* SCSI_SENSE_ASCQ_PARAMETER_LIST_LENGTH_ERROR */
+    case 0x2000: /* SCSI_SENSE_ASCQ_INVALID_OPERATION_CODE */
+    case 0x2400: /* SCSI_SENSE_ASCQ_INVALID_FIELD_IN_CDB */
+    case 0x2600: /* SCSI_SENSE_ASCQ_INVALID_FIELD_IN_PARAMETER_LIST */
+        return EINVAL;
+    case 0x2100: /* SCSI_SENSE_ASCQ_LBA_OUT_OF_RANGE */
+        return ENOSPC;
+    case 0x2500: /* SCSI_SENSE_ASCQ_LOGICAL_UNIT_NOT_SUPPORTED */
+        return ENOTSUP;
+    case 0x3a00: /* SCSI_SENSE_ASCQ_MEDIUM_NOT_PRESENT */
+    case 0x3a01: /* SCSI_SENSE_ASCQ_MEDIUM_NOT_PRESENT_TRAY_CLOSED */
+    case 0x3a02: /* SCSI_SENSE_ASCQ_MEDIUM_NOT_PRESENT_TRAY_OPEN */
+        return ENOMEDIUM;
+    case 0x2700: /* SCSI_SENSE_ASCQ_WRITE_PROTECTED */
+        return EACCES;
+    default:
+        return EIO;
+    }
+}
-- 
2.13.4
