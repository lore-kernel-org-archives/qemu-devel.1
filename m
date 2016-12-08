Received: from eggs.gnu.org ([2001:4830:134:3::10]:43264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cEy19-0002qn-N2
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 07:41:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cEy18-0001bC-0B
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 07:41:43 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu,  8 Dec 2016 12:41:03 +0000
Message-Id: <20161208124103.9813-3-berrange@redhat.com>
In-Reply-To: <20161208124103.9813-1-berrange@redhat.com>
References: <20161208124103.9813-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] iscsi: support most -iscsi opts against
 block dev opts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pino Toscano <ptoscano@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Lieven <pl@kamp.de>, qemu-block@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>

Currently a number of iscsi related options must be specified against
the separate -iscsi argument, instead of as part of the block device
configuration. This extends the iscsi bdev runtime options to support
all the options available via -iscsi, except for the deprecated
"password" option.  This makes the -iscsi argument obsolete, though
it is kept for sake of backwards compatibility.

If the same property is set against -iscsi and against -drive, then
the latter will always take priority.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 block/iscsi.c | 75 ++++++++++++++++++++++++++++++++++++--------------------
 block/iscsi.h | 79 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 vl.c          | 36 +++++++--------------------
 3 files changed, 136 insertions(+), 54 deletions(-)
 create mode 100644 block/iscsi.h

diff --git a/block/iscsi.c b/block/iscsi.c
index 6c5bb89..939150f 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -40,6 +40,7 @@
 #include "qmp-commands.h"
 #include "qapi/qmp/qstring.h"
 #include "crypto/secret.h"
+#include "block/iscsi.h"
 
 #include <iscsi/iscsi.h>
 #include <iscsi/scsi-lowlevel.h>
@@ -1235,25 +1236,34 @@ retry:
     return 0;
 }
 
-static void parse_chap(QemuOpts *iscsiopts, struct iscsi_context *iscsi,
-                       Error **errp)
+static void parse_chap(QemuOpts *iscsiopts, QemuOpts *bdevopts,
+                       struct iscsi_context *iscsi, Error **errp)
 {
     const char *user = NULL;
     const char *password = NULL;
     const char *secretid;
     char *secret = NULL;
 
-    if (!iscsiopts) {
-        return;
+    user = qemu_opt_get(bdevopts, "user");
+    if (!user && iscsiopts) {
+        user = qemu_opt_get(iscsiopts, "user");
     }
-
-    user = qemu_opt_get(iscsiopts, "user");
     if (!user) {
         return;
     }
 
-    secretid = qemu_opt_get(iscsiopts, "password-secret");
-    password = qemu_opt_get(iscsiopts, "password");
+    secretid = qemu_opt_get(bdevopts, "password-secret");
+    if (!secretid && iscsiopts) {
+        secretid = qemu_opt_get(iscsiopts, "password-secret");
+    }
+    /* Intentionally don't look for 'password' in bdev opts,
+     * since this is an insecure broken feature of -iscsi.
+     * we only want to support password-secret with -drive
+     */
+    if (iscsiopts) {
+        password = qemu_opt_get(iscsiopts, "password");
+    }
+
     if (secretid && password) {
         error_setg(errp, "'password' and 'password-secret' properties are "
                    "mutually exclusive");
@@ -1277,16 +1287,15 @@ static void parse_chap(QemuOpts *iscsiopts, struct iscsi_context *iscsi,
     g_free(secret);
 }
 
-static void parse_header_digest(QemuOpts *iscsiopts,
+static void parse_header_digest(QemuOpts *iscsiopts, QemuOpts *bdevopts,
                                 struct iscsi_context *iscsi, Error **errp)
 {
     const char *digest = NULL;
 
-    if (!iscsiopts) {
-        return;
+    digest = qemu_opt_get(bdevopts, "header-digest");
+    if (!digest && iscsiopts) {
+        digest = qemu_opt_get(iscsiopts, "header-digest");
     }
-
-    digest = qemu_opt_get(iscsiopts, "header-digest");
     if (!digest) {
         return;
     }
@@ -1304,17 +1313,18 @@ static void parse_header_digest(QemuOpts *iscsiopts,
     }
 }
 
-static char *parse_initiator_name(QemuOpts *iscsiopts)
+static char *parse_initiator_name(QemuOpts *iscsiopts, QemuOpts *bdevopts)
 {
     const char *name;
     char *iscsi_name;
     UuidInfo *uuid_info;
 
-    if (iscsiopts) {
+    name = qemu_opt_get(bdevopts, "initiator-name");
+    if (!name && iscsiopts) {
         name = qemu_opt_get(iscsiopts, "initiator-name");
-        if (name) {
-            return g_strdup(name);
-        }
+    }
+    if (name) {
+        return g_strdup(name);
     }
 
     uuid_info = qmp_query_uuid(NULL);
@@ -1329,15 +1339,16 @@ static char *parse_initiator_name(QemuOpts *iscsiopts)
     return iscsi_name;
 }
 
-static int parse_timeout(QemuOpts *iscsiopts)
+static int parse_timeout(QemuOpts *iscsiopts, QemuOpts *bdevopts)
 {
     const char *timeout;
 
-    if (iscsiopts) {
+    timeout = qemu_opt_get(bdevopts, "timeout");
+    if (!timeout && iscsiopts) {
         timeout = qemu_opt_get(iscsiopts, "timeout");
-        if (timeout) {
-            return atoi(timeout);
-        }
+    }
+    if (timeout) {
+        return atoi(timeout);
     }
 
     return 0;
@@ -1439,6 +1450,16 @@ static QemuOptsList runtime_opts = {
             .type = QEMU_OPT_STRING,
             .help = "URL to the iscsi image",
         },
+        ISCSI_OPT_USER,
+        /* Intentionally don't register 'password' in bdev opts,
+         * since this is an insecure broken feature of -iscsi.
+         * we only want to support password-secret with -drive
+         *
+         *ISCSI_OPT_PASSWORD,*/
+        ISCSI_OPT_PASSWORD_SECRET,
+        ISCSI_OPT_HEADER_DIGEST,
+        ISCSI_OPT_INITIATOR_NAME,
+        ISCSI_OPT_TIMEOUT,
         { /* end of list */ }
     },
 };
@@ -1622,7 +1643,7 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
 
     memset(iscsilun, 0, sizeof(IscsiLun));
 
-    initiator_name = parse_initiator_name(iscsiopts);
+    initiator_name = parse_initiator_name(iscsiopts, opts);
 
     iscsi = iscsi_create_context(initiator_name);
     if (iscsi == NULL) {
@@ -1654,7 +1675,7 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     /* check if we got CHAP username/password via the options */
-    parse_chap(iscsiopts, iscsi, &local_err);
+    parse_chap(iscsiopts, opts, iscsi, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         ret = -EINVAL;
@@ -1670,7 +1691,7 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
     iscsi_set_header_digest(iscsi, ISCSI_HEADER_DIGEST_NONE_CRC32C);
 
     /* check if we got HEADER_DIGEST via the options */
-    parse_header_digest(iscsiopts, iscsi, &local_err);
+    parse_header_digest(iscsiopts, opts, iscsi, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         ret = -EINVAL;
@@ -1678,7 +1699,7 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     /* timeout handling is broken in libiscsi before 1.15.0 */
-    timeout = parse_timeout(iscsiopts);
+    timeout = parse_timeout(iscsiopts, opts);
 #if LIBISCSI_API_VERSION >= 20150621
     iscsi_set_timeout(iscsi, timeout);
 #else
diff --git a/block/iscsi.h b/block/iscsi.h
new file mode 100644
index 0000000..588c548
--- /dev/null
+++ b/block/iscsi.h
@@ -0,0 +1,79 @@
+/*
+ * QEMU Block driver for iSCSI images
+ *
+ * Copyright (c) 2010-2011 Ronnie Sahlberg <ronniesahlberg@gmail.com>
+ * Copyright (c) 2012-2016 Peter Lieven <pl@kamp.de>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef QEMU_BLOCK_ISCSI_H
+#define QEMU_BLOCK_ISCSI_H
+
+/*
+ * These properties were historically set using the '-iscsi' arg,
+ * but are not settable directly against the blockdev with -drive
+ * or equivalent
+ */
+
+#define ISCSI_OPT_USER                                          \
+    {                                                           \
+        .name = "user",                                         \
+        .type = QEMU_OPT_STRING,                                \
+        .help = "username for CHAP authentication to target",   \
+    }
+
+#define ISCSI_OPT_PASSWORD                                      \
+    {                                                           \
+        .name = "password",                                     \
+        .type = QEMU_OPT_STRING,                                \
+        .help = "password for CHAP authentication to target",   \
+    }
+
+#define ISCSI_OPT_PASSWORD_SECRET                               \
+    {                                                           \
+        .name = "password-secret",                              \
+        .type = QEMU_OPT_STRING,                                \
+        .help = "ID of the secret providing password for CHAP " \
+        "authentication to target",                             \
+    }
+
+#define ISCSI_OPT_HEADER_DIGEST                                 \
+    {                                                           \
+        .name = "header-digest",                                \
+        .type = QEMU_OPT_STRING,                                \
+        .help = "HeaderDigest setting. "                        \
+                "{CRC32C|CRC32C-NONE|NONE-CRC32C|NONE}",        \
+    }
+
+#define ISCSI_OPT_INITIATOR_NAME                                \
+    {                                                           \
+        .name = "initiator-name",                               \
+        .type = QEMU_OPT_STRING,                                \
+        .help = "Initiator iqn name to use when connecting",    \
+    }
+
+#define ISCSI_OPT_TIMEOUT                                               \
+    {                                                                   \
+        .name = "timeout",                                              \
+        .type = QEMU_OPT_NUMBER,                                        \
+        .help = "Request timeout in seconds (default 0 = no timeout)",  \
+    }
+
+#endif /* QEMU_BLOCK_ISCSI_H */
diff --git a/vl.c b/vl.c
index d77dd86..7234d9c 100644
--- a/vl.c
+++ b/vl.c
@@ -26,6 +26,9 @@
 #include "qemu/cutils.h"
 #include "qemu/help_option.h"
 #include "qemu/uuid.h"
+#ifdef CONFIG_LIBISCSI
+#include "block/iscsi.h"
+#endif
 
 #ifdef CONFIG_SECCOMP
 #include "sysemu/seccomp.h"
@@ -514,33 +517,12 @@ static QemuOptsList qemu_iscsi_opts = {
     .name = "iscsi",
     .head = QTAILQ_HEAD_INITIALIZER(qemu_iscsi_opts.head),
     .desc = {
-        {
-            .name = "user",
-            .type = QEMU_OPT_STRING,
-            .help = "username for CHAP authentication to target",
-        },{
-            .name = "password",
-            .type = QEMU_OPT_STRING,
-            .help = "password for CHAP authentication to target",
-        },{
-            .name = "password-secret",
-            .type = QEMU_OPT_STRING,
-            .help = "ID of the secret providing password for CHAP "
-                    "authentication to target",
-        },{
-            .name = "header-digest",
-            .type = QEMU_OPT_STRING,
-            .help = "HeaderDigest setting. "
-                    "{CRC32C|CRC32C-NONE|NONE-CRC32C|NONE}",
-        },{
-            .name = "initiator-name",
-            .type = QEMU_OPT_STRING,
-            .help = "Initiator iqn name to use when connecting",
-        },{
-            .name = "timeout",
-            .type = QEMU_OPT_NUMBER,
-            .help = "Request timeout in seconds (default 0 = no timeout)",
-        },
+        ISCSI_OPT_USER,
+        ISCSI_OPT_PASSWORD,
+        ISCSI_OPT_PASSWORD_SECRET,
+        ISCSI_OPT_HEADER_DIGEST,
+        ISCSI_OPT_INITIATOR_NAME,
+        ISCSI_OPT_TIMEOUT,
         { /* end of list */ }
     },
 };
-- 
2.9.3
