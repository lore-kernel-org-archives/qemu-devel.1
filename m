Received: from eggs.gnu.org ([2001:4830:134:3::10]:52984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dGp3C-0001FS-CS
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:03:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dGp3B-0002Ta-6Y
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:03:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dGp3A-0002TD-UM
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:03:45 -0400
From: Laszlo Ersek <lersek@redhat.com>
Date: Fri,  2 Jun 2017 18:03:30 +0200
Message-Id: <20170602160332.1939-2-lersek@redhat.com>
In-Reply-To: <20170602160332.1939-1-lersek@redhat.com>
References: <c76b36de-ebf9-c662-d454-0a95b43901e8@redhat.com>
	<20170602160332.1939-1-lersek@redhat.com>
Subject: [Qemu-devel] [edk2 PATCH 1/3] OvmfPkg/AcpiPlatformDxe: rename
 BLOB.HostsOnlyTableData to BLOB.Releasable
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

The "BLOB.HostsOnlyTableData" field tracks whether the allocated &
downloaded fw_cfg blob should be released in the end. The current name
"HostsOnlyTableData" reflects only the original determinant for this,
namely whether the blob hosts ACPI table data only -- because in that case
EFI_ACPI_TABLE_PROTOCOL.InstallAcpiTable() would create deep copies of all
referenced parts of the blob.

However, in commit 9965cbd424f2 ("OvmfPkg/AcpiPlatformDxe: implement the
QEMU_LOADER_WRITE_POINTER command", 2017-02-08) we flipped the field to
FALSE in ProcessCmdWritePointer() too, because the blob must also not be
released if we send its allocation address back to QEMU. Therefore we
should more generally call the field "Releasable".

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
 OvmfPkg/AcpiPlatformDxe/QemuFwCfgAcpi.c | 22 ++++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/OvmfPkg/AcpiPlatformDxe/QemuFwCfgAcpi.c b/OvmfPkg/AcpiPlatformDxe/QemuFwCfgAcpi.c
index 1bc5fe297a96..4a7b051288bc 100644
--- a/OvmfPkg/AcpiPlatformDxe/QemuFwCfgAcpi.c
+++ b/OvmfPkg/AcpiPlatformDxe/QemuFwCfgAcpi.c
@@ -34,13 +34,12 @@ typedef struct {
   UINT8   File[QEMU_LOADER_FNAME_SIZE]; // NUL-terminated name of the fw_cfg
                                         // blob. This is the ordering / search
                                         // key.
   UINTN   Size;                         // The number of bytes in this blob.
   UINT8   *Base;                        // Pointer to the blob data.
-  BOOLEAN HostsOnlyTableData;           // TRUE iff the blob has been found to
-                                        // only contain data that is directly
-                                        // part of ACPI tables.
+  BOOLEAN Releasable;                   // TRUE iff the blob should be released
+                                        // at the end of processing.
 } BLOB;
 
 
 /**
   Compare a standalone key against a user structure containing an embedded key.
@@ -206,11 +205,11 @@ ProcessCmdAllocate (
     goto FreePages;
   }
   CopyMem (Blob->File, Allocate->File, QEMU_LOADER_FNAME_SIZE);
   Blob->Size = FwCfgSize;
   Blob->Base = (VOID *)(UINTN)Address;
-  Blob->HostsOnlyTableData = TRUE;
+  Blob->Releasable = TRUE;
 
   Status = OrderedCollectionInsert (Tracker, NULL, Blob);
   if (Status == RETURN_ALREADY_STARTED) {
     DEBUG ((EFI_D_ERROR, "%a: duplicated file \"%a\"\n", __FUNCTION__,
       Allocate->File));
@@ -505,11 +504,11 @@ ProcessCmdWritePointer (
   //
   // Because QEMU has now learned PointeeBlob->Base, we must mark PointeeBlob
   // as unreleasable, for the case when the whole linker/loader script is
   // handled successfully.
   //
-  PointeeBlob->HostsOnlyTableData = FALSE;
+  PointeeBlob->Releasable = FALSE;
 
   DEBUG ((DEBUG_VERBOSE, "%a: PointerFile=\"%a\" PointeeFile=\"%a\" "
     "PointerOffset=0x%x PointeeOffset=0x%x PointerSize=%d\n", __FUNCTION__,
     WritePointer->PointerFile, WritePointer->PointeeFile,
     WritePointer->PointerOffset, WritePointer->PointeeOffset,
@@ -612,12 +611,13 @@ UndoCmdWritePointer (
                                  before, or an ACPI table different from RSDT
                                  and XSDT has been installed (reflected by
                                  InstalledKey and NumInstalled), or RSDT or
                                  XSDT has been identified but not installed, or
                                  the fw_cfg blob pointed-into by AddPointer has
-                                 been marked as hosting something else than
-                                 just direct ACPI table contents.
+                                 been marked as non-releasable due to hosting
+                                 something else than just direct ACPI table
+                                 contents.
 
   @return                        Error codes returned by
                                  AcpiProtocol->InstallAcpiTable().
 **/
 STATIC
@@ -740,11 +740,11 @@ Process2ndPassCmdAddPointer (
     }
   }
 
   if (TableSize == 0) {
     DEBUG ((EFI_D_VERBOSE, "not found; marking fw_cfg blob as opaque\n"));
-    Blob2->HostsOnlyTableData = FALSE;
+    Blob2->Releasable = FALSE;
     return EFI_SUCCESS;
   }
 
   if (*NumInstalled == INSTALLED_TABLES_MAX) {
     DEBUG ((EFI_D_ERROR, "%a: can't install more than %d tables\n",
@@ -982,23 +982,23 @@ RollbackWritePointersAndFreeTracker:
     }
   }
 
   //
   // Tear down the tracker infrastructure. Each fw_cfg blob will be left in
-  // place only if we're exiting with success and the blob hosts data that is
-  // not directly part of some ACPI table.
+  // place only if we're exiting with success and the blob has been marked
+  // non-releasable.
   //
   for (TrackerEntry = OrderedCollectionMin (Tracker); TrackerEntry != NULL;
        TrackerEntry = TrackerEntry2) {
     VOID *UserStruct;
     BLOB *Blob;
 
     TrackerEntry2 = OrderedCollectionNext (TrackerEntry);
     OrderedCollectionDelete (Tracker, TrackerEntry, &UserStruct);
     Blob = UserStruct;
 
-    if (EFI_ERROR (Status) || Blob->HostsOnlyTableData) {
+    if (EFI_ERROR (Status) || Blob->Releasable) {
       DEBUG ((EFI_D_VERBOSE, "%a: freeing \"%a\"\n", __FUNCTION__,
         Blob->File));
       gBS->FreePages ((UINTN)Blob->Base, EFI_SIZE_TO_PAGES (Blob->Size));
     }
     FreePool (Blob);
-- 
2.9.3
