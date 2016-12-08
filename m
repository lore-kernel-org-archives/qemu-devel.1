Received: from eggs.gnu.org ([2001:4830:134:3::10]:59803)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEyfX-0005VH-FV
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 08:23:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEyfW-00030K-IX
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 08:23:27 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu,  8 Dec 2016 14:23:08 +0100
Message-Id: <1481203391-9523-4-git-send-email-kwolf@redhat.com>
In-Reply-To: <1481203391-9523-1-git-send-email-kwolf@redhat.com>
References: <1481203391-9523-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 3/6] iscsi: Add initiator-name option
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
 block/iscsi.c | 32 +++++++++++++++-----------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index c5106c1..7b909e8 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -1311,26 +1311,15 @@ static void parse_header_digest(struct iscsi_context *iscsi, const char *target,
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
@@ -1575,7 +1564,7 @@ static void iscsi_parse_iscsi_option(const char *target, QDict *options)
 {
     QemuOptsList *list;
     QemuOpts *opts;
-    const char *user;
+    const char *user, *initiator_name;
 
     list = qemu_find_opts("iscsi");
     if (!list) {
@@ -1598,6 +1587,11 @@ static void iscsi_parse_iscsi_option(const char *target, QDict *options)
         qdict_set_default_str(options, "password-secret",
                               qemu_opt_get(opts, "password-secret"));
     }
+
+    initiator_name = qemu_opt_get(opts, "initiator-name");
+    if (initiator_name) {
+        qdict_set_default_str(options, "initiator-name", initiator_name);
+    }
 }
 
 /*
@@ -1682,6 +1676,10 @@ static QemuOptsList runtime_opts = {
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
@@ -1738,7 +1736,7 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
 
     memset(iscsilun, 0, sizeof(IscsiLun));
 
-    initiator_name = parse_initiator_name(target);
+    initiator_name = get_initiator_name(opts);
 
     iscsi = iscsi_create_context(initiator_name);
     if (iscsi == NULL) {
-- 
1.8.3.1
