Received: from eggs.gnu.org ([2001:4830:134:3::10]:48186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cbrsk-0003lU-LE
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 11:47:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cbrsj-0003Fu-MZ
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 11:47:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39004)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cbrsj-0003FN-Hf
	for qemu-devel@nongnu.org; Thu, 09 Feb 2017 11:47:41 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0935043A3C
	for <qemu-devel@nongnu.org>; Thu,  9 Feb 2017 16:47:40 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu,  9 Feb 2017 17:47:21 +0100
Message-Id: <1486658842-7143-10-git-send-email-kraxel@redhat.com>
In-Reply-To: <1486658842-7143-1-git-send-email-kraxel@redhat.com>
References: <1486658842-7143-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL v2 09/10] util: add iterators for QemuOpts values
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

To iterate over all QemuOpts currently requires using a callback
function which is inconvenient for control flow. Add support for
using iterator functions more directly

  QemuOptsIter iter;
  QemuOpt *opt;

  qemu_opts_iter_init(&iter, opts, "repeated-key");
  while ((opt = qemu_opts_iter_next(&iter)) != NULL) {
      ....do something...
  }

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-id: 20170203120649.15637-8-berrange@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 include/qemu/option.h |  9 +++++++++
 util/qemu-option.c    | 19 +++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/qemu/option.h b/include/qemu/option.h
index 1f9e3f9..e786df0 100644
--- a/include/qemu/option.h
+++ b/include/qemu/option.h
@@ -100,6 +100,15 @@ typedef int (*qemu_opt_loopfunc)(void *opaque,
 int qemu_opt_foreach(QemuOpts *opts, qemu_opt_loopfunc func, void *opaque,
                      Error **errp);
 
+typedef struct {
+    QemuOpts *opts;
+    QemuOpt *opt;
+    const char *name;
+} QemuOptsIter;
+
+void qemu_opt_iter_init(QemuOptsIter *iter, QemuOpts *opts, const char *name);
+const char *qemu_opt_iter_next(QemuOptsIter *iter);
+
 QemuOpts *qemu_opts_find(QemuOptsList *list, const char *id);
 QemuOpts *qemu_opts_create(QemuOptsList *list, const char *id,
                            int fail_if_exists, Error **errp);
diff --git a/util/qemu-option.c b/util/qemu-option.c
index 3467dc2..d611946 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -332,6 +332,25 @@ const char *qemu_opt_get(QemuOpts *opts, const char *name)
     return opt ? opt->str : NULL;
 }
 
+void qemu_opt_iter_init(QemuOptsIter *iter, QemuOpts *opts, const char *name)
+{
+    iter->opts = opts;
+    iter->opt = QTAILQ_FIRST(&opts->head);
+    iter->name = name;
+}
+
+const char *qemu_opt_iter_next(QemuOptsIter *iter)
+{
+    QemuOpt *ret = iter->opt;
+    if (iter->name) {
+        while (ret && !g_str_equal(iter->name, ret->name)) {
+            ret = QTAILQ_NEXT(ret, next);
+        }
+    }
+    iter->opt = ret ? QTAILQ_NEXT(ret, next) : NULL;
+    return ret ? ret->str : NULL;
+}
+
 /* Get a known option (or its default) and remove it from the list
  * all in one action. Return a malloced string of the option value.
  * Result must be freed by caller with g_free().
-- 
1.8.3.1
