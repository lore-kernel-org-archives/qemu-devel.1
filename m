Received: from eggs.gnu.org ([2001:4830:134:3::10]:51837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dGp09-0006kk-Va
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:00:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dGp09-0000eJ-3g
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:00:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dGp08-0000da-Tq
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:00:37 -0400
From: Laszlo Ersek <lersek@redhat.com>
Date: Fri,  2 Jun 2017 18:00:03 +0200
Message-Id: <20170602160006.1748-5-lersek@redhat.com>
In-Reply-To: <20170602160006.1748-1-lersek@redhat.com>
References: <c76b36de-ebf9-c662-d454-0a95b43901e8@redhat.com>
	<20170602160006.1748-1-lersek@redhat.com>
Subject: [Qemu-devel] [qemu PATCH 4/7] hw/acpi/nvdimm: ask the firmware to
 allocate NVDIMM_DSM_MEM_FILE as NOACPI
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

The "etc/acpi/nvdimm-mem" fw_cfg blob is guaranteed not to contain ACPI
tables, so turning off the ACPI SDT header probe in OVMF is the right
thing to do.

SeaBIOS needs a patch for recognizing (and masking out) the
BIOS_LINKER_LOADER_ALLOC_CONTENT_NOACPI bit, but its behavior will not
change.

Regarding the allocation zone, we cannot relax that to 64-bit, because the
"MEMA" object (NVDIMM_ACPI_MEM_ADDR), into which the address of
"etc/acpi/nvdimm-mem" is patched, is only a DWORD.

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
    I don't know how to test this device, so I didn't. Help from the
    device's maintainer would be highly appreciated. Thanks.

 hw/acpi/nvdimm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/acpi/nvdimm.c b/hw/acpi/nvdimm.c
index 81bd0214fb3e..34b9a0f39a02 100644
--- a/hw/acpi/nvdimm.c
+++ b/hw/acpi/nvdimm.c
@@ -1263,11 +1263,11 @@ static void nvdimm_build_ssdt(GArray *table_offsets, GArray *table_data,
 
     bios_linker_loader_alloc(linker,
                              NVDIMM_DSM_MEM_FILE, dsm_dma_arrea,
                              sizeof(NvdimmDsmIn),
                              BIOS_LINKER_LOADER_ALLOC_ZONE_HIGH,
-                             BIOS_LINKER_LOADER_ALLOC_CONTENT_MIXED);
+                             BIOS_LINKER_LOADER_ALLOC_CONTENT_NOACPI);
     bios_linker_loader_add_pointer(linker,
         ACPI_BUILD_TABLE_FILE, mem_addr_offset, sizeof(uint32_t),
         NVDIMM_DSM_MEM_FILE, 0);
     build_header(linker, table_data,
         (void *)(table_data->data + nvdimm_ssdt),
-- 
2.9.3
