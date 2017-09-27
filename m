Received: from eggs.gnu.org ([2001:4830:134:3::10]:56509)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx70M-0001Qc-LS
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:43:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dx70L-00043R-Cx
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 03:43:38 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 27 Sep 2017 17:42:55 +1000
Message-Id: <20170927074316.4454-6-david@gibson.dropbear.id.au>
In-Reply-To: <20170927074316.4454-1-david@gibson.dropbear.id.au>
References: <20170927074316.4454-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 05/26] ppc: Add 460EX embedded CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, groug@kaod.org, mark.cave-ayland@ilande.co.uk, balaton@eik.bme.hu, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: BALATON Zoltan <balaton@eik.bme.hu>

Despite its name it is a 440 core CPU

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu-models.c     |  3 +++
 target/ppc/cpu-models.h     |  1 +
 target/ppc/translate_init.c | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
index 9626d6b7c4..9d45702843 100644
--- a/target/ppc/cpu-models.c
+++ b/target/ppc/cpu-models.c
@@ -167,6 +167,8 @@
                 "PowerPC 440 EPb")
     POWERPC_DEF("440epx",        CPU_POWERPC_440EPX,                 440EP,
                 "PowerPC 440 EPX")
+    POWERPC_DEF("460exb",        CPU_POWERPC_460EXb,                 460EX,
+                "PowerPC 460 EXb")
 #if defined(TODO_USER_ONLY)
     POWERPC_DEF("440gpb",        CPU_POWERPC_440GPb,                 440GP,
                 "PowerPC 440 GPb")
@@ -786,6 +788,7 @@ PowerPCCPUAlias ppc_cpu_aliases[] = {
     { "x2vp50", "x2vp20" },
 
     { "440ep", "440epb" },
+    { "460ex", "460exb" },
 #if defined(TODO_USER_ONLY)
     { "440gp", "440gpc" },
     { "440gr", "440gra" },
diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
index df31d7f492..ed64005ff8 100644
--- a/target/ppc/cpu-models.h
+++ b/target/ppc/cpu-models.h
@@ -240,6 +240,7 @@ enum {
     CPU_POWERPC_440SP              = 0x53221850,
     CPU_POWERPC_440SP2             = 0x53221891,
     CPU_POWERPC_440SPE             = 0x53421890,
+    CPU_POWERPC_460EXb             = 0x130218A4, /* called 460 but 440 core */
     /* PowerPC 460 family */
 #if 0
     /* Generic PowerPC 464 */
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 466bf97347..c6399a3a0d 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -3833,6 +3833,44 @@ POWERPC_FAMILY(440EP)(ObjectClass *oc, void *data)
                  POWERPC_FLAG_DE | POWERPC_FLAG_BUS_CLK;
 }
 
+POWERPC_FAMILY(460EX)(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    PowerPCCPUClass *pcc = POWERPC_CPU_CLASS(oc);
+
+    dc->desc = "PowerPC 460 EX";
+    pcc->init_proc = init_proc_440EP;
+    pcc->check_pow = check_pow_nocheck;
+    pcc->insns_flags = PPC_INSNS_BASE | PPC_STRING |
+                       PPC_FLOAT | PPC_FLOAT_FRES | PPC_FLOAT_FSEL |
+                       PPC_FLOAT_FSQRT | PPC_FLOAT_FRSQRTE |
+                       PPC_FLOAT_STFIWX |
+                       PPC_DCR | PPC_DCRX | PPC_WRTEE | PPC_RFMCI |
+                       PPC_CACHE | PPC_CACHE_ICBI |
+                       PPC_CACHE_DCBZ | PPC_CACHE_DCBA |
+                       PPC_MEM_TLBSYNC | PPC_MFTB |
+                       PPC_BOOKE | PPC_4xx_COMMON | PPC_405_MAC |
+                       PPC_440_SPEC;
+    pcc->msr_mask = (1ull << MSR_POW) |
+                    (1ull << MSR_CE) |
+                    (1ull << MSR_EE) |
+                    (1ull << MSR_PR) |
+                    (1ull << MSR_FP) |
+                    (1ull << MSR_ME) |
+                    (1ull << MSR_FE0) |
+                    (1ull << MSR_DWE) |
+                    (1ull << MSR_DE) |
+                    (1ull << MSR_FE1) |
+                    (1ull << MSR_IR) |
+                    (1ull << MSR_DR);
+    pcc->mmu_model = POWERPC_MMU_BOOKE;
+    pcc->excp_model = POWERPC_EXCP_BOOKE;
+    pcc->bus_model = PPC_FLAGS_INPUT_BookE;
+    pcc->bfd_mach = bfd_mach_ppc_403;
+    pcc->flags = POWERPC_FLAG_CE | POWERPC_FLAG_DWE |
+                 POWERPC_FLAG_DE | POWERPC_FLAG_BUS_CLK;
+}
+
 static void init_proc_440GP(CPUPPCState *env)
 {
     /* Time base */
-- 
2.13.5
