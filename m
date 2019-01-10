Received: from eggs.gnu.org ([209.51.188.92]:35019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ghPgh-0006JF-0a
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 21:03:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ghPgg-0003GS-6Q
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 21:03:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58912)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ghPgg-0003GI-13
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 21:03:14 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 10 Jan 2019 00:02:57 -0200
Message-Id: <20190110020259.8492-2-ehabkost@redhat.com>
In-Reply-To: <20190110020259.8492-1-ehabkost@redhat.com>
References: <20190110020259.8492-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/3] qom: Don't keep error value between
 object_property_parse() calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Cornelia Huck <cohuck@redhat.com>

When handling errp==NULL at object_apply_global_props(), we are
leaving the old error value in `err` after printing a warning.
This makes QEMU crash if two global properties generate warnings:

  $ echo device_add rtl8139 | qemu-system-x86_64 -monitor stdio -global rtl8139.xxx=yyy -global rtl8139.xxx=zzz
  warning: can't apply global rtl8139.xxx=yyy: Property '.xxx' not found
  qemu-system-x86_64: util/error.c:57: error_setv: Assertion `*errp == NULL' failed.
  Aborted (core dumped)

Fix that by making `err` go out of scope immediately after the
warn_report_err() call.

Fixes: 50545b2cc029 "qdev-props: call object_apply_global_props()"
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 qom/object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qom/object.c b/qom/object.c
index aa6f3a2a71..4e5226ca12 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -372,7 +372,6 @@ static void object_post_init_with_type(Object *obj, TypeImpl *ti)
 
 void object_apply_global_props(Object *obj, const GPtrArray *props, Error **errp)
 {
-    Error *err = NULL;
     int i;
 
     if (!props) {
@@ -381,6 +380,7 @@ void object_apply_global_props(Object *obj, const GPtrArray *props, Error **errp
 
     for (i = 0; i < props->len; i++) {
         GlobalProperty *p = g_ptr_array_index(props, i);
+        Error *err = NULL;
 
         if (object_dynamic_cast(obj, p->driver) == NULL) {
             continue;
-- 
2.18.0.rc1.1.g3f1ff2140
