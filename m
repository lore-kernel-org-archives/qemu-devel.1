Received: from eggs.gnu.org ([2001:4830:134:3::10]:59894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEyfl-0005jp-Is
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 08:23:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cEyff-00035L-T3
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 08:23:41 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu,  8 Dec 2016 14:23:10 +0100
Message-Id: <1481203391-9523-6-git-send-email-kwolf@redhat.com>
In-Reply-To: <1481203391-9523-1-git-send-email-kwolf@redhat.com>
References: <1481203391-9523-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 5/6] iscsi: Add timeout option
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

All -iscsi options have a corresponding driver-specific option for the
iscsi block driver now.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/iscsi.c | 37 +++++++++++--------------------------
 1 file changed, 11 insertions(+), 26 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index f993b19..29191f2 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -1317,29 +1317,6 @@ static char *get_initiator_name(QemuOpts *opts)
     return iscsi_name;
 }
 
-static int parse_timeout(const char *target)
-{
-    QemuOptsList *list;
-    QemuOpts *opts;
-    const char *timeout;
-
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
-        }
-    }
-
-    return 0;
-}
-
 static void iscsi_nop_timed_event(void *opaque)
 {
     IscsiLun *iscsilun = opaque;
@@ -1547,7 +1524,7 @@ static void iscsi_parse_iscsi_option(const char *target, QDict *options)
 {
     QemuOptsList *list;
     QemuOpts *opts;
-    const char *user, *initiator_name, *header_digest;
+    const char *user, *initiator_name, *header_digest, *timeout;
 
     list = qemu_find_opts("iscsi");
     if (!list) {
@@ -1580,6 +1557,11 @@ static void iscsi_parse_iscsi_option(const char *target, QDict *options)
     if (header_digest) {
         qdict_set_default_str(options, "header-digest", header_digest);
     }
+
+    timeout = qemu_opt_get(opts, "timeout");
+    if (timeout) {
+        qdict_set_default_str(options, "timeout", timeout);
+    }
 }
 
 /*
@@ -1631,7 +1613,6 @@ static void iscsi_parse_filename(const char *filename, QDict *options,
     iscsi_destroy_url(iscsi_url);
 }
 
-/* TODO Add -iscsi options */
 static QemuOptsList runtime_opts = {
     .name = "iscsi",
     .head = QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
@@ -1672,6 +1653,10 @@ static QemuOptsList runtime_opts = {
             .name = "header-digest",
             .type = QEMU_OPT_STRING,
         },
+        {
+            .name = "timeout",
+            .type = QEMU_OPT_NUMBER,
+        },
         { /* end of list */ }
     },
 };
@@ -1772,7 +1757,7 @@ static int iscsi_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     /* timeout handling is broken in libiscsi before 1.15.0 */
-    timeout = parse_timeout(target);
+    timeout = qemu_opt_get_number(opts, "timeout", 0);
 #if LIBISCSI_API_VERSION >= 20150621
     iscsi_set_timeout(iscsi, timeout);
 #else
-- 
1.8.3.1
