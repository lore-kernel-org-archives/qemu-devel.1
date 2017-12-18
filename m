Received: from eggs.gnu.org ([2001:4830:134:3::10]:48259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eQwc5-00031n-VM
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:41:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eQwc1-0002oI-2B
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:41:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1eQwc0-0002n2-SE
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:41:48 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EDBF84A706
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 14:41:47 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Mon, 18 Dec 2017 22:41:45 +0800
Message-Id: <20171218144145.13579-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC] error: Include hint everywhere
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

Previously we only print hint lines if we are in a command line context
or HMP. However QMP errors are also eventually consumed by human and the
hint could help.

Append hint lines already in error_get_pretty() and do as said above
consistently in CLI, HMP and QMP.

Signed-off-by: Fam Zheng <famz@redhat.com>

---

We could drop Error.hint because now it's is unused outside of
error_append_hint, but I tend to see Error.pretty as a cache and 'hint'
is the authentic data.
---
 util/error.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/util/error.c b/util/error.c
index 3efdd69162..f42ae248b4 100644
--- a/util/error.c
+++ b/util/error.c
@@ -24,6 +24,7 @@ struct Error
     const char *src, *func;
     int line;
     GString *hint;
+    GString *pretty;
 };
 
 Error *error_abort;
@@ -166,6 +167,11 @@ void error_append_hint(Error **errp, const char *fmt, ...)
     g_string_append_vprintf(err->hint, fmt, ap);
     va_end(ap);
 
+    if (!err->pretty) {
+        err->pretty = g_string_new(NULL);
+    }
+    g_string_printf(err->pretty, "%s\n%s", err->msg, err->hint->str);
+
     errno = saved_errno;
 }
 
@@ -206,8 +212,10 @@ Error *error_copy(const Error *err)
     err_new->src = err->src;
     err_new->line = err->line;
     err_new->func = err->func;
+    assert(!!err->hint == !!err->pretty);
     if (err->hint) {
         err_new->hint = g_string_new(err->hint->str);
+        err_new->pretty = g_string_new(err->pretty->str);
     }
 
     return err_new;
@@ -220,24 +228,24 @@ ErrorClass error_get_class(const Error *err)
 
 const char *error_get_pretty(const Error *err)
 {
-    return err->msg;
+    if (err->pretty) {
+        assert(err->hint);
+        return err->pretty->str;
+    } else {
+        assert(!err->hint);
+        return err->msg;
+    }
 }
 
 void error_report_err(Error *err)
 {
     error_report("%s", error_get_pretty(err));
-    if (err->hint) {
-        error_printf_unless_qmp("%s", err->hint->str);
-    }
     error_free(err);
 }
 
 void warn_report_err(Error *err)
 {
     warn_report("%s", error_get_pretty(err));
-    if (err->hint) {
-        error_printf_unless_qmp("%s", err->hint->str);
-    }
     error_free(err);
 }
 
@@ -268,6 +276,7 @@ void error_free(Error *err)
         g_free(err->msg);
         if (err->hint) {
             g_string_free(err->hint, true);
+            g_string_free(err->pretty, true);
         }
         g_free(err);
     }
-- 
2.14.3
