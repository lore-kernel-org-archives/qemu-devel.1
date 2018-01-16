Received: from eggs.gnu.org ([2001:4830:134:3::10]:44862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebVMh-0006kW-UN
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:49:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ebVMe-0001ZH-1B
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:49:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ebVMd-0001Yy-QS
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 12:49:35 -0500
Date: Tue, 16 Jan 2018 19:49:26 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1516121887-32738-10-git-send-email-mst@redhat.com>
References: <1516121887-32738-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1516121887-32738-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 09/34] pci/shpc: Move function to generic
 header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Yuval Shaia <yuval.shaia@oracle.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Marcel Apfelbaum <marcel@redhat.com>

From: Yuval Shaia <yuval.shaia@oracle.com>

This function should be declared in generic header file so we can
utilize it.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/qemu/host-utils.h | 10 ++++++++++
 hw/pci/shpc.c             | 13 ++-----------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/qemu/host-utils.h b/include/qemu/host-utils.h
index 5ac621c..38da849 100644
--- a/include/qemu/host-utils.h
+++ b/include/qemu/host-utils.h
@@ -400,6 +400,16 @@ static inline uint64_t pow2ceil(uint64_t value)
     return 0x8000000000000000ull >> (n - 1);
 }
=20
+static inline uint32_t pow2roundup32(uint32_t x)
+{
+    x |=3D (x >> 1);
+    x |=3D (x >> 2);
+    x |=3D (x >> 4);
+    x |=3D (x >> 8);
+    x |=3D (x >> 16);
+    return x + 1;
+}
+
 /**
  * urshift - 128-bit Unsigned Right Shift.
  * @plow: in/out - lower 64-bit integer.
diff --git a/hw/pci/shpc.c b/hw/pci/shpc.c
index 69fc14b..a8462d4 100644
--- a/hw/pci/shpc.c
+++ b/hw/pci/shpc.c
@@ -1,6 +1,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
+#include "qemu/host-utils.h"
 #include "qemu/range.h"
 #include "qemu/error-report.h"
 #include "hw/pci/shpc.h"
@@ -122,16 +123,6 @@
 #define SHPC_PCI_TO_IDX(pci_slot) ((pci_slot) - 1)
 #define SHPC_IDX_TO_PHYSICAL(slot) ((slot) + 1)
=20
-static int roundup_pow_of_two(int x)
-{
-    x |=3D (x >> 1);
-    x |=3D (x >> 2);
-    x |=3D (x >> 4);
-    x |=3D (x >> 8);
-    x |=3D (x >> 16);
-    return x + 1;
-}
-
 static uint16_t shpc_get_status(SHPCDevice *shpc, int slot, uint16_t msk=
)
 {
     uint8_t *status =3D shpc->config + SHPC_SLOT_STATUS(slot);
@@ -656,7 +647,7 @@ int shpc_init(PCIDevice *d, PCIBus *sec_bus, MemoryRe=
gion *bar,
=20
 int shpc_bar_size(PCIDevice *d)
 {
-    return roundup_pow_of_two(SHPC_SLOT_REG(SHPC_MAX_SLOTS));
+    return pow2roundup32(SHPC_SLOT_REG(SHPC_MAX_SLOTS));
 }
=20
 void shpc_cleanup(PCIDevice *d, MemoryRegion *bar)
--=20
MST
