Received: from eggs.gnu.org ([2001:4830:134:3::10]:49908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fiw8g-0001OY-P6
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 02:22:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fiw8c-00055t-LB
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 02:22:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34960 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fiw8c-000555-GV
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 02:22:06 -0400
From: Markus Armbruster <armbru@redhat.com>
Date: Fri, 27 Jul 2018 08:22:03 +0200
Message-Id: <20180727062204.10401-2-armbru@redhat.com>
In-Reply-To: <20180727062204.10401-1-armbru@redhat.com>
References: <20180727062204.10401-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/2] qstring: Assert size calculations don't
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
Cc: liujunjie23@huawei.com, eblake@redhat.com

Signed-off-by: Markus Armbruster <armbru@redhat.com>
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
