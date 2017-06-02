Received: from eggs.gnu.org ([2001:4830:134:3::10]:51916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dGp0K-0006uP-Io
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:00:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dGp0G-0000kj-TA
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:00:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60188)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1dGp0G-0000jt-JT
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 12:00:44 -0400
From: Laszlo Ersek <lersek@redhat.com>
Date: Fri,  2 Jun 2017 18:00:04 +0200
Message-Id: <20170602160006.1748-6-lersek@redhat.com>
In-Reply-To: <20170602160006.1748-1-lersek@redhat.com>
References: <c76b36de-ebf9-c662-d454-0a95b43901e8@redhat.com>
	<20170602160006.1748-1-lersek@redhat.com>
Subject: [Qemu-devel] [qemu PATCH 5/7] hw/acpi/vmgenid: ask the fw to alloc
 VMGENID_GUID_FW_CFG_FILE as NOACPI
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

The "etc/vmgenid_guid" fw_cfg blob is guaranteed not to contain ACPI
tables, so turning off the ACPI SDT header probe in OVMF is the right
thing to do.

SeaBIOS needs a patch for recognizing (and masking out) the
BIOS_LINKER_LOADER_ALLOC_CONTENT_NOACPI bit, but its behavior will not
change.

By setting the BIOS_LINKER_LOADER_ALLOC_CONTENT_NOACPI bit, we can
eliminate the "OVMF SDT Header probe suppressor" -- we can shift the GUID
to offset zero from offset 40 decimal (VMGENID_GUID_OFFSET).

Regarding the allocation zone, we cannot relax that to 64-bit, because the
"VGIA" object, into which the address of "etc/vmgenid_guid" is patched, is
only a DWORD.

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
    I tested this change extensively,
    - by repeating the steps written up in
      <http://mid.mail-archive.com/c052d05e-71a5-1a6a-f34f-17d14167c2f6@redhat.com>,
    - by doing the same after S3 suspend/resume,
    - by verifying firmware logs,
    - by directly checking ACPI content and dmesg in a Linux guest.
    
    I know Ben has a pending patch titled "[PATCH] tests: Add unit tests for
    the VM Generation ID feature", that one should be adapted as well
    (replace VMGENID_GUID_OFFSET with plain 0). I'd be happy to do that.

 docs/specs/vmgenid.txt    | 49 ++++++++++++++++++++---------------------------
 include/hw/acpi/vmgenid.h |  3 ---
 hw/acpi/vmgenid.c         | 21 ++++----------------
 3 files changed, 25 insertions(+), 48 deletions(-)

diff --git a/docs/specs/vmgenid.txt b/docs/specs/vmgenid.txt
index aa9f5186767c..fb9f372edbc8 100644
--- a/docs/specs/vmgenid.txt
+++ b/docs/specs/vmgenid.txt
@@ -63,76 +63,74 @@ Xen) put it in the main descriptor table (Differentiated System Description
 Table or DSDT).  For ease of debugging and implementation, we have decided to
 put it in its own Secondary System Description Table, or SSDT.
 
 The following is a dump of the contents from a running system:
 
-# iasl -p ./SSDT -d /sys/firmware/acpi/tables/SSDT
+# acpidump -n SSDT -b
+# iasl -d ssdt.dat
 
 Intel ACPI Component Architecture
-ASL+ Optimizing Compiler version 20150717-64
-Copyright (c) 2000 - 2015 Intel Corporation
+ASL+ Optimizing Compiler version 20160527-64
+Copyright (c) 2000 - 2016 Intel Corporation
 
-Reading ACPI table from file /sys/firmware/acpi/tables/SSDT - Length
-00000198 (0x0000C6)
+Input file ssdt.dat, Length 0xC6 (198) bytes
 ACPI: SSDT 0x0000000000000000 0000C6 (v01 BOCHS  VMGENID  00000001 BXPC
 00000001)
-Acpi table [SSDT] successfully installed and loaded
 Pass 1 parse of [SSDT]
 Pass 2 parse of [SSDT]
 Parsing Deferred Opcodes (Methods/Buffers/Packages/Regions)
 
 Parsing completed
 Disassembly completed
-ASL Output:    ./SSDT.dsl - 1631 bytes
-# cat SSDT.dsl
+ASL Output:    ssdt.dsl - 1559 bytes
+# cat ssdt.dsl
 /*
  * Intel ACPI Component Architecture
- * AML/ASL+ Disassembler version 20150717-64
- * Copyright (c) 2000 - 2015 Intel Corporation
+ * AML/ASL+ Disassembler version 20160527-64
+ * Copyright (c) 2000 - 2016 Intel Corporation
  *
  * Disassembling to symbolic ASL+ operators
  *
- * Disassembly of /sys/firmware/acpi/tables/SSDT, Sun Feb  5 00:19:37 2017
+ * Disassembly of ssdt.dat, Fri Jun  2 15:29:10 2017
  *
  * Original Table Header:
  *     Signature        "SSDT"
- *     Length           0x000000CA (202)
+ *     Length           0x000000C6 (198)
  *     Revision         0x01
- *     Checksum         0x4B
+ *     Checksum         0x38
  *     OEM ID           "BOCHS "
  *     OEM Table ID     "VMGENID"
  *     OEM Revision     0x00000001 (1)
  *     Compiler ID      "BXPC"
  *     Compiler Version 0x00000001 (1)
  */
-DefinitionBlock ("/sys/firmware/acpi/tables/SSDT.aml", "SSDT", 1, "BOCHS ",
-"VMGENID", 0x00000001)
+DefinitionBlock ("", "SSDT", 1, "BOCHS ", "VMGENID", 0x00000001)
 {
-    Name (VGIA, 0x07FFF000)
+    Name (VGIA, 0xBFFFF000)
     Scope (\_SB)
     {
         Device (VGEN)
         {
             Name (_HID, "QEMUVGID")  // _HID: Hardware ID
             Name (_CID, "VM_Gen_Counter")  // _CID: Compatible ID
             Name (_DDN, "VM_Gen_Counter")  // _DDN: DOS Device Name
             Method (_STA, 0, NotSerialized)  // _STA: Status
             {
                 Local0 = 0x0F
-                If ((VGIA == Zero))
+                If (VGIA == Zero)
                 {
                     Local0 = Zero
                 }
 
                 Return (Local0)
             }
 
             Method (ADDR, 0, NotSerialized)
             {
                 Local0 = Package (0x02) {}
-                Index (Local0, Zero) = (VGIA + 0x28)
-                Index (Local0, One) = Zero
+                Local0 [Zero] = VGIA /* \VGIA */
+                Local0 [One] = Zero
                 Return (Local0)
             }
         }
     }
 
@@ -197,12 +195,11 @@ GUID values displayed via monitor are shown in big-endian format.
 
 
 GUID Storage Format:
 --------------------
 
-In order to implement an OVMF "SDT Header Probe Suppressor", the contents of
-the vmgenid_guid fw_cfg blob are not simply a 128-bit GUID.  There is also
+The contents of the vmgenid_guid fw_cfg blob are a 128-bit GUID, followed by
 significant padding in order to align and fill a memory page, as shown in the
 following diagram:
 
 +----------------------------------+
 | SSDT with OEM Table ID = VMGENID |
@@ -210,17 +207,13 @@ following diagram:
 | ...                              |       TOP OF PAGE
 | VGIA dword object ---------------|-----> +---------------------------+
 | ...                              |       | fw-allocated array for    |
 | _STA method referring to VGIA    |       | "etc/vmgenid_guid"        |
 | ...                              |       +---------------------------+
-| ADDR method referring to VGIA    |       |  0: OVMF SDT Header probe |
-| ...                              |       |     suppressor            |
-+----------------------------------+       | 36: padding for 8-byte    |
-                                           |     alignment             |
-                                           | 40: GUID                  |
-                                           | 56: padding to page size  |
-                                           +---------------------------+
+| ADDR method referring to VGIA    |       |  0: GUID                  |
+| ...                              |       | 16: padding to page size  |
++----------------------------------+       +---------------------------+
                                            END OF PAGE
 
 
 Device Usage:
 -------------
diff --git a/include/hw/acpi/vmgenid.h b/include/hw/acpi/vmgenid.h
index 7beb9592fb01..b7cde45c0dea 100644
--- a/include/hw/acpi/vmgenid.h
+++ b/include/hw/acpi/vmgenid.h
@@ -9,13 +9,10 @@
 #define VMGENID_GUID             "guid"
 #define VMGENID_GUID_FW_CFG_FILE      "etc/vmgenid_guid"
 #define VMGENID_ADDR_FW_CFG_FILE      "etc/vmgenid_addr"
 
 #define VMGENID_FW_CFG_SIZE      4096 /* Occupy a page of memory */
-#define VMGENID_GUID_OFFSET      40   /* allow space for
-                                       * OVMF SDT Header Probe Supressor
-                                       */
 
 #define VMGENID(obj) OBJECT_CHECK(VmGenIdState, (obj), VMGENID_DEVICE)
 
 typedef struct VmGenIdState {
     DeviceClass parent_obj;
diff --git a/hw/acpi/vmgenid.c b/hw/acpi/vmgenid.c
index dc97771de5f7..92067bc52421 100644
--- a/hw/acpi/vmgenid.c
+++ b/hw/acpi/vmgenid.c
@@ -29,16 +29,11 @@ void vmgenid_build_acpi(VmGenIdState *vms, GArray *table_data, GArray *guid,
      * first, since that's what the guest expects
      */
     g_array_set_size(guid, VMGENID_FW_CFG_SIZE - ARRAY_SIZE(guid_le.data));
     guid_le = vms->guid;
     qemu_uuid_bswap(&guid_le);
-    /* The GUID is written at a fixed offset into the fw_cfg file
-     * in order to implement the "OVMF SDT Header probe suppressor"
-     * see docs/specs/vmgenid.txt for more details
-     */
-    g_array_insert_vals(guid, VMGENID_GUID_OFFSET, guid_le.data,
-                        ARRAY_SIZE(guid_le.data));
+    g_array_insert_vals(guid, 0, guid_le.data, ARRAY_SIZE(guid_le.data));
 
     /* Put this in a separate SSDT table */
     ssdt = init_aml_allocator();
 
     /* Reserve space for header */
@@ -70,12 +65,11 @@ void vmgenid_build_acpi(VmGenIdState *vms, GArray *table_data, GArray *guid,
     method = aml_method("ADDR", 0, AML_NOTSERIALIZED);
 
     addr = aml_local(0);
     aml_append(method, aml_store(aml_package(2), addr));
 
-    aml_append(method, aml_store(aml_add(aml_name("VGIA"),
-                                         aml_int(VMGENID_GUID_OFFSET), NULL),
+    aml_append(method, aml_store(aml_name("VGIA"),
                                  aml_index(addr, aml_int(0))));
     aml_append(method, aml_store(aml_int(0), aml_index(addr, aml_int(1))));
     aml_append(method, aml_return(addr));
 
     aml_append(dev, method);
@@ -91,22 +85,19 @@ void vmgenid_build_acpi(VmGenIdState *vms, GArray *table_data, GArray *guid,
 
     /* Allocate guest memory for the Data fw_cfg blob */
     bios_linker_loader_alloc(linker, VMGENID_GUID_FW_CFG_FILE, guid,
                              4096 /* page boundary */,
                              BIOS_LINKER_LOADER_ALLOC_ZONE_HIGH,
-                             BIOS_LINKER_LOADER_ALLOC_CONTENT_MIXED);
+                             BIOS_LINKER_LOADER_ALLOC_CONTENT_NOACPI);
 
     /* Patch address of GUID fw_cfg blob into the ADDR fw_cfg blob
      * so QEMU can write the GUID there.  The address is expected to be
      * < 4GB, but write 64 bits anyway.
-     * The address that is patched in is offset in order to implement
-     * the "OVMF SDT Header probe suppressor"
-     * see docs/specs/vmgenid.txt for more details.
      */
     bios_linker_loader_write_pointer(linker,
         VMGENID_ADDR_FW_CFG_FILE, 0, sizeof(uint64_t),
-        VMGENID_GUID_FW_CFG_FILE, VMGENID_GUID_OFFSET);
+        VMGENID_GUID_FW_CFG_FILE, 0);
 
     /* Patch address of GUID fw_cfg blob into the AML so OSPM can retrieve
      * and read it.  Note that while we provide storage for 64 bits, only
      * the least-signficant 32 get patched into AML.
      */
@@ -150,14 +141,10 @@ static void vmgenid_update_guest(VmGenIdState *vms)
              * however, will expect the fields to be little-endian.
              * Perform a byte swap immediately before writing.
              */
             guid_le = vms->guid;
             qemu_uuid_bswap(&guid_le);
-            /* The GUID is written at a fixed offset into the fw_cfg file
-             * in order to implement the "OVMF SDT Header probe suppressor"
-             * see docs/specs/vmgenid.txt for more details.
-             */
             cpu_physical_memory_write(vmgenid_addr, guid_le.data,
                                       sizeof(guid_le.data));
             /* Send _GPE.E05 event */
             acpi_send_event(DEVICE(obj), ACPI_VMGENID_CHANGE_STATUS);
         }
-- 
2.9.3
