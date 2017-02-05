Received: from eggs.gnu.org ([2001:4830:134:3::10]:59505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1caIsB-0002XD-Fx
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 04:12:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1caIs9-0001r1-2W
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 04:12:39 -0500
Received: from mail-pg0-x230.google.com ([2607:f8b0:400e:c05::230]:35453)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1caIs8-0001qt-RT
	for qemu-devel@nongnu.org; Sun, 05 Feb 2017 04:12:36 -0500
Received: by mail-pg0-x230.google.com with SMTP id 194so19475546pgd.2
	for <qemu-devel@nongnu.org>; Sun, 05 Feb 2017 01:12:36 -0800 (PST)
From: ben@skyportsystems.com
Date: Sun,  5 Feb 2017 01:11:56 -0800
Message-Id: <e531606c10f3c40dbc10d0fa4a4a5d806d7946d9.1486285434.git.ben@skyportsystems.com>
In-Reply-To: <cover.1486285434.git.ben@skyportsystems.com>
References: <cover.1486285434.git.ben@skyportsystems.com>
In-Reply-To: <cover.1486285434.git.ben@skyportsystems.com>
References: <cover.1486285434.git.ben@skyportsystems.com>
Subject: [Qemu-devel] [PATCH v5 01/10] ACPI: Add a function for building
 named qword entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: lersek@redhat.com, mst@redhat.com, imammedo@redhat.com, Ben Warren <ben@skyportsystems.com>

From: Ben Warren <ben@skyportsystems.com>

This is initially used to patch a 64-bit address into
the VM Generation ID SSDT

Signed-off-by: Ben Warren <ben@skyportsystems.com>
---
 hw/acpi/aml-build.c         | 35 +++++++++++++++++++++++++++++++++++
 include/hw/acpi/aml-build.h |  4 ++++
 2 files changed, 39 insertions(+)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index b2a1e40..9fc54c9 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -264,6 +264,9 @@ static void build_append_int(GArray *table, uint64_t value)
  * Warning: runtime patching is best avoided. Only use this as
  * a replacement for DataTableRegion (for guests that don't
  * support it).
+ *
+ * ACPI 5.0: 19.2.5
+ * 32-bit integers are supported beginning with ACPI 1.0
  */
 int
 build_append_named_dword(GArray *array, const char *name_format, ...)
@@ -285,6 +288,38 @@ build_append_named_dword(GArray *array, const char *name_format, ...)
     return offset;
 }
 
+/*
+ * Build NAME(XXXX, 0x0000000000000000) where 0x0000000000000000
+ * is encoded as a qword, and return the offset to 0x0000000000000000
+ * for runtime patching.
+ *
+ * Warning: runtime patching is best avoided. Only use this as
+ * a replacement for DataTableRegion (for guests that don't
+ * support it).
+ *
+ * ACPI 5.0: 19.2.5
+ * 64-bit integers are supported beginning with ACPI 2.0
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
+    build_append_int_noprefix(array, 0x0000000000000000, 8);
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
