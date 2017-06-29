Received: from eggs.gnu.org ([2001:4830:134:3::10]:59254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQURk-0003rN-Cd
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:05:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dQURj-0003H8-HY
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:05:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dQURj-0003Gu-CH
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:05:03 -0400
From: Fam Zheng <famz@redhat.com>
Date: Thu, 29 Jun 2017 16:04:47 +0800
Message-Id: <20170629080452.26470-3-famz@redhat.com>
In-Reply-To: <20170629080452.26470-1-famz@redhat.com>
References: <20170629080452.26470-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/7] qom: Handle property lookup failure in
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
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Markus Armbruster <armbru@redhat.com>

Since we have made object_set_link_property a public function, it is
possible that it will be called with a nonexistent property name.  Let's
survive this error case and report error to avoid segfault in the future.

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 qom/object.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/qom/object.c b/qom/object.c
index fdb8f0d..7ce97d9 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1471,7 +1471,10 @@ static Object *object_resolve_link(Object *obj, const char *name,
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
