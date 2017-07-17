Received: from eggs.gnu.org ([2001:4830:134:3::10]:60449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dX1Me-0006g2-FG
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:26:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dX1MZ-0001vT-JG
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:26:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57362)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dX1MZ-0001ut-DF
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 04:26:43 -0400
From: Peter Xu <peterx@redhat.com>
Date: Mon, 17 Jul 2017 16:26:04 +0800
Message-Id: <1500279971-13875-5-git-send-email-peterx@redhat.com>
In-Reply-To: <1500279971-13875-1-git-send-email-peterx@redhat.com>
References: <1500279971-13875-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 04/11] qom: call parent first on post_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Peter Xu <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>

It makes more sense to call the post_init() hook of the parent first
then the child, just like what we do in the rest of the hooks.

CC: Andreas F=C3=A4rber <afaerber@suse.de>
CC: Markus Armbruster <armbru@redhat.com>
CC: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 qom/object.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/qom/object.c b/qom/object.c
index dfdbd50..e2c9c4a 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -347,13 +347,13 @@ static void object_init_with_type(Object *obj, Type=
Impl *ti)
=20
 static void object_post_init_with_type(Object *obj, TypeImpl *ti)
 {
-    if (ti->instance_post_init) {
-        ti->instance_post_init(obj);
-    }
-
     if (type_has_parent(ti)) {
         object_post_init_with_type(obj, type_get_parent(ti));
     }
+
+    if (ti->instance_post_init) {
+        ti->instance_post_init(obj);
+    }
 }
=20
 static void object_initialize_with_type(void *data, size_t size, TypeImp=
l *type)
--=20
2.7.4
