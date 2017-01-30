Received: from eggs.gnu.org ([2001:4830:134:3::10]:34733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1cYDet-0002MZ-Fw
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:14:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jgross@suse.com>) id 1cYDeq-0005hb-9O
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:14:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:60206)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jgross@suse.com>) id 1cYDeq-0005gl-2D
	for qemu-devel@nongnu.org; Mon, 30 Jan 2017 10:14:16 -0500
From: Juergen Gross <jgross@suse.com>
Date: Mon, 30 Jan 2017 16:14:09 +0100
Message-Id: <20170130151409.20444-1-jgross@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] xen: use qdev_unplug() insteda of g_free() in
 xen_pv_find_xendev()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Cc: anthony.perard@citrix.com, kraxel@redhat.com, sstabellini@kernel.org, roger.pau@citrix.com, Juergen Gross <jgross@suse.com>

The error exits of xen_pv_find_xendev() free the new xen-device via
g_free() which is wrong.

As the xen-device has been initialized as qdev it must be removed
via qdev_unplug().

This bug has been introduced with commit 3a6c9172ac5951e6dac2b3f6
("xen: create qdev for each backend device").

Reported-by: Roger Pau Monn=C3=A9 <roger.pau@citrix.com>
Tested-by: Roger Pau Monn=C3=A9 <roger.pau@citrix.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 hw/xen/xen_backend.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/xen/xen_backend.c b/hw/xen/xen_backend.c
index d119004..030772b 100644
--- a/hw/xen/xen_backend.c
+++ b/hw/xen/xen_backend.c
@@ -145,7 +145,7 @@ static struct XenDevice *xen_be_get_xendev(const char=
 *type, int dom, int dev,
     xendev->evtchndev =3D xenevtchn_open(NULL, 0);
     if (xendev->evtchndev =3D=3D NULL) {
         xen_pv_printf(NULL, 0, "can't open evtchn device\n");
-        g_free(xendev);
+        qdev_unplug(&xendev->qdev, NULL);
         return NULL;
     }
     fcntl(xenevtchn_fd(xendev->evtchndev), F_SETFD, FD_CLOEXEC);
@@ -155,7 +155,7 @@ static struct XenDevice *xen_be_get_xendev(const char=
 *type, int dom, int dev,
         if (xendev->gnttabdev =3D=3D NULL) {
             xen_pv_printf(NULL, 0, "can't open gnttab device\n");
             xenevtchn_close(xendev->evtchndev);
-            g_free(xendev);
+            qdev_unplug(&xendev->qdev, NULL);
             return NULL;
         }
     } else {
--=20
2.10.2
