Received: from eggs.gnu.org ([2001:4830:134:3::10]:40267)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fHJIA-0006Mx-4Z
	for qemu-devel@nongnu.org; Fri, 11 May 2018 21:25:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fHJI9-0006VZ-2J
	for qemu-devel@nongnu.org; Fri, 11 May 2018 21:25:46 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri, 11 May 2018 21:25:33 -0400
Message-Id: <20180512012537.22478-9-jsnow@redhat.com>
In-Reply-To: <20180512012537.22478-1-jsnow@redhat.com>
References: <20180512012537.22478-1-jsnow@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 08/12] qjson: allow caller to ask for
 arbitrary indent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, John Snow <jsnow@redhat.com>

The function already exists, just expose it.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 include/qapi/qmp/qjson.h |  1 +
 qobject/qjson.c          | 21 +++++++++++----------
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/qapi/qmp/qjson.h b/include/qapi/qmp/qjson.h
index b274ac3a86..0e8624c1fa 100644
--- a/include/qapi/qmp/qjson.h
+++ b/include/qapi/qmp/qjson.h
@@ -19,6 +19,7 @@ QObject *qobject_from_jsonf(const char *string, ...) GCC_FMT_ATTR(1, 2);
 QObject *qobject_from_jsonv(const char *string, va_list *ap, Error **errp)
     GCC_FMT_ATTR(1, 0);
 
+QString *qobject_to_json_opt(const QObject *obj, int pretty, int indent);
 QString *qobject_to_json(const QObject *obj);
 QString *qobject_to_json_pretty(const QObject *obj);
 
diff --git a/qobject/qjson.c b/qobject/qjson.c
index 9816a65c7d..d603e1cce1 100644
--- a/qobject/qjson.c
+++ b/qobject/qjson.c
@@ -252,20 +252,21 @@ static void to_json(const QObject *obj, QString *str, int pretty, int indent)
     }
 }
 
+QString *qobject_to_json_opt(const QObject *obj, int pretty, int indent)
+{
+    QString *str = qstring_new();
+
+    to_json(obj, str, pretty, indent);
+
+    return str;
+}
+
 QString *qobject_to_json(const QObject *obj)
 {
-    QString *str = qstring_new();
-
-    to_json(obj, str, 0, 0);
-
-    return str;
+    return qobject_to_json_opt(obj, 0, 0);
 }
 
 QString *qobject_to_json_pretty(const QObject *obj)
 {
-    QString *str = qstring_new();
-
-    to_json(obj, str, 1, 0);
-
-    return str;
+    return qobject_to_json_opt(obj, 1, 0);
 }
-- 
2.14.3
