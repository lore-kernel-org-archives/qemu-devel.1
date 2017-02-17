Received: from eggs.gnu.org ([2001:4830:134:3::10]:58978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cepIU-0002YY-Px
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:38:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cepIS-0004Ol-5s
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:38:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cepIR-0004OB-WC
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:38:28 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0D640C04B924
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 20:38:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1HKcQB5019357
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 15:38:27 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 17 Feb 2017 21:38:12 +0100
Message-Id: <1487363905-9480-2-git-send-email-armbru@redhat.com>
In-Reply-To: <1487363905-9480-1-git-send-email-armbru@redhat.com>
References: <1487363905-9480-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 01/14] qdict: Make qdict_get_qlist() safe like
 qdict_get_qdict()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Commit 89cad9f changed qdict_get_qdict() to return NULL instead of
crash when the key doesn't exist or its value isn't a QDict.
Commit 2d6421a neglected to do the same for qdict_get_qlist().
Correct that, and update the function comments.

qdict_get_obj() is now unused, remove.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qobject/qdict.c | 30 +++---------------------------
 1 file changed, 3 insertions(+), 27 deletions(-)

diff --git a/qobject/qdict.c b/qobject/qdict.c
index 197b0fb..b0c5364 100644
--- a/qobject/qdict.c
+++ b/qobject/qdict.c
@@ -178,20 +178,6 @@ size_t qdict_size(const QDict *qdict)
 }
 
 /**
- * qdict_get_obj(): Get a QObject of a specific type
- */
-static QObject *qdict_get_obj(const QDict *qdict, const char *key, QType type)
-{
-    QObject *obj;
-
-    obj = qdict_get(qdict, key);
-    assert(obj != NULL);
-    assert(qobject_type(obj) == type);
-
-    return obj;
-}
-
-/**
  * qdict_get_double(): Get an number mapped by 'key'
  *
  * This function assumes that 'key' exists and it stores a
@@ -241,25 +227,15 @@ bool qdict_get_bool(const QDict *qdict, const char *key)
 }
 
 /**
- * qdict_get_qlist(): Get the QList mapped by 'key'
- *
- * This function assumes that 'key' exists and it stores a
- * QList object.
- *
- * Return QList mapped by 'key'.
+ * qdict_get_qlist(): If @qdict maps @key to a QList, return it, else NULL.
  */
 QList *qdict_get_qlist(const QDict *qdict, const char *key)
 {
-    return qobject_to_qlist(qdict_get_obj(qdict, key, QTYPE_QLIST));
+    return qobject_to_qlist(qdict_get(qdict, key));
 }
 
 /**
- * qdict_get_qdict(): Get the QDict mapped by 'key'
- *
- * This function assumes that 'key' exists and it stores a
- * QDict object.
- *
- * Return QDict mapped by 'key'.
+ * qdict_get_qdict(): If @qdict maps @key to a QDict, return it, else NULL.
  */
 QDict *qdict_get_qdict(const QDict *qdict, const char *key)
 {
-- 
2.7.4
