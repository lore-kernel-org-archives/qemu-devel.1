Received: from eggs.gnu.org ([209.51.188.92]:38454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mopsfelder@gmail.com>) id 1gyJeO-0007Ma-HR
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 12:02:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mopsfelder@gmail.com>) id 1gyJeI-0007zw-Kn
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 12:02:44 -0500
From: Murilo Opsfelder Araujo <mopsfelder@gmail.com>
Date: Mon, 25 Feb 2019 14:01:53 -0300
Message-Id: <20190225170155.1972-2-muriloo@linux.ibm.com>
In-Reply-To: <20190225170155.1972-1-muriloo@linux.ibm.com>
References: <20190225170155.1972-1-muriloo@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 1/3] ppc/pnv: increase kernel size limit to
 256MiB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mopsfelder@gmail.com, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, qemu-ppc@nongnu.org

Building kernel with CONFIG_DEBUG_INFO_REDUCED can generate a ~90MB image and
building with CONFIG_DEBUG_INFO can generate a ~225M one, both exceeds the
current limit of 32MiB.

Increasing kernel size limit to 256MiB should fit for now.

Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
---
 hw/ppc/pnv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index da540860a2..1dbb62c4c9 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -54,6 +54,7 @@
 #define FW_MAX_SIZE             0x00400000
 
 #define KERNEL_LOAD_ADDR        0x20000000
+#define KERNEL_MAX_SIZE         (256 * MiB)
 #define INITRD_LOAD_ADDR        0x60000000
 
 static const char *pnv_chip_core_typename(const PnvChip *o)
@@ -588,7 +589,7 @@ static void pnv_init(MachineState *machine)
         long kernel_size;
 
         kernel_size = load_image_targphys(machine->kernel_filename,
-                                          KERNEL_LOAD_ADDR, 0x2000000);
+                                          KERNEL_LOAD_ADDR, KERNEL_MAX_SIZE);
         if (kernel_size < 0) {
             error_report("Could not load kernel '%s'",
                          machine->kernel_filename);
-- 
2.20.1
