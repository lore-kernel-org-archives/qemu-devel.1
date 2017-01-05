Received: from eggs.gnu.org ([2001:4830:134:3::10]:40914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPAZd-0000tZ-1V
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:07:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPAZZ-0001F3-3d
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:07:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPAZY-0001Ek-U4
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 11:07:25 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2FB4B8050D
	for <qemu-devel@nongnu.org>; Thu,  5 Jan 2017 16:07:25 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu,  5 Jan 2017 16:07:00 +0000
Message-Id: <20170105160701.22118-8-berrange@redhat.com>
In-Reply-To: <20170105160701.22118-1-berrange@redhat.com>
References: <20170105160701.22118-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH 7/8] util: add qemu_opt_get_all() to get
 repeated opts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The QemuOpts parser accepts repeated option names, storing
all the provided values. qemu_opt_get() then just returns
the last value. There is no way to get the other values
without using a callback function to iterate over all
option names. Add a qemu_opt_get_all() method to return
a string list of all values.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 include/qemu/option.h |  1 +
 util/qemu-option.c    | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/qemu/option.h b/include/qemu/option.h
index 1f9e3f9..689e0a8 100644
--- a/include/qemu/option.h
+++ b/include/qemu/option.h
@@ -65,6 +65,7 @@ struct QemuOptsList {
 };
 
 const char *qemu_opt_get(QemuOpts *opts, const char *name);
+size_t qemu_opt_get_all(QemuOpts *opts, const char *name, char ***vals);
 char *qemu_opt_get_del(QemuOpts *opts, const char *name);
 /**
  * qemu_opt_has_help_opt:
diff --git a/util/qemu-option.c b/util/qemu-option.c
index 3467dc2..0418d71 100644
--- a/util/qemu-option.c
+++ b/util/qemu-option.c
@@ -332,6 +332,28 @@ const char *qemu_opt_get(QemuOpts *opts, const char *name)
     return opt ? opt->str : NULL;
 }
 
+size_t qemu_opt_get_all(QemuOpts *opts, const char *name, char ***vals)
+{
+    QemuOpt *opt;
+    size_t nvals = 0;
+
+    *vals = NULL;
+
+    QTAILQ_FOREACH(opt, &opts->head, next) {
+        if (!g_str_equal(opt->name, name)) {
+            continue;
+        }
+
+        *vals = g_renew(char *, *vals, nvals + 1);
+        (*vals)[nvals++] = g_strdup(opt->str);
+    }
+    if (nvals) {
+        *vals = g_renew(char *, *vals, nvals + 1);
+        (*vals)[nvals] = NULL;
+    }
+    return nvals;
+}
+
 /* Get a known option (or its default) and remove it from the list
  * all in one action. Return a malloced string of the option value.
  * Result must be freed by caller with g_free().
-- 
2.9.3
