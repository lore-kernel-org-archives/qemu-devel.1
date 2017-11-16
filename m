Received: from eggs.gnu.org ([2001:4830:134:3::10]:38000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eFJsU-0007lX-Hp
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:06:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eFJsP-0006Gx-30
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:06:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eFJsO-0006Ed-SM
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 08:06:40 -0500
From: Peter Xu <peterx@redhat.com>
Date: Thu, 16 Nov 2017 21:05:46 +0800
Message-Id: <20171116130610.23582-4-peterx@redhat.com>
In-Reply-To: <20171116130610.23582-1-peterx@redhat.com>
References: <20171116130610.23582-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v4 03/27] qobject: let object_property_get_str()
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
Cc: Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

We can simplify object_property_get_str() using the new
qobject_get_try_str().

Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qom/object.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index c58c52d518..9cbeb51f0b 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1116,18 +1116,15 @@ char *object_property_get_str(Object *obj, const char *name,
                               Error **errp)
 {
     QObject *ret = object_property_get_qobject(obj, name, errp);
-    QString *qstring;
     char *retval;
 
     if (!ret) {
         return NULL;
     }
-    qstring = qobject_to_qstring(ret);
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
2.13.6
