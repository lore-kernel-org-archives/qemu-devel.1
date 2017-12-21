Received: from eggs.gnu.org ([2001:4830:134:3::10]:45980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS1qp-00086T-D4
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:29:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eS1qo-0005sa-Em
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:29:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eS1qo-0005rb-4P
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 09:29:34 -0500
Date: Thu, 21 Dec 2017 16:29:25 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1513866427-27125-17-git-send-email-mst@redhat.com>
References: <1513866427-27125-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1513866427-27125-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 16/25] hw/pci-host/piix: QOM'ify the IGD
 Passthrough host bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Marcel Apfelbaum <marcel@redhat.com>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
---
 hw/pci-host/piix.c | 45 ++++++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 25 deletions(-)

diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index effe3db..0e60834 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -804,60 +804,55 @@ static const IGDHostInfo igd_host_bridge_infos[] =3D=
 {
     {0xa8, 4},  /* SNB: base of GTT stolen memory */
 };
=20
-static int host_pci_config_read(int pos, int len, uint32_t *val)
+static void host_pci_config_read(int pos, int len, uint32_t *val, Error =
**errp)
 {
-    char path[PATH_MAX];
-    int config_fd;
-    ssize_t size =3D sizeof(path);
+    int rc, config_fd;
     /* Access real host bridge. */
-    int rc =3D snprintf(path, size, "/sys/bus/pci/devices/%04x:%02x:%02x=
.%d/%s",
-                      0, 0, 0, 0, "config");
-    int ret =3D 0;
-
-    if (rc >=3D size || rc < 0) {
-        return -ENODEV;
-    }
+    char *path =3D g_strdup_printf("/sys/bus/pci/devices/%04x:%02x:%02x.=
%d/%s",
+                                 0, 0, 0, 0, "config");
=20
     config_fd =3D open(path, O_RDWR);
     if (config_fd < 0) {
-        return -ENODEV;
+        error_setg_errno(errp, errno, "Failed to open: %s", path);
+        goto out;
     }
=20
     if (lseek(config_fd, pos, SEEK_SET) !=3D pos) {
-        ret =3D -errno;
-        goto out;
+        error_setg_errno(errp, errno, "Failed to seek: %s", path);
+        goto out_close_fd;
     }
=20
     do {
         rc =3D read(config_fd, (uint8_t *)val, len);
     } while (rc < 0 && (errno =3D=3D EINTR || errno =3D=3D EAGAIN));
     if (rc !=3D len) {
-        ret =3D -errno;
+        error_setg_errno(errp, errno, "Failed to read: %s", path);
     }
=20
-out:
+out_close_fd:
     close(config_fd);
-    return ret;
+out:
+    g_free(path);
 }
=20
-static int igd_pt_i440fx_initfn(struct PCIDevice *pci_dev)
+static void igd_pt_i440fx_realize(PCIDevice *pci_dev, Error **errp)
 {
     uint32_t val =3D 0;
-    int rc, i, num;
+    int i, num;
     int pos, len;
+    Error *local_err =3D NULL;
=20
     num =3D ARRAY_SIZE(igd_host_bridge_infos);
     for (i =3D 0; i < num; i++) {
         pos =3D igd_host_bridge_infos[i].offset;
         len =3D igd_host_bridge_infos[i].len;
-        rc =3D host_pci_config_read(pos, len, &val);
-        if (rc) {
-            return -ENODEV;
+        host_pci_config_read(pos, len, &val, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
         }
         pci_default_write_config(pci_dev, pos, val, len);
     }
-
-    return 0;
 }
=20
 static void igd_passthrough_i440fx_class_init(ObjectClass *klass, void *=
data)
@@ -865,7 +860,7 @@ static void igd_passthrough_i440fx_class_init(ObjectC=
lass *klass, void *data)
     DeviceClass *dc =3D DEVICE_CLASS(klass);
     PCIDeviceClass *k =3D PCI_DEVICE_CLASS(klass);
=20
-    k->init =3D igd_pt_i440fx_initfn;
+    k->realize =3D igd_pt_i440fx_realize;
     dc->desc =3D "IGD Passthrough Host bridge";
 }
=20
--=20
MST
