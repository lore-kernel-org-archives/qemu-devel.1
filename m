Received: from eggs.gnu.org ([2001:4830:134:3::10]:53061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dGp3N-0001WP-7M
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:03:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dGp3M-0002Y4-Ay
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:03:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56966)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dGp3M-0002XS-5G
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:03:56 -0400
From: Laszlo Ersek <lersek@redhat.com>
Date: Fri,  2 Jun 2017 18:03:32 +0200
Message-Id: <20170602160332.1939-4-lersek@redhat.com>
In-Reply-To: <20170602160332.1939-1-lersek@redhat.com>
References: <c76b36de-ebf9-c662-d454-0a95b43901e8@redhat.com>
	<20170602160332.1939-1-lersek@redhat.com>
Subject: [Qemu-devel] [edk2 PATCH 3/3] OvmfPkg/AcpiPlatformDxe: support
 64-bit zone in ALLOCATE command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: SeaBIOS@seabios.org, qemu-devel@nongnu.org, edk2-devel@lists.01.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Ben Warren <ben@skyportsystems.com>, Dongjiu Geng <gengdongjiu@huawei.com>, Igor Mammedov <imammedo@redhat.com>, Jordan Justen <jordan.l.justen@intel.com>, Leif Lindholm <leif.lindholm@linaro.org>, Shannon Zhao <zhaoshenglong@huawei.com>

The QemuLoaderAlloc64Bit (3) Zone value permits the guest firmware to
allocate the blob being downloaded anywhere in the 64-bit address space.
Set the maximum Address value in ProcessCmdAllocate() accordingly.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Ben Warren <ben@skyportsystems.com>
Cc: Dongjiu Geng <gengdongjiu@huawei.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Jordan Justen <jordan.l.justen@intel.com>
Cc: Leif Lindholm <leif.lindholm@linaro.org>
Cc: Shannon Zhao <zhaoshenglong@huawei.com>
Contributed-under: TianoCore Contribution Agreement 1.0
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
---
 OvmfPkg/AcpiPlatformDxe/QemuLoader.h    | 3 ++-
 OvmfPkg/AcpiPlatformDxe/QemuFwCfgAcpi.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/OvmfPkg/AcpiPlatformDxe/QemuLoader.h b/OvmfPkg/AcpiPlatformDxe/QemuLoader.h
index fa558540e62b..1daa918ff9b7 100644
--- a/OvmfPkg/AcpiPlatformDxe/QemuLoader.h
+++ b/OvmfPkg/AcpiPlatformDxe/QemuLoader.h
@@ -31,11 +31,12 @@ typedef enum {
   QemuLoaderCmdWritePointer,
 } QEMU_LOADER_COMMAND_TYPE;
 
 typedef enum {
   QemuLoaderAllocHigh = 1,
-  QemuLoaderAllocFSeg
+  QemuLoaderAllocFSeg,
+  QemuLoaderAlloc64Bit,
 } QEMU_LOADER_ALLOC_ZONE;
 
 typedef enum {
   QemuLoaderAllocContentMixed  = 0x00,
   QemuLoaderAllocContentNoAcpi = 0x80,
diff --git a/OvmfPkg/AcpiPlatformDxe/QemuFwCfgAcpi.c b/OvmfPkg/AcpiPlatformDxe/QemuFwCfgAcpi.c
index 23d543ffe361..0b0b3f590f2b 100644
--- a/OvmfPkg/AcpiPlatformDxe/QemuFwCfgAcpi.c
+++ b/OvmfPkg/AcpiPlatformDxe/QemuFwCfgAcpi.c
@@ -202,11 +202,11 @@ ProcessCmdAllocate (
   } else {
     AcpiTablesExcluded = FALSE;
   }
 
   NumPages = EFI_SIZE_TO_PAGES (FwCfgSize);
-  Address = 0xFFFFFFFF;
+  Address = (Zone == QemuLoaderAlloc64Bit) ? MAX_UINT64 : MAX_UINT32;
   Status = gBS->AllocatePages (AllocateMaxAddress, EfiACPIMemoryNVS, NumPages,
                   &Address);
   if (EFI_ERROR (Status)) {
     return Status;
   }
-- 
2.9.3
