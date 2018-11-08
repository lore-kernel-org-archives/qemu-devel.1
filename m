Received: from eggs.gnu.org ([2001:4830:134:3::10]:39616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1gKhR1-0004BB-Kh
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:21:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1gKhOp-00024t-W7
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:18:57 -0500
From: Dongjiu Geng <gengdongjiu@huawei.com>
Date: Thu, 8 Nov 2018 02:15:53 -0800
Message-ID: <1541672153-15529-11-git-send-email-gengdongjiu@huawei.com>
In-Reply-To: <1541672153-15529-1-git-send-email-gengdongjiu@huawei.com>
References: <1541672153-15529-1-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v15 10/10] target-arm: kvm64: handle SIGBUS
 signal from kernel or KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: imammedo@redhat.com, mst@redhat.com, peter.maydell@linaro.org, pbonzini@redhat.com, mtosatti@redhat.com, rth@twiddle.net, ehabkost@redhat.com, kvm@vger.kernel.org, shannon.zhaosl@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, gengdongjiu@huawei.com

Add SIGBUS signal handler. In this handler, it checks the SIGBUS type,
translates the host VA delivered by host to guest PA, then fill this PA
to guest APEI GHES memory, then notify guest according to the SIGBUS type.
There are two kinds of SIGBUS that QEMU needs to handle, which are
BUS_MCEERR_AO and BUS_MCEERR_AR.

If guest accesses the poisoned memory, it generates Synchronous External
Abort(SEA). Then host kernel gets an APEI notification and call memory_failure()
to unmapped the affected page from the guest's stage 2, finally return
to guest.

Guest continues to access PG_hwpoison page, it will trap to KVM as stage2 fault,
then a SIGBUS_MCEERR_AR synchronous signal is delivered to Qemu, Qemu record this
error into guest APEI GHES memory and notify guest using Synchronous-External-Abort(SEA).

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>

Address James's comments to record CPER and notify guest for SIGBUS signal handling.
Shown some discussion in [1].

[1]:
https://lkml.org/lkml/2017/2/27/246
https://lkml.org/lkml/2017/9/14/241
https://lkml.org/lkml/2017/9/22/499
---
 hw/acpi/acpi_ghes.c         | 164 ++++++++++++++++++++++++++++++++++++++++++++
 include/hw/acpi/acpi_ghes.h |   4 ++
 include/sysemu/kvm.h        |   2 +-
 target/arm/kvm.c            |   3 +
 target/arm/kvm64.c          |  34 +++++++++
 5 files changed, 206 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/acpi_ghes.c b/hw/acpi/acpi_ghes.c
index d03e797..ef83c05 100644
--- a/hw/acpi/acpi_ghes.c
+++ b/hw/acpi/acpi_ghes.c
@@ -26,6 +26,87 @@
 #include "sysemu/sysemu.h"
 #include "qemu/error-report.h"
 
+/* UEFI 2.6: N.2.5 Memory Error Section */
+static void build_append_mem_cper(GArray *table, uint64_t error_physical_addr)
+{
+    /*
+     * Memory Error Record
+     */
+    build_append_int_noprefix(table,
+                 (1UL << 14) | /* Type Valid */
+                 (1UL << 1) /* Physical Address Valid */,
+                 8);
+    /* Memory error status information */
+    build_append_int_noprefix(table, 0, 8);
+    /* The physical address at which the memory error occurred */
+    build_append_int_noprefix(table, error_physical_addr, 8);
+    build_append_int_noprefix(table, 0, 48);
+    build_append_int_noprefix(table, 0 /* Unknown error */, 1);
+    build_append_int_noprefix(table, 0, 7);
+}
+
+static int ghes_record_mem_error(uint64_t error_block_address,
+                                    uint64_t error_physical_addr)
+{
+    GArray *block;
+    uint64_t current_block_length;
+    uint32_t data_length;
+    /* Memory section */
+    char mem_section_id_le[] = {0x14, 0x11, 0xBC, 0xA5, 0x64, 0x6F, 0xDE,
+                                0x4E, 0xB8, 0x63, 0x3E, 0x83, 0xED, 0x7C,
+                                0x83, 0xB1};
+    uint8_t fru_id[16] = {0};
+    uint8_t fru_text[20] = {0};
+
+    block = g_array_new(false, true /* clear */, 1);
+
+    /* Read the current length in bytes of the generic error data */
+    cpu_physical_memory_read(error_block_address +
+        offsetof(AcpiGenericErrorStatus, data_length), &data_length, 4);
+
+    /* The current whole length in bytes of the generic error status block */
+    current_block_length = sizeof(AcpiGenericErrorStatus) + le32_to_cpu(data_length);
+
+    /* Add a new generic error data entry*/
+    data_length += GHES_DATA_LENGTH;
+    data_length += GHES_CPER_LENGTH;
+
+    /* Check whether it will run out of the preallocated memory if adding a new
+     * generic error data entry
+     */
+    if ((data_length + sizeof(AcpiGenericErrorStatus)) > GHES_MAX_RAW_DATA_LENGTH) {
+        error_report("Record CPER out of boundary!!!");
+        return GHES_CPER_FAIL;
+    }
+    /* Build the new generic error status block header */
+    build_append_ghes_generic_status(block, cpu_to_le32(ACPI_GEBS_UNCORRECTABLE), 0, 0,
+        cpu_to_le32(data_length), cpu_to_le32(ACPI_CPER_SEV_RECOVERABLE));
+
+    /* Write back above generic error status block header to guest memory */
+    cpu_physical_memory_write(error_block_address, block->data,
+                              block->len);
+
+    /* Build the generic error data entries */
+
+    data_length = block->len;
+    /* Build the new generic error data entry header */
+    build_append_ghes_generic_data(block, mem_section_id_le,
+                    cpu_to_le32(ACPI_CPER_SEV_RECOVERABLE), cpu_to_le32(0x300), 0, 0,
+                    cpu_to_le32(80)/* the total size of Memory Error Record */, fru_id,
+                    fru_text, 0);
+
+    /* Build the memory section CPER */
+    build_append_mem_cper(block, error_physical_addr);
+
+    /* Write back above whole new generic error data entry to guest memory */
+    cpu_physical_memory_write(error_block_address + current_block_length,
+                    block->data + data_length, block->len - data_length);
+
+    g_array_free(block, true);
+
+    return GHES_CPER_OK;
+}
+
 /* Build table for the hardware error fw_cfg blob */
 void build_hardware_error_table(GArray *hardware_errors, BIOSLinker *linker)
 {
@@ -169,3 +250,86 @@ void ghes_add_fw_cfg(FWCfgState *s, GArray *hardware_error)
     fw_cfg_add_file_callback(s, GHES_DATA_ADDR_FW_CFG_FILE, NULL, NULL, NULL,
         &ges.ghes_addr_le, sizeof(ges.ghes_addr_le), false);
 }
+
+bool ghes_record_errors(uint32_t notify, uint64_t physical_address)
+{
+    uint64_t error_block_addr, read_ack_register_addr;
+    int read_ack_register = 0, loop = 0;
+    uint64_t start_addr = le32_to_cpu(ges.ghes_addr_le);
+    bool ret = GHES_CPER_FAIL;
+    const uint8_t error_source_id[] = { 0xff, 0xff, 0xff, 0xff,
+                                        0xff, 0xff, 0xff, 0, 1};
+
+    /*
+     * | +---------------------+ ges.ghes_addr_le
+     * | |error_block_address0|
+     * | +---------------------+
+     * | |error_block_address1|
+     * | +---------------------+ --+--
+     * | |    .............    | GHES_ADDRESS_SIZE
+     * | +---------------------+ --+--
+     * | |error_block_addressN|
+     * | +---------------------+
+     * | | read_ack_register0  |
+     * | +---------------------+ --+--
+     * | | read_ack_register1  | GHES_ADDRESS_SIZE
+     * | +---------------------+ --+--
+     * | |   .............     |
+     * | +---------------------+
+     * | | read_ack_registerN  |
+     * | +---------------------+ --+--
+     * | |      CPER           |   |
+     * | |      ....           | GHES_MAX_RAW_DATA_LENGT
+     * | |      CPER           |   |
+     * | +---------------------+ --+--
+     * | |    ..........       |
+     * | +---------------------+
+     * | |      CPER           |
+     * | |      ....           |
+     * | |      CPER           |
+     * | +---------------------+
+     */
+    if (physical_address && notify < ACPI_HEST_NOTIFY_RESERVED) {
+        /* Find and check the source id for this new CPER */
+        if (error_source_id[notify] != 0xff) {
+            start_addr += error_source_id[notify] * GHES_ADDRESS_SIZE;
+        } else {
+            goto out;
+        }
+
+        cpu_physical_memory_read(start_addr, &error_block_addr,
+                                    GHES_ADDRESS_SIZE);
+
+        read_ack_register_addr = start_addr +
+                        ACPI_HEST_ERROR_SOURCE_COUNT * GHES_ADDRESS_SIZE;
+retry:
+        cpu_physical_memory_read(read_ack_register_addr,
+                                 &read_ack_register, GHES_ADDRESS_SIZE);
+
+        /* zero means OSPM does not acknowledge the error */
+        if (!read_ack_register) {
+            if (loop < 3) {
+                usleep(100 * 1000);
+                loop++;
+                goto retry;
+            } else {
+                error_report("Last time OSPM does not acknowledge the error,"
+                    " record CPER failed this time, set the ack value to"
+                    " avoid blocking next time CPER record! exit");
+                read_ack_register = 1;
+                cpu_physical_memory_write(read_ack_register_addr,
+                    &read_ack_register, GHES_ADDRESS_SIZE);
+            }
+        } else {
+            if (error_block_addr) {
+                read_ack_register = 0;
+                cpu_physical_memory_write(read_ack_register_addr,
+                    &read_ack_register, GHES_ADDRESS_SIZE);
+                ret = ghes_record_mem_error(error_block_addr, physical_address);
+            }
+        }
+    }
+
+out:
+    return ret;
+}
diff --git a/include/hw/acpi/acpi_ghes.h b/include/hw/acpi/acpi_ghes.h
index 0a7c6c2..95d22ef 100644
--- a/include/hw/acpi/acpi_ghes.h
+++ b/include/hw/acpi/acpi_ghes.h
@@ -40,6 +40,9 @@
 #define GHES_CPER_OK                1
 #define GHES_CPER_FAIL              0
 
+#define GHES_CPER_OK                1
+#define GHES_CPER_FAIL              0
+
 /* The max size in bytes for one error block */
 #define GHES_MAX_RAW_DATA_LENGTH        0x1000
 /* Now only have GPIO-Signal and ARMv8 SEA notification types error sources
@@ -79,4 +82,5 @@ void build_apei_hest(GArray *table_data, GArray *hardware_error,
 
 void build_hardware_error_table(GArray *hardware_errors, BIOSLinker *linker);
 void ghes_add_fw_cfg(FWCfgState *s, GArray *hardware_errors);
+bool ghes_record_errors(uint32_t notify, uint64_t error_physical_addr);
 #endif
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 97d8d9d..fd07d62 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -377,7 +377,7 @@ bool kvm_vcpu_id_is_valid(int vcpu_id);
 /* Returns VCPU ID to be used on KVM_CREATE_VCPU ioctl() */
 unsigned long kvm_arch_vcpu_id(CPUState *cpu);
 
-#ifdef TARGET_I386
+#if defined(TARGET_I386) || defined(TARGET_AARCH64)
 #define KVM_HAVE_MCE_INJECTION 1
 void kvm_arch_on_sigbus_vcpu(CPUState *cpu, int code, void *addr);
 #endif
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 09a86e2..f22dc4e 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -28,6 +28,7 @@
 #include "exec/address-spaces.h"
 #include "hw/boards.h"
 #include "qemu/log.h"
+#include "exec/ram_addr.h"
 
 const KVMCapabilityInfo kvm_arch_required_capabilities[] = {
     KVM_CAP_LAST_INFO
@@ -176,6 +177,8 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
 
     cap_has_mp_state = kvm_check_extension(s, KVM_CAP_MP_STATE);
 
+    qemu_register_reset(kvm_unpoison_all, NULL);
+
     return 0;
 }
 
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 0ca2b29..913e707 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -27,6 +27,9 @@
 #include "kvm_arm.h"
 #include "internals.h"
 #include "hw/arm/arm.h"
+#include "exec/ram_addr.h"
+#include "hw/acpi/acpi-defs.h"
+#include "hw/acpi/acpi_ghes.h"
 
 static bool have_guest_debug;
 
@@ -929,6 +932,37 @@ int kvm_arch_get_registers(CPUState *cs)
     return ret;
 }
 
+void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
+{
+    ram_addr_t ram_addr;
+    hwaddr paddr;
+
+    assert(code == BUS_MCEERR_AR || code == BUS_MCEERR_AO);
+    if (addr) {
+        ram_addr = qemu_ram_addr_from_host(addr);
+        if (ram_addr != RAM_ADDR_INVALID &&
+            kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
+            kvm_hwpoison_page_add(ram_addr);
+            if (code == BUS_MCEERR_AR) {
+                kvm_cpu_synchronize_state(c);
+                if (ghes_record_errors(ACPI_HEST_NOTIFY_SEA, paddr)) {
+                    kvm_inject_arm_sea(c);
+                } else {
+                    fprintf(stderr, "failed to record the error\n");
+                }
+            }
+            return;
+        }
+        fprintf(stderr, "Hardware memory error for memory used by "
+                "QEMU itself instead of guest system!\n");
+    }
+
+    if (code == BUS_MCEERR_AR) {
+        fprintf(stderr, "Hardware memory error!\n");
+        exit(1);
+    }
+}
+
 /* C6.6.29 BRK instruction */
 static const uint32_t brk_insn = 0xd4200000;
 
-- 
1.8.3.1
