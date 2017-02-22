Received: from eggs.gnu.org ([2001:4830:134:3::10]:40568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgcNU-0004d0-Cg
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 14:15:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cgcNR-0000dW-Ao
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 14:15:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cgcNR-0000cw-32
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 14:15:01 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3F3342E6060
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 19:15:01 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-55.ams2.redhat.com
	[10.36.116.55])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0945A7FE77
	for <qemu-devel@nongnu.org>; Wed, 22 Feb 2017 19:15:00 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Wed, 22 Feb 2017 20:14:45 +0100
Message-Id: <1487790898-24921-4-git-send-email-armbru@redhat.com>
In-Reply-To: <1487790898-24921-1-git-send-email-armbru@redhat.com>
References: <1487790898-24921-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 03/16] qdict: Make qdict_get_qlist() safe like
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
Message-Id: <1487363905-9480-2-git-send-email-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
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
