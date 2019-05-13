Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0030BC04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 13:07:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B99582166E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 13:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B99582166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57036 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQAgG-0007Zu-OF
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 09:07:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1hQAbh-0003al-51
	for qemu-devel@nongnu.org; Mon, 13 May 2019 09:03:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1hQAM3-00088f-Jp
	for qemu-devel@nongnu.org; Mon, 13 May 2019 08:46:57 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2212 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <gengdongjiu@huawei.com>)
	id 1hQAM0-00080y-0I; Mon, 13 May 2019 08:46:53 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
	by Forcepoint Email with ESMTP id 7628658FDE34E46A89B2;
	Mon, 13 May 2019 20:46:48 +0800 (CST)
Received: from ros.huawei.com (10.143.28.118) by
	DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server
	id 14.3.439.0; Mon, 13 May 2019 20:46:41 +0800
From: Dongjiu Geng <gengdongjiu@huawei.com>
To: <pbonzini@redhat.com>, <mst@redhat.com>, <imammedo@redhat.com>,
	<shannon.zhaosl@gmail.com>, <peter.maydell@linaro.org>,
	<lersek@redhat.com>, 
	<james.morse@arm.com>, <gengdongjiu@huawei.com>, <mtosatti@redhat.com>, 
	<rth@twiddle.net>, <ehabkost@redhat.com>, <zhengxiang9@huawei.com>,
	<jonathan.cameron@huawei.com>, <xuwei5@huawei.com>, <kvm@vger.kernel.org>, 
	<qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>, <linuxarm@huawei.com>
Date: Mon, 13 May 2019 05:43:08 -0700
Message-ID: <1557751388-27063-11-git-send-email-gengdongjiu@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1557751388-27063-1-git-send-email-gengdongjiu@huawei.com>
References: <1557751388-27063-1-git-send-email-gengdongjiu@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.143.28.118]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.190
Subject: [Qemu-devel] [PATCH v16 10/10] target-arm: kvm64: handle SIGBUS
 signal from kernel or KVM
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add SIGBUS signal handler. In this handler, it checks the SIGBUS type,
translates the host VA delivered by host to guest PA, then fill this PA
to guest APEI GHES memory, then notify guest according to the SIGBUS type.

If guest accesses the poisoned memory, it generates Synchronous External
Abort(SEA). Then host kernel gets an APEI notification and call memory_failure()
to unmapped the affected page for the guest's stage 2, finally return
to guest.

Guest continues to access PG_hwpoison page, it will trap to KVM as stage2 fault,
then a SIGBUS_MCEERR_AR synchronous signal is delivered to Qemu, Qemu record this
error address into guest APEI GHES memory and notify guest using
Synchronous-External-Abort(SEA).

Suggested-by: James Morse <james.morse@arm.com>
Signed-off-by: Dongjiu Geng <gengdongjiu@huawei.com>
---
 hw/acpi/acpi_ghes.c         | 177 ++++++++++++++++++++++++++++++++++++++++++++
 include/hw/acpi/acpi_ghes.h |   6 +-
 include/sysemu/kvm.h        |   2 +-
 target/arm/kvm64.c          |  40 ++++++++++
 4 files changed, 223 insertions(+), 2 deletions(-)

diff --git a/hw/acpi/acpi_ghes.c b/hw/acpi/acpi_ghes.c
index d03e797..06b7374 100644
--- a/hw/acpi/acpi_ghes.c
+++ b/hw/acpi/acpi_ghes.c
@@ -26,6 +26,101 @@
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
+    /* Generic Error Status Block
+     * | +---------------------+
+     * | |     block_status    |
+     * | +---------------------+
+     * | |    raw_data_offset  |
+     * | +---------------------+
+     * | |    raw_data_length  |
+     * | +---------------------+
+     * | |     data_length     |
+     * | +---------------------+
+     * | |   error_severity    |
+     * | +---------------------+
+     */
+    block = g_array_new(false, true /* clear */, 1);
+
+    /* Get the length of the Generic Error Data Entries */
+    cpu_physical_memory_read(error_block_address +
+        offsetof(AcpiGenericErrorStatus, data_length), &data_length, 4);
+
+    /* The current whole length of the generic error status block */
+    current_block_length = sizeof(AcpiGenericErrorStatus) + le32_to_cpu(data_length);
+
+    /* This is the length if adding a new generic error data entry*/
+    data_length += GHES_DATA_LENGTH;
+    data_length += GHES_MEM_CPER_LENGTH;
+
+    /* Check whether it will run out of the preallocated memory if adding a new
+     * generic error data entry
+     */
+    if ((data_length + sizeof(AcpiGenericErrorStatus)) > GHES_MAX_RAW_DATA_LENGTH) {
+        error_report("Record CPER out of boundary!!!");
+        return GHES_CPER_FAIL;
+    }
+
+    /* Build the new generic error status block header */
+    build_append_ghes_generic_status(block, cpu_to_le32(ACPI_GEBS_UNCORRECTABLE), 0, 0,
+        cpu_to_le32(data_length), cpu_to_le32(ACPI_CPER_SEV_RECOVERABLE));
+
+    /* Write back above generic error status block header to guest memory */
+    cpu_physical_memory_write(error_block_address, block->data,
+                              block->len);
+
+    /* Add a new generic error data entry */
+
+    data_length = block->len;
+    /* Build this new generic error data entry header */
+    build_append_ghes_generic_data(block, mem_section_id_le,
+                    cpu_to_le32(ACPI_CPER_SEV_RECOVERABLE), cpu_to_le32(0x300), 0, 0,
+                    cpu_to_le32(80)/* the total size of Memory Error Record */, fru_id,
+                    fru_text, 0);
+
+    /* Build the memory section CPER for above new generic error data entry */
+    build_append_mem_cper(block, error_physical_addr);
+
+    /* Write back above this new generic error data entry to guest memory */
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
@@ -169,3 +264,85 @@ void ghes_add_fw_cfg(FWCfgState *s, GArray *hardware_error)
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
+     * | |error_block_address0 |
+     * | +---------------------+ --+--
+     * | |    .............    | GHES_ADDRESS_SIZE
+     * | +---------------------+ --+--
+     * | |error_block_addressN |
+     * | +---------------------+
+     * | | read_ack_register0  |
+     * | +---------------------+ --+--
+     * | |   .............     | GHES_ADDRESS_SIZE
+     * | +---------------------+ --+--
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
+                error_report("OSPM does not acknowledge previous error,"
+                    " so can not record CPER for current error, forcibly acknowledge"
+                    " previous error to avoid blocking next time CPER record! Exit");
+                read_ack_register = 1;
+                cpu_physical_memory_write(read_ack_register_addr,
+                    &read_ack_register, GHES_ADDRESS_SIZE);
+            }
+        } else {
+            if (error_block_addr) {
+                read_ack_register = 0;
+                /* Clear the Read Ack Register, OSPM will write it to 1 when
+                 * acknowledge this error.
+                 */
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
index 38fd87c..6b38097 100644
--- a/include/hw/acpi/acpi_ghes.h
+++ b/include/hw/acpi/acpi_ghes.h
@@ -32,11 +32,14 @@
 #define GHES_ADDRESS_SIZE           8
 
 #define GHES_DATA_LENGTH            72
-#define GHES_CPER_LENGTH            80
+#define GHES_MEM_CPER_LENGTH        80
 
 #define ReadAckPreserve             0xfffffffe
 #define ReadAckWrite                0x1
 
+#define GHES_CPER_OK                1
+#define GHES_CPER_FAIL              0
+
 /* The max size in bytes for one error block */
 #define GHES_MAX_RAW_DATA_LENGTH        0x1000
 /* Now only have GPIO-Signal and ARMv8 SEA notification types error sources
@@ -76,4 +79,5 @@ void build_apei_hest(GArray *table_data, GArray *hardware_error,
 
 void build_hardware_error_table(GArray *hardware_errors, BIOSLinker *linker);
 void ghes_add_fw_cfg(FWCfgState *s, GArray *hardware_errors);
+bool ghes_record_errors(uint32_t notify, uint64_t error_physical_addr);
 #endif
diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index a6d1cd1..1d1a7a8 100644
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
diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index c7bdc6a..6e5341d 100644
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
 
@@ -1029,6 +1032,43 @@ int kvm_arch_get_registers(CPUState *cs)
     return ret;
 }
 
+void kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
+{
+    ARMCPU *cpu = ARM_CPU(c);
+    CPUARMState *env = &cpu->env;
+    ram_addr_t ram_addr;
+    hwaddr paddr;
+
+    assert(code == BUS_MCEERR_AR || code == BUS_MCEERR_AO);
+
+    if (addr) {
+        ram_addr = qemu_ram_addr_from_host(addr);
+        if (ram_addr != RAM_ADDR_INVALID &&
+            kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
+            kvm_hwpoison_page_add(ram_addr);
+            /* Asynchronous signal will be masked by main thread, so
+             * only handle synchronous signal.
+             */
+            if (code == BUS_MCEERR_AR) {
+                kvm_cpu_synchronize_state(c);
+                if (GHES_CPER_FAIL != ghes_record_errors(ACPI_HEST_NOTIFY_SEA, paddr)) {
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


