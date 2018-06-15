Received: from eggs.gnu.org ([2001:4830:134:3::10]:45634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fTmr3-0007zT-JU
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 07:25:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fTmr0-0000p8-9u
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 07:25:21 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri, 15 Jun 2018 13:24:52 +0200
Message-Id: <20180615112500.19854-5-david@redhat.com>
In-Reply-To: <20180615112500.19854-1-david@redhat.com>
References: <20180615112500.19854-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 04/12] pc-dimm: remove
 pc_dimm_get_free_slot() from header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

Not used outside of pc-dimm.c and there shouldn't be other users. If
other devices ever have to also sue slots, this has to be factored out.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/pc-dimm.c         | 4 +++-
 include/hw/mem/pc-dimm.h | 2 --
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 9e0c83e415..7387963cf1 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -27,6 +27,8 @@
 #include "sysemu/numa.h"
 #include "trace.h"
 
+static int pc_dimm_get_free_slot(const int *hint, int max_slots, Error **errp);
+
 void pc_dimm_plug(DeviceState *dev, MachineState *machine, uint64_t align,
                   Error **errp)
 {
@@ -111,7 +113,7 @@ static int pc_dimm_slot2bitmap(Object *obj, void *opaque)
     return 0;
 }
 
-int pc_dimm_get_free_slot(const int *hint, int max_slots, Error **errp)
+static int pc_dimm_get_free_slot(const int *hint, int max_slots, Error **errp)
 {
     unsigned long *bitmap;
     int slot = 0;
diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
index 860343d64f..cf71247630 100644
--- a/include/hw/mem/pc-dimm.h
+++ b/include/hw/mem/pc-dimm.h
@@ -76,8 +76,6 @@ typedef struct PCDIMMDeviceClass {
     MemoryRegion *(*get_vmstate_memory_region)(PCDIMMDevice *dimm);
 } PCDIMMDeviceClass;
 
-int pc_dimm_get_free_slot(const int *hint, int max_slots, Error **errp);
-
 void pc_dimm_plug(DeviceState *dev, MachineState *machine, uint64_t align,
                   Error **errp);
 void pc_dimm_unplug(DeviceState *dev, MachineState *machine);
-- 
2.17.1
