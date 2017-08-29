Received: from eggs.gnu.org ([2001:4830:134:3::10]:47419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUC8-0000rC-B8
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:15:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUC5-00056t-4n
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:15:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60523
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUC4-00056H-N8
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:15:48 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0E7Yu043799
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:15:48 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cmu3kpdsm-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:15:48 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 18:15:47 -0600
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:13:51 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-17-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 16/79] qobject: Add helper macros for common
 scalar insertions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

From: Eric Blake <eblake@redhat.com>

Rather than making lots of callers wrap a scalar in a QInt, QString,
or QBool, provide helper macros that do the wrapping automatically.

Update the Coccinelle script to make mass conversions easy, although
the conversion itself will be done as a separate patches to ease
review and backport efforts.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20170427215821.19397-6-eblake@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
(cherry picked from commit a92c21591b5bb9543996538f14854ca6b528318b)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 include/qapi/qmp/qdict.h         |  8 ++++++++
 include/qapi/qmp/qlist.h         |  8 ++++++++
 scripts/coccinelle/qobject.cocci | 22 ++++++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/include/qapi/qmp/qdict.h b/include/qapi/qmp/qdict.h
index fe9a4c5..188440a 100644
--- a/include/qapi/qmp/qdict.h
+++ b/include/qapi/qmp/qdict.h
@@ -52,6 +52,14 @@ void qdict_destroy_obj(QObject *obj);
 #define qdict_put(qdict, key, obj) \
         qdict_put_obj(qdict, key, QOBJECT(obj))
 
+/* Helpers for int, bool, and string */
+#define qdict_put_int(qdict, key, value) \
+        qdict_put(qdict, key, qint_from_int(value))
+#define qdict_put_bool(qdict, key, value) \
+        qdict_put(qdict, key, qbool_from_bool(value))
+#define qdict_put_str(qdict, key, value) \
+        qdict_put(qdict, key, qstring_from_str(value))
+
 /* High level helpers */
 double qdict_get_double(const QDict *qdict, const char *key);
 int64_t qdict_get_int(const QDict *qdict, const char *key);
diff --git a/include/qapi/qmp/qlist.h b/include/qapi/qmp/qlist.h
index a84117e..5dc4ed9 100644
--- a/include/qapi/qmp/qlist.h
+++ b/include/qapi/qmp/qlist.h
@@ -29,6 +29,14 @@ typedef struct QList {
 #define qlist_append(qlist, obj) \
         qlist_append_obj(qlist, QOBJECT(obj))
 
+/* Helpers for int, bool, and string */
+#define qlist_append_int(qlist, value) \
+        qlist_append(qlist, qint_from_int(value))
+#define qlist_append_bool(qlist, value) \
+        qlist_append(qlist, qbool_from_bool(value))
+#define qlist_append_str(qlist, value) \
+        qlist_append(qlist, qstring_from_str(value))
+
 #define QLIST_FOREACH_ENTRY(qlist, var)             \
         for ((var) = ((qlist)->head.tqh_first);     \
             (var);                                  \
diff --git a/scripts/coccinelle/qobject.cocci b/scripts/coccinelle/qobject.cocci
index aa899e2..97703a4 100644
--- a/scripts/coccinelle/qobject.cocci
+++ b/scripts/coccinelle/qobject.cocci
@@ -2,12 +2,34 @@
 @@
 expression Obj, Key, E;
 @@
+(
 - qdict_put_obj(Obj, Key, QOBJECT(E));
 + qdict_put(Obj, Key, E);
+|
+- qdict_put(Obj, Key, qint_from_int(E));
++ qdict_put_int(Obj, Key, E);
+|
+- qdict_put(Obj, Key, qbool_from_bool(E));
++ qdict_put_bool(Obj, Key, E);
+|
+- qdict_put(Obj, Key, qstring_from_str(E));
++ qdict_put_str(Obj, Key, E);
+)
 
 // Use QList macros where they make sense
 @@
 expression Obj, E;
 @@
+(
 - qlist_append_obj(Obj, QOBJECT(E));
 + qlist_append(Obj, E);
+|
+- qlist_append(Obj, qint_from_int(E));
++ qlist_append_int(Obj, E);
+|
+- qlist_append(Obj, qbool_from_bool(E));
++ qlist_append_bool(Obj, E);
+|
+- qlist_append(Obj, qstring_from_str(E));
++ qlist_append_str(Obj, E);
+)
-- 
2.7.4
