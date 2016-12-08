Received: from eggs.gnu.org ([2001:4830:134:3::10]:59866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEyfe-0005d2-J6
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 08:23:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEyfd-00034J-Ez
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 08:23:34 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu,  8 Dec 2016 14:23:09 +0100
Message-Id: <1481203391-9523-5-git-send-email-kwolf@redhat.com>
In-Reply-To: <1481203391-9523-1-git-send-email-kwolf@redhat.com>
References: <1481203391-9523-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 4/6] iscsi: Add header-digest option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, berrange@redhat.com, pl@kamp.de, ptoscano@redhat.com, ronniesahlberg@gmail.com, pbonzini@redhat.com, qemu-devel@nongnu.org

This was previously only available with -iscsi. Again, after this patch,
the -iscsi option only takes effect if an URL is given. New users are
supposed to use the new driver-specific option.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/iscsi.c | 38 ++++++++++++++------------------------
 1 file changed, 14 insertions(+), 24 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 7b909e8..f993b19 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -1273,32 +1273,15 @@ static void apply_chap(struct iscsi_context *iscsi, QemuOpts *opts,
     g_free(secret);
 }
 
-static void parse_header_digest(struct iscsi_context *iscsi, const char *target,
+static void apply_header_digest(struct iscsi_context *iscsi, QemuOpts *opts,
                                 Error **errp)
 {
-    QemuOptsList *list;
-    QemuOpts *opts;
     const char *digest = NULL;
 
-    list = qemu_find_opts("iscsi");
-    if (!list) {
-        return;
-    }
-
-    opts = qemu_opts_find(list, target);
-    if (opts == NULL) {
-        opts = QTAILQ_FIRST(&list->head);
-        if (!opts) {
-            return;
-        }
-    }
-
     digest = qemu_opt_get(opts, "header-digest");
     if (!digest) {
-        return;
-    }
-
-    if (!strcmp(digest, "CRC32C")) {
+        iscsi_set_header_digest(iscsi, ISCSI_HEADER_DIGEST_NONE_CRC32C);
+    } else if (!strcmp(digest, "CRC32C")) {
         iscsi_set_header_digest(iscsi, ISCSI_HEADER_DIGEST_CRC32C);
     } else if (!strcmp(digest, "NONE")) {
         iscsi_set_header_digest(iscsi, ISCSI_HEADER_DIGEST_NONE);
@@ -1564,7 +1547,7 @@ static void iscsi_parse_iscsi_option(const char *target, QDict *options)
 {
     QemuOptsList *list;
     QemuOpts *opts;
-    const char *user, *initiator_name;
+    const char *user, *initiator_name, *header_digest;
 
     list = qemu_find_opts("iscsi");
     if (!list) {
@@ -1592,6 +1575,11 @@ static void iscsi_parse_iscsi_option(const char *target, QDict *options)
     if (initiator_name) {
         qdict_set_default_str(options, "initiator-name", initiator_name);
     }
+
+    header_digest = qemu_opt_get(opts, "header-digest");
+    if (header_digest) {
+        qdict_set_default_str(options, "header-digest", header_digest);
+    }
 }
 
 /*
@@ -1680,6 +1668,10 @@ static QemuOptsList runtime_opts = {
             .name = "initiator-name",
             .type = QEMU_OPT_STRING,
         },
+        {
+            .name = "header-digest",
+            .type = QEMU_OPT_STRING,
+        },
         { /* end of list */ }
     },
 };
@@ -1771,10 +1763,8 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
         goto out;
     }
 
-    iscsi_set_header_digest(iscsi, ISCSI_HEADER_DIGEST_NONE_CRC32C);
-
     /* check if we got HEADER_DIGEST via the options */
-    parse_header_digest(iscsi, target, &local_err);
+    apply_header_digest(iscsi, opts, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
         ret = -EINVAL;
-- 
1.8.3.1
