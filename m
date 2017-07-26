Received: from eggs.gnu.org ([2001:4830:134:3::10]:33093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1daIq8-00017G-TU
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 05:42:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1daIq6-00079H-JE
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 05:42:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54566)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1daIq6-00078v-Ai
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 05:42:46 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 26 Jul 2017 11:42:34 +0200
Message-Id: <20170726094235.14267-2-pbonzini@redhat.com>
In-Reply-To: <20170726094235.14267-1-pbonzini@redhat.com>
References: <20170726094235.14267-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [seabios PATCH 1/2] seabios: build RSDT from XSDT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: seabios@seabios.org
Cc: Kevin O'Connor <kevin@koconnor.net>, qemu-devel@nongnu.org, lersek@redhat.com, lists@philjordan.eu, imammedo@redhat.com, mst@redhat.com, phil@philjordan.eu, programmingkidx@gmail.com, kraxel@redhat.com

Old operating systems would like to have a rev1 (ACPI 1.0) FADT, but
new operating systems would like to have rev3 (ACPI 2.0).

Since old operating systems do not know about XSDTs, the
solution is to point the RSDT to a rev1 FADT and the XSDT to a
rev3 FADT.

But, edk2 is not able to handle QEMU providing two FADTs and barfs when
it sees the second; edk2 subscribes to the view that the platform code
(meaning not only OVMF, but transitively QEMU's ACPI table builder)
should not handle such hacks; it's common edk2 code that should handle
FADT rev1 vs. rev3 and RSDT vs. XSDT.

These patches make SeaBIOS follow the same model as edk2, the only
difference being how the two identify ACPI tables from the BIOS
linker/loader script.  For SeaBIOS, this task is actually much
simpler since it can just look into the RSDP: if QEMU only
provides an XSDT, SeaBIOS takes care of building the RSDT and
rev1 FADT to satisfy ACPI 1.0-compliant operating systems.

This part makes SeaBIOS build an RSDT out of an existing XSDT,
patching the RSDP to point to the RSDT.

Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 src/fw/paravirt.c | 49 ++++++++++++++++++++++++++++++++++++++++++++++++-
 src/std/acpi.h    | 11 +++++++++++
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/src/fw/paravirt.c b/src/fw/paravirt.c
index 5b23d78..927fd75 100644
--- a/src/fw/paravirt.c
+++ b/src/fw/paravirt.c
@@ -25,6 +25,7 @@
 #include "x86.h" // cpuid
 #include "xen.h" // xen_biostable_setup
 #include "stacks.h" // yield
+#include "std/acpi.h"
 
 // Amount of continuous ram under 4Gig
 u32 RamSize;
@@ -147,6 +148,50 @@ static void msr_feature_control_setup(void)
         wrmsr_smp(MSR_IA32_FEATURE_CONTROL, feature_control_bits);
 }
 
+static void
+build_compatibility_rsdt(void)
+{
+    if (RsdpAddr->rsdt_physical_address)
+        return;
+
+    u64 xsdt_addr = RsdpAddr->xsdt_physical_address;
+    if (xsdt_addr & ~0xffffffffULL)
+        return;
+
+    struct xsdt_descriptor_rev1 *xsdt = (void*)(u32)xsdt_addr;
+    void *end = (void*)xsdt + xsdt->length;
+    struct rsdt_descriptor_rev1 *rsdt;
+    int rsdt_size = offsetof(struct rsdt_descriptor_rev1, table_offset_entry[0]);
+    int i;
+    for (i=0; (void*)&xsdt->table_offset_entry[i] < end; i++) {
+        u64 tbl_addr = xsdt->table_offset_entry[i];
+        if (!tbl_addr || (tbl_addr & ~0xffffffffULL))
+            continue;
+        rsdt_size += 4;
+    }
+
+    rsdt = malloc_high(rsdt_size);
+    RsdpAddr->rsdt_physical_address = (u32)rsdt;
+    RsdpAddr->checksum -= checksum(RsdpAddr,
+				   offsetof(struct rsdp_descriptor, length));
+    RsdpAddr->extended_checksum -= checksum(RsdpAddr,
+					    sizeof(struct rsdp_descriptor));
+
+    memcpy(rsdt, xsdt, sizeof(struct acpi_table_header));
+    rsdt->signature = RSDT_SIGNATURE;
+    rsdt->length = rsdt_size;
+    rsdt->revision = 1;
+    int j;
+    for (i=j=0; (void*)&xsdt->table_offset_entry[i] < end; i++) {
+        u64 tbl_addr = xsdt->table_offset_entry[i];
+        if (!tbl_addr || (tbl_addr & ~0xffffffffULL))
+            continue;
+        rsdt->table_offset_entry[j++] = (u32)tbl_addr;
+    }
+
+    rsdt->checksum -= checksum(rsdt, rsdt_size);
+}
+
 void
 qemu_platform_setup(void)
 {
@@ -186,8 +231,10 @@ qemu_platform_setup(void)
 
         RsdpAddr = find_acpi_rsdp();
 
-        if (RsdpAddr)
+        if (RsdpAddr) {
+            build_compatibility_rsdt();
             return;
+        }
 
         /* If present, loader should have installed an RSDP.
          * Not installed? We might still be able to continue
diff --git a/src/std/acpi.h b/src/std/acpi.h
index c2ea707..a77b53c 100644
--- a/src/std/acpi.h
+++ b/src/std/acpi.h
@@ -133,6 +133,17 @@ struct rsdt_descriptor_rev1
 } PACKED;
 
 /*
+ * ACPI 2.0 Extended System Description Table (XSDT)
+ */
+#define XSDT_SIGNATURE 0x54445358 // XSDT
+struct xsdt_descriptor_rev1
+{
+    ACPI_TABLE_HEADER_DEF       /* ACPI common table header */
+    u64 table_offset_entry[0];  /* Array of pointers to other */
+    /* ACPI tables */
+} PACKED;
+
+/*
  * ACPI 1.0 Firmware ACPI Control Structure (FACS)
  */
 #define FACS_SIGNATURE 0x53434146 // FACS
-- 
2.13.3
