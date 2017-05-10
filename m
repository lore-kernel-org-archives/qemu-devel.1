Received: from eggs.gnu.org ([2001:4830:134:3::10]:42618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8Lcq-0002SF-8c
	for qemu-devel@nongnu.org; Wed, 10 May 2017 03:01:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8Lco-0007os-MM
	for qemu-devel@nongnu.org; Wed, 10 May 2017 03:01:32 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 10 May 2017 17:01:09 +1000
Message-Id: <20170510070115.13063-17-david@gibson.dropbear.id.au>
In-Reply-To: <20170510070115.13063-1-david@gibson.dropbear.id.au>
References: <20170510070115.13063-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 16/22] target/ppc: Change tlbie invalid fields
 for POWER9 support
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

From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

The tlbie[l] instructions are used to invalidate TLB entries used to cache
address translations.

In ISAv3.00 (POWER9) more fields were added to the tblie[l] instructions
which were previously invalid. We don't care about any of these new fields
since we just invalidate the whole world anyway but we need to not
cause an illegal instruction exception when the instructions are called.
We also don't want to allow an older processor to have these fields set
since that would be invalid.

Add a new GEN_HANDLER for the ISAv3 instructions with the correct invalid
mask. These will only be generated to a POWER9 processor for now based on
the instruction flag. Also remove the PPC_MEM_TLBIE instruction flag from
the POWER9 processor definition to ensure the old tlbie isn't generated.

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 target/ppc/translate.c      | 2 ++
 target/ppc/translate_init.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 1ce6ab1..c0cd64d 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -6578,6 +6578,8 @@ GEN_HANDLER(tlbia, 0x1F, 0x12, 0x0B, 0x03FFFC01, PPC_MEM_TLBIA),
  * different ISA versions */
 GEN_HANDLER(tlbiel, 0x1F, 0x12, 0x08, 0x001F0001, PPC_MEM_TLBIE),
 GEN_HANDLER(tlbie, 0x1F, 0x12, 0x09, 0x001F0001, PPC_MEM_TLBIE),
+GEN_HANDLER_E(tlbiel, 0x1F, 0x12, 0x08, 0x00100001, PPC_NONE, PPC2_ISA300),
+GEN_HANDLER_E(tlbie, 0x1F, 0x12, 0x09, 0x00100001, PPC_NONE, PPC2_ISA300),
 GEN_HANDLER(tlbsync, 0x1F, 0x16, 0x11, 0x03FFF801, PPC_MEM_TLBSYNC),
 #if defined(TARGET_PPC64)
 GEN_HANDLER(slbia, 0x1F, 0x12, 0x0F, 0x031FFC01, PPC_SLBI),
diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
index 9b048cd..fda30b0 100644
--- a/target/ppc/translate_init.c
+++ b/target/ppc/translate_init.c
@@ -8960,7 +8960,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
                        PPC_FLOAT_EXT |
                        PPC_CACHE | PPC_CACHE_ICBI | PPC_CACHE_DCBZ |
                        PPC_MEM_SYNC | PPC_MEM_EIEIO |
-                       PPC_MEM_TLBIE | PPC_MEM_TLBSYNC |
+                       PPC_MEM_TLBSYNC |
                        PPC_64B | PPC_64BX | PPC_ALTIVEC |
                        PPC_SEGMENT_64B | PPC_SLBI |
                        PPC_POPCNTB | PPC_POPCNTWD |
-- 
2.9.3
