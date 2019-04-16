Received: from eggs.gnu.org ([209.51.188.92]:35277)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1hGNgb-00065O-B4
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:59:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1hGNga-00024K-Ce
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:59:41 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43166)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1hGNga-00023G-1f
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:59:40 -0400
From: Liran Alon <liran.alon@oracle.com>
Date: Tue, 16 Apr 2019 15:59:11 +0300
Message-Id: <20190416125912.44001-3-liran.alon@oracle.com>
In-Reply-To: <20190416125912.44001-1-liran.alon@oracle.com>
References: <20190416125912.44001-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 2/3] vhost-scsi: Add VMState descriptor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, rth@twiddle.net, ehabkost@redhat.com, stefanha@gmail.com, nir.weiner@oracle.com, bijan.mottahedeh@oracle.com, Liran Alon <liran.alon@oracle.com>

From: Nir Weiner <nir.weiner@oracle.com>

As preparation of enabling migration of vhost-scsi device,
define it=E2=80=99s VMState. Note, we keep the convention of
verifying in the pre_save() method that the vhost backend
must be stopped before attempting to save the device
state. Similar to how it is done for vhost-vsock.

Reviewed-by: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Reviewed-by: Liran Alon <liran.alon@oracle.com>
Signed-off-by: Nir Weiner <nir.weiner@oracle.com>
---
 hw/scsi/vhost-scsi.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index ca42cff1b907..eb0cf9e1312f 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -139,6 +139,28 @@ static void vhost_dummy_handle_output(VirtIODevice *=
vdev, VirtQueue *vq)
 {
 }
=20
+static int vhost_scsi_pre_save(void *opaque)
+{
+    VHostSCSICommon *vsc =3D opaque;
+
+    /* At this point, backend must be stopped, otherwise
+     * it might keep writing to memory. */
+    assert(!vsc->dev.started);
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_virtio_vhost_scsi =3D {
+    .name =3D "virtio-vhost_scsi",
+    .minimum_version_id =3D 1,
+    .version_id =3D 1,
+    .fields =3D (VMStateField[]) {
+        VMSTATE_VIRTIO_DEVICE,
+        VMSTATE_END_OF_LIST()
+    },
+    .pre_save =3D vhost_scsi_pre_save,
+};
+
 static void vhost_scsi_realize(DeviceState *dev, Error **errp)
 {
     VirtIOSCSICommon *vs =3D VIRTIO_SCSI_COMMON(dev);
@@ -256,6 +278,7 @@ static void vhost_scsi_class_init(ObjectClass *klass,=
 void *data)
     FWPathProviderClass *fwc =3D FW_PATH_PROVIDER_CLASS(klass);
=20
     dc->props =3D vhost_scsi_properties;
+    dc->vmsd =3D &vmstate_virtio_vhost_scsi;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
     vdc->realize =3D vhost_scsi_realize;
     vdc->unrealize =3D vhost_scsi_unrealize;
--=20
2.20.1
