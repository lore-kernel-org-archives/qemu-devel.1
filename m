Received: from eggs.gnu.org ([2001:4830:134:3::10]:37889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ967-00048F-3X
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fZ966-00023H-3s
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:03 -0400
Received: from mail-wm0-x233.google.com ([2a00:1450:400c:c09::233]:34816)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fZ965-00021z-T0
	for qemu-devel@nongnu.org; Sat, 30 Jun 2018 02:11:02 -0400
Received: by mail-wm0-x233.google.com with SMTP id z137-v6so3958443wmc.0
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 23:11:01 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat, 30 Jun 2018 08:10:10 +0200
Message-Id: <20180630061040.6018-18-pbonzini@redhat.com>
In-Reply-To: <20180630061040.6018-1-pbonzini@redhat.com>
References: <20180630061040.6018-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 17/47] hw/misc: Use the IEC binary prefix
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

It eases code review, unit is explicit.

Patch generated using:

  $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include/hw/

and modified manually.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20180625124238.25339-16-f4bug@amsat.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/misc/auxbus.c | 3 ++-
 hw/misc/edu.c    | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/misc/auxbus.c b/hw/misc/auxbus.c
index b4cacd6..b8a8721 100644
--- a/hw/misc/auxbus.c
+++ b/hw/misc/auxbus.c
@@ -27,6 +27,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "qemu/log.h"
 #include "hw/misc/auxbus.h"
 #include "hw/i2c/i2c.h"
@@ -68,7 +69,7 @@ AUXBus *aux_init_bus(DeviceState *parent, const char *name)
 
     /* Memory related. */
     bus->aux_io = g_malloc(sizeof(*bus->aux_io));
-    memory_region_init(bus->aux_io, OBJECT(bus), "aux-io", (1 << 20));
+    memory_region_init(bus->aux_io, OBJECT(bus), "aux-io", 1 * MiB);
     address_space_init(&bus->aux_addr_space, bus->aux_io, "aux-io");
     return bus;
 }
diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index 34eb05d..df26a4d 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -23,6 +23,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/units.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/msi.h"
 #include "qemu/timer.h"
@@ -357,7 +358,7 @@ static void pci_edu_realize(PCIDevice *pdev, Error **errp)
                        edu, QEMU_THREAD_JOINABLE);
 
     memory_region_init_io(&edu->mmio, OBJECT(edu), &edu_mmio_ops, edu,
-                    "edu-mmio", 1 << 20);
+                    "edu-mmio", 1 * MiB);
     pci_register_bar(pdev, 0, PCI_BASE_ADDRESS_SPACE_MEMORY, &edu->mmio);
 }
 
-- 
1.8.3.1
