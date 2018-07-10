Received: from eggs.gnu.org ([2001:4830:134:3::10]:36029)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fcg62-00018E-NC
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 20:01:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fcg60-0001nj-37
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 20:01:34 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38462 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fcg5z-0001nV-UK
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 20:01:32 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 740154023470
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 00:01:31 +0000 (UTC)
Date: Tue, 10 Jul 2018 03:01:30 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180710000024.542612-2-mst@redhat.com>
References: <20180710000024.542612-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710000024.542612-1-mst@redhat.com>
Subject: [Qemu-devel] [PATCH hack dontapply v2 1/7] acpi: aml: add
 aml_register()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: ehabkost@redhat.com, imammedo@redhat.com, pbonzini@redhat.com

Based on a patch by Igor Mammedov.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/aml-build.h |  5 +++++
 hw/acpi/aml-build.c         | 21 +++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index 6c36903c0a..10c7946028 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -346,6 +346,11 @@ Aml *aml_qword_memory(AmlDecode dec, AmlMinFixed min_fixed,
                       uint64_t len);
 Aml *aml_dma(AmlDmaType typ, AmlDmaBusMaster bm, AmlTransferSize sz,
              uint8_t channel);
+Aml *aml_register(AmlAddressSpace as,
+                  uint8_t bit_width,
+                  uint8_t bit_offset,
+                  uint64_t address,
+                  uint8_t access_size);
 Aml *aml_sleep(uint64_t msec);
 
 /* Block AML object primitives */
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 1e43cd736d..def62b3112 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -874,6 +874,27 @@ Aml *aml_irq_no_flags(uint8_t irq)
     return var;
 }
 
+/*
+ * ACPI: 2.0: 16.2.4.16 ASL Macro for Generic Register Descriptor
+ *
+ * access_size comes from:
+ *     ACPI 3.0: 17.5.98 Register (Generic Register Resource Descriptor Macro)
+ */
+Aml *aml_register(AmlAddressSpace as,
+                  uint8_t bit_width,
+                  uint8_t bit_offset,
+                  uint64_t address,
+                  uint8_t access_size)
+{
+    Aml *var = aml_alloc();
+
+    build_append_byte(var->buf, 0x82);        /* Generic Register Descriptor */
+    build_append_byte(var->buf, 0x0C);        /* Length, bits[7:0] */
+    build_append_byte(var->buf, 0x0);         /* Length, bits[15:8] */
+    build_append_gas(var->buf, as, bit_width, bit_offset, access_size, address);
+    return var;
+}
+
 /* ACPI 1.0b: 16.2.5.4 Type 2 Opcodes Encoding: DefLNot */
 Aml *aml_lnot(Aml *arg)
 {
-- 
MST
