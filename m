Received: from eggs.gnu.org ([2001:4830:134:3::10]:58171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1cpkwd-00051m-DB
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 20:13:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <haozhong.zhang@intel.com>) id 1cpkwc-0004up-1y
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 20:13:07 -0400
Received: from mga03.intel.com ([134.134.136.65]:51743)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <haozhong.zhang@intel.com>)
	id 1cpkwb-0004uJ-O0
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 20:13:05 -0400
From: Haozhong Zhang <haozhong.zhang@intel.com>
Date: Mon, 20 Mar 2017 08:12:42 +0800
Message-Id: <20170320001249.25521-4-haozhong.zhang@intel.com>
In-Reply-To: <20170320001249.25521-1-haozhong.zhang@intel.com>
References: <20170320001249.25521-1-haozhong.zhang@intel.com>
Subject: [Qemu-devel] [RFC QEMU PATCH v2 03/10] xen-hvm: support copying
 ACPI to guest memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, xen-devel@lists.xen.org
Cc: Konrad Rzeszutek Wilk <konrad@darnok.org>, Dan Williams <dan.j.williams@intel.com>, Haozhong Zhang <haozhong.zhang@intel.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org

Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
---
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: xen-devel@lists.xenproject.org
---
 include/hw/xen/xen.h |  18 ++++++++
 xen-hvm-stub.c       |   6 +++
 xen-hvm.c            | 113 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 137 insertions(+)

diff --git a/include/hw/xen/xen.h b/include/hw/xen/xen.h
index 09c2ce5170..d67cdd8c7d 100644
--- a/include/hw/xen/xen.h
+++ b/include/hw/xen/xen.h
@@ -47,4 +47,22 @@ void xen_modified_memory(ram_addr_t start, ram_addr_t length);
 
 void xen_register_framebuffer(struct MemoryRegion *mr);
 
+/*
+ * Copy an ACPI blob from QEMU to HVM guest.
+ *
+ * Parameters:
+ *   name:    a unique name of the data blob; for XEN_DM_ACPI_BLOB_TYPE_NSDEV,
+ *            name should be less then 4 characters
+ *   blob:    the ACPI blob to be copied
+ *   length:  the length in bytes of the ACPI blob
+ *   type:    the type of content in the ACPI blob
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
diff --git a/xen-hvm-stub.c b/xen-hvm-stub.c
index c5003251cb..a6c018505c 100644
--- a/xen-hvm-stub.c
+++ b/xen-hvm-stub.c
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
diff --git a/xen-hvm.c b/xen-hvm.c
index c42c958a0a..4ddc47e5f1 100644
--- a/xen-hvm.c
+++ b/xen-hvm.c
@@ -1252,6 +1252,20 @@ static int dm_acpi_buf_init(XenIOState *state)
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
 static int xen_dm_acpi_required(PCMachineState *pcms)
 {
     return 0;
@@ -1486,3 +1500,102 @@ void qmp_xen_set_global_dirty_log(bool enable, Error **errp)
         memory_global_dirty_log_stop();
     }
 }
+
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
-- 
2.12.0
