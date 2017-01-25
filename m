Received: from eggs.gnu.org ([2001:4830:134:3::10]:47457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cWCcw-0003hD-Kx
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 20:43:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cWCcs-0005Mo-J4
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 20:43:58 -0500
Received: from mail-yw0-x22c.google.com ([2607:f8b0:4002:c05::22c]:34440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1cWCcs-0005Lw-F2
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 20:43:54 -0500
Received: by mail-yw0-x22c.google.com with SMTP id w75so3587419ywg.1
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 17:43:52 -0800 (PST)
From: ben@skyportsystems.com
Date: Tue, 24 Jan 2017 17:43:20 -0800
Message-Id: <dabc5ffbb5b9d29e88087dcbe03b1ba0232c342c.1485308342.git.ben@skyportsystems.com>
In-Reply-To: <cover.1485308342.git.ben@skyportsystems.com>
References: <cover.1485308342.git.ben@skyportsystems.com>
In-Reply-To: <cover.1485308342.git.ben@skyportsystems.com>
References: <cover.1485308342.git.ben@skyportsystems.com>
Subject: [Qemu-devel] [PATCH v4 1/9] ACPI: Add a function for building named
 qword entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Ben Warren <ben@skyportsystems.com>

From: Ben Warren <ben@skyportsystems.com>

This is initially used to patch a 64-bit address into the VM Generation ID SSDT

Signed-off-by: Ben Warren <ben@skyportsystems.com>
---
 hw/acpi/aml-build.c         | 28 ++++++++++++++++++++++++++++
 include/hw/acpi/aml-build.h |  4 ++++
 2 files changed, 32 insertions(+)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index b2a1e40..dc4edc2 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -285,6 +285,34 @@ build_append_named_dword(GArray *array, const char *name_format, ...)
     return offset;
 }
 
+/*
+ * Build NAME(XXXX, 0x00000000) where 0x00000000 is encoded as a qword,
+ * and return the offset to 0x00000000 for runtime patching.
+ *
+ * Warning: runtime patching is best avoided. Only use this as
+ * a replacement for DataTableRegion (for guests that don't
+ * support it).
+ */
+int
+build_append_named_qword(GArray *array, const char *name_format, ...)
+{
+    int offset;
+    va_list ap;
+
+    build_append_byte(array, 0x08); /* NameOp */
+    va_start(ap, name_format);
+    build_append_namestringv(array, name_format, ap);
+    va_end(ap);
+
+    build_append_byte(array, 0x0E); /* QWordPrefix */
+
+    offset = array->len;
+    build_append_int_noprefix(array, 0x00000000, 8);
+    assert(array->len == offset + 8);
+
+    return offset;
+}
+
 static GPtrArray *alloc_list;
 
 static Aml *aml_alloc(void)
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index 559326c..dbf63cf 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -385,6 +385,10 @@ int
 build_append_named_dword(GArray *array, const char *name_format, ...)
 GCC_FMT_ATTR(2, 3);
 
+int
+build_append_named_qword(GArray *array, const char *name_format, ...)
+GCC_FMT_ATTR(2, 3);
+
 void build_srat_memory(AcpiSratMemoryAffinity *numamem, uint64_t base,
                        uint64_t len, int node, MemoryAffinityFlags flags);
 
-- 
2.7.4
