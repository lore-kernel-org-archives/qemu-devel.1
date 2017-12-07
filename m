Received: from eggs.gnu.org ([2001:4830:134:3::10]:52105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eMtGP-0005PS-NS
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 05:18:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1eMtGO-0003Qk-Iv
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 05:18:45 -0500
Received: from mga06.intel.com ([134.134.136.31]:34562)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1eMtGO-000355-9Y
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 05:18:44 -0500
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Thu,  7 Dec 2017 18:18:09 +0800
Message-Id: <20171207101812.23602-8-haozhong.zhang@intel.com>
In-Reply-To: <20171207101812.23602-1-haozhong.zhang@intel.com>
References: <20171207101812.23602-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [RFC QEMU PATCH v4 07/10] xen-hvm: add functions to
 copy data from/to HVM memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Cc: Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
---
 hw/i386/xen/xen-hvm.c | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/xen/xen.h  |  3 +++
 stubs/xen-hvm.c       | 10 ++++++++++
 3 files changed, 68 insertions(+)

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index 3df20ff282..a7e99bd438 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -1494,3 +1494,58 @@ void xen_acpi_build(AcpiBuildTables *tables, GArray *table_offsets,
     build_rsdt(tables_blob, tables->linker, table_offsets, 0, 0);
     build_rsdp(tables->rsdp, tables->linker, rsdt);
 }
+
+static size_t xen_rw_guest(ram_addr_t gpa,
+                           void *buf, size_t length, bool is_write)
+{
+    size_t copied = 0, size;
+    ram_addr_t s, e, offset, cur = gpa;
+    xen_pfn_t cur_pfn;
+    void *page;
+    int prot = is_write ? PROT_WRITE : PROT_READ;
+
+    if (!buf || !length) {
+        return 0;
+    }
+
+    s = gpa & TARGET_PAGE_MASK;
+    e = gpa + length;
+    if (e < s) {
+        return 0;
+    }
+
+    while (cur < e) {
+        cur_pfn = cur >> TARGET_PAGE_BITS;
+        offset = cur - (cur_pfn << TARGET_PAGE_BITS);
+        size = MIN(length, TARGET_PAGE_SIZE - offset);
+
+        page = xenforeignmemory_map(xen_fmem, xen_domid, prot, 1, &cur_pfn, NULL);
+        if (!page) {
+            break;
+        }
+
+        if (is_write) {
+            memcpy(page + offset, buf, size);
+        } else {
+            memcpy(buf, page + offset, size);
+        }
+        xenforeignmemory_unmap(xen_fmem, page, 1);
+
+        copied += size;
+        buf += size;
+        cur += size;
+        length -= size;
+    }
+
+    return copied;
+}
+
+size_t xen_copy_to_guest(ram_addr_t gpa, void *buf, size_t length)
+{
+    return xen_rw_guest(gpa, buf, length, true);
+}
+
+size_t xen_copy_from_guest(ram_addr_t gpa, void *buf, size_t length)
+{
+    return xen_rw_guest(gpa, buf, length, false);
+}
diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
index 2785b8fd35..cc40d45aeb 100644
--- a/include/hw/xen/xen.h
+++ b/include/hw/xen/xen.h
@@ -52,4 +52,7 @@ void xen_register_framebuffer(struct MemoryRegion *mr);
 void xen_acpi_build(AcpiBuildTables *tables, GArray *table_offsets,
                     MachineState *machine);
 
+size_t xen_copy_to_guest(ram_addr_t gpa, void *buf, size_t length);
+size_t xen_copy_from_guest(ram_addr_t gpa, void *buf, size_t length);
+
 #endif /* QEMU_HW_XEN_H */
diff --git a/stubs/xen-hvm.c b/stubs/xen-hvm.c
index 58017c1457..5de02842a3 100644
--- a/stubs/xen-hvm.c
+++ b/stubs/xen-hvm.c
@@ -66,3 +66,13 @@ void xen_acpi_build(AcpiBuildTables *tables, GArray *table_offsets,
                     MachineState *machine)
 {
 }
+
+size_t xen_copy_to_guest(ram_addr_t gpa, void *buf, size_t length)
+{
+    return 0;
+}
+
+size_t xen_copy_from_guest(ram_addr_t gpa, void *buf, size_t length)
+{
+    return 0;
+}
-- 
2.15.1
