Received: from eggs.gnu.org ([2001:4830:134:3::10]:45885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3rQu-0001NC-02
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 17:58:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3rQr-0003cY-I4
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 17:58:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1d3rQr-0003bO-9B
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 17:58:37 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2E0F0624D9
	for <qemu-devel@nongnu.org>; Thu, 27 Apr 2017 21:58:36 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
Date: Thu, 27 Apr 2017 16:58:16 -0500
Message-Id: <20170427215821.19397-6-eblake@redhat.com>
In-Reply-To: <20170427215821.19397-1-eblake@redhat.com>
References: <20170427215821.19397-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v5 05/10] qobject: Add helper macros for common
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
Cc: armbru@redhat.com

Rather than making lots of callers wrap a scalar in a QInt, QString,
or QBool, provide helper macros that do the wrapping automatically.

Update the Coccinelle script to make mass conversions easy, although
the conversion itself will be done as a separate patches to ease
review and backport efforts.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>

---
v5: minor comment tweak [Markus], add R-b
v4: tweak comment wording
v3: new patch
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
2.9.3
