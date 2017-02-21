Received: from eggs.gnu.org ([2001:4830:134:3::10]:55224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cgCYv-0005ty-32
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:41:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cgCYt-0004Mm-Up
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:41:09 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 21 Feb 2017 10:40:52 -0500
Message-Id: <20170221154057.20313-5-jcody@redhat.com>
In-Reply-To: <20170221154057.20313-1-jcody@redhat.com>
References: <20170221154057.20313-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 4/9] iscsi: Add header-digest option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com

From: Kevin Wolf <kwolf@redhat.com>

This was previously only available with -iscsi. Again, after this patch,
the -iscsi option only takes effect if an URL is given. New users are
supposed to use the new driver-specific option.

Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 block/iscsi.c | 39 +++++++++++++++------------------------
 1 file changed, 15 insertions(+), 24 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 6db5615..11bbb93 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -1283,32 +1283,15 @@ static void apply_chap(struct iscsi_context *iscsi, QemuOpts *opts,
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
@@ -1578,7 +1561,8 @@ static void iscsi_parse_iscsi_option(const char *target, QDict *options)
 {
     QemuOptsList *list;
     QemuOpts *opts;
-    const char *user, *password, *password_secret, *initiator_name;
+    const char *user, *password, *password_secret, *initiator_name,
+               *header_digest;
 
     list = qemu_find_opts("iscsi");
     if (!list) {
@@ -1612,6 +1596,11 @@ static void iscsi_parse_iscsi_option(const char *target, QDict *options)
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
@@ -1704,6 +1693,10 @@ static QemuOptsList runtime_opts = {
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
@@ -1795,10 +1788,8 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
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
2.9.3
