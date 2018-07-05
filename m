Received: from eggs.gnu.org ([2001:4830:134:3::10]:50946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fb2vY-0000pG-1I
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 08:00:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fb2vW-0002sZ-CX
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 08:00:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34168 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fb2vW-0002rS-7A
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 07:59:58 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B1250401EF02
	for <qemu-devel@nongnu.org>; Thu,  5 Jul 2018 11:59:57 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
Date: Thu,  5 Jul 2018 13:59:39 +0200
Message-Id: <20180705115943.29402-8-david@redhat.com>
In-Reply-To: <20180705115943.29402-1-david@redhat.com>
References: <20180705115943.29402-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 07/11] pc-dimm: implement memory device
 class function set_addr()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, David Hildenbrand <david@redhat.com>

We can change the address as long as the device has not been plugged
(== memory region mapped) yet.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/pc-dimm.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index a208b17c64..bb8e10903f 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -236,6 +236,28 @@ static uint64_t pc_dimm_md_get_addr(const MemoryDeviceState *md)
     return dimm->addr;
 }
 
+static void pc_dimm_md_set_addr(MemoryDeviceState *md, uint64_t addr,
+                                Error **errp)
+{
+    PCDIMMDevice *dimm = PC_DIMM(md);
+    const PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(md);
+    Error *local_err = NULL;
+    MemoryRegion *mr;
+
+    mr = ddc->get_memory_region(dimm, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    if (memory_region_is_mapped(mr)) {
+        error_setg(errp, "Can't change address, memory region already mapped.");
+        return;
+    }
+
+    dimm->addr = addr;
+}
+
 static uint64_t pc_dimm_md_get_plugged_size(const MemoryDeviceState *md,
                                             Error **errp)
 {
@@ -307,6 +329,7 @@ static void pc_dimm_class_init(ObjectClass *oc, void *data)
     ddc->get_vmstate_memory_region = pc_dimm_get_memory_region;
 
     mdc->get_addr = pc_dimm_md_get_addr;
+    mdc->set_addr = pc_dimm_md_set_addr;
     mdc->get_plugged_size = pc_dimm_md_get_plugged_size;
     mdc->get_memory_region = pc_dimm_md_get_memory_region;
     mdc->fill_device_info = pc_dimm_md_fill_device_info;
-- 
2.17.1
