Received: from eggs.gnu.org ([2001:4830:134:3::10]:50175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fEGUS-0000gz-7w
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:49:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fEGUP-0003fc-4b
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:49:52 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu,  3 May 2018 17:49:29 +0200
Message-Id: <20180503154936.18946-2-david@redhat.com>
In-Reply-To: <20180503154936.18946-1-david@redhat.com>
References: <20180503154936.18946-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 1/8] memory-device: always compile support
 for memory devices for SOFTMMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

Let's always compile support memory devices. MEM_HOTPLUG is very DIMM
specific.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/Makefile.objs          |  2 +-
 hw/mem/Makefile.objs      |  2 +-
 stubs/Makefile.objs       |  1 -
 stubs/qmp_memory_device.c | 13 -------------
 4 files changed, 2 insertions(+), 16 deletions(-)
 delete mode 100644 stubs/qmp_memory_device.c

diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 6a0ffe0afd..3d7d086930 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -33,7 +33,7 @@ devices-dirs-$(CONFIG_SOFTMMU) += vfio/
 devices-dirs-$(CONFIG_SOFTMMU) += virtio/
 devices-dirs-$(CONFIG_SOFTMMU) += watchdog/
 devices-dirs-$(CONFIG_SOFTMMU) += xen/
-devices-dirs-$(CONFIG_MEM_HOTPLUG) += mem/
+devices-dirs-$(CONFIG_SOFTMMU) += mem/
 devices-dirs-$(CONFIG_SOFTMMU) += smbios/
 devices-dirs-y += core/
 common-obj-y += $(devices-dirs-y)
diff --git a/hw/mem/Makefile.objs b/hw/mem/Makefile.objs
index 10be4df2a2..c5648fb2c5 100644
--- a/hw/mem/Makefile.objs
+++ b/hw/mem/Makefile.objs
@@ -1,3 +1,3 @@
 common-obj-$(CONFIG_MEM_HOTPLUG) += pc-dimm.o
-common-obj-$(CONFIG_MEM_HOTPLUG) += memory-device.o
+common-obj-y += memory-device.o
 common-obj-$(CONFIG_NVDIMM) += nvdimm.o
diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 53d3f32cb2..76ab2a9dbb 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -34,7 +34,6 @@ stub-obj-y += uuid.o
 stub-obj-y += vm-stop.o
 stub-obj-y += vmstate.o
 stub-obj-$(CONFIG_WIN32) += fd-register.o
-stub-obj-y += qmp_memory_device.o
 stub-obj-y += target-monitor-defs.o
 stub-obj-y += target-get-monitor-def.o
 stub-obj-y += pc_madt_cpu_entry.o
diff --git a/stubs/qmp_memory_device.c b/stubs/qmp_memory_device.c
deleted file mode 100644
index 85ff8f2d7e..0000000000
--- a/stubs/qmp_memory_device.c
+++ /dev/null
@@ -1,13 +0,0 @@
-#include "qemu/osdep.h"
-#include "qom/object.h"
-#include "hw/mem/memory-device.h"
-
-MemoryDeviceInfoList *qmp_memory_device_list(void)
-{
-   return NULL;
-}
-
-uint64_t get_plugged_memory_size(void)
-{
-    return (uint64_t)-1;
-}
-- 
2.14.3
