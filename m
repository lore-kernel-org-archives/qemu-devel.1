Received: from eggs.gnu.org ([2001:4830:134:3::10]:39616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1gKhRB-0004BB-79
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:21:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1gKhOo-00022Z-Ld
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:18:55 -0500
From: Dongjiu Geng <gengdongjiu@huawei.com>
Date: Thu, 8 Nov 2018 02:15:45 -0800
Message-ID: <1541672153-15529-3-git-send-email-gengdongjiu@huawei.com>
In-Reply-To: <1541672153-15529-1-git-send-email-gengdongjiu@huawei.com>
References: <1541672153-15529-1-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v15 02/10] acpi: add build_append_ghes_notify()
 helper for Hardware Error Notification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: imammedo@redhat.com, mst@redhat.com, peter.maydell@linaro.org, pbonzini@redhat.com, mtosatti@redhat.com, rth@twiddle.net, ehabkost@redhat.com, kvm@vger.kernel.org, shannon.zhaosl@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, gengdongjiu@huawei.com

It will help to add Hardware Error Notification to ACPI tables
without using packed C structures and avoid endianness
issues as API doesn't need explicit conversion.

Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
 hw/acpi/aml-build.c         | 22 ++++++++++++++++++++++
 include/hw/acpi/aml-build.h |  8 ++++++++
 2 files changed, 30 insertions(+)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 1e43cd7..4210c36 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -274,6 +274,28 @@ void build_append_gas(GArray *table, AmlAddressSpace as,
     build_append_int_noprefix(table, address, 8);
 }
 
+/* Hardware Error Notification
+ * ACPI 4.0: 17.3.2.7 Hardware Error Notification
+ */
+void build_append_ghes_notify(GArray *table, const uint8_t type,
+                              uint8_t length, uint16_t config_write_enable,
+                              uint32_t poll_interval, uint32_t vector,
+                              uint32_t polling_threshold_value,
+                              uint32_t polling_threshold_window,
+                              uint32_t error_threshold_value,
+                              uint32_t error_threshold_window)
+{
+        build_append_int_noprefix(table, type, 1); /* type */
+        build_append_int_noprefix(table, length, 1);
+        build_append_int_noprefix(table, config_write_enable, 2);
+        build_append_int_noprefix(table, poll_interval, 4);
+        build_append_int_noprefix(table, vector, 4);
+        build_append_int_noprefix(table, polling_threshold_value, 4);
+        build_append_int_noprefix(table, polling_threshold_window, 4);
+        build_append_int_noprefix(table, error_threshold_value, 4);
+        build_append_int_noprefix(table, error_threshold_window, 4);
+}
+
 /*
  * Build NAME(XXXX, 0x00000000) where 0x00000000 is encoded as a dword,
  * and return the offset to 0x00000000 for runtime patching.
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index 6c36903..a005052 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -409,6 +409,14 @@ build_append_gas_from_struct(GArray *table, const struct AcpiGenericAddress *s)
                      s->access_width, s->address);
 }
 
+void build_append_ghes_notify(GArray *table, const uint8_t type,
+                              uint8_t length, uint16_t config_write_enable,
+                              uint32_t poll_interval, uint32_t vector,
+                              uint32_t polling_threshold_value,
+                              uint32_t polling_threshold_window,
+                              uint32_t error_threshold_value,
+                              uint32_t error_threshold_window);
+
 void build_srat_memory(AcpiSratMemoryAffinity *numamem, uint64_t base,
                        uint64_t len, int node, MemoryAffinityFlags flags);
 
-- 
1.8.3.1
