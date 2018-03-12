Received: from eggs.gnu.org ([2001:4830:134:3::10]:45233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJU-0000h6-6s
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evSJT-0005xZ-A4
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33602 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1evSJT-0005xB-6J
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 14:36:47 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 12 Mar 2018 13:36:06 -0500
Message-Id: <20180312183628.394722-16-eblake@redhat.com>
In-Reply-To: <20180312183628.394722-1-eblake@redhat.com>
References: <20180312183628.394722-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 15/36] qobject: let object_property_get_str()
 use new API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>

From: Peter Xu <peterx@redhat.com>

We can simplify object_property_get_str() using the new
qobject_get_try_str().

Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180309090006.10018-5-peterx@redhat.com>
[eblake: rebase context of qobject_to() macro]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 qom/object.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 7b3a6158fde..1c1b8cf8be0 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1123,18 +1123,15 @@ char *object_property_get_str(Object *obj, const char *name,
                               Error **errp)
 {
     QObject *ret = object_property_get_qobject(obj, name, errp);
-    QString *qstring;
     char *retval;

     if (!ret) {
         return NULL;
     }
-    qstring = qobject_to(QString, ret);
-    if (!qstring) {
+
+    retval = g_strdup(qobject_get_try_str(ret));
+    if (!retval) {
         error_setg(errp, QERR_INVALID_PARAMETER_TYPE, name, "string");
-        retval = NULL;
-    } else {
-        retval = g_strdup(qstring_get_str(qstring));
     }

     qobject_decref(ret);
-- 
2.14.3
