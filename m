Received: from eggs.gnu.org ([2001:4830:134:3::10]:42639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fa1av-0004Tp-CI
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:22:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fa1as-0006gq-Bi
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:22:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45544 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fa1ar-0006f0-SM
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 12:22:26 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1DD888315E
	for <qemu-devel@nongnu.org>; Mon,  2 Jul 2018 16:22:25 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  2 Jul 2018 18:22:15 +0200
Message-Id: <20180702162218.13678-30-armbru@redhat.com>
In-Reply-To: <20180702162218.13678-1-armbru@redhat.com>
References: <20180702162218.13678-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 29/32] qobject: Let qobject_from_jsonf() fail
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
Cc: peterx@redhat.com, eblake@redhat.com, stefanha@redhat.com, dgilbert@redhat.com

qobject_from_jsonf() aborts on error, unlike qobject_from_jsonv(),
which returns null.  Since all remaining users of qobject_from_jsonf()
cope fine with null, change it to return null.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
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
