Received: from eggs.gnu.org ([2001:4830:134:3::10]:40070)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eBmKf-0007cf-Hy
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:41:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1eBmKe-0005Ph-Kp
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:41:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56506)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1eBmKe-0005PK-C3
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 13:41:12 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon,  6 Nov 2017 19:39:18 +0100
Message-Id: <20171106183925.16747-22-marcandre.lureau@redhat.com>
In-Reply-To: <20171106183925.16747-1-marcandre.lureau@redhat.com>
References: <20171106183925.16747-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 21/28] acpi: change TPM TIS data conditions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: amarnath.valluri@intel.com, stefanb@linux.vnet.ibm.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>

The device should be exposed if present. It shouldn't have an
undefined version (or else backend init failed, and device should fail
too). Finally, make the fields specific to TIS device model.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
---
 include/sysemu/tpm.h |  3 +++
 hw/i386/acpi-build.c | 12 ++++++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/sysemu/tpm.h b/include/sysemu/tpm.h
index 650b4b8565..852e02687c 100644
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
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index cdb4aa9835..dd1420b410 100644
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
--=20
2.15.0.rc0.40.gaefcc5f6f
