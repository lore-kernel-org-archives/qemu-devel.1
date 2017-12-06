Received: from eggs.gnu.org ([2001:4830:134:3::10]:54045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eMYNA-0003Tf-MI
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 07:00:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1eMYN0-0002bv-TK
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 07:00:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:58902
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1eMYN0-0002a1-Nn
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 07:00:10 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vB6BxFR8004167
	for <qemu-devel@nongnu.org>; Wed, 6 Dec 2017 07:00:08 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2epdk6860x-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 07:00:07 -0500
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Wed, 6 Dec 2017 12:00:05 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Wed,  6 Dec 2017 13:00:00 +0100
Message-Id: <20171206120000.63822-1-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH/RFC] s390x: split memory into 4TB chunks
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
limiting the memory per slot to 7.999TB. Lets split the base memory
into 4TB chunks to allow go beyond 8TB for a guest. With that (and
optimistic overcommitment in the kernel) I was able to start  a 59TB
guest on a 1TB system.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/s390x/s390-virtio-ccw.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 8425534..6735bbb 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -157,11 +157,25 @@ static void virtio_ccw_register_hcalls(void)
 static void s390_memory_init(ram_addr_t mem_size)
 {
     MemoryRegion *sysmem = get_system_memory();
-    MemoryRegion *ram = g_new(MemoryRegion, 1);
+    ram_addr_t chunk, offset;
+    gchar *name;
 
     /* allocate RAM for core */
-    memory_region_allocate_system_memory(ram, NULL, "s390.ram", mem_size);
-    memory_region_add_subregion(sysmem, 0, ram);
+    offset = 0;
+    while (mem_size) {
+        MemoryRegion *ram = g_new(MemoryRegion, 1);
+        chunk = mem_size;
+        /* KVM does not allow memslots >= 8 TB. Lets split into 4TB chunks */
+        if (chunk > 4UL * 1024 * 1024 * 1024 * 1024) {
+            chunk = 4UL * 1024 * 1024 * 1024 * 1024;
+        }
+        name = g_strdup_printf("s390.ram[0x%lx]", offset);
+        memory_region_allocate_system_memory(ram, NULL, name, chunk);
+        memory_region_add_subregion(sysmem, offset, ram);
+        mem_size -= chunk;
+        offset += chunk;
+        g_free(name);
+    }
 
     /* Initialize storage key device */
     s390_skeys_init();
-- 
2.9.4
