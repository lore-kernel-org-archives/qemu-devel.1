Received: from eggs.gnu.org ([2001:4830:134:3::10]:50336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faSxv-00084S-0l
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:36:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faSxs-0006BD-Oc
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:36:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48964 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faSxs-0006AL-ET
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 17:36:00 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E82977262D
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 21:35:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-126.ams2.redhat.com
	[10.36.116.126])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id C2424111C4A0
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 21:35:59 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  3 Jul 2018 23:35:45 +0200
Message-Id: <20180703213556.20619-22-armbru@redhat.com>
In-Reply-To: <20180703213556.20619-1-armbru@redhat.com>
References: <20180703213556.20619-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL v2 21/32] qobject: New qdict_from_jsonf_nofail()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Many uses of qobject_from_jsonf() convert JSON objects.  Create new
convenience function qdict_from_jsonf_nofail() that includes the
conversion to QDict.  The next few commits will put it to use.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180703085358.13941-22-armbru@redhat.com>
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
