Received: from eggs.gnu.org ([2001:4830:134:3::10]:34493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faNN1-0002PS-TM
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:37:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1faNMy-0005Mg-I2
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:37:35 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38864 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1faNMy-0005LJ-6a
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:37:32 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BD548FA47B
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 15:37:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-126.ams2.redhat.com
	[10.36.116.126])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9AE761C660
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 15:37:31 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue,  3 Jul 2018 17:37:25 +0200
Message-Id: <20180703153728.2175-30-armbru@redhat.com>
In-Reply-To: <20180703153728.2175-1-armbru@redhat.com>
References: <20180703153728.2175-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 29/32] qobject: Let qobject_from_jsonf() fail
 instead of abort
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

qobject_from_jsonf() aborts on error, unlike qobject_from_jsonv(),
which returns null.  Since all remaining users of qobject_from_jsonf()
cope fine with null, change it to return null.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20180703085358.13941-30-armbru@redhat.com>
---
 qobject/qjson.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/qobject/qjson.c b/qobject/qjson.c
index 0df3120202..2f6a590e44 100644
--- a/qobject/qjson.c
+++ b/qobject/qjson.c
@@ -59,10 +59,6 @@ QObject *qobject_from_json(const char *string, Error **errp)
     return qobject_from_jsonv(string, NULL, errp);
 }
 
-/*
- * IMPORTANT: This function aborts on error, thus it must not
- * be used with untrusted arguments.
- */
 QObject *qobject_from_jsonf(const char *string, ...)
 {
     QObject *obj;
@@ -72,7 +68,6 @@ QObject *qobject_from_jsonf(const char *string, ...)
     obj = qobject_from_jsonv(string, &ap, &error_abort);
     va_end(ap);
 
-    assert(obj != NULL);
     return obj;
 }
 
-- 
2.17.1
