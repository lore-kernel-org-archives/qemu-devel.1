Received: from eggs.gnu.org ([2001:4830:134:3::10]:37389)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gPsFa-0001uH-PU
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:54:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gPsFY-00012D-2l
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 11:54:46 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 22 Nov 2018 17:54:15 +0100
Message-Id: <20181122165417.23894-12-kwolf@redhat.com>
In-Reply-To: <20181122165417.23894-1-kwolf@redhat.com>
References: <20181122165417.23894-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/13] Revert "nvme: fix oob access
 issue(CVE-2018-16847)"
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

This reverts commit 5e3c0220d7e4f0361c4d36c697a8842f2b583402.
We have a better fix commited for this now.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/nvme.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 8c35cab2b4..84062d388f 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1177,10 +1177,6 @@ static void nvme_cmb_write(void *opaque, hwaddr ad=
dr, uint64_t data,
     unsigned size)
 {
     NvmeCtrl *n =3D (NvmeCtrl *)opaque;
-
-    if (addr + size > NVME_CMBSZ_GETSIZE(n->bar.cmbsz)) {
-        return;
-    }
     memcpy(&n->cmbuf[addr], &data, size);
 }
=20
@@ -1189,9 +1185,6 @@ static uint64_t nvme_cmb_read(void *opaque, hwaddr =
addr, unsigned size)
     uint64_t val;
     NvmeCtrl *n =3D (NvmeCtrl *)opaque;
=20
-    if (addr + size > NVME_CMBSZ_GETSIZE(n->bar.cmbsz)) {
-        return 0;
-    }
     memcpy(&val, &n->cmbuf[addr], size);
     return val;
 }
--=20
2.19.1
