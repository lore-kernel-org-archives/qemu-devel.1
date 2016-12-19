Received: from eggs.gnu.org ([2001:4830:134:3::10]:52964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cJ6hf-0004nw-Gy
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 17:46:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cJ6hc-0008Aj-FX
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 17:46:43 -0500
Received: from mail-io0-x22e.google.com ([2607:f8b0:4001:c06::22e]:34759)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1cJ6hc-0008AP-BV
	for qemu-devel@nongnu.org; Mon, 19 Dec 2016 17:46:40 -0500
Received: by mail-io0-x22e.google.com with SMTP id p42so165412081ioo.1
	for <qemu-devel@nongnu.org>; Mon, 19 Dec 2016 14:46:40 -0800 (PST)
From: ben@skyportsystems.com
Date: Mon, 19 Dec 2016 14:46:31 -0800
Message-Id: <8f8971ae6feb51f445e50f65ad70d276b1ac231e.1482187052.git.ben@skyportsystems.com>
In-Reply-To: <cover.1482187052.git.ben@skyportsystems.com>
References: <cover.1482187052.git.ben@skyportsystems.com>
In-Reply-To: <cover.1482187052.git.ben@skyportsystems.com>
References: <cover.1482187052.git.ben@skyportsystems.com>
Subject: [Qemu-devel] [PATCH 2/5] ACPI: Add a function for building named
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
