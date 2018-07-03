Received: from eggs.gnu.org ([2001:4830:134:3::10]:53175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faH4b-0001W7-WF
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:54:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faH4W-0007Ef-7o
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:54:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51088 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faH4W-0007EH-3C
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:54:04 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  3 Jul 2018 10:53:47 +0200
Message-Id: <20180703085358.13941-22-armbru@redhat.com>
In-Reply-To: <20180703085358.13941-1-armbru@redhat.com>
References: <20180703085358.13941-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 21/32] qobject: New qdict_from_jsonf_nofail()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, eblake@redhat.com, stefanha@redhat.com, dgilbert@redhat.com, mdroth@linux.vnet.ibm.com

Many uses of qobject_from_jsonf() convert JSON objects.  Create new
convenience function qdict_from_jsonf_nofail() that includes the
conversion to QDict.  The next few commits will put it to use.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
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
