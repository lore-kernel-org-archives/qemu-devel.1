Received: from eggs.gnu.org ([2001:4830:134:3::10]:33706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKl3-0001Aw-NF
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKl2-00071W-2x
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:37 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 17:19:00 +0100
Message-Id: <20180309161933.8168-24-kwolf@redhat.com>
In-Reply-To: <20180309161933.8168-1-kwolf@redhat.com>
References: <20180309161933.8168-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 23/56] util: Add qemu_opts_to_qdict_filtered()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

This allows, given a QemuOpts for a QemuOptsList that was merged from
multiple QemuOptsList, to only consider those options that exist in one
specific list. Block drivers need this to separate format-layer create
options from protocol-level options.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 include/qemu/option.h |  2 ++
 util/qemu-option.c    | 42 +++++++++++++++++++++++++++++++++++++-----
 2 files changed, 39 insertions(+), 5 deletions(-)

diff --git a/include/qemu/option.h b/include/qemu/option.h
index b127fb6db6..306fdb5f7a 100644
--- a/include/qemu/option.h
+++ b/include/qemu/option.h
@@ -124,6 +124,8 @@ void qemu_opts_set_defaults(QemuOptsList *list, const char *params,
                             int permit_abbrev);
 QemuOpts *qemu_opts_from_qdict(QemuOptsList *list, const QDict *qdict,
                                Error **errp);
+QDict *qemu_opts_to_qdict_filtered(QemuOpts *opts, QDict *qdict,
+                                   QemuOptsList *list, bool del);
 QDict *qemu_opts_to_qdict(QemuOpts *opts, QDict *qdict);
 void qemu_opts_absorb_qdict(QemuOpts *opts, QDict *qdict, Error **errp);
 
diff --git a/util/qemu-option.c b/util/qemu-option.c
index a401e936da..2b412eff5e 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -1007,14 +1007,23 @@ void qemu_opts_absorb_qdict(QemuOpts *opts, QDict *qdict, Error **errp)
 }
 
 /*
- * Convert from QemuOpts to QDict.
- * The QDict values are of type QString.
+ * Convert from QemuOpts to QDict. The QDict values are of type QString.
+ *
+ * If @list is given, only add those options to the QDict that are contained in
+ * the list. If @del is true, any options added to the QDict are removed from
+ * the QemuOpts, otherwise they remain there.
+ *
+ * If two options in @opts have the same name, they are processed in order
+ * so that the last one wins (consistent with the reverse iteration in
+ * qemu_opt_find()), but all of them are deleted if @del is true.
+ *
  * TODO We'll want to use types appropriate for opt->desc->type, but
  * this is enough for now.
  */
-QDict *qemu_opts_to_qdict(QemuOpts *opts, QDict *qdict)
+QDict *qemu_opts_to_qdict_filtered(QemuOpts *opts, QDict *qdict,
+                                   QemuOptsList *list, bool del)
 {
-    QemuOpt *opt;
+    QemuOpt *opt, *next;
 
     if (!qdict) {
         qdict = qdict_new();
@@ -1022,12 +1031,35 @@ QDict *qemu_opts_to_qdict(QemuOpts *opts, QDict *qdict)
     if (opts->id) {
         qdict_put_str(qdict, "id", opts->id);
     }
-    QTAILQ_FOREACH(opt, &opts->head, next) {
+    QTAILQ_FOREACH_SAFE(opt, &opts->head, next, next) {
+        if (list) {
+            QemuOptDesc *desc;
+            bool found = false;
+            for (desc = list->desc; desc->name; desc++) {
+                if (!strcmp(desc->name, opt->name)) {
+                    found = true;
+                    break;
+                }
+            }
+            if (!found) {
+                continue;
+            }
+        }
         qdict_put_str(qdict, opt->name, opt->str);
+        if (del) {
+            qemu_opt_del(opt);
+        }
     }
     return qdict;
 }
 
+/* Copy all options in a QemuOpts to the given QDict. See
+ * qemu_opts_to_qdict_filtered() for details. */
+QDict *qemu_opts_to_qdict(QemuOpts *opts, QDict *qdict)
+{
+    return qemu_opts_to_qdict_filtered(opts, qdict, NULL, false);
+}
+
 /* Validate parsed opts against descriptions where no
  * descriptions were provided in the QemuOptsList.
  */
-- 
2.13.6
