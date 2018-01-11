Received: from eggs.gnu.org ([2001:4830:134:3::10]:58177)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eZiv2-0005jA-CE
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:53:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eZiv1-0000tb-EE
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:53:44 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 11 Jan 2018 20:52:23 +0100
Message-Id: <20180111195225.4226-9-kwolf@redhat.com>
In-Reply-To: <20180111195225.4226-1-kwolf@redhat.com>
References: <20180111195225.4226-1-kwolf@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 08/10] util: Add
 qemu_opts_to_qdict_filtered()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, pkrempa@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

This allows, given a QemuOpts for a QemuOptsList that was merged from
multiple QemuOptsList, to only consider those options that exist in one
specific list. Block drivers need this to separate format-layer create
options from protocol-level options.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/qemu/option.h |  2 ++
 util/qemu-option.c    | 28 +++++++++++++++++++++++++---
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/include/qemu/option.h b/include/qemu/option.h
index a88c5f02b1..197f80e79d 100644
--- a/include/qemu/option.h
+++ b/include/qemu/option.h
@@ -125,6 +125,8 @@ void qemu_opts_set_defaults(QemuOptsList *list, const char *params,
                             int permit_abbrev);
 QemuOpts *qemu_opts_from_qdict(QemuOptsList *list, const QDict *qdict,
                                Error **errp);
+QDict *qemu_opts_to_qdict_filtered(QemuOpts *opts, QDict *qdict,
+                                   QemuOptsList *list, bool del);
 QDict *qemu_opts_to_qdict(QemuOpts *opts, QDict *qdict);
 void qemu_opts_absorb_qdict(QemuOpts *opts, QDict *qdict, Error **errp);
 
diff --git a/util/qemu-option.c b/util/qemu-option.c
index 553d3dc552..76dc5bedf8 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -1009,9 +1009,10 @@ void qemu_opts_absorb_qdict(QemuOpts *opts, QDict *qdict, Error **errp)
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
@@ -1019,12 +1020,33 @@ QDict *qemu_opts_to_qdict(QemuOpts *opts, QDict *qdict)
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
+            qemu_opt_del_all(opts, opt->name);
+        }
     }
     return qdict;
 }
 
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
