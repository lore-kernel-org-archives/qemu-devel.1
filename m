Received: from eggs.gnu.org ([2001:4830:134:3::10]:56182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2TI6-0001Pt-BS
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 21:59:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2TI5-0003N4-8C
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 21:59:50 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 24 Apr 2017 11:58:56 +1000
Message-Id: <20170424015927.8933-17-david@gibson.dropbear.id.au>
In-Reply-To: <20170424015927.8933-1-david@gibson.dropbear.id.au>
References: <20170424015927.8933-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 16/47] target/ppc: Add ibm,
 processor-radix-AP-encodings for TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The ibm,processor-radix-AP-encodings device tree property of the cpu node
is used to specify the radix mode supported page sizes of the processor
to the guest os. Contained in the top 3 bits of the msb is the actual
page size (AP) encoding associated with the corresponding radix mode
supported page size. Add this property for a TCG guest, note the TCG code
is capable of translating any format so just add the 4 default page sizes.

The ibm,processor-radix-AP-encodings device tree property is defined as:
One to n cells in ascending order of radix mode supported page sizes
encoded as BE ints (32bit on ppc) in the form:
0bxxxyyyyyyyyyyyyyyyyyyyyyyyyyyyyy
- 0bxxx -> AP encoding
- 0byyyyyyyyyyyyyyyyyyyyyyyyyyyyy -> supported page size encoded as a shift

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate_init.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index c1a9014..aa0c44d 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -8808,6 +8808,25 @@ POWERPC_FAMILY(POWER8)(ObjectClass *oc, void *data)
     pcc->interrupts_big_endian = ppc_cpu_interrupts_big_endian_lpcr;
 }
 
+#ifdef CONFIG_SOFTMMU
+/*
+ * Radix pg sizes and AP encodings for dt node ibm,processor-radix-AP-encodings
+ * Encoded as array of int_32s in the form:
+ *  0bxxxyyyyyyyyyyyyyyyyyyyyyyyyyyyyy
+ *  x -> AP encoding
+ *  y -> radix mode supported page size (encoded as a shift)
+ */
+static struct ppc_radix_page_info POWER9_radix_page_info = {
+    .count = 4,
+    .entries = {
+        0x0000000c, /*  4K - enc: 0x0 */
+        0xa0000010, /* 64K - enc: 0x5 */
+        0x20000015, /*  2M - enc: 0x1 */
+        0x4000001e  /*  1G - enc: 0x2 */
+    }
+};
+#endif /* CONFIG_SOFTMMU */
+
 static void init_proc_POWER9(CPUPPCState *env)
 {
     /* Common Registers */
@@ -8959,6 +8978,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
     pcc->handle_mmu_fault = ppc64_v3_handle_mmu_fault;
     /* segment page size remain the same */
     pcc->sps = &POWER7_POWER8_sps;
+    pcc->radix_page_info = &POWER9_radix_page_info;
 #endif
     pcc->excp_model = POWERPC_EXCP_POWER8;
     pcc->bus_model = PPC_FLAGS_INPUT_POWER7;
-- 
2.9.3
