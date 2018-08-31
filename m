Received: from eggs.gnu.org ([2001:4830:134:3::10]:56584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fvnAT-0007PM-Ut
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 13:25:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fvnAN-0003Bn-8v
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 13:25:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fvnAM-0003B8-V2
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 13:25:03 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 31 Aug 2018 19:24:22 +0200
Message-Id: <20180831172424.12029-5-marcandre.lureau@redhat.com>
In-Reply-To: <20180831172424.12029-1-marcandre.lureau@redhat.com>
References: <20180831172424.12029-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v10 4/6] acpi: expose TPM/PPI configuration
 parameters to firmware via fw_cfg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, stefanb@linux.vnet.ibm.com, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Stefan Berger <stefanb@linux.vnet.ibm.com>

To avoid having to hard code the base address of the PPI virtual
memory device we introduce a fw_cfg file etc/tpm/config that holds the
base address of the PPI device, the version of the PPI interface and
the version of the attached TPM.

Signed-off-by: Stefan Berger <stefanb@linux.vnet.ibm.com>
[ Marc-Andr=C3=A9: renamed to etc/tpm/config, made it static, document it=
 ]
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/acpi/tpm.h |  3 +++
 hw/i386/acpi-build.c  | 19 +++++++++++++++++++
 docs/specs/tpm.txt    | 20 ++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/include/hw/acpi/tpm.h b/include/hw/acpi/tpm.h
index b8796df916..a6109a97fc 100644
--- a/include/hw/acpi/tpm.h
+++ b/include/hw/acpi/tpm.h
@@ -194,4 +194,7 @@ REG32(CRB_DATA_BUFFER, 0x80)
 #define TPM_PPI_ADDR_SIZE           0x400
 #define TPM_PPI_ADDR_BASE           0xFED45000
=20
+#define TPM_PPI_VERSION_NONE        0
+#define TPM_PPI_VERSION_1_30        1
+
 #endif /* HW_ACPI_TPM_H */
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index e1ee8ae9e0..c24f68df02 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -119,6 +119,12 @@ typedef struct AcpiBuildPciBusHotplugState {
     bool pcihp_bridge_en;
 } AcpiBuildPciBusHotplugState;
=20
+typedef struct FWCfgTPMConfig {
+    uint32_t tpmppi_address;
+    uint8_t tpm_version;
+    uint8_t tpmppi_version;
+} QEMU_PACKED FWCfgTPMConfig;
+
 static void init_common_fadt_data(Object *o, AcpiFadtData *data)
 {
     uint32_t io =3D object_property_get_uint(o, ACPI_PM_PROP_PM_IO_BASE,=
 NULL);
@@ -2877,6 +2883,8 @@ void acpi_setup(void)
     AcpiBuildTables tables;
     AcpiBuildState *build_state;
     Object *vmgenid_dev;
+    TPMIf *tpm;
+    static FWCfgTPMConfig tpm_config;
=20
     if (!pcms->fw_cfg) {
         ACPI_BUILD_DPRINTF("No fw cfg. Bailing out.\n");
@@ -2911,6 +2919,17 @@ void acpi_setup(void)
     fw_cfg_add_file(pcms->fw_cfg, ACPI_BUILD_TPMLOG_FILE,
                     tables.tcpalog->data, acpi_data_len(tables.tcpalog))=
;
=20
+    tpm =3D tpm_find();
+    if (tpm && object_property_get_bool(OBJECT(tpm), "ppi", &error_abort=
)) {
+        tpm_config =3D (FWCfgTPMConfig) {
+            .tpmppi_address =3D cpu_to_le32(TPM_PPI_ADDR_BASE),
+            .tpm_version =3D tpm_get_version(tpm_find()),
+            .tpmppi_version =3D TPM_PPI_VERSION_NONE
+        };
+        fw_cfg_add_file(pcms->fw_cfg, "etc/tpm/config",
+                        &tpm_config, sizeof tpm_config);
+    }
+
     vmgenid_dev =3D find_vmgenid_dev();
     if (vmgenid_dev) {
         vmgenid_add_fw_cfg(VMGENID(vmgenid_dev), pcms->fw_cfg,
diff --git a/docs/specs/tpm.txt b/docs/specs/tpm.txt
index 0e9bbebe1d..a5bdd5f26e 100644
--- a/docs/specs/tpm.txt
+++ b/docs/specs/tpm.txt
@@ -20,6 +20,26 @@ QEMU files related to TPM TIS interface:
  - hw/tpm/tpm_tis.h
=20
=20
+=3D fw_cfg interface =3D
+
+The bios/firmware may read the "etc/tpm/config" fw_cfg entry for
+configuring the guest appropriately.
+
+The entry of 6 bytes has the following content, in little-endian:
+
+    #define TPM_VERSION_UNSPEC          0
+    #define TPM_VERSION_1_2             1
+    #define TPM_VERSION_2_0             2
+
+    #define TPM_PPI_VERSION_NONE        0
+    #define TPM_PPI_VERSION_1_30        1
+
+    struct FWCfgTPMConfig {
+        uint32_t tpmppi_address;         /* PPI memory location */
+        uint8_t tpm_version;             /* TPM version */
+        uint8_t tpmppi_version;          /* PPI version */
+    };
+
 =3D ACPI Interface =3D
=20
 The TPM device is defined with ACPI ID "PNP0C31". QEMU builds a SSDT and=
 passes
--=20
2.19.0.rc1
