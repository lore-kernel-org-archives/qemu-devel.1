Received: from eggs.gnu.org ([2001:4830:134:3::10]:35838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dxm8y-0005JA-NW
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:39:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dxm8y-0006KA-2K
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:39:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:17046)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dxm8x-0006Jj-SB
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 23:39:15 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 29 Sep 2017 11:38:26 +0800
Message-Id: <20170929033844.26935-5-peterx@redhat.com>
In-Reply-To: <20170929033844.26935-1-peterx@redhat.com>
References: <20170929033844.26935-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v2 04/22] qobject: let object_property_get_str()
 use new API
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, peterx@redhat.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@gmail.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
List-ID: <qemu-devel.nongnu.org>

We can simplify object_property_get_str() using the new
qobject_get_try_str().

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qom/object.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index 6a7bd9257b..d76a0ee797 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1107,18 +1107,15 @@ char *object_property_get_str(Object *obj, const char *name,
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
2.13.5
