Received: from eggs.gnu.org ([2001:4830:134:3::10]:33856)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cVZ7v-0004up-80
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 02:33:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1cVZ7u-0006dg-DE
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 02:33:19 -0500
Received: from mail-pf0-x22d.google.com ([2607:f8b0:400e:c00::22d]:36803)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1cVZ7u-0006dT-7S
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 02:33:18 -0500
Received: by mail-pf0-x22d.google.com with SMTP id 189so39280019pfu.3
	for <qemu-devel@nongnu.org>; Sun, 22 Jan 2017 23:33:18 -0800 (PST)
From: ben@skyportsystems.com
Date: Sun, 22 Jan 2017 23:32:47 -0800
Message-Id: <6d20d5be94de5e631dd5f706f68738b9b2bc88b2.1485155611.git.ben@skyportsystems.com>
In-Reply-To: <cover.1485155611.git.ben@skyportsystems.com>
References: <cover.1485155611.git.ben@skyportsystems.com>
In-Reply-To: <cover.1485155611.git.ben@skyportsystems.com>
References: <cover.1485155611.git.ben@skyportsystems.com>
Subject: [Qemu-devel] [PATCH v3 1/6] ACPI: Add a function for building named
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
2.10.1 (Apple Git-78)
