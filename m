Received: from eggs.gnu.org ([2001:4830:134:3::10]:43229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cEy13-0002m1-Ov
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 07:41:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cEy0x-0001X3-HE
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 07:41:37 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu,  8 Dec 2016 12:41:02 +0000
Message-Id: <20161208124103.9813-2-berrange@redhat.com>
In-Reply-To: <20161208124103.9813-1-berrange@redhat.com>
References: <20161208124103.9813-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] iscsi: reduce code duplication parsing
 -iscsi opts
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

The iscsi block driver has to pull some of its options out of
a separate -iscsi. It has a separate helper method for each
set of options it needs to extract, and in doing so, it runs
qemu_opts_find multiple times. Switch to running qemu_opts_find
once and passing the QemuOpts object into the helpers instead.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 block/iscsi.c | 112 +++++++++++++++++++++++++---------------------------------
 1 file changed, 48 insertions(+), 64 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 0960929..6c5bb89 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -1235,36 +1235,25 @@ retry:
     return 0;
 }
 
-static void parse_chap(struct iscsi_context *iscsi, const char *target,
+static void parse_chap(QemuOpts *iscsiopts, struct iscsi_context *iscsi,
                        Error **errp)
 {
-    QemuOptsList *list;
-    QemuOpts *opts;
     const char *user = NULL;
     const char *password = NULL;
     const char *secretid;
     char *secret = NULL;
 
-    list = qemu_find_opts("iscsi");
-    if (!list) {
+    if (!iscsiopts) {
         return;
     }
 
-    opts = qemu_opts_find(list, target);
-    if (opts == NULL) {
-        opts = QTAILQ_FIRST(&list->head);
-        if (!opts) {
-            return;
-        }
-    }
-
-    user = qemu_opt_get(opts, "user");
+    user = qemu_opt_get(iscsiopts, "user");
     if (!user) {
         return;
     }
 
-    secretid = qemu_opt_get(opts, "password-secret");
-    password = qemu_opt_get(opts, "password");
+    secretid = qemu_opt_get(iscsiopts, "password-secret");
+    password = qemu_opt_get(iscsiopts, "password");
     if (secretid && password) {
         error_setg(errp, "'password' and 'password-secret' properties are "
                    "mutually exclusive");
@@ -1288,27 +1277,16 @@ static void parse_chap(struct iscsi_context *iscsi, const char *target,
     g_free(secret);
 }
 
-static void parse_header_digest(struct iscsi_context *iscsi, const char *target,
-                                Error **errp)
+static void parse_header_digest(QemuOpts *iscsiopts,
+                                struct iscsi_context *iscsi, Error **errp)
 {
-    QemuOptsList *list;
-    QemuOpts *opts;
     const char *digest = NULL;
 
-    list = qemu_find_opts("iscsi");
-    if (!list) {
+    if (!iscsiopts) {
         return;
     }
 
-    opts = qemu_opts_find(list, target);
-    if (opts == NULL) {
-        opts = QTAILQ_FIRST(&list->head);
-        if (!opts) {
-            return;
-        }
-    }
-
-    digest = qemu_opt_get(opts, "header-digest");
+    digest = qemu_opt_get(iscsiopts, "header-digest");
     if (!digest) {
         return;
     }
@@ -1326,25 +1304,16 @@ static void parse_header_digest(struct iscsi_context *iscsi, const char *target,
     }
 }
 
-static char *parse_initiator_name(const char *target)
+static char *parse_initiator_name(QemuOpts *iscsiopts)
 {
-    QemuOptsList *list;
-    QemuOpts *opts;
     const char *name;
     char *iscsi_name;
     UuidInfo *uuid_info;
 
-    list = qemu_find_opts("iscsi");
-    if (list) {
-        opts = qemu_opts_find(list, target);
-        if (!opts) {
-            opts = QTAILQ_FIRST(&list->head);
-        }
-        if (opts) {
-            name = qemu_opt_get(opts, "initiator-name");
-            if (name) {
-                return g_strdup(name);
-            }
+    if (iscsiopts) {
+        name = qemu_opt_get(iscsiopts, "initiator-name");
+        if (name) {
+            return g_strdup(name);
         }
     }
 
@@ -1360,23 +1329,14 @@ static char *parse_initiator_name(const char *target)
     return iscsi_name;
 }
 
-static int parse_timeout(const char *target)
+static int parse_timeout(QemuOpts *iscsiopts)
 {
-    QemuOptsList *list;
-    QemuOpts *opts;
     const char *timeout;
 
-    list = qemu_find_opts("iscsi");
-    if (list) {
-        opts = qemu_opts_find(list, target);
-        if (!opts) {
-            opts = QTAILQ_FIRST(&list->head);
-        }
-        if (opts) {
-            timeout = qemu_opt_get(opts, "timeout");
-            if (timeout) {
-                return atoi(timeout);
-            }
+    if (iscsiopts) {
+        timeout = qemu_opt_get(iscsiopts, "timeout");
+        if (timeout) {
+            return atoi(timeout);
         }
     }
 
@@ -1600,6 +1560,28 @@ out:
     }
 }
 
+static QemuOpts *find_iscsi_opts(const char *target)
+{
+    QemuOptsList *list;
+    QemuOpts *opts;
+
+    list = qemu_find_opts("iscsi");
+    if (!list) {
+        return NULL;
+    }
+
+    opts = qemu_opts_find(list, target);
+    if (opts == NULL) {
+        opts = QTAILQ_FIRST(&list->head);
+        if (!opts) {
+            return NULL;
+        }
+    }
+
+    return opts;
+}
+
+
 /*
  * We support iscsi url's on the form
  * iscsi://[<username>%<password>@]<host>[:<port>]/<targetname>/<lun>
@@ -1614,7 +1596,7 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
     struct scsi_inquiry_standard *inq = NULL;
     struct scsi_inquiry_supported_pages *inq_vpd;
     char *initiator_name = NULL;
-    QemuOpts *opts;
+    QemuOpts *opts, *iscsiopts;
     Error *local_err = NULL;
     const char *filename;
     int i, ret = 0, timeout = 0;
@@ -1636,9 +1618,11 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
         goto out;
     }
 
+    iscsiopts = find_iscsi_opts(iscsi_url->target);
+
     memset(iscsilun, 0, sizeof(IscsiLun));
 
-    initiator_name = parse_initiator_name(iscsi_url->target);
+    initiator_name = parse_initiator_name(iscsiopts);
 
     iscsi = iscsi_create_context(initiator_name);
     if (iscsi == NULL) {
@@ -1670,7 +1654,7 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     /* check if we got CHAP username/password via the options */
-    parse_chap(iscsi, iscsi_url->target, &local_err);
+    parse_chap(iscsiopts, iscsi, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         ret = -EINVAL;
@@ -1686,7 +1670,7 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
     iscsi_set_header_digest(iscsi, ISCSI_HEADER_DIGEST_NONE_CRC32C);
 
     /* check if we got HEADER_DIGEST via the options */
-    parse_header_digest(iscsi, iscsi_url->target, &local_err);
+    parse_header_digest(iscsiopts, iscsi, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         ret = -EINVAL;
@@ -1694,7 +1678,7 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     /* timeout handling is broken in libiscsi before 1.15.0 */
-    timeout = parse_timeout(iscsi_url->target);
+    timeout = parse_timeout(iscsiopts);
 #if LIBISCSI_API_VERSION >= 20150621
     iscsi_set_timeout(iscsi, timeout);
 #else
-- 
2.9.3
