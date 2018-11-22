Received: from eggs.gnu.org ([2001:4830:134:3::10]:51535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gPtfe-0002az-A7
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 13:25:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gPtdd-0007J4-2b
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 13:23:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gPtdc-0007Hh-S0
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 13:23:40 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 22 Nov 2018 19:23:35 +0100
Message-Id: <20181122182335.9038-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] nvme: fix CMB endianness confusion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org

The CMB is marked as DEVICE_LITTLE_ENDIAN, so the data must be
read/written as if it was little-endian output (in the case of
big endian, we get two swaps, one in the memory core and one
in nvme.c).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/block/nvme.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 5d92794ef7..8a12fba24f 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1175,16 +1175,13 @@ static void nvme_cmb_write(void *opaque, hwaddr a=
ddr, uint64_t data,
     unsigned size)
 {
     NvmeCtrl *n =3D (NvmeCtrl *)opaque;
-    memcpy(&n->cmbuf[addr], &data, size);
+    stn_le_p(&n->cmbuf[addr], size, data);
 }
=20
 static uint64_t nvme_cmb_read(void *opaque, hwaddr addr, unsigned size)
 {
-    uint64_t val;
     NvmeCtrl *n =3D (NvmeCtrl *)opaque;
-
-    memcpy(&val, &n->cmbuf[addr], size);
-    return val;
+    return ldn_le_p(&n->cmbuf[addr], size);
 }
=20
 static const MemoryRegionOps nvme_cmb_ops =3D {
--=20
2.19.1
