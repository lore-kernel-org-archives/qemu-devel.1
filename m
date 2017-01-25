Received: from eggs.gnu.org ([2001:4830:134:3::10]:33533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cWJ8f-0006Yi-3x
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 03:41:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cWJ8Y-0007Cj-Hy
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 03:41:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37638)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cWJ8Y-0007C2-AP
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 03:41:02 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 25 Jan 2017 09:40:58 +0100
Message-Id: <1485333658-23035-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] null-machine: Add support for the "-kernel"
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, Laurent Vivier <laurent@vivier.eu>, Max Filippov <jcmvbkbc@gmail.com>

We can have basic support for the "-kernel" parameter quite easily
by using the generic loader device. This should be enough for most
boards which do not need special machine-specific magic for loading
a kernel (and for those that need special magic, the generic "none"
machine is likely not suitable for using it as an instruction set
simulator board anyway).

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 PS: If we can't agree on using the generic loader here, I can also
     prepare a patch instead that simply prints out an error message
     if the user tried to use the "-kernel" parameter.

 hw/core/null-machine.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/core/null-machine.c b/hw/core/null-machine.c
index 27c8369..866e699 100644
--- a/hw/core/null-machine.c
+++ b/hw/core/null-machine.c
@@ -5,6 +5,7 @@
  *
  * Authors:
  *  Anthony Liguori   <aliguori@us.ibm.com>
+ *  Thomas Huth       <thuth@redhat.com>
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or later.
  * See the COPYING file in the top-level directory.
@@ -16,6 +17,7 @@
 #include "qemu/error-report.h"
 #include "hw/hw.h"
 #include "hw/boards.h"
+#include "hw/core/generic-loader.h"
 #include "sysemu/sysemu.h"
 #include "exec/address-spaces.h"
 #include "cpu.h"
@@ -40,6 +42,18 @@ static void machine_none_init(MachineState *mch)
         memory_region_allocate_system_memory(ram, NULL, "ram", mch->ram_size);
         memory_region_add_subregion(get_system_memory(), 0, ram);
     }
+
+    /* Load kernel */
+    if (mch->kernel_filename) {
+        DeviceState *loader;
+
+        loader = qdev_create(sysbus_get_default(), TYPE_GENERIC_LOADER);
+        qdev_prop_set_string(loader, "file", mch->kernel_filename);
+        if (cpu) {
+            qdev_prop_set_uint32(loader, "cpu-num", cpu->cpu_index);
+        }
+        qdev_init_nofail(loader);
+    }
 }
 
 static void machine_none_machine_init(MachineClass *mc)
-- 
1.8.3.1
