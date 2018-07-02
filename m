Received: from eggs.gnu.org ([2001:4830:134:3::10]:42599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fa1au-0004SY-Cg
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:22:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fa1as-0006g2-0e
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:22:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54118 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fa1ar-0006e6-Ic
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:22:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BAE95402316D
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 16:22:24 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Jul 2018 18:22:07 +0200
Message-Id: <20180702162218.13678-22-armbru@redhat.com>
In-Reply-To: <20180702162218.13678-1-armbru@redhat.com>
References: <20180702162218.13678-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 21/32] qobject: New qdict_from_jsonf_nofail()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, eblake@redhat.com, stefanha@redhat.com, dgilbert@redhat.com

Many uses of qobject_from_jsonf() convert JSON objects.  Create new
convenience function qdict_from_jsonf_nofail() that includes the
conversion to QDict.  The next few commits will put it to use.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/qmp/qjson.h |  2 ++
 qobject/qjson.c          | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/include/qapi/qmp/qjson.h b/include/qapi/qmp/qjson.h
index b274ac3a86..43b2ce2f33 100644
--- a/include/qapi/qmp/qjson.h
+++ b/include/qapi/qmp/qjson.h
@@ -19,6 +19,8 @@ QObject *qobject_from_jsonf(const char *string, ...) GCC_FMT_ATTR(1, 2);
 QObject *qobject_from_jsonv(const char *string, va_list *ap, Error **errp)
     GCC_FMT_ATTR(1, 0);
 
+QDict *qdict_from_jsonf_nofail(const char *string, ...) GCC_FMT_ATTR(1, 2);
+
 QString *qobject_to_json(const QObject *obj);
 QString *qobject_to_json_pretty(const QObject *obj);
 
diff --git a/qobject/qjson.c b/qobject/qjson.c
index 9816a65c7d..0df3120202 100644
--- a/qobject/qjson.c
+++ b/qobject/qjson.c
@@ -76,6 +76,24 @@ QObject *qobject_from_jsonf(const char *string, ...)
     return obj;
 }
 
+/*
+ * Parse @string as JSON object with %-escapes interpolated.
+ * Abort on error.  Do not use with untrusted @string.
+ * Return the resulting QDict.  It is never null.
+ */
+QDict *qdict_from_jsonf_nofail(const char *string, ...)
+{
+    QDict *obj;
+    va_list ap;
+
+    va_start(ap, string);
+    obj = qobject_to(QDict, qobject_from_jsonv(string, &ap, &error_abort));
+    va_end(ap);
+
+    assert(obj);
+    return obj;
+}
+
 typedef struct ToJsonIterState
 {
     int indent;
-- 
2.17.1
