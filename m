Received: from eggs.gnu.org ([2001:4830:134:3::10]:33112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1daIq9-00017M-R6
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 05:42:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1daIq9-0007A8-3S
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 05:42:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1daIq8-00079j-Ts
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 05:42:49 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 26 Jul 2017 11:42:35 +0200
Message-Id: <20170726094235.14267-3-pbonzini@redhat.com>
In-Reply-To: <20170726094235.14267-1-pbonzini@redhat.com>
References: <20170726094235.14267-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [seabios PATCH 2/2] seabios: create rev1 FADT in
 compatibility RSDT
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

This patch completes the job, presenting a rev1 FADT inside the
compatibility RSDT, so that ACPI 1.0 operating systems such as
Windows 2000 are not broken.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 src/fw/paravirt.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/src/fw/paravirt.c b/src/fw/paravirt.c
index 927fd75..97e2fe3 100644
--- a/src/fw/paravirt.c
+++ b/src/fw/paravirt.c
@@ -148,6 +148,20 @@ static void msr_feature_control_setup(void)
         wrmsr_smp(MSR_IA32_FEATURE_CONTROL, feature_control_bits);
 }
 
+static void*
+build_rev1_fadt(struct fadt_descriptor_rev1 *fadt_v3)
+{
+    struct fadt_descriptor_rev1 *fadt_v1 = malloc_high(sizeof *fadt_v1);
+
+    memcpy(fadt_v1, fadt_v3, sizeof *fadt_v1);
+    fadt_v1->length = sizeof *fadt_v1;
+    fadt_v1->revision = 1;
+    // the upper 23 bits are reserved in the rev1 FADT
+    fadt_v1->flags &= 0x1ff;
+    fadt_v1->checksum -= checksum(fadt_v1, fadt_v1->length);
+    return fadt_v1;
+}
+
 static void
 build_compatibility_rsdt(void)
 {
@@ -186,6 +200,11 @@ build_compatibility_rsdt(void)
         u64 tbl_addr = xsdt->table_offset_entry[i];
         if (!tbl_addr || (tbl_addr & ~0xffffffffULL))
             continue;
+        struct acpi_table_header *tbl = (void*)(u32)tbl_addr;
+        // for compatibility with Windows 2000, the RSDT should contain
+        // an ACPI 1.0 FADT (table revision 1)
+        if (tbl->signature == FACP_SIGNATURE && tbl->revision > 1)
+            tbl_addr = (u32)build_rev1_fadt((void *)tbl);
         rsdt->table_offset_entry[j++] = (u32)tbl_addr;
     }
 
-- 
2.13.3
