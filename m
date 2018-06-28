Received: from eggs.gnu.org ([2001:4830:134:3::10]:38028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAe-0007Fc-BR
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAd-0000VT-3d
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:36 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:36281)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYdAc-0000UE-Sf
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:35 -0400
Received: by mail-wr0-x22a.google.com with SMTP id f16-v6so6686837wrm.3
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:05:34 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 22:04:30 +0200
Message-Id: <1530216310-52873-21-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
References: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 20/60] pc-dimm: remove pc_dimm_get_free_slot()
 from header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

Not used outside of pc-dimm.c and there shouldn't be other users. If
other devices (e.g. memory devices) ever have to also use slots, then we
will have to factor this out.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180619134141.29478-5-david@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/mem/pc-dimm.c         | 4 +++-
 include/hw/mem/pc-dimm.h | 2 --
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 9e0c83e..7387963 100644
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
index 860343d..cf71247 100644
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
1.8.3.1
