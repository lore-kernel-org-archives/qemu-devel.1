Received: from eggs.gnu.org ([2001:4830:134:3::10]:51926)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dGp0L-0006uq-6B
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:00:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dGp0K-0000ni-7N
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:00:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48856)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dGp0J-0000n0-VG
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:00:48 -0400
From: Laszlo Ersek <lersek@redhat.com>
Date: Fri,  2 Jun 2017 18:00:05 +0200
Message-Id: <20170602160006.1748-7-lersek@redhat.com>
In-Reply-To: <20170602160006.1748-1-lersek@redhat.com>
References: <c76b36de-ebf9-c662-d454-0a95b43901e8@redhat.com>
	<20170602160006.1748-1-lersek@redhat.com>
Subject: [Qemu-devel] [qemu PATCH 6/7] hw/i386/acpi-build: ask the fw to
 alloc ACPI_BUILD_TPMLOG_FILE with 64bit/NOACPI
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

The "etc/tpm/log" fw_cfg blob is guaranteed not to contain ACPI tables, so
turning off the ACPI SDT header probe in OVMF is the right thing to do.

In addition, the address of the blob is patched into the
"TCPA.log_area_start_address" field, which has type "uint64_t". Therefore
we can change the allocation zone to 64-bit as well.

SeaBIOS needs a patch for recognizing (and masking out) the
BIOS_LINKER_LOADER_ALLOC_CONTENT_NOACPI bit, and also for handling
BIOS_LINKER_LOADER_ALLOC_ZONE_64BIT the same as
BIOS_LINKER_LOADER_ALLOC_ZONE_HIGH, but its allocation behavior will not
change.

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

 hw/i386/acpi-build.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 3c4c28c6c2ca..1ec008ec5003 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2285,12 +2285,12 @@ build_tpm_tcpa(GArray *table_data, BIOSLinker *linker, GArray *tcpalog)
     tcpa->platform_class = cpu_to_le16(TPM_TCPA_ACPI_CLASS_CLIENT);
     tcpa->log_area_minimum_length = cpu_to_le32(TPM_LOG_AREA_MINIMUM_SIZE);
     acpi_data_push(tcpalog, le32_to_cpu(tcpa->log_area_minimum_length));
 
     bios_linker_loader_alloc(linker, ACPI_BUILD_TPMLOG_FILE, tcpalog, 1,
-                             BIOS_LINKER_LOADER_ALLOC_ZONE_HIGH,
-                             BIOS_LINKER_LOADER_ALLOC_CONTENT_MIXED);
+                             BIOS_LINKER_LOADER_ALLOC_ZONE_64BIT,
+                             BIOS_LINKER_LOADER_ALLOC_CONTENT_NOACPI);
 
     /* log area start address to be filled by Guest linker */
     bios_linker_loader_add_pointer(linker,
         ACPI_BUILD_TABLE_FILE, log_addr_offset, log_addr_size,
         ACPI_BUILD_TPMLOG_FILE, 0);
-- 
2.9.3
