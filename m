Received: from eggs.gnu.org ([209.51.188.92]:48797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1hB4OV-00059L-Qz
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:23:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bsd@redhat.com>) id 1hB4OU-0008GT-Cf
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:23:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55112)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bsd@redhat.com>) id 1hB4OS-0008Ec-AY
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 17:23:00 -0400
From: Bandan Das <bsd@redhat.com>
Date: Mon,  1 Apr 2019 17:17:11 -0400
Message-Id: <20190401211712.19012-3-bsd@redhat.com>
In-Reply-To: <20190401211712.19012-1-bsd@redhat.com>
References: <20190401211712.19012-1-bsd@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 2/3] usb-mtp: remove usb_mtp_object_free_one
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, peter.maydell@linaro.org

This function is used in the delete path only and can
be replaced by a call to usb_mtp_object_free.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Bandan Das <bsd@redhat.com>
---
 hw/usb/dev-mtp.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 91b820baaf..4dc1317e2e 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -1150,16 +1150,6 @@ enum {
     DELETE_PARTIAL =3D (DELETE_FAILURE | DELETE_SUCCESS),
 };
=20
-/* Assumes that children, if any, have been already freed */
-static void usb_mtp_object_free_one(MTPState *s, MTPObject *o)
-{
-    assert(o->nchildren =3D=3D 0);
-    QTAILQ_REMOVE(&s->objects, o, next);
-    g_free(o->name);
-    g_free(o->path);
-    g_free(o);
-}
-
 static int usb_mtp_deletefn(MTPState *s, MTPObject *o, uint32_t trans)
 {
     MTPObject *iter, *iter2;
@@ -1181,14 +1171,14 @@ static int usb_mtp_deletefn(MTPState *s, MTPObjec=
t *o, uint32_t trans)
         if (remove(o->path)) {
             ret |=3D DELETE_FAILURE;
         } else {
-            usb_mtp_object_free_one(s, o);
+            usb_mtp_object_free(s, o);
             ret |=3D DELETE_SUCCESS;
         }
     } else if (o->format =3D=3D FMT_ASSOCIATION) {
         if (rmdir(o->path)) {
             ret |=3D DELETE_FAILURE;
         } else {
-            usb_mtp_object_free_one(s, o);
+            usb_mtp_object_free(s, o);
             ret |=3D DELETE_SUCCESS;
         }
     }
--=20
2.19.2
