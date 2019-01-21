Received: from eggs.gnu.org ([209.51.188.92]:51817)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldyE-0004Tk-2k
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldyC-0004Hb-OD
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:50 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36978)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gldyC-0004Ga-DN
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:48 -0500
Received: by mail-wr1-x443.google.com with SMTP id s12so24494632wrt.4
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 10:06:48 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 21 Jan 2019 19:05:56 +0100
Message-Id: <1548093980-43088-26-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
References: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 25/49] pvh: Add x86/HVM direct boot ABI header
 file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Liam Merwick <Liam.Merwick@oracle.com>

The x86/HVM direct boot ABI permits Qemu to be able to boot directly
into the uncompressed Linux kernel binary with minimal firmware involvement.

	https://xenbits.xen.org/docs/unstable/misc/pvh.html

This commit adds the header file that defines the start_info struct
that needs to be populated in order to use this ABI.

The canonical version of start_info.h is in the Xen codebase.
(like QEMU, the Linux kernel uses a copy as well).

Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
Reviewed-by: Konrad Rzeszutek Wilk <Konrad.Wilk@oracle.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/xen/start_info.h | 146 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 146 insertions(+)
 create mode 100644 include/hw/xen/start_info.h

diff --git a/include/hw/xen/start_info.h b/include/hw/xen/start_info.h
new file mode 100644
index 0000000..348779e
--- /dev/null
+++ b/include/hw/xen/start_info.h
@@ -0,0 +1,146 @@
+/*
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to
+ * deal in the Software without restriction, including without limitation the
+ * rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
+ * sell copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+ * DEALINGS IN THE SOFTWARE.
+ *
+ * Copyright (c) 2016, Citrix Systems, Inc.
+ */
+
+#ifndef __XEN_PUBLIC_ARCH_X86_HVM_START_INFO_H__
+#define __XEN_PUBLIC_ARCH_X86_HVM_START_INFO_H__
+
+/*
+ * Start of day structure passed to PVH guests and to HVM guests in %ebx.
+ *
+ * NOTE: nothing will be loaded at physical address 0, so a 0 value in any
+ * of the address fields should be treated as not present.
+ *
+ *  0 +----------------+
+ *    | magic          | Contains the magic value XEN_HVM_START_MAGIC_VALUE
+ *    |                | ("xEn3" with the 0x80 bit of the "E" set).
+ *  4 +----------------+
+ *    | version        | Version of this structure. Current version is 1. New
+ *    |                | versions are guaranteed to be backwards-compatible.
+ *  8 +----------------+
+ *    | flags          | SIF_xxx flags.
+ * 12 +----------------+
+ *    | nr_modules     | Number of modules passed to the kernel.
+ * 16 +----------------+
+ *    | modlist_paddr  | Physical address of an array of modules
+ *    |                | (layout of the structure below).
+ * 24 +----------------+
+ *    | cmdline_paddr  | Physical address of the command line,
+ *    |                | a zero-terminated ASCII string.
+ * 32 +----------------+
+ *    | rsdp_paddr     | Physical address of the RSDP ACPI data structure.
+ * 40 +----------------+
+ *    | memmap_paddr   | Physical address of the (optional) memory map. Only
+ *    |                | present in version 1 and newer of the structure.
+ * 48 +----------------+
+ *    | memmap_entries | Number of entries in the memory map table. Only
+ *    |                | present in version 1 and newer of the structure.
+ *    |                | Zero if there is no memory map being provided.
+ * 52 +----------------+
+ *    | reserved       | Version 1 and newer only.
+ * 56 +----------------+
+ *
+ * The layout of each entry in the module structure is the following:
+ *
+ *  0 +----------------+
+ *    | paddr          | Physical address of the module.
+ *  8 +----------------+
+ *    | size           | Size of the module in bytes.
+ * 16 +----------------+
+ *    | cmdline_paddr  | Physical address of the command line,
+ *    |                | a zero-terminated ASCII string.
+ * 24 +----------------+
+ *    | reserved       |
+ * 32 +----------------+
+ *
+ * The layout of each entry in the memory map table is as follows:
+ *
+ *  0 +----------------+
+ *    | addr           | Base address
+ *  8 +----------------+
+ *    | size           | Size of mapping in bytes
+ * 16 +----------------+
+ *    | type           | Type of mapping as defined between the hypervisor
+ *    |                | and guest it's starting. E820_TYPE_xxx, for example.
+ * 20 +----------------|
+ *    | reserved       |
+ * 24 +----------------+
+ *
+ * The address and sizes are always a 64bit little endian unsigned integer.
+ *
+ * NB: Xen on x86 will always try to place all the data below the 4GiB
+ * boundary.
+ *
+ * Version numbers of the hvm_start_info structure have evolved like this:
+ *
+ * Version 0:
+ *
+ * Version 1:   Added the memmap_paddr/memmap_entries fields (plus 4 bytes of
+ *              padding) to the end of the hvm_start_info struct. These new
+ *              fields can be used to pass a memory map to the guest. The
+ *              memory map is optional and so guests that understand version 1
+ *              of the structure must check that memmap_entries is non-zero
+ *              before trying to read the memory map.
+ */
+#define XEN_HVM_START_MAGIC_VALUE 0x336ec578
+
+/*
+ * C representation of the x86/HVM start info layout.
+ *
+ * The canonical definition of this layout is above, this is just a way to
+ * represent the layout described there using C types.
+ */
+struct hvm_start_info {
+    uint32_t magic;             /* Contains the magic value 0x336ec578       */
+                                /* ("xEn3" with the 0x80 bit of the "E" set).*/
+    uint32_t version;           /* Version of this structure.                */
+    uint32_t flags;             /* SIF_xxx flags.                            */
+    uint32_t nr_modules;        /* Number of modules passed to the kernel.   */
+    uint64_t modlist_paddr;     /* Physical address of an array of           */
+                                /* hvm_modlist_entry.                        */
+    uint64_t cmdline_paddr;     /* Physical address of the command line.     */
+    uint64_t rsdp_paddr;        /* Physical address of the RSDP ACPI data    */
+                                /* structure.                                */
+    uint64_t memmap_paddr;      /* Physical address of an array of           */
+                                /* hvm_memmap_table_entry. Only present in   */
+                                /* version 1 and newer of the structure      */
+    uint32_t memmap_entries;    /* Number of entries in the memmap table.    */
+                                /* Only present in version 1 and newer of    */
+                                /* the structure. Value will be zero if      */
+                                /* there is no memory map being provided.    */
+    uint32_t reserved;
+};
+
+struct hvm_modlist_entry {
+    uint64_t paddr;             /* Physical address of the module.           */
+    uint64_t size;              /* Size of the module in bytes.              */
+    uint64_t cmdline_paddr;     /* Physical address of the command line.     */
+    uint64_t reserved;
+};
+
+struct hvm_memmap_table_entry {
+    uint64_t addr;              /* Base address of the memory region         */
+    uint64_t size;              /* Size of the memory region in bytes        */
+    uint32_t type;              /* Mapping type                              */
+    uint32_t reserved;
+};
+
+#endif /* __XEN_PUBLIC_ARCH_X86_HVM_START_INFO_H__ */
-- 
1.8.3.1
