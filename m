Received: from eggs.gnu.org ([2001:4830:134:3::10]:43397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1cMz0X-0002Pc-Ag
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:22:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1cMz0W-0000J7-7p
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:22:13 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:35919)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1cMz0W-0000Iu-2u
	for qemu-devel@nongnu.org; Fri, 30 Dec 2016 10:22:12 -0500
Received: by mail-pg0-x242.google.com with SMTP id n5so22380992pgh.3
	for <qemu-devel@nongnu.org>; Fri, 30 Dec 2016 07:22:12 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Fri, 30 Dec 2016 09:21:42 -0600
Message-Id: <1483111310-24808-12-git-send-email-minyard@acm.org>
In-Reply-To: <1483111310-24808-1-git-send-email-minyard@acm.org>
References: <1483111310-24808-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 11/19] acpi: Add i2c serial bus CRS handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: minyard@acm.org, Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/acpi/aml-build.c         | 40 ++++++++++++++++++++++++++++++++++++++++
 include/hw/acpi/aml-build.h | 18 ++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index b2a1e40..7b2673f 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1607,3 +1607,43 @@ void build_srat_memory(AcpiSratMemoryAffinity *numamem, uint64_t base,
     numamem->base_addr = cpu_to_le64(base);
     numamem->range_length = cpu_to_le64(len);
 }
+
+/* ACPI 5.0: 6.4.3.8.2 Serial Bus Connection Descriptors */
+static Aml *aml_serial_bus_device(uint8_t serial_bus_type, uint8_t flags,
+                                  uint16_t type_flags,
+                                  uint8_t revid, uint16_t data_length,
+                                  uint16_t resource_source_len)
+{
+    Aml *var = aml_alloc();
+    uint16_t length = data_length + resource_source_len + 9;
+
+    build_append_byte(var->buf, 0x8e); /* Serial Bus Connection Descriptor */
+    build_append_int_noprefix(var->buf, length, sizeof(length));
+    build_append_byte(var->buf, 1);    /* Revision ID */
+    build_append_byte(var->buf, 0);    /* Resource Source Index */
+    build_append_byte(var->buf, serial_bus_type); /* Serial Bus Type */
+    build_append_byte(var->buf, flags); /* General Flags */
+    build_append_int_noprefix(var->buf, type_flags, /* Type Specific Flags */
+                              sizeof(type_flags));
+    build_append_byte(var->buf, revid); /* Type Specification Revision ID */
+    build_append_int_noprefix(var->buf, data_length, sizeof(data_length));
+
+    return var;
+}
+
+/* ACPI 5.0: 6.4.3.8.2.1 I2C Serial Bus Connection Resource Descriptor */
+Aml *aml_i2c_serial_bus_device(uint16_t address, const char *resource_source)
+{
+    uint16_t resource_source_len = strlen(resource_source) + 1;
+    Aml *var = aml_serial_bus_device(AML_SERIAL_BUS_TYPE_I2C, 0, 0, 1,
+                                     6, resource_source_len);
+
+    /* Connection Speed.  Just set to 100K for now, it doesn't really matter. */
+    build_append_int_noprefix(var->buf, 100000, 4);
+    build_append_int_noprefix(var->buf, address, sizeof(address));
+
+    /* This is a string, not a name, so just copy it directly in. */
+    g_array_append_vals(var->buf, resource_source, resource_source_len);
+
+    return var;
+}
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index 559326c..27e23b1 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -213,6 +213,23 @@ struct AcpiBuildTables {
     BIOSLinker *linker;
 } AcpiBuildTables;
 
+/*
+ * ACPI 5.0: 6.4.3.8.2 Serial Bus Connection Descriptors
+ * Serial Bus Type
+ */
+#define AML_SERIAL_BUS_TYPE_I2C  1
+#define AML_SERIAL_BUS_TYPE_SPI  2
+#define AML_SERIAL_BUS_TYPE_UART 3
+
+/*
+ * ACPI 5.0: 6.4.3.8.2 Serial Bus Connection Descriptors
+ * General Flags
+ */
+/* Slave Mode */
+#define AML_SERIAL_BUS_FLAG_MASTER_DEVICE       (1 << 0)
+/* Consumer/Producer */
+#define AML_SERIAL_BUS_FLAG_CONSUME_ONLY        (1 << 1)
+
 /**
  * init_aml_allocator:
  *
@@ -337,6 +354,7 @@ Aml *aml_qword_memory(AmlDecode dec, AmlMinFixed min_fixed,
 Aml *aml_dma(AmlDmaType typ, AmlDmaBusMaster bm, AmlTransferSize sz,
              uint8_t channel);
 Aml *aml_sleep(uint64_t msec);
+Aml *aml_i2c_serial_bus_device(uint16_t address, const char *resource_source);
 
 /* Block AML object primitives */
 Aml *aml_scope(const char *name_format, ...) GCC_FMT_ATTR(1, 2);
-- 
2.7.4
