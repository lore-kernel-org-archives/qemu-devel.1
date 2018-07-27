Received: from eggs.gnu.org ([2001:4830:134:3::10]:52492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fj569-0005C0-Qq
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:56:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fj565-0004Ad-UG
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:56:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49636 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fj565-0004A2-Oe
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 11:56:05 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 1417D40216E7
	for <qemu-devel@nongnu.org>; Fri, 27 Jul 2018 15:56:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-135.ams2.redhat.com
	[10.36.116.135])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DEF342166BA3
	for <qemu-devel@nongnu.org>; Fri, 27 Jul 2018 15:56:04 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 27 Jul 2018 17:56:01 +0200
Message-Id: <20180727155602.10148-3-armbru@redhat.com>
In-Reply-To: <20180727155602.10148-1-armbru@redhat.com>
References: <20180727155602.10148-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 2/3] qstring: Assert size calculations don't
 overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180727062204.10401-2-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qobject/qstring.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/qobject/qstring.c b/qobject/qstring.c
index 18b8eb82f8..1bb7784a88 100644
--- a/qobject/qstring.c
+++ b/qobject/qstring.c
@@ -41,17 +41,19 @@ QString *qstring_from_substr(const char *str, size_t start, size_t end)
 {
     QString *qstring;
 
+    assert(start <= end + 1);
+
     qstring = g_malloc(sizeof(*qstring));
     qobject_init(QOBJECT(qstring), QTYPE_QSTRING);
 
     qstring->length = end - start + 1;
     qstring->capacity = qstring->length;
 
+    assert(qstring->capacity < SIZE_MAX);
     qstring->string = g_malloc(qstring->capacity + 1);
     memcpy(qstring->string, str + start, qstring->length);
     qstring->string[qstring->length] = 0;
 
-
     return qstring;
 }
 
@@ -68,7 +70,9 @@ QString *qstring_from_str(const char *str)
 static void capacity_increase(QString *qstring, size_t len)
 {
     if (qstring->capacity < (qstring->length + len)) {
+        assert(len <= SIZE_MAX - qstring->capacity);
         qstring->capacity += len;
+        assert(qstring->capacity <= SIZE_MAX / 2);
         qstring->capacity *= 2; /* use exponential growth */
 
         qstring->string = g_realloc(qstring->string, qstring->capacity + 1);
-- 
2.17.1
