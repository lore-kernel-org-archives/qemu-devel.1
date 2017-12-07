Received: from eggs.gnu.org ([2001:4830:134:3::10]:51533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN408-00049C-Iw
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:46:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1eN406-0006Ze-JY
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:46:40 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:39837)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tcminyard@gmail.com>) id 1eN406-0006Y4-9N
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 16:46:38 -0500
Received: by mail-pg0-x243.google.com with SMTP id w7so5384351pgv.6
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 13:46:38 -0800 (PST)
Sender: Corey Minyard <tcminyard@gmail.com>
From: minyard@acm.org
Date: Thu,  7 Dec 2017 15:46:18 -0600
Message-Id: <1512683181-8420-12-git-send-email-minyard@acm.org>
In-Reply-To: <1512683181-8420-1-git-send-email-minyard@acm.org>
References: <1512683181-8420-1-git-send-email-minyard@acm.org>
Subject: [Qemu-devel] [PATCH 11/14] acpi: Add i2c serial bus CRS handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Corey Minyard <cminyard@mvista.com>

From: Corey Minyard <cminyard@mvista.com>

Signed-off-by: Corey Minyard <cminyard@mvista.com>
---
 hw/acpi/aml-build.c         | 40 ++++++++++++++++++++++++++++++++++++++++
 include/hw/acpi/aml-build.h | 18 ++++++++++++++++++
 2 files changed, 58 insertions(+)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 36a6cc4..36e2263 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1662,3 +1662,43 @@ void build_slit(GArray *table_data, BIOSLinker *linker)
                  "SLIT",
                  table_data->len - slit_start, 1, NULL, NULL);
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
index 88d0738..26fece8 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -214,6 +214,23 @@ struct AcpiBuildTables {
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
@@ -338,6 +355,7 @@ Aml *aml_qword_memory(AmlDecode dec, AmlMinFixed min_fixed,
 Aml *aml_dma(AmlDmaType typ, AmlDmaBusMaster bm, AmlTransferSize sz,
              uint8_t channel);
 Aml *aml_sleep(uint64_t msec);
+Aml *aml_i2c_serial_bus_device(uint16_t address, const char *resource_source);
 
 /* Block AML object primitives */
 Aml *aml_scope(const char *name_format, ...) GCC_FMT_ATTR(1, 2);
-- 
2.7.4
