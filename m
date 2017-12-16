Received: from eggs.gnu.org ([2001:4830:134:3::10]:46023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQGTt-0006BV-H2
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanb@linux.vnet.ibm.com>) id 1eQGTp-0000D2-K0
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:37 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55710
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanb@linux.vnet.ibm.com>)
	id 1eQGTp-0000Cg-EA
	for qemu-devel@nongnu.org; Sat, 16 Dec 2017 12:42:33 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	vBGHfM85074894
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 12:42:32 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2evx0cxtef-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Sat, 16 Dec 2017 12:42:32 -0500
Received: from localhost
	by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <stefanb@linux.vnet.ibm.com>;
	Sat, 16 Dec 2017 10:42:32 -0700
From: Stefan Berger <stefanb@linux.vnet.ibm.com>
Date: Sat, 16 Dec 2017 12:41:38 -0500
In-Reply-To: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1513446109-9013-22-git-send-email-stefanb@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v1 21/32] acpi: change TPM TIS data conditions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

The device should be exposed if present. It shouldn't have an
undefined version (or else backend init failed, and device should fail
too). Finally, make the fields specific to TIS device model.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 hw/i386/acpi-build.c | 12 ++++++++----
 include/sysemu/tpm.h |  3 +++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index cdb4aa9..dd1420b 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2038,7 +2038,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         }
     }
=20
-    if (misc->tpm_version !=3D TPM_VERSION_UNSPEC) {
+    if (TPM_IS_TIS(tpm_find())) {
         aml_append(crs, aml_memory32_fixed(TPM_TIS_ADDR_BASE,
                    TPM_TIS_ADDR_SIZE, AML_READ_WRITE));
     }
@@ -2204,7 +2204,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
             /* Scan all PCI buses. Generate tables to support hotplug. *=
/
             build_append_pci_bus_devices(scope, bus, pm->pcihp_bridge_en=
);
=20
-            if (misc->tpm_version !=3D TPM_VERSION_UNSPEC) {
+            if (TPM_IS_TIS(tpm_find())) {
                 dev =3D aml_device("ISA.TPM");
                 aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0C3=
1")));
                 aml_append(dev, aml_name_decl("_STA", aml_int(0xF)));
@@ -2281,8 +2281,12 @@ build_tpm2(GArray *table_data, BIOSLinker *linker)
     tpm2_ptr =3D acpi_data_push(table_data, sizeof *tpm2_ptr);
=20
     tpm2_ptr->platform_class =3D cpu_to_le16(TPM2_ACPI_CLASS_CLIENT);
-    tpm2_ptr->control_area_address =3D cpu_to_le64(0);
-    tpm2_ptr->start_method =3D cpu_to_le32(TPM2_START_METHOD_MMIO);
+    if (TPM_IS_TIS(tpm_find())) {
+        tpm2_ptr->control_area_address =3D cpu_to_le64(0);
+        tpm2_ptr->start_method =3D cpu_to_le32(TPM2_START_METHOD_MMIO);
+    } else {
+        g_warn_if_reached();
+    }
=20
     build_header(linker, table_data,
                  (void *)tpm2_ptr, "TPM2", sizeof(*tpm2_ptr), 4, NULL, N=
ULL);
diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
index 650b4b8..852e026 100644
--- a/include/sysemu/tpm.h
+++ b/include/sysemu/tpm.h
@@ -47,6 +47,9 @@ typedef struct TPMIfClass {
=20
 #define TYPE_TPM_TIS                "tpm-tis"
=20
+#define TPM_IS_TIS(chr)                             \
+    object_dynamic_cast(OBJECT(chr), TYPE_TPM_TIS)
+
 /* returns NULL unless there is exactly one TPM device */
 static inline TPMIf *tpm_find(void)
 {
--=20
2.5.5
