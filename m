Received: from eggs.gnu.org ([2001:4830:134:3::10]:51963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dGp0P-0006ym-I2
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:00:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dGp0O-0000sJ-Mf
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:00:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dGp0O-0000r4-An
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:00:52 -0400
From: Laszlo Ersek <lersek@redhat.com>
Date: Fri,  2 Jun 2017 18:00:06 +0200
Message-Id: <20170602160006.1748-8-lersek@redhat.com>
In-Reply-To: <20170602160006.1748-1-lersek@redhat.com>
References: <c76b36de-ebf9-c662-d454-0a95b43901e8@redhat.com>
	<20170602160006.1748-1-lersek@redhat.com>
Subject: [Qemu-devel] [qemu PATCH 7/7] hw/arm/virt-acpi-build: make the fw
 alloc blobs with ACPI tables as 64bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: SeaBIOS@seabios.org, qemu-devel@nongnu.org, edk2-devel@lists.01.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Ben Warren <ben@skyportsystems.com>, Dongjiu Geng <gengdongjiu@huawei.com>, Igor Mammedov <imammedo@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Stefan Berger <stefanb@linux.vnet.ibm.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>

Thanks to commit cb51ac2ffe36 ("hw/arm/virt: generate 64-bit addressable
ACPI objects", 2017-04-10), all pointer fields in the ACPI tables in the
"etc/acpi/rsdp" (ACPI_BUILD_RSDP_FILE) and "etc/acpi/tables"
(ACPI_BUILD_TABLE_FILE) fw_cfg blobs are 64-bit wide.

Therefore we can allow the guest firmware to allocate these blobs from
64-bit address space.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Ben Warren <ben@skyportsystems.com>
Cc: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Shannon Zhao <zhaoshenglong@huawei.com>
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: Xiao Guangrong <guangrong.xiao@linux.intel.com>
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
---

Notes:
    I verified this change with firmware logs and a Linux guest's dmesg.

 hw/arm/virt-acpi-build.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 1c20b851a611..8648d89decb7 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -370,11 +370,11 @@ build_rsdp(GArray *rsdp_table, BIOSLinker *linker, unsigned xsdt_tbl_offset)
     unsigned xsdt_pa_size = sizeof(rsdp->xsdt_physical_address);
     unsigned xsdt_pa_offset =
         (char *)&rsdp->xsdt_physical_address - rsdp_table->data;
 
     bios_linker_loader_alloc(linker, ACPI_BUILD_RSDP_FILE, rsdp_table, 16,
-                             BIOS_LINKER_LOADER_ALLOC_ZONE_FSEG,
+                             BIOS_LINKER_LOADER_ALLOC_ZONE_64BIT,
                              BIOS_LINKER_LOADER_ALLOC_CONTENT_MIXED);
 
     memcpy(&rsdp->signature, "RSD PTR ", sizeof(rsdp->signature));
     memcpy(rsdp->oem_id, ACPI_BUILD_APPNAME6, sizeof(rsdp->oem_id));
     rsdp->length = cpu_to_le32(sizeof(*rsdp));
@@ -750,11 +750,11 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     table_offsets = g_array_new(false, true /* clear */,
                                         sizeof(uint32_t));
 
     bios_linker_loader_alloc(tables->linker,
                              ACPI_BUILD_TABLE_FILE, tables_blob,
-                             64, BIOS_LINKER_LOADER_ALLOC_ZONE_HIGH,
+                             64, BIOS_LINKER_LOADER_ALLOC_ZONE_64BIT,
                              BIOS_LINKER_LOADER_ALLOC_CONTENT_MIXED);
 
     /* DSDT is pointed to by FADT */
     dsdt = tables_blob->len;
     build_dsdt(tables_blob, tables->linker, vms);
-- 
2.9.3
