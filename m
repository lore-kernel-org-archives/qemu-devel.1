Received: from eggs.gnu.org ([2001:4830:134:3::10]:56998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1e4c2J-0001oE-I3
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 20:16:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Andrew.Baumann@microsoft.com>) id 1e4c2F-0007k2-HR
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 20:16:39 -0400
From: Andrew Baumann <Andrew.Baumann@microsoft.com>
Date: Tue, 17 Oct 2017 17:16:08 -0700
Message-Id: <20171018001608.8388-1-Andrew.Baumann@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [RFC PATCH] arm: implement cache/shareability
 attribute bits for PAR registers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Andrew Baumann <Andrew.Baumann@microsoft.com>

On a successful address translation instruction, PAR is supposed to
contain cacheability and shareability attributes determined by the
translation. Previous versions of QEMU returned 0 for these bits (in
line with the general strategy of ignoring caches and memory
attributes), but some guests may depend on them.

This patch collects the attribute bits in the page-table work, and
updates PAR with the correct attributes after translation by the MAIR
registers, but only in the restricted case of an LPAE descriptor with
no second-stage translation. Other cases log an unimplemented message,
and return 0 in these bits as in the prior implementation.
---
This is my second attempt at implementing enough of the PAR attribute
bits to be able to boot Windows on aarch64. I'd appreciate some
feedback/guidance on the following:

1. Is adding these entirely ARM-specific fields to the generic
   MemTxAttrs bitfield the right approach, or would you prefer a new
   return field from get_phys_addr() and friends?

2. Is it acceptable to implement this piecemeal for the special LPAE
   case we care about, and defer the messy special cases for later? (I
   hope so!)

3. Is my implementation of mair0 and mair1 (with the XXX comments)
   sane? I suspect it's not. I had a hard time mapping what the ARM
   ARM describes (e.g. in the pseudocode for AArch32.S1AttrDecode and
   AArch64.S1AttrDecode) to the union interpreting mair_el[0] and
   mair_el[1].

Thanks,
Andrew


 include/exec/memattrs.h |  3 +++
 target/arm/helper.c     | 57 ++++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 59 insertions(+), 1 deletion(-)

diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
index d4a1642098..3f4e1d7f0d 100644
--- a/include/exec/memattrs.h
+++ b/include/exec/memattrs.h
@@ -37,6 +37,9 @@ typedef struct MemTxAttrs {
     unsigned int user:1;
     /* Requester ID (for MSI for example) */
     unsigned int requester_id:16;
+    /* ARM: memory cacheability and shareability attributes */
+    unsigned int arm_attrindx:3;
+    unsigned int arm_shareability:2;
 } MemTxAttrs;
 
 /* Bus masters which don't specify any attributes will get this,
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 96113fe989..1dc1834929 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -19,6 +19,9 @@
 #define ARM_CPU_FREQ 1000000000 /* FIXME: 1 GHz, should be configurable */
 
 #ifndef CONFIG_USER_ONLY
+static inline bool regime_using_lpae_format(CPUARMState *env,
+                                            ARMMMUIdx mmu_idx);
+
 static bool get_phys_addr(CPUARMState *env, target_ulong address,
                           MMUAccessType access_type, ARMMMUIdx mmu_idx,
                           hwaddr *phys_ptr, MemTxAttrs *attrs, int *prot,
@@ -2148,6 +2151,54 @@ static CPAccessResult ats_access(CPUARMState *env, const ARMCPRegInfo *ri,
     return CP_ACCESS_OK;
 }
 
+static uint8_t get_memattrs(CPUARMState *env, ARMMMUIdx mmu_idx,
+                            uint8_t attrindx)
+{
+    uint64_t mair;
+
+    if (!regime_using_lpae_format(env, mmu_idx)) {
+        qemu_log_mask(LOG_UNIMP,
+                      "arm: short PTE memory attributes not implemented");
+        return 0; /* keep consistency with the prior implementation */
+    }
+
+    switch (mmu_idx) {
+    case ARMMMUIdx_S1E2:
+        mair = env->cp15.mair_el[2];
+        break;
+
+    case ARMMMUIdx_S1E3:
+        mair = env->cp15.mair_el[3];
+        break;
+
+    case ARMMMUIdx_S1SE0:
+    case ARMMMUIdx_S1SE1:
+        /* XXX: is this correct? */
+        mair = (uint64_t)env->cp15.mair1_s << 32 | env->cp15.mair0_s;
+        break;
+
+    case ARMMMUIdx_S1NSE0:
+    case ARMMMUIdx_S1NSE1:
+        /* XXX: is this correct? */
+        mair = (uint64_t)env->cp15.mair1_ns << 32 | env->cp15.mair0_ns;
+        break;
+
+    case ARMMMUIdx_S12NSE0:
+    case ARMMMUIdx_S12NSE1:
+    case ARMMMUIdx_S2NS:
+        /* these cases (involving stage 2 attribute combining) are also NYI */
+        qemu_log_mask(LOG_UNIMP,
+                      "arm: stage 2 memory attributes not implemented");
+        return 0;
+
+    default:
+        abort(); /* M-profile code shouldn't reach here */
+    }
+
+    assert(attrindx <= 7);
+    return extract64(mair, attrindx * 8, 8);
+}
+
 static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
                              MMUAccessType access_type, ARMMMUIdx mmu_idx)
 {
@@ -2173,7 +2224,9 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
             if (!attrs.secure) {
                 par64 |= (1 << 9); /* NS */
             }
-            /* We don't set the ATTR or SH fields in the PAR. */
+            par64 |= (uint64_t)get_memattrs(env, mmu_idx,
+                                            attrs.arm_attrindx) << 56; /*ATTR*/
+            par64 |= attrs.arm_shareability << 7; /* SH */
         } else {
             par64 |= 1; /* F */
             par64 |= (fsr & 0x3f) << 1; /* FS */
@@ -8929,6 +8982,8 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
          */
         txattrs->secure = false;
     }
+    txattrs->arm_attrindx = extract32(attrs, 0, 3);
+    txattrs->arm_shareability = extract32(attrs, 6, 2);
     *phys_ptr = descaddr;
     *page_size_ptr = page_size;
     return false;
-- 
2.14.2
