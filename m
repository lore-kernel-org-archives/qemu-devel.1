Received: from eggs.gnu.org ([2001:4830:134:3::10]:33523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1er2fj-0004jM-79
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 09:25:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1er2fi-0001w7-Ak
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 09:25:31 -0500
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 28 Feb 2018 15:23:50 +0100
Message-Id: <1519827835-239519-6-git-send-email-imammedo@redhat.com>
In-Reply-To: <1519827835-239519-1-git-send-email-imammedo@redhat.com>
References: <1519827835-239519-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH v2 05/10] acpi: move ACPI_PORT_SMI_CMD define
 to header it belongs to
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Auger Eric <eric.auger@redhat.com>, qemu-arm@nongnu.org

ACPI_PORT_SMI_CMD is alias for APM_CNT_IOPORT,
so make it really one instead of duplicating its value.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/isa/apm.h | 3 +++
 hw/i386/acpi-build.c | 2 --
 hw/isa/apm.c         | 1 -
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/hw/isa/apm.h b/include/hw/isa/apm.h
index 4839ff1..b7098bf 100644
--- a/include/hw/isa/apm.h
+++ b/include/hw/isa/apm.h
@@ -5,6 +5,9 @@
 #include "hw/hw.h"
 #include "exec/memory.h"
 
+#define APM_CNT_IOPORT  0xb2
+#define ACPI_PORT_SMI_CMD APM_CNT_IOPORT
+
 typedef void (*apm_ctrl_changed_t)(uint32_t val, void *arg);
 
 typedef struct APMState {
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index b85fefe..699f3a0 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -255,8 +255,6 @@ static void acpi_get_pci_holes(Range *hole, Range *hole64)
                                                NULL));
 }
 
-#define ACPI_PORT_SMI_CMD           0x00b2 /* TODO: this is APM_CNT_IOPORT */
-
 static void acpi_align_size(GArray *blob, unsigned align)
 {
     /* Align size to multiple of given size. This reduces the chance
diff --git a/hw/isa/apm.c b/hw/isa/apm.c
index e232b0d..c3101ef 100644
--- a/hw/isa/apm.c
+++ b/hw/isa/apm.c
@@ -34,7 +34,6 @@
 #endif
 
 /* fixed I/O location */
-#define APM_CNT_IOPORT  0xb2
 #define APM_STS_IOPORT  0xb3
 
 static void apm_ioport_writeb(void *opaque, hwaddr addr, uint64_t val,
-- 
2.7.4
