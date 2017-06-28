Received: from eggs.gnu.org ([2001:4830:134:3::10]:47159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQCPC-00034J-6o
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:49:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQCP9-00019P-5S
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:49:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dQCP8-000199-VC
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 08:49:11 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 28 Jun 2017 20:48:45 +0800
Message-Id: <20170628124850.12821-3-famz@redhat.com>
In-Reply-To: <20170628124850.12821-1-famz@redhat.com>
References: <20170628124850.12821-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 2/7] qom: Handle property lookup failure in
 object_resolve_link
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>

Since we have made object_set_link_property a public function, it is
possible that it will be called with a nonexistent property name.  Let's
survive this error case and report error to avoid segfault in the future.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 qom/object.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/qom/object.c b/qom/object.c
index 3868370..dd9c3fa 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1470,7 +1470,10 @@ static Object *object_resolve_link(Object *obj, const char *name,
     Object *target;
 
     /* Go from link<FOO> to FOO.  */
-    type = object_property_get_type(obj, name, NULL);
+    type = object_property_get_type(obj, name, errp);
+    if (!type) {
+        return NULL;
+    }
     target_type = g_strndup(&type[5], strlen(type) - 6);
     target = object_resolve_path_type(path, target_type, &ambiguous);
 
-- 
2.9.4
