Received: from eggs.gnu.org ([2001:4830:134:3::10]:56340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8fV1-0005RW-Ja
	for qemu-devel@nongnu.org; Thu, 11 May 2017 00:14:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8fV0-0001aU-9U
	for qemu-devel@nongnu.org; Thu, 11 May 2017 00:14:47 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 11 May 2017 14:14:24 +1000
Message-Id: <20170511041426.6488-22-david@gibson.dropbear.id.au>
In-Reply-To: <20170511041426.6488-1-david@gibson.dropbear.id.au>
References: <20170511041426.6488-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 21/23] target/ppc: Allow workarounds for POWER9
 DD1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com, bharata@linux.vnet.ibm.com, agraf@suse.de, aik@ozlabs.ru, sjitindarsingh@gmail.com, mark.cave-ayland@ilande.co.uk, sam.bobroff@au1.ibm.com, nikunj@linux.vnet.ibm.com, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

POWER9 DD1 silicon has some bugs which mean it a) isn't really compliant
with the ISA v3.00 and b) require a number of special workarounds in the
kernel.

At the moment, qemu isn't aware of DD1.  For TCG we don't really want it to
be (why bother emulating buggy silicon).  But with KVM, the guest does need
to be aware of DD1 so it can apply the necessary workarounds.

Meanwhile, the feature negotiation between qemu and the guest strongly
favours architected compatibility modes to "raw" CPU modes.  In combination
with the above, this means the guest sees architected POWER9 mode, and
doesn't apply the DD1 workarounds.  Well, unless it has yet another
workaround to partially ignore what qemu tells it.

This patch addresses this by disabling support for compatibility modes when
using KVM on a POWER9 DD1 host.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/cpu-models.h |  1 +
 target/ppc/kvm.c        | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/target/ppc/cpu-models.h b/target/ppc/cpu-models.h
index d587e69..b563c45 100644
--- a/target/ppc/cpu-models.h
+++ b/target/ppc/cpu-models.h
@@ -561,6 +561,7 @@ enum {
     CPU_POWERPC_POWER8NVL_BASE     = 0x004C0000,
     CPU_POWERPC_POWER8NVL_v10      = 0x004C0100,
     CPU_POWERPC_POWER9_BASE        = 0x004E0000,
+    CPU_POWERPC_POWER9_DD1         = 0x004E0100,
     CPU_POWERPC_970_v22            = 0x00390202,
     CPU_POWERPC_970FX_v10          = 0x00391100,
     CPU_POWERPC_970FX_v20          = 0x003C0200,
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 8574c36..cb2cf2b 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2380,6 +2380,17 @@ static void kvmppc_host_cpu_class_init(ObjectClass *oc, void *data)
 
 #if defined(TARGET_PPC64)
     pcc->radix_page_info = kvm_get_radix_page_info();
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
 #endif /* defined(TARGET_PPC64) */
 }
 
-- 
2.9.3
