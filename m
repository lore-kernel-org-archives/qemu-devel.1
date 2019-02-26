Received: from eggs.gnu.org ([209.51.188.92]:57712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUkn-0004wC-3B
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyUkm-0002Ln-13
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 23:54:05 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 26 Feb 2019 15:52:34 +1100
Message-Id: <20190226045304.25618-21-david@gibson.dropbear.id.au>
In-Reply-To: <20190226045304.25618-1-david@gibson.dropbear.id.au>
References: <20190226045304.25618-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 20/50] target/ppc: Re-enable RMLS on POWER9 for
 virtual hypervisors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Gibson <david@gibson.dropbear.id.au>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Historically the 64-bit server MMU supports two way of configuring the
guest "real mode" mapping:

 - The "RMA" with is a single chunk of physically contiguous
memory remapped as guest real, and controlled by the RMLS
field in the LPCR register and the RMOR register.

 - The "VRMA" which uses special PTEs inserted in the partition
hash table by the hypervisor.

POWER9 deprecates the former, which is reflected by the filtering
done in ppc_store_lpcr() which effectively prevents setting of
the RMLS field.

However, when using fully emulated SPAPR machines, our qemu code
currently only knows how to define the guest real mode memory using
RMLS.

Thus you cannot run a SPAPR machine anymore with a POWER9 CPU
model today.

This works around it with a quirk in ppc_store_lpcr() to continue
allowing the RMLS field to be set when using a virtual hypervisor.

Ultimately we will want to implement configuring a VRMA instead
which will also be necessary if we want to migrate a SPAPR guest
between TCG and KVM but this is a lot more work.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190215170029.15641-4-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/mmu-hash64.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index f1c7729332..1175b991d9 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -1088,6 +1088,14 @@ void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong =
val)
                       (LPCR_PECE_L_MASK & (LPCR_PDEE | LPCR_HDEE | LPCR_=
EEE |
                       LPCR_DEE | LPCR_OEE)) | LPCR_MER | LPCR_GTSE | LPC=
R_TC |
                       LPCR_HEIC | LPCR_LPES0 | LPCR_HVICE | LPCR_HDICE);
+        /*
+         * If we have a virtual hypervisor, we need to bring back RMLS. =
It
+         * doesn't exist on an actual P9 but that's all we know how to
+         * configure with softmmu at the moment
+         */
+        if (cpu->vhyp) {
+            lpcr |=3D (val & LPCR_RMLS);
+        }
         break;
     default:
         ;
--=20
2.20.1
