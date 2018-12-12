Received: from eggs.gnu.org ([2001:4830:134:3::10]:48002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gXCyV-0004NM-HF
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 17:27:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gXCyU-00040c-Gq
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 17:27:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47604)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gXCyU-0003zd-77
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 17:27:26 -0500
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Dec 2018 02:26:45 +0400
Message-Id: <20181212222648.595-4-marcandre.lureau@redhat.com>
In-Reply-To: <20181212222648.595-1-marcandre.lureau@redhat.com>
References: <20181212222648.595-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v13 3/6] acpi: expose TPM/PPI configuration
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, stefanb@linux.vnet.ibm.com, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, f4bug@amsat.org, Stefan Berger <stefanb@linux.ibm.com>, Igor Mammedov <imammedo@redhat.com>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

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
 docs/specs/tpm.txt    | 19 +++++++++++++++++++
 3 files changed, 41 insertions(+)

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
index 236a20eaa8..7b5c67e202 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -119,6 +119,12 @@ typedef struct AcpiBuildPciBusHotplugState {
     bool pcihp_bridge_en;
 } AcpiBuildPciBusHotplugState;
=20
+typedef struct FwCfgTPMConfig {
+    uint32_t tpmppi_address;
+    uint8_t tpm_version;
+    uint8_t tpmppi_version;
+} QEMU_PACKED FwCfgTPMConfig;
+
 static void init_common_fadt_data(Object *o, AcpiFadtData *data)
 {
     uint32_t io =3D object_property_get_uint(o, ACPI_PM_PROP_PM_IO_BASE,=
 NULL);
@@ -2855,6 +2861,8 @@ void acpi_setup(void)
     AcpiBuildTables tables;
     AcpiBuildState *build_state;
     Object *vmgenid_dev;
+    TPMIf *tpm;
+    static FwCfgTPMConfig tpm_config;
=20
     if (!pcms->fw_cfg) {
         ACPI_BUILD_DPRINTF("No fw cfg. Bailing out.\n");
@@ -2889,6 +2897,17 @@ void acpi_setup(void)
     fw_cfg_add_file(pcms->fw_cfg, ACPI_BUILD_TPMLOG_FILE,
                     tables.tcpalog->data, acpi_data_len(tables.tcpalog))=
;
=20
+    tpm =3D tpm_find();
+    if (tpm && object_property_get_bool(OBJECT(tpm), "ppi", &error_abort=
)) {
+        tpm_config =3D (FwCfgTPMConfig) {
+            .tpmppi_address =3D cpu_to_le32(TPM_PPI_ADDR_BASE),
+            .tpm_version =3D tpm_get_version(tpm),
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
index 1af82bba86..e4bb094700 100644
--- a/docs/specs/tpm.txt
+++ b/docs/specs/tpm.txt
@@ -34,6 +34,25 @@ The CRB interface makes a memory mapped IO region in t=
he area 0xfed40000 -
 QEMU files related to TPM CRB interface:
  - hw/tpm/tpm_crb.c
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
+    struct FwCfgTPMConfig {
+        uint32_t tpmppi_address;         /* PPI memory location */
+        uint8_t tpm_version;             /* TPM version */
+        uint8_t tpmppi_version;          /* PPI version */
+    };
=20
 =3D ACPI Interface =3D
=20
--=20
2.20.0
