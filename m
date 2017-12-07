Received: from eggs.gnu.org ([2001:4830:134:3::10]:33601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eMxd6-0003Zt-NH
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 09:58:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eMxd3-0004f6-Hf
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 09:58:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:43514
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eMxd3-0004ec-Aj
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 09:58:25 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB7EtBch066366
	for <qemu-devel@nongnu.org>; Thu, 7 Dec 2017 09:58:22 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2eq4b33wvq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 09:58:22 -0500
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 7 Dec 2017 14:58:20 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu,  7 Dec 2017 15:58:16 +0100
Message-Id: <20171207145816.87347-1-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH/RFC v2] s390x: start a new memory region if the
 old one exceeds KVM_MEM_MAX_NR_PAGES
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, Christian Borntraeger <borntraeger@de.ibm.com>

KVM does not allow memory regions > KVM_MEM_MAX_NR_PAGES, basically
limiting the memory per slot to 8TB-4k. Lets start a new memory region
if we cross that boundary.

With that (and optimistic overcommitment in the kernel) I was able to
start  a 24TB guest on a 1TB system.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/s390x/s390-virtio-ccw.c | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 8425534..3630f6a 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -154,14 +154,41 @@ static void virtio_ccw_register_hcalls(void)
                                    virtio_ccw_hcall_early_printk);
 }
 
+/*
+ * KVM does only support memory slots up to KVM_MEM_MAX_NR_PAGES pages
+ * as the dirty bitmap must be managed by bitops that take an int as
+ * position indicator. If we have a guest beyond that we will split off
+ * new subregions.
+ */
+#define KVM_SLOT_MAX ((((1UL << 31) - 1) * 4096) & ~0xfffffUL )
+
 static void s390_memory_init(ram_addr_t mem_size)
 {
     MemoryRegion *sysmem = get_system_memory();
-    MemoryRegion *ram = g_new(MemoryRegion, 1);
+    ram_addr_t chunk, offset;
+    unsigned int number;
+    gchar *name;
 
     /* allocate RAM for core */
-    memory_region_allocate_system_memory(ram, NULL, "s390.ram", mem_size);
-    memory_region_add_subregion(sysmem, 0, ram);
+    offset = 0;
+    number = 0;
+    name = g_strdup_printf("s390.ram");
+    while (mem_size) {
+        MemoryRegion *ram = g_new(MemoryRegion, 1);
+        chunk = mem_size;
+        /* KVM does not allow memslots >= 8 TB */
+        if (chunk > KVM_SLOT_MAX) {
+            chunk = KVM_SLOT_MAX;
+        }
+        memory_region_allocate_system_memory(ram, NULL, name, chunk);
+        memory_region_add_subregion(sysmem, offset, ram);
+        mem_size -= chunk;
+        offset += chunk;
+	number++;
+        g_free(name);
+        name = g_strdup_printf("s390.ram.%u", number);
+    }
+    g_free(name);
 
     /* Initialize storage key device */
     s390_skeys_init();
-- 
2.9.4
