Received: from eggs.gnu.org ([2001:4830:134:3::10]:56292)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1drGYE-0000xs-Sd
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 00:42:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1drGYA-0004Ze-U9
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 00:42:26 -0400
Received: from mga04.intel.com ([192.55.52.120]:23374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1drGYA-0004UV-KI
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 00:42:22 -0400
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Mon, 11 Sep 2017 12:41:53 +0800
Message-Id: <20170911044157.15403-7-haozhong.zhang@intel.com>
In-Reply-To: <20170911044157.15403-1-haozhong.zhang@intel.com>
References: <20170911044157.15403-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [RFC QEMU PATCH v3 06/10] hw/xen-hvm: add function to
 copy ACPI into guest memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xen.org
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Dan Williams <dan.j.williams@intel.com>, Chao Peng <chao.p.peng@linux.intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

Xen relies on QEMU to build guest NFIT and NVDIMM namespace devices,
and implements an interface to allow QEMU to copy its ACPI into guest
memory. This commit implements the QEMU side support.

The location of guest memory that can receive QEMU ACPI can be found
from XenStore entries /local/domain/$dom_id/hvmloader/dm-acpi/{address,length},
which have been handled by previous commit.

QEMU ACPI copied to guest is organized in blobs. For each blob, QEMU
creates following XenStore entries under
/local/domain/$dom_id/hvmloader/dm-acpi/$name to indicate its type,
location in above guest memory region and size.
 - type   the type of the passed ACPI, which can be the following
          values.
    * XEN_DM_ACPI_BLOB_TYPE_TABLE (0) indicates it's a complete ACPI
      table, and its signature is indicated by $name in the XenStore
      path.
    * XEN_DM_ACPI_BLOB_TYPE_NSDEV (1) indicates it's the body of a
      namespace device, and its device name is indicated by $name in
      the XenStore path.
 - offset  offset in byte from the beginning of above guest memory region
 - length  size in byte of the copied ACPI

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/i386/xen/xen-hvm.c | 113 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/xen/xen.h  |  18 ++++++++
 stubs/xen-hvm.c       |   6 +++
 3 files changed, 137 insertions(+)

diff --git a/hw/i386/xen/xen-hvm.c b/hw/i386/xen/xen-hvm.c
index ae895aaf03..b74c4ffb9c 100644
--- a/hw/i386/xen/xen-hvm.c
+++ b/hw/i386/xen/xen-hvm.c
@@ -1286,6 +1286,20 @@ static int dm_acpi_buf_init(XenIOState *state)
     return 0;
 }
 
+static ram_addr_t dm_acpi_buf_alloc(size_t length)
+{
+    ram_addr_t addr;
+
+    if (dm_acpi_buf->length - dm_acpi_buf->used < length) {
+        return 0;
+    }
+
+    addr = dm_acpi_buf->base + dm_acpi_buf->used;
+    dm_acpi_buf->used += length;
+
+    return addr;
+}
+
 static int xen_dm_acpi_init(PCMachineState *pcms, XenIOState *state)
 {
     if (!xen_dm_acpi_needed(pcms)) {
@@ -1295,6 +1309,105 @@ static int xen_dm_acpi_init(PCMachineState *pcms, XenIOState *state)
     return dm_acpi_buf_init(state);
 }
 
+static int xs_write_dm_acpi_blob_entry(const char *name,
+                                       const char *entry, const char *value)
+{
+    XenIOState *state = container_of(dm_acpi_buf, XenIOState, dm_acpi_buf);
+    char path[80];
+
+    snprintf(path, sizeof(path),
+             "/local/domain/%d"HVM_XS_DM_ACPI_ROOT"/%s/%s",
+             xen_domid, name, entry);
+    if (!xs_write(state->xenstore, 0, path, value, strlen(value))) {
+        return -EIO;
+    }
+
+    return 0;
+}
+
+static size_t xen_memcpy_to_guest(ram_addr_t gpa,
+                                  const void *buf, size_t length)
+{
+    size_t copied = 0, size;
+    ram_addr_t s, e, offset, cur = gpa;
+    xen_pfn_t cur_pfn;
+    void *page;
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
+        size = (length >= TARGET_PAGE_SIZE - offset) ?
+               TARGET_PAGE_SIZE - offset : length;
+
+        page = xenforeignmemory_map(xen_fmem, xen_domid, PROT_READ | PROT_WRITE,
+                                    1, &cur_pfn, NULL);
+        if (!page) {
+            break;
+        }
+
+        memcpy(page + offset, buf, size);
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
+int xen_acpi_copy_to_guest(const char *name, const void *blob, size_t length,
+                           int type)
+{
+    char value[21];
+    ram_addr_t buf_addr;
+    int rc;
+
+    if (type != XEN_DM_ACPI_BLOB_TYPE_TABLE &&
+        type != XEN_DM_ACPI_BLOB_TYPE_NSDEV) {
+        return -EINVAL;
+    }
+
+    buf_addr = dm_acpi_buf_alloc(length);
+    if (!buf_addr) {
+        return -ENOMEM;
+    }
+    if (xen_memcpy_to_guest(buf_addr, blob, length) != length) {
+        return -EIO;
+    }
+
+    snprintf(value, sizeof(value), "%d", type);
+    rc = xs_write_dm_acpi_blob_entry(name, "type", value);
+    if (rc) {
+        return rc;
+    }
+
+    snprintf(value, sizeof(value), "%"PRIu64, buf_addr - dm_acpi_buf->base);
+    rc = xs_write_dm_acpi_blob_entry(name, "offset", value);
+    if (rc) {
+        return rc;
+    }
+
+    snprintf(value, sizeof(value), "%"PRIu64, length);
+    rc = xs_write_dm_acpi_blob_entry(name, "length", value);
+    if (rc) {
+        return rc;
+    }
+
+    return 0;
+}
+
 void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
 {
     int i, rc;
diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
index 7efcdaa8fe..38dcd1a7d4 100644
--- a/include/hw/xen/xen.h
+++ b/include/hw/xen/xen.h
@@ -48,4 +48,22 @@ void xen_hvm_modified_memory(ram_addr_t start, ram_addr_t length);
 
 void xen_register_framebuffer(struct MemoryRegion *mr);
 
+/*
+ * Copy an ACPI blob from QEMU to HVM guest.
+ *
+ * Parameters:
+ *  name:   a unique name of the data blob; for XEN_DM_ACPI_BLOB_TYPE_NSDEV,
+ *          name should be less then 4 characters
+ *  blob:   the ACPI blob to be copied
+ *  length: the length in bytes of the ACPI blob
+ *  type:   the type of content in the ACPI blob, one of XEN_DM_ACPI_BLOB_TYPE_*
+ *
+ * Return:
+ *   0 on success; a non-zero error code on failures.
+ */
+#define XEN_DM_ACPI_BLOB_TYPE_TABLE 0 /* ACPI table */
+#define XEN_DM_ACPI_BLOB_TYPE_NSDEV 1 /* AML of ACPI namespace device */
+int xen_acpi_copy_to_guest(const char *name, const void *blob, size_t length,
+                           int type);
+
 #endif /* QEMU_HW_XEN_H */
diff --git a/stubs/xen-hvm.c b/stubs/xen-hvm.c
index 3ca6c51b21..58889ae0fb 100644
--- a/stubs/xen-hvm.c
+++ b/stubs/xen-hvm.c
@@ -61,3 +61,9 @@ void xen_hvm_init(PCMachineState *pcms, MemoryRegion **ram_memory)
 void qmp_xen_set_global_dirty_log(bool enable, Error **errp)
 {
 }
+
+int xen_acpi_copy_to_guest(const char *name, const void *blob, size_t length,
+                           int type)
+{
+    return -1;
+}
-- 
2.11.0
