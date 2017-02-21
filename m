Received: from eggs.gnu.org ([2001:4830:134:3::10]:55203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cgCYu-0005te-MG
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:41:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cgCYt-0004MW-Mx
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:41:08 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 21 Feb 2017 10:40:51 -0500
Message-Id: <20170221154057.20313-4-jcody@redhat.com>
In-Reply-To: <20170221154057.20313-1-jcody@redhat.com>
References: <20170221154057.20313-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 3/9] iscsi: Add initiator-name option
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
 block/iscsi.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index ec26fc6..6db5615 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -1321,26 +1321,15 @@ static void parse_header_digest(struct iscsi_context *iscsi, const char *target,
     }
 }
 
-static char *parse_initiator_name(const char *target)
+static char *get_initiator_name(QemuOpts *opts)
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
-        }
+    name = qemu_opt_get(opts, "initiator-name");
+    if (name) {
+        return g_strdup(name);
     }
 
     uuid_info = qmp_query_uuid(NULL);
@@ -1589,7 +1578,7 @@ static void iscsi_parse_iscsi_option(const char *target, QDict *options)
 {
     QemuOptsList *list;
     QemuOpts *opts;
-    const char *user, *password, *password_secret;
+    const char *user, *password, *password_secret, *initiator_name;
 
     list = qemu_find_opts("iscsi");
     if (!list) {
@@ -1618,6 +1607,11 @@ static void iscsi_parse_iscsi_option(const char *target, QDict *options)
     if (password_secret) {
         qdict_set_default_str(options, "password-secret", password_secret);
     }
+
+    initiator_name = qemu_opt_get(opts, "initiator-name");
+    if (initiator_name) {
+        qdict_set_default_str(options, "initiator-name", initiator_name);
+    }
 }
 
 /*
@@ -1706,6 +1700,10 @@ static QemuOptsList runtime_opts = {
             .name = "lun",
             .type = QEMU_OPT_NUMBER,
         },
+        {
+            .name = "initiator-name",
+            .type = QEMU_OPT_STRING,
+        },
         { /* end of list */ }
     },
 };
@@ -1762,7 +1760,7 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
 
     memset(iscsilun, 0, sizeof(IscsiLun));
 
-    initiator_name = parse_initiator_name(target);
+    initiator_name = get_initiator_name(opts);
 
     iscsi = iscsi_create_context(initiator_name);
     if (iscsi == NULL) {
-- 
2.9.3
