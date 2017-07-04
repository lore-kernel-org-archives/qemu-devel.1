Received: from eggs.gnu.org ([2001:4830:134:3::10]:33271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dSLaN-0000qA-HF
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:01:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dSLaM-0004P8-Fd
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 07:01:39 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Tue,  4 Jul 2017 13:01:26 +0200
Message-Id: <20170704110126.26806-3-lvivier@redhat.com>
In-Reply-To: <20170704110126.26806-1-lvivier@redhat.com>
References: <20170704110126.26806-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH v4 2/2] target/ppc: move POWER9 DD1 workaround
 to init_proc_POWER9()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: joserz@linux.vnet.ibm.com, qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-ppc@nongnu.org, Suraj Singh <sursingh@redhat.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Sam Bobroff <sbobroff@redhat.com>, Greg Kurz <groug@kaod.org>, Laurent Vivier <lvivier@redhat.com>

Commit 5f3066d ("target/ppc: Allow workarounds for POWER9 DD1")
disables compatibility mode for POWER9 DD1 to allow to
boot on POWER9 DD1 host with KVM.

As the workaround has been added in kvmppc_host_cpu_class_init(),
it applies only on CPU created with "-cpu host".
As we want to be able to use also "-cpu POWER9" on a POWER9 DD1
host, this patch moves the workaround from kvmppc_host_cpu_class_init()
to init_proc_POWER9().

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 target/ppc/kvm.c            | 11 -----------
 target/ppc/translate_init.c | 15 ++++++++++++++-
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index f2f7c53..9d76817 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2381,17 +2381,6 @@ static void kvmppc_host_cpu_class_init(ObjectClass *oc, void *data)
 
 #if defined(TARGET_PPC64)
     pcc->radix_page_info = kvm_get_radix_page_info();
-
-    if ((pcc->pvr & 0xffffff00) == CPU_POWERPC_POWER9_DD1) {
-        /*
-         * POWER9 DD1 has some bugs which make it not really ISA 3.00
-         * compliant.  More importantly, advertising ISA 3.00
-         * architected mode may prevent guests from activating
-         * necessary DD1 workarounds.
-         */
-        pcc->pcr_supported &= ~(PCR_COMPAT_3_00 | PCR_COMPAT_2_07
-                                | PCR_COMPAT_2_06 | PCR_COMPAT_2_05);
-    }
 #endif /* defined(TARGET_PPC64) */
 }
 
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 783bf98..a41fe66 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -8811,6 +8811,8 @@ static struct ppc_radix_page_info POWER9_radix_page_info = {
 
 static void init_proc_POWER9(CPUPPCState *env)
 {
+    PowerPCCPU *cpu = ppc_env_get_cpu(env);
+    PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
     /* Common Registers */
     init_proc_book3s_common(env);
     gen_spr_book3s_207_dbg(env);
@@ -8848,7 +8850,18 @@ static void init_proc_POWER9(CPUPPCState *env)
 
     /* Allocate hardware IRQ controller */
     init_excp_POWER8(env);
-    ppcPOWER7_irq_init(ppc_env_get_cpu(env));
+    ppcPOWER7_irq_init(cpu);
+
+    if ((pcc->pvr & 0xffffff00) == CPU_POWERPC_POWER9_DD1) {
+        /*
+         * POWER9 DD1 has some bugs which make it not really ISA 3.00
+         * compliant.  More importantly, advertising ISA 3.00
+         * architected mode may prevent guests from activating
+         * necessary DD1 workarounds.
+         */
+        pcc->pcr_supported &= ~(PCR_COMPAT_3_00 | PCR_COMPAT_2_07
+                                | PCR_COMPAT_2_06 | PCR_COMPAT_2_05);
+    }
 }
 
 static bool ppc_pvr_match_power9(PowerPCCPUClass *pcc, uint32_t pvr)
-- 
2.9.4
