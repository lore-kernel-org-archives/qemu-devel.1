Received: from eggs.gnu.org ([2001:4830:134:3::10]:34280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1cVgtw-0008FX-IE
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:51:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeepkiruvale@gmail.com>) id 1cVgtt-00043q-FV
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:51:24 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:35628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pradeepkiruvale@gmail.com>)
	id 1cVgtt-00043F-4d
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 10:51:21 -0500
Received: by mail-wm0-x241.google.com with SMTP id d140so27397861wmd.2
	for <qemu-devel@nongnu.org>; Mon, 23 Jan 2017 07:51:20 -0800 (PST)
From: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>
Date: Mon, 23 Jan 2017 10:50:41 -0500
Message-Id: <1485186641-12220-3-git-send-email-pradeep.jagadeesh@huawei.com>
In-Reply-To: <1485186641-12220-1-git-send-email-pradeep.jagadeesh@huawei.com>
References: <1485186641-12220-1-git-send-email-pradeep.jagadeesh@huawei.com>
Subject: [Qemu-devel] [PATCH 2/2 V13] throttle: factor out duplicate code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@gmail.com>, Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org

This patch removes the redundant throttle code that was present in
block and fsdev device files. Now the common code is moved
to a single file.

---
 blockdev.c                      | 81 ++----------------------------------
 fsdev/qemu-fsdev-opts.c         | 80 ++---------------------------------
 include/qemu/throttle-options.h | 92 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 100 insertions(+), 153 deletions(-)
 create mode 100644 include/qemu/throttle-options.h

diff --git a/blockdev.c b/blockdev.c
index 245e1e1..9320c8a 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -52,6 +52,7 @@
 #include "sysemu/arch_init.h"
 #include "qemu/cutils.h"
 #include "qemu/help_option.h"
+#include "qemu/throttle-options.h"
 
 static QTAILQ_HEAD(, BlockDriverState) monitor_bdrv_states =
     QTAILQ_HEAD_INITIALIZER(monitor_bdrv_states);
@@ -3999,83 +4000,9 @@ QemuOptsList qemu_common_drive_opts = {
             .name = BDRV_OPT_READ_ONLY,
             .type = QEMU_OPT_BOOL,
             .help = "open drive file as read-only",
-        },{
-            .name = "throttling.iops-total",
-            .type = QEMU_OPT_NUMBER,
-            .help = "limit total I/O operations per second",
-        },{
-            .name = "throttling.iops-read",
-            .type = QEMU_OPT_NUMBER,
-            .help = "limit read operations per second",
-        },{
-            .name = "throttling.iops-write",
-            .type = QEMU_OPT_NUMBER,
-            .help = "limit write operations per second",
-        },{
-            .name = "throttling.bps-total",
-            .type = QEMU_OPT_NUMBER,
-            .help = "limit total bytes per second",
-        },{
-            .name = "throttling.bps-read",
-            .type = QEMU_OPT_NUMBER,
-            .help = "limit read bytes per second",
-        },{
-            .name = "throttling.bps-write",
-            .type = QEMU_OPT_NUMBER,
-            .help = "limit write bytes per second",
-        },{
-            .name = "throttling.iops-total-max",
-            .type = QEMU_OPT_NUMBER,
-            .help = "I/O operations burst",
-        },{
-            .name = "throttling.iops-read-max",
-            .type = QEMU_OPT_NUMBER,
-            .help = "I/O operations read burst",
-        },{
-            .name = "throttling.iops-write-max",
-            .type = QEMU_OPT_NUMBER,
-            .help = "I/O operations write burst",
-        },{
-            .name = "throttling.bps-total-max",
-            .type = QEMU_OPT_NUMBER,
-            .help = "total bytes burst",
-        },{
-            .name = "throttling.bps-read-max",
-            .type = QEMU_OPT_NUMBER,
-            .help = "total bytes read burst",
-        },{
-            .name = "throttling.bps-write-max",
-            .type = QEMU_OPT_NUMBER,
-            .help = "total bytes write burst",
-        },{
-            .name = "throttling.iops-total-max-length",
-            .type = QEMU_OPT_NUMBER,
-            .help = "length of the iops-total-max burst period, in seconds",
-        },{
-            .name = "throttling.iops-read-max-length",
-            .type = QEMU_OPT_NUMBER,
-            .help = "length of the iops-read-max burst period, in seconds",
-        },{
-            .name = "throttling.iops-write-max-length",
-            .type = QEMU_OPT_NUMBER,
-            .help = "length of the iops-write-max burst period, in seconds",
-        },{
-            .name = "throttling.bps-total-max-length",
-            .type = QEMU_OPT_NUMBER,
-            .help = "length of the bps-total-max burst period, in seconds",
-        },{
-            .name = "throttling.bps-read-max-length",
-            .type = QEMU_OPT_NUMBER,
-            .help = "length of the bps-read-max burst period, in seconds",
-        },{
-            .name = "throttling.bps-write-max-length",
-            .type = QEMU_OPT_NUMBER,
-            .help = "length of the bps-write-max burst period, in seconds",
-        },{
-            .name = "throttling.iops-size",
-            .type = QEMU_OPT_NUMBER,
-            .help = "when limiting by iops max size of an I/O in bytes",
-        },{
+        },
+            THROTTLE_OPTS,
+          {
             .name = "throttling.group",
             .type = QEMU_OPT_STRING,
             .help = "name of the block throttling group",
diff --git a/fsdev/qemu-fsdev-opts.c b/fsdev/qemu-fsdev-opts.c
index 385423f0..bf57130 100644
--- a/fsdev/qemu-fsdev-opts.c
+++ b/fsdev/qemu-fsdev-opts.c
@@ -9,6 +9,7 @@
 #include "qemu/config-file.h"
 #include "qemu/option.h"
 #include "qemu/module.h"
+#include "qemu/throttle-options.h"
 
 static QemuOptsList qemu_fsdev_opts = {
     .name = "fsdev",
@@ -37,83 +38,10 @@ static QemuOptsList qemu_fsdev_opts = {
         }, {
             .name = "sock_fd",
             .type = QEMU_OPT_NUMBER,
-        }, {
-            .name = "throttling.iops-total",
-            .type = QEMU_OPT_NUMBER,
-            .help = "limit total I/O operations per second",
-        }, {
-            .name = "throttling.iops-read",
-            .type = QEMU_OPT_NUMBER,
-            .help = "limit read operations per second",
-        }, {
-            .name = "throttling.iops-write",
-            .type = QEMU_OPT_NUMBER,
-            .help = "limit write operations per second",
-        }, {
-            .name = "throttling.bps-total",
-            .type = QEMU_OPT_NUMBER,
-            .help = "limit total bytes per second",
-        }, {
-            .name = "throttling.bps-read",
-            .type = QEMU_OPT_NUMBER,
-            .help = "limit read bytes per second",
-        }, {
-            .name = "throttling.bps-write",
-            .type = QEMU_OPT_NUMBER,
-            .help = "limit write bytes per second",
-        }, {
-            .name = "throttling.iops-total-max",
-            .type = QEMU_OPT_NUMBER,
-            .help = "I/O operations burst",
-        }, {
-            .name = "throttling.iops-read-max",
-            .type = QEMU_OPT_NUMBER,
-            .help = "I/O operations read burst",
-        }, {
-            .name = "throttling.iops-write-max",
-            .type = QEMU_OPT_NUMBER,
-            .help = "I/O operations write burst",
-        }, {
-            .name = "throttling.bps-total-max",
-            .type = QEMU_OPT_NUMBER,
-            .help = "total bytes burst",
-        }, {
-            .name = "throttling.bps-read-max",
-            .type = QEMU_OPT_NUMBER,
-            .help = "total bytes read burst",
-        }, {
-            .name = "throttling.bps-write-max",
-            .type = QEMU_OPT_NUMBER,
-            .help = "total bytes write burst",
-        }, {
-            .name = "throttling.iops-total-max-length",
-            .type = QEMU_OPT_NUMBER,
-            .help = "length of the iops-total-max burst period, in seconds",
-        }, {
-            .name = "throttling.iops-read-max-length",
-            .type = QEMU_OPT_NUMBER,
-            .help = "length of the iops-read-max burst period, in seconds",
-        }, {
-            .name = "throttling.iops-write-max-length",
-            .type = QEMU_OPT_NUMBER,
-            .help = "length of the iops-write-max burst period, in seconds",
-        }, {
-            .name = "throttling.bps-total-max-length",
-            .type = QEMU_OPT_NUMBER,
-            .help = "length of the bps-total-max burst period, in seconds",
-        }, {
-            .name = "throttling.bps-read-max-length",
-            .type = QEMU_OPT_NUMBER,
-            .help = "length of the bps-read-max burst period, in seconds",
-        }, {
-            .name = "throttling.bps-write-max-length",
-            .type = QEMU_OPT_NUMBER,
-            .help = "length of the bps-write-max burst period, in seconds",
-        }, {
-            .name = "throttling.iops-size",
-            .type = QEMU_OPT_NUMBER,
-            .help = "when limiting by iops max size of an I/O in bytes",
         },
+
+        THROTTLE_OPTS,
+
         { /*End of list */ }
     },
 };
diff --git a/include/qemu/throttle-options.h b/include/qemu/throttle-options.h
new file mode 100644
index 0000000..3133d1c
--- /dev/null
+++ b/include/qemu/throttle-options.h
@@ -0,0 +1,92 @@
+/*
+ * QEMU throttling command line options
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or
+ * (at your option) any later version.
+ *
+ * See the COPYING file in the top-level directory for details.
+ *
+ */
+#ifndef THROTTLE_OPTIONS_H
+#define THROTTLE_OPTIONS_H
+
+#define THROTTLE_OPTS \
+          { \
+            .name = "throttling.iops-total",\
+            .type = QEMU_OPT_NUMBER,\
+            .help = "limit total I/O operations per second",\
+        },{ \
+            .name = "throttling.iops-read",\
+            .type = QEMU_OPT_NUMBER,\
+            .help = "limit read operations per second",\
+        },{ \
+            .name = "throttling.iops-write",\
+            .type = QEMU_OPT_NUMBER,\
+            .help = "limit write operations per second",\
+        },{ \
+            .name = "throttling.bps-total",\
+            .type = QEMU_OPT_NUMBER,\
+            .help = "limit total bytes per second",\
+        },{ \
+            .name = "throttling.bps-read",\
+            .type = QEMU_OPT_NUMBER,\
+            .help = "limit read bytes per second",\
+        },{ \
+            .name = "throttling.bps-write",\
+            .type = QEMU_OPT_NUMBER,\
+            .help = "limit write bytes per second",\
+        },{ \
+            .name = "throttling.iops-total-max",\
+            .type = QEMU_OPT_NUMBER,\
+            .help = "I/O operations burst",\
+        },{ \
+            .name = "throttling.iops-read-max",\
+            .type = QEMU_OPT_NUMBER,\
+            .help = "I/O operations read burst",\
+        },{ \
+            .name = "throttling.iops-write-max",\
+            .type = QEMU_OPT_NUMBER,\
+            .help = "I/O operations write burst",\
+        },{ \
+            .name = "throttling.bps-total-max",\
+            .type = QEMU_OPT_NUMBER,\
+            .help = "total bytes burst",\
+        },{ \
+            .name = "throttling.bps-read-max",\
+            .type = QEMU_OPT_NUMBER,\
+            .help = "total bytes read burst",\
+        },{ \
+            .name = "throttling.bps-write-max",\
+            .type = QEMU_OPT_NUMBER,\
+            .help = "total bytes write burst",\
+        },{ \
+            .name = "throttling.iops-total-max-length",\
+            .type = QEMU_OPT_NUMBER,\
+            .help = "length of the iops-total-max burst period, in seconds",\
+        },{ \
+            .name = "throttling.iops-read-max-length",\
+            .type = QEMU_OPT_NUMBER,\
+            .help = "length of the iops-read-max burst period, in seconds",\
+        },{ \
+            .name = "throttling.iops-write-max-length",\
+            .type = QEMU_OPT_NUMBER,\
+            .help = "length of the iops-write-max burst period, in seconds",\
+        },{ \
+            .name = "throttling.bps-total-max-length",\
+            .type = QEMU_OPT_NUMBER,\
+            .help = "length of the bps-total-max burst period, in seconds",\
+        },{ \
+            .name = "throttling.bps-read-max-length",\
+            .type = QEMU_OPT_NUMBER,\
+            .help = "length of the bps-read-max burst period, in seconds",\
+        },{ \
+            .name = "throttling.bps-write-max-length",\
+            .type = QEMU_OPT_NUMBER,\
+            .help = "length of the bps-write-max burst period, in seconds",\
+        },{ \
+            .name = "throttling.iops-size",\
+            .type = QEMU_OPT_NUMBER,\
+            .help = "when limiting by iops max size of an I/O in bytes",\
+        }
+
+#endif
-- 
1.8.3.1
