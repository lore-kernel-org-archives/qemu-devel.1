Received: from eggs.gnu.org ([2001:4830:134:3::10]:38297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cZMEb-0003qF-HD
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 13:35:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cZMEa-0004gX-Kz
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 13:35:53 -0500
Received: from mail.kernel.org ([198.145.29.136]:45178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cZMEa-0004g6-EY
	for qemu-devel@nongnu.org; Thu, 02 Feb 2017 13:35:52 -0500
From: Stefano Stabellini <sstabellini@kernel.org>
Date: Thu,  2 Feb 2017 10:35:41 -0800
Message-Id: <1486060541-29146-5-git-send-email-sstabellini@kernel.org>
In-Reply-To: <1486060541-29146-1-git-send-email-sstabellini@kernel.org>
References: <alpine.DEB.2.10.1702021024200.17946@sstabellini-ThinkPad-X260>
	<1486060541-29146-1-git-send-email-sstabellini@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 5/5] xen: use qdev_unplug() instead of g_free()
 in xen_pv_find_xendev()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@gmail.com
Cc: sstabellini@kernel.org, stefanha@redhat.com, peter.maydell@linaro.org, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, qemu-devel@nongnu.org, Juergen Gross <jgross@suse.com>

From: Juergen Gross <jgross@suse.com>

The error exits of xen_pv_find_xendev() free the new xen-device via
g_free() which is wrong.

As the xen-device has been initialized as qdev it must be removed
via qdev_unplug().

This bug has been introduced with commit 3a6c9172ac5951e6dac2b3f6
("xen: create qdev for each backend device").

Reported-by: Roger Pau Monn=C3=A9 <roger.pau@citrix.com>
Tested-by: Roger Pau Monn=C3=A9 <roger.pau@citrix.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 hw/xen/xen_backend.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/hw/xen/xen_backend.c b/hw/xen/xen_backend.c
index d119004..6c21c37 100644
--- a/hw/xen/xen_backend.c
+++ b/hw/xen/xen_backend.c
@@ -124,10 +124,11 @@ static struct XenDevice *xen_be_get_xendev(const ch=
ar *type, int dom, int dev,
     /* init new xendev */
     xendev =3D g_malloc0(ops->size);
     object_initialize(&xendev->qdev, ops->size, TYPE_XENBACKEND);
-    qdev_set_parent_bus(&xendev->qdev, xen_sysbus);
-    qdev_set_id(&xendev->qdev, g_strdup_printf("xen-%s-%d", type, dev));
-    qdev_init_nofail(&xendev->qdev);
-    object_unref(OBJECT(&xendev->qdev));
+    OBJECT(xendev)->free =3D g_free;
+    qdev_set_parent_bus(DEVICE(xendev), xen_sysbus);
+    qdev_set_id(DEVICE(xendev), g_strdup_printf("xen-%s-%d", type, dev))=
;
+    qdev_init_nofail(DEVICE(xendev));
+    object_unref(OBJECT(xendev));
=20
     xendev->type  =3D type;
     xendev->dom   =3D dom;
@@ -145,7 +146,7 @@ static struct XenDevice *xen_be_get_xendev(const char=
 *type, int dom, int dev,
     xendev->evtchndev =3D xenevtchn_open(NULL, 0);
     if (xendev->evtchndev =3D=3D NULL) {
         xen_pv_printf(NULL, 0, "can't open evtchn device\n");
-        g_free(xendev);
+        qdev_unplug(DEVICE(xendev), NULL);
         return NULL;
     }
     fcntl(xenevtchn_fd(xendev->evtchndev), F_SETFD, FD_CLOEXEC);
@@ -155,7 +156,7 @@ static struct XenDevice *xen_be_get_xendev(const char=
 *type, int dom, int dev,
         if (xendev->gnttabdev =3D=3D NULL) {
             xen_pv_printf(NULL, 0, "can't open gnttab device\n");
             xenevtchn_close(xendev->evtchndev);
-            g_free(xendev);
+            qdev_unplug(DEVICE(xendev), NULL);
             return NULL;
         }
     } else {
--=20
1.9.1
