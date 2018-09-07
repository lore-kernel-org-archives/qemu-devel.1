Received: from eggs.gnu.org ([2001:4830:134:3::10]:45603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fyBFU-0007UK-J4
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 03:32:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fyBFT-00054n-7z
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 03:32:12 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri,  7 Sep 2018 17:31:55 +1000
Message-Id: <20180907073155.26200-15-david@gibson.dropbear.id.au>
In-Reply-To: <20180907073155.26200-1-david@gibson.dropbear.id.au>
References: <20180907073155.26200-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 14/14] target-ppc: Extend HWCAP2 bits for ISA 3.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, lvivier@redhat.com, groug@kaod.org, clg@kaod.org, mark.cave-ayland@ilande.co.uk, Sandipan Das <sandipan@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Sandipan Das <sandipan@linux.ibm.com>

This adds the HWCAP2 bit to detect if a linux user process is
running on an ISA 3.0 compliant cpu like POWER9. This can be
verified using a simple test program that prints the value in
the auxiliary vector for AT_HWCAP2 as shown below.

Before:
  $ qemu-ppc64le -cpu power8 test
  0x8c000000

  $ qemu-ppc64le -cpu power9 test
  0x8c000000

After:
  $ qemu-ppc64le -cpu power8 test
  0x8c000000

  $ qemu-ppc64le -cpu power9 test
  0x8c800000

Signed-off-by: Sandipan Das <sandipan@linux.ibm.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 linux-user/elfload.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 8638612aec..e97c4cde49 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -710,6 +710,7 @@ enum {
     QEMU_PPC_FEATURE2_HAS_EBB = 0x10000000, /* Event Base Branching */
     QEMU_PPC_FEATURE2_HAS_ISEL = 0x08000000, /* Integer Select */
     QEMU_PPC_FEATURE2_HAS_TAR = 0x04000000, /* Target Address Register */
+    QEMU_PPC_FEATURE2_ARCH_3_00 = 0x00800000, /* ISA 3.00 */
 };
 
 #define ELF_HWCAP get_elf_hwcap()
@@ -764,6 +765,7 @@ static uint32_t get_elf_hwcap2(void)
     GET_FEATURE2(PPC2_BCTAR_ISA207, QEMU_PPC_FEATURE2_HAS_TAR);
     GET_FEATURE2((PPC2_BCTAR_ISA207 | PPC2_LSQ_ISA207 | PPC2_ALTIVEC_207 |
                   PPC2_ISA207S), QEMU_PPC_FEATURE2_ARCH_2_07);
+    GET_FEATURE2(PPC2_ISA300, QEMU_PPC_FEATURE2_ARCH_3_00);
 
 #undef GET_FEATURE
 #undef GET_FEATURE2
-- 
2.17.1
