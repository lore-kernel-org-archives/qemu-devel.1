Received: from eggs.gnu.org ([2001:4830:134:3::10]:46801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gOkYz-0001Dt-9y
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 09:30:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gOkYu-0006wm-N7
	for qemu-devel@nongnu.org; Mon, 19 Nov 2018 09:30:09 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 19 Nov 2018 15:29:36 +0100
Message-Id: <20181119142944.29061-2-kwolf@redhat.com>
In-Reply-To: <20181119142944.29061-1-kwolf@redhat.com>
References: <20181119142944.29061-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/9] nvme: fix oob access issue(CVE-2018-16847)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Li Qiang <liq3ea@gmail.com>

Currently, the nvme_cmb_ops mr doesn't check the addr and size.
This can lead an oob access issue. This is triggerable in the guest.
Add check to avoid this issue.

Fixes CVE-2018-16847.

Reported-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Li Qiang <liq3ea@gmail.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/nvme.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 09d7c90259..d0226e7fdc 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1175,6 +1175,10 @@ static void nvme_cmb_write(void *opaque, hwaddr ad=
dr, uint64_t data,
     unsigned size)
 {
     NvmeCtrl *n =3D (NvmeCtrl *)opaque;
+
+    if (addr + size > NVME_CMBSZ_GETSIZE(n->bar.cmbsz)) {
+        return;
+    }
     memcpy(&n->cmbuf[addr], &data, size);
 }
=20
@@ -1183,6 +1187,9 @@ static uint64_t nvme_cmb_read(void *opaque, hwaddr =
addr, unsigned size)
     uint64_t val;
     NvmeCtrl *n =3D (NvmeCtrl *)opaque;
=20
+    if (addr + size > NVME_CMBSZ_GETSIZE(n->bar.cmbsz)) {
+        return 0;
+    }
     memcpy(&val, &n->cmbuf[addr], size);
     return val;
 }
--=20
2.19.1
