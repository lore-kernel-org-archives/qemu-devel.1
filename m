Received: from eggs.gnu.org ([2001:4830:134:3::10]:58984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cepIU-0002Yf-R2
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:38:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cepIS-0004Ou-7q
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:38:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60612)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cepIR-0004OD-VN
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 15:38:28 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 11BBF7E9EA
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 20:38:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-50.ams2.redhat.com
	[10.36.116.50])
	by int-mx09.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1HKcQQp019359
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=NO)
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 15:38:27 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 17 Feb 2017 21:38:15 +0100
Message-Id: <1487363905-9480-5-git-send-email-armbru@redhat.com>
In-Reply-To: <1487363905-9480-1-git-send-email-armbru@redhat.com>
References: <1487363905-9480-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 04/14] check-qjson: Simplify around
 compare_litqobj_to_qobj()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Make compare_litqobj_to_qobj() cope with null, and drop non-null
assertions from callers.

compare_litqobj_to_qobj() already checks the QType matches; drop the
redundant assertions from callers.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/check-qjson.c | 22 +---------------------
 1 file changed, 1 insertion(+), 21 deletions(-)

diff --git a/tests/check-qjson.c b/tests/check-qjson.c
index 0b21a22..49e02591 100644
--- a/tests/check-qjson.c
+++ b/tests/check-qjson.c
@@ -1110,7 +1110,7 @@ static void compare_helper(QObject *obj, void *opaque)
 
 static int compare_litqobj_to_qobj(LiteralQObject *lhs, QObject *rhs)
 {
-    if (lhs->type != qobject_type(rhs)) {
+    if (!rhs || lhs->type != qobject_type(rhs)) {
         return 0;
     }
 
@@ -1184,18 +1184,12 @@ static void simple_dict(void)
         QString *str;
 
         obj = qobject_from_json(test_cases[i].encoded);
-        g_assert(obj != NULL);
-        g_assert(qobject_type(obj) == QTYPE_QDICT);
-
         g_assert(compare_litqobj_to_qobj(&test_cases[i].decoded, obj) == 1);
 
         str = qobject_to_json(obj);
         qobject_decref(obj);
 
         obj = qobject_from_json(qstring_get_str(str));
-        g_assert(obj != NULL);
-        g_assert(qobject_type(obj) == QTYPE_QDICT);
-
         g_assert(compare_litqobj_to_qobj(&test_cases[i].decoded, obj) == 1);
         qobject_decref(obj);
         QDECREF(str);
@@ -1299,18 +1293,12 @@ static void simple_list(void)
         QString *str;
 
         obj = qobject_from_json(test_cases[i].encoded);
-        g_assert(obj != NULL);
-        g_assert(qobject_type(obj) == QTYPE_QLIST);
-
         g_assert(compare_litqobj_to_qobj(&test_cases[i].decoded, obj) == 1);
 
         str = qobject_to_json(obj);
         qobject_decref(obj);
 
         obj = qobject_from_json(qstring_get_str(str));
-        g_assert(obj != NULL);
-        g_assert(qobject_type(obj) == QTYPE_QLIST);
-
         g_assert(compare_litqobj_to_qobj(&test_cases[i].decoded, obj) == 1);
         qobject_decref(obj);
         QDECREF(str);
@@ -1367,18 +1355,12 @@ static void simple_whitespace(void)
         QString *str;
 
         obj = qobject_from_json(test_cases[i].encoded);
-        g_assert(obj != NULL);
-        g_assert(qobject_type(obj) == QTYPE_QLIST);
-
         g_assert(compare_litqobj_to_qobj(&test_cases[i].decoded, obj) == 1);
 
         str = qobject_to_json(obj);
         qobject_decref(obj);
 
         obj = qobject_from_json(qstring_get_str(str));
-        g_assert(obj != NULL);
-        g_assert(qobject_type(obj) == QTYPE_QLIST);
-
         g_assert(compare_litqobj_to_qobj(&test_cases[i].decoded, obj) == 1);
 
         qobject_decref(obj);
@@ -1403,8 +1385,6 @@ static void simple_varargs(void)
     g_assert(embedded_obj != NULL);
 
     obj = qobject_from_jsonf("[%d, 2, %p]", 1, embedded_obj);
-    g_assert(obj != NULL);
-
     g_assert(compare_litqobj_to_qobj(&decoded, obj) == 1);
 
     qobject_decref(obj);
-- 
2.7.4
