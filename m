Received: from eggs.gnu.org ([209.51.188.92]:54731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHE0d-0005CB-2L
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hHE0V-0005Hy-Q6
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52866)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hHE0V-0005Ev-9p
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 16:51:43 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 27E27C066474
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 20:51:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-116.ams2.redhat.com
	[10.36.116.116])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id EA84760148
	for <qemu-devel@nongnu.org>; Thu, 18 Apr 2019 20:51:41 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Thu, 18 Apr 2019 22:51:31 +0200
Message-Id: <20190418205135.6686-33-armbru@redhat.com>
In-Reply-To: <20190418205135.6686-1-armbru@redhat.com>
References: <20190418205135.6686-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL for-4.1 32/36] qemu-print: New qemu_fprintf(),
 qemu_vfprintf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Code that doesn't want to know about current monitor vs. stdout
vs. stderr takes an fprintf_function callback and a FILE * argument to
pass to it.  Actual arguments are either fprintf() and stdout or
stderr, or monitor_fprintf() and the current monitor cast to FILE *.
monitor_fprintf() casts it right back, and is otherwise identical to
monitor_printf().  The type-punning is ugly.

New qemu_fprintf() and qemu_vprintf() address this need without type
punning: they are like fprintf() and vfprintf(), except they print to
the current monitor when passed a null FILE *.  The next commits will
put them to use.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Message-Id: <20190417191805.28198-14-armbru@redhat.com>
---
 include/qemu/qemu-print.h |  4 ++++
 util/qemu-print.c         | 27 +++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/qemu/qemu-print.h b/include/qemu/qemu-print.h
index 8fed32bf42..40b596262f 100644
--- a/include/qemu/qemu-print.h
+++ b/include/qemu/qemu-print.h
@@ -16,4 +16,8 @@
 int qemu_vprintf(const char *fmt, va_list ap) GCC_FMT_ATTR(1, 0);
 int qemu_printf(const char *fmt, ...) GCC_FMT_ATTR(1, 2);
 
+int qemu_vfprintf(FILE *stream, const char *fmt, va_list ap)
+    GCC_FMT_ATTR(2, 0);
+int qemu_fprintf(FILE *stream, const char *fmt, ...) GCC_FMT_ATTR(2, 3);
+
 #endif
diff --git a/util/qemu-print.c b/util/qemu-print.c
index 86f9417af8..e79d6b8396 100644
--- a/util/qemu-print.c
+++ b/util/qemu-print.c
@@ -40,3 +40,30 @@ int qemu_printf(const char *fmt, ...)
     va_end(ap);
     return ret;
 }
+
+/*
+ * Print like vfprintf()
+ * Print to @stream if non-null, else to current monitor.
+ */
+int qemu_vfprintf(FILE *stream, const char *fmt, va_list ap)
+{
+    if (!stream) {
+        return monitor_vprintf(cur_mon, fmt, ap);
+    }
+    return vfprintf(stream, fmt, ap);
+}
+
+/*
+ * Print like fprintf().
+ * Print to @stream if non-null, else to current monitor.
+ */
+int qemu_fprintf(FILE *stream, const char *fmt, ...)
+{
+    va_list ap;
+    int ret;
+
+    va_start(ap, fmt);
+    ret = qemu_vfprintf(stream, fmt, ap);
+    va_end(ap);
+    return ret;
+}
-- 
2.17.2
