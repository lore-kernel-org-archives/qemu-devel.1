Received: from eggs.gnu.org ([209.51.188.92]:50775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gyEvG-0008R1-IE
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 06:59:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gyEvB-0008F3-NJ
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 06:59:46 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 25 Feb 2019 12:59:30 +0100
Message-Id: <1551095970-14645-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] block/nvme: Remove QEMU_PACKED from naturally
 aligned NVMeRegs struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>
Cc: qemu-block@nongnu.org, qemu-trivial@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>

The QEMU_PACKED is causing a compiler warning/error with GCC 9:

  CC      block/nvme.o
block/nvme.c: In function =E2=80=98nvme_create_queue_pair=E2=80=99:
block/nvme.c:209:22: error: taking address of packed member of
 =E2=80=98struct <anonymous>=E2=80=99 may result in an unaligned pointer =
value
 [-Werror=3Daddress-of-packed-member]
  209 |     q->sq.doorbell =3D &s->regs->doorbells[idx * 2 * s->doorbell_=
scale];

All members of the struct are naturally aligned, so there should
not be the need for QEMU_PACKED here, and the following QEMU_BUILD_BUG_ON
also ensures that there is no padding. Thus simply remove the QEMU_PACKED
here.

Buglink: https://bugs.launchpad.net/qemu/+bug/1817525
Reported-by: Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 block/nvme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/nvme.c b/block/nvme.c
index b5952c9..6c2ce7d 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -82,7 +82,7 @@ typedef volatile struct {
     uint8_t  reserved1[0xec0];
     uint8_t  cmd_set_specfic[0x100];
     uint32_t doorbells[];
-} QEMU_PACKED NVMeRegs;
+} NVMeRegs;
=20
 QEMU_BUILD_BUG_ON(offsetof(NVMeRegs, doorbells) !=3D 0x1000);
=20
--=20
1.8.3.1
