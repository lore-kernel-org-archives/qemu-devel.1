Received: from eggs.gnu.org ([2001:4830:134:3::10]:51880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dh273-0007Rf-Vf
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 19:16:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dh270-0005wL-Mk
	for qemu-devel@nongnu.org; Sun, 13 Aug 2017 19:16:05 -0400
Message-Id: <49e4b95ddbb40575bfb4db2e7c43b0b0801ce399.1502643878.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1502643878.git.balaton@eik.bme.hu>
References: <cover.1502643878.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Sun, 13 Aug 2017 19:04:38 +0200
Subject: [Qemu-devel] [RFC PATCH 10/12] ppc: Add 460EX embedded CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>, Francois Revol <revol@free.fr>

Despite its name it is a 440 core CPU

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 target/ppc/cpu-models.c     |  3 +++
 target/ppc/cpu-models.h     |  1 +
 target/ppc/translate_init.c | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+)

diff --git a/target/ppc/cpu-models.c b/target/ppc/cpu-models.c
index 4d3e635..7c368fc 100644
--- a/target/ppc/cpu-models.c
+++ b/target/ppc/cpu-models.c
@@ -348,6 +348,8 @@
                 "PowerPC 440 EPb")
     POWERPC_DEF("440EPX",        CPU_POWERPC_440EPX,                 440EP,
                 "PowerPC 440 EPX")
+    POWERPC_DEF("460EXb",        CPU_POWERPC_460EXb,                 460EX,
+                "PowerPC 460 EXb")
 #if defined(TODO_USER_ONLY)
     POWERPC_DEF("440GPb",        CPU_POWERPC_440GPb,                 440GP,
                 "PowerPC 440 GPb")
@@ -1238,6 +1240,7 @@ PowerPCCPUAlias ppc_cpu_aliases[] = {
     { "440GP", "440GPc" },
     { "440GR", "440GRa" },
     { "440GX", "440GXf" },
+    { "460EX", "460EXb" },
 
     { "RCPU", "MPC5xx" },
     /* MPC5xx microcontrollers */
diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
index b563c45..92f99c0 100644
--- a/target/ppc/cpu-models.h
+++ b/target/ppc/cpu-models.h
@@ -241,6 +241,7 @@ enum {
     CPU_POWERPC_440SP              = 0x53221850,
     CPU_POWERPC_440SP2             = 0x53221891,
     CPU_POWERPC_440SPE             = 0x53421890,
+    CPU_POWERPC_460EXb             = 0x130218A4, /* called 460 but 440 core */
     /* PowerPC 460 family */
 #if 0
     /* Generic PowerPC 464 */
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 8fb407e..1e0d566 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -3832,6 +3832,44 @@ POWERPC_FAMILY(440EP)(ObjectClass *oc, void *data)
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
2.7.4
