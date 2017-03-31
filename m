Received: from eggs.gnu.org ([2001:4830:134:3::10]:39128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ctr7M-0001DD-2s
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 03:37:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ctr7I-0006wR-W6
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 03:37:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49554)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ctr7I-0006vk-RA
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 03:37:04 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 31 Mar 2017 15:36:29 +0800
Message-Id: <1490945793-21276-2-git-send-email-peterx@redhat.com>
In-Reply-To: <1490945793-21276-1-git-send-email-peterx@redhat.com>
References: <1490945793-21276-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.10 1/5] QemuOpts: introduce
 qemu_opts_extract()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, Paolo Bonzini <pbonzini@redhat.com>, kevin.tian@intel.com, yi.l.liu@intel.com, Marcel Apfelbaum <marcel@redhat.com>, "\\  Michael S . Tsirkin \\ " <mst@redhat.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>

This helper function is used to extract specific QemuOpts item from an
existing QemuOptsList which matches specific patterns.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/qemu/option.h |  2 ++
 util/qemu-option.c    | 24 ++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/qemu/option.h b/include/qemu/option.h
index f7338db..355cee8 100644
--- a/include/qemu/option.h
+++ b/include/qemu/option.h
@@ -136,6 +136,8 @@ void qemu_opts_absorb_qdict(QemuOpts *opts, QDict *qdict, Error **errp);
 typedef int (*qemu_opts_loopfunc)(void *opaque, QemuOpts *opts, Error **errp);
 int qemu_opts_foreach(QemuOptsList *list, qemu_opts_loopfunc func,
                       void *opaque, Error **errp);
+QemuOpts *qemu_opts_extract(QemuOptsList *list, qemu_opts_loopfunc func,
+                            void *opaque, Error **errp);
 void qemu_opts_print(QemuOpts *opts, const char *sep);
 void qemu_opts_print_help(QemuOptsList *list);
 void qemu_opts_free(QemuOptsList *list);
diff --git a/util/qemu-option.c b/util/qemu-option.c
index 5ce1b5c..7c34d88 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -1121,6 +1121,30 @@ int qemu_opts_foreach(QemuOptsList *list, qemu_opts_loopfunc func,
     return rc;
 }
 
+/*
+ * Extract specific QemuOpts from a QemuOptsList. For each QemuOpts
+ * item, if checks against func() returns zero, it'll be picked out
+ * from current QemuOptsList, then returned. If there are more than
+ * one QemuOpts that match the check, will only return the first one
+ * found.
+ */
+QemuOpts *qemu_opts_extract(QemuOptsList *list, qemu_opts_loopfunc func,
+                            void *opaque, Error **errp)
+{
+    QemuOpts *opts, *next_opts;
+
+    assert(list && func);
+
+    QTAILQ_FOREACH_SAFE(opts, &list->head, next, next_opts) {
+        if (func(opaque, opts, errp) == 0) {
+            QTAILQ_REMOVE(&list->head, opts, next);
+            return opts;
+        }
+    }
+
+    return NULL;
+}
+
 static size_t count_opts_list(QemuOptsList *list)
 {
     QemuOptDesc *desc = NULL;
-- 
2.7.4
