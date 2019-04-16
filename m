Received: from eggs.gnu.org ([209.51.188.92]:35254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1hGNga-00064O-7E
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:59:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liran.alon@oracle.com>) id 1hGNgY-00022c-3s
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:59:40 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37994)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liran.alon@oracle.com>)
	id 1hGNgX-00021t-Pf
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 08:59:38 -0400
From: Liran Alon <liran.alon@oracle.com>
Date: Tue, 16 Apr 2019 15:59:10 +0300
Message-Id: <20190416125912.44001-2-liran.alon@oracle.com>
In-Reply-To: <20190416125912.44001-1-liran.alon@oracle.com>
References: <20190416125912.44001-1-liran.alon@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/3] vhost-scsi: The vhost backend should be
 stopped when the VM is not running
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

vhost-scsi doesn=E2=80=99t takes into account whether the VM is running o=
r not in
order to decide if it should start/stop vhost backend.
This would lead to vhost backend still being active when VM's RunState
suddenly change to stopped.

An example of when this issue is encountered is when Live-Migration Pre-C=
opy
phase completes. As in this case, VM state will be changed to stopped (wh=
ile
vhost backend is still active), which will result in
virtio_vmstate_change() -> virtio_set_status() -> vhost_scsi_set_status()
executed but vhost_scsi_set_status() will just return without stopping
vhost backend.

To handle this, change code to consider that vhost processing should be
stopped when VM is not running. Similar to how it is done in vhost-vsock
device at vhost_vsock_set_status().

Fixes: 5e9be92d7752 ("vhost-scsi: new device supporting the tcm_vhost Lin=
ux kernel module=E2=80=9D)
Reviewed-by: Bijan Mottahedeh <bijan.mottahedeh@oracle.com>
Reviewed-by: Liran Alon <liran.alon@oracle.com>
Signed-off-by: Nir Weiner <nir.weiner@oracle.com>
---
 hw/scsi/vhost-scsi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
index 61e2e57da9d5..ca42cff1b907 100644
--- a/hw/scsi/vhost-scsi.c
+++ b/hw/scsi/vhost-scsi.c
@@ -114,6 +114,10 @@ static void vhost_scsi_set_status(VirtIODevice *vdev=
, uint8_t val)
     VHostSCSICommon *vsc =3D VHOST_SCSI_COMMON(s);
     bool start =3D (val & VIRTIO_CONFIG_S_DRIVER_OK);
=20
+    if (!vdev->vm_running) {
+        start =3D false;
+    }
+
     if (vsc->dev.started =3D=3D start) {
         return;
     }
--=20
2.20.1
