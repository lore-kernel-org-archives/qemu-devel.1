Received: from eggs.gnu.org ([2001:4830:134:3::10]:49252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dS1C3-0004kG-Sv
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 09:15:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1dS1C2-0001wp-QF
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 09:15:11 -0400
From: Laurent Vivier <lvivier@redhat.com>
Date: Mon,  3 Jul 2017 15:14:55 +0200
Message-Id: <20170703131455.25424-3-lvivier@redhat.com>
In-Reply-To: <20170703131455.25424-1-lvivier@redhat.com>
References: <20170703131455.25424-1-lvivier@redhat.com>
Subject: [Qemu-devel] [RFC v3 2/2] target/ppc: move POWER9 DD1 workaround to
 ppc_cpu_initfn
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
to ppc_cpu_initfn().

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 target/ppc/kvm.c            | 11 -----------
 target/ppc/translate_init.c | 10 ++++++++++
 2 files changed, 10 insertions(+), 11 deletions(-)

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
index 56a0ab2..ceb5bdb 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -10617,6 +10617,16 @@ static void ppc_cpu_initfn(Object *obj)
         };
         env->sps = (env->mmu_model & POWERPC_MMU_64K) ? defsps_64k : defsps_4k;
     }
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
 #endif /* defined(TARGET_PPC64) */
 
     if (tcg_enabled()) {
-- 
2.9.4
