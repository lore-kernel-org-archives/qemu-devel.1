Received: from eggs.gnu.org ([2001:4830:134:3::10]:56835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eMJBC-0001CD-Tl
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 14:47:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1eMJBB-0002Qh-Js
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 14:46:58 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Dec 2017 19:46:21 +0000
Message-Id: <1512503192-2239-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1512503192-2239-1-git-send-email-peter.maydell@linaro.org>
References: <1512503192-2239-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 01/12] target/arm: Provide fault type enum and
 FSR conversion functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Stefano Stabellini <sstabellini@kernel.org>

Currently get_phys_addr() and its various subfunctions return
a hard-coded fault status register value for translation
failures. This is awkward because FSR values these days may
be either long-descriptor format or short-descriptor format.
Worse, the right FSR type to use doesn't depend only on the
translation table being walked -- some cases, like fault
info reported to AArch32 EL2 for some kinds of ATS operation,
must be in long-descriptor format even if the translation
table being walked was short format. We can't get those cases
right with our current approach.

Provide fields in the ARMMMUFaultInfo struct which allow
get_phys_addr() to provide sufficient information for a caller to
construct an FSR value themselves, and utility functions which do
this for both long and short format FSR values, as a first step in
switching get_phys_addr() and its children to only returning the
failure cause in the ARMMMUFaultInfo struct.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/internals.h | 185 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 185 insertions(+)

diff --git a/target/arm/internals.h b/target/arm/internals.h
index aa9c91b..67b9a52 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -488,7 +488,39 @@ static inline void arm_clear_exclusive(CPUARMState *env)
 }
 
 /**
+ * ARMFaultType: type of an ARM MMU fault
+ * This corresponds to the v8A pseudocode's Fault enumeration,
+ * with extensions for QEMU internal conditions.
+ */
+typedef enum ARMFaultType {
+    ARMFault_None,
+    ARMFault_AccessFlag,
+    ARMFault_Alignment,
+    ARMFault_Background,
+    ARMFault_Domain,
+    ARMFault_Permission,
+    ARMFault_Translation,
+    ARMFault_AddressSize,
+    ARMFault_SyncExternal,
+    ARMFault_SyncExternalOnWalk,
+    ARMFault_SyncParity,
+    ARMFault_SyncParityOnWalk,
+    ARMFault_AsyncParity,
+    ARMFault_AsyncExternal,
+    ARMFault_Debug,
+    ARMFault_TLBConflict,
+    ARMFault_Lockdown,
+    ARMFault_Exclusive,
+    ARMFault_ICacheMaint,
+    ARMFault_QEMU_NSCExec, /* v8M: NS executing in S&NSC memory */
+    ARMFault_QEMU_SFault, /* v8M: SecureFault INVTRAN, INVEP or AUVIOL */
+} ARMFaultType;
+
+/**
  * ARMMMUFaultInfo: Information describing an ARM MMU Fault
+ * @type: Type of fault
+ * @level: Table walk level (for translation, access flag and permission faults)
+ * @domain: Domain of the fault address (for non-LPAE CPUs only)
  * @s2addr: Address that caused a fault at stage 2
  * @stage2: True if we faulted at stage 2
  * @s1ptw: True if we faulted at stage 2 while doing a stage 1 page-table walk
@@ -496,12 +528,165 @@ static inline void arm_clear_exclusive(CPUARMState *env)
  */
 typedef struct ARMMMUFaultInfo ARMMMUFaultInfo;
 struct ARMMMUFaultInfo {
+    ARMFaultType type;
     target_ulong s2addr;
+    int level;
+    int domain;
     bool stage2;
     bool s1ptw;
     bool ea;
 };
 
+/**
+ * arm_fi_to_sfsc: Convert fault info struct to short-format FSC
+ * Compare pseudocode EncodeSDFSC(), though unlike that function
+ * we set up a whole FSR-format code including domain field and
+ * putting the high bit of the FSC into bit 10.
+ */
+static inline uint32_t arm_fi_to_sfsc(ARMMMUFaultInfo *fi)
+{
+    uint32_t fsc;
+
+    switch (fi->type) {
+    case ARMFault_None:
+        return 0;
+    case ARMFault_AccessFlag:
+        fsc = fi->level == 1 ? 0x3 : 0x6;
+        break;
+    case ARMFault_Alignment:
+        fsc = 0x1;
+        break;
+    case ARMFault_Permission:
+        fsc = fi->level == 1 ? 0xd : 0xf;
+        break;
+    case ARMFault_Domain:
+        fsc = fi->level == 1 ? 0x9 : 0xb;
+        break;
+    case ARMFault_Translation:
+        fsc = fi->level == 1 ? 0x5 : 0x7;
+        break;
+    case ARMFault_SyncExternal:
+        fsc = 0x8 | (fi->ea << 12);
+        break;
+    case ARMFault_SyncExternalOnWalk:
+        fsc = fi->level == 1 ? 0xc : 0xe;
+        fsc |= (fi->ea << 12);
+        break;
+    case ARMFault_SyncParity:
+        fsc = 0x409;
+        break;
+    case ARMFault_SyncParityOnWalk:
+        fsc = fi->level == 1 ? 0x40c : 0x40e;
+        break;
+    case ARMFault_AsyncParity:
+        fsc = 0x408;
+        break;
+    case ARMFault_AsyncExternal:
+        fsc = 0x406 | (fi->ea << 12);
+        break;
+    case ARMFault_Debug:
+        fsc = 0x2;
+        break;
+    case ARMFault_TLBConflict:
+        fsc = 0x400;
+        break;
+    case ARMFault_Lockdown:
+        fsc = 0x404;
+        break;
+    case ARMFault_Exclusive:
+        fsc = 0x405;
+        break;
+    case ARMFault_ICacheMaint:
+        fsc = 0x4;
+        break;
+    case ARMFault_Background:
+        fsc = 0x0;
+        break;
+    case ARMFault_QEMU_NSCExec:
+        fsc = M_FAKE_FSR_NSC_EXEC;
+        break;
+    case ARMFault_QEMU_SFault:
+        fsc = M_FAKE_FSR_SFAULT;
+        break;
+    default:
+        /* Other faults can't occur in a context that requires a
+         * short-format status code.
+         */
+        g_assert_not_reached();
+    }
+
+    fsc |= (fi->domain << 4);
+    return fsc;
+}
+
+/**
+ * arm_fi_to_lfsc: Convert fault info struct to long-format FSC
+ * Compare pseudocode EncodeLDFSC(), though unlike that function
+ * we fill in also the LPAE bit 9 of a DFSR format.
+ */
+static inline uint32_t arm_fi_to_lfsc(ARMMMUFaultInfo *fi)
+{
+    uint32_t fsc;
+
+    switch (fi->type) {
+    case ARMFault_None:
+        return 0;
+    case ARMFault_AddressSize:
+        fsc = fi->level & 3;
+        break;
+    case ARMFault_AccessFlag:
+        fsc = (fi->level & 3) | (0x2 << 2);
+        break;
+    case ARMFault_Permission:
+        fsc = (fi->level & 3) | (0x3 << 2);
+        break;
+    case ARMFault_Translation:
+        fsc = (fi->level & 3) | (0x1 << 2);
+        break;
+    case ARMFault_SyncExternal:
+        fsc = 0x10 | (fi->ea << 12);
+        break;
+    case ARMFault_SyncExternalOnWalk:
+        fsc = (fi->level & 3) | (0x5 << 2) | (fi->ea << 12);
+        break;
+    case ARMFault_SyncParity:
+        fsc = 0x18;
+        break;
+    case ARMFault_SyncParityOnWalk:
+        fsc = (fi->level & 3) | (0x7 << 2);
+        break;
+    case ARMFault_AsyncParity:
+        fsc = 0x19;
+        break;
+    case ARMFault_AsyncExternal:
+        fsc = 0x11 | (fi->ea << 12);
+        break;
+    case ARMFault_Alignment:
+        fsc = 0x21;
+        break;
+    case ARMFault_Debug:
+        fsc = 0x22;
+        break;
+    case ARMFault_TLBConflict:
+        fsc = 0x30;
+        break;
+    case ARMFault_Lockdown:
+        fsc = 0x34;
+        break;
+    case ARMFault_Exclusive:
+        fsc = 0x35;
+        break;
+    default:
+        /* Other faults can't occur in a context that requires a
+         * long-format status code.
+         */
+        g_assert_not_reached();
+    }
+
+    fsc |= 1 << 9;
+    return fsc;
+}
+
 /* Do a page table walk and add page to TLB if possible */
 bool arm_tlb_fill(CPUState *cpu, vaddr address,
                   MMUAccessType access_type, int mmu_idx,
-- 
2.7.4
