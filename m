Received: from eggs.gnu.org ([2001:4830:134:3::10]:57372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dX8O8-0002sO-V5
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:56:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dX8O8-0007ay-8A
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 11:56:49 -0400
From: Eric Blake <eblake@redhat.com>
Date: Mon, 17 Jul 2017 10:56:31 -0500
Message-Id: <20170717155632.12754-5-eblake@redhat.com>
In-Reply-To: <20170717155632.12754-1-eblake@redhat.com>
References: <20170717155632.12754-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 4/5] qapi: Use simpler QAPI_TO_QOBJECT()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

Use the new macro to avoid some boilerplate.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/qapi.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/block/qapi.c b/block/qapi.c
index 080eb8f115..23e666f108 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -675,14 +675,13 @@ void bdrv_image_info_specific_dump(fprintf_function func_fprintf, void *f,
                                    ImageInfoSpecific *info_spec)
 {
     QObject *obj, *data;
-    Visitor *v = qobject_output_visitor_new(&obj);

-    visit_type_ImageInfoSpecific(v, NULL, &info_spec, &error_abort);
-    visit_complete(v, &obj);
+    obj = QAPI_TO_QOBJECT(ImageInfoSpecific, info_spec, &error_abort);
+
+    assert(qobject_type(obj) == QTYPE_QDICT);
     data = qdict_get(qobject_to_qdict(obj), "data");
     dump_qobject(func_fprintf, f, 1, data);
     qobject_decref(obj);
-    visit_free(v);
 }

 void bdrv_image_info_dump(fprintf_function func_fprintf, void *f,
-- 
2.13.3
