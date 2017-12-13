Received: from eggs.gnu.org ([2001:4830:134:3::10]:60396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tuxillo@quantumachine.net>) id 1ePGLi-0005JD-SU
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:22:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tuxillo@quantumachine.net>) id 1ePGLd-0007Je-Ro
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:22:02 -0500
Received: from mailrelay.quantumachine.net ([2001:41d0:51:1::917]:34262)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tuxillo@quantumachine.net>) id 1ePGLd-0007GQ-I1
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 18:21:57 -0500
Received: from mail.quantumachine.net (unknown [185.48.85.59])
	by mailrelay.quantumachine.net (Postfix) with ESMTP id 8A0164FE
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 00:21:49 +0100 (CET)
Date: Wed, 13 Dec 2017 23:21:43 +0000
Message-ID: <20171213232143.Horde.RpwulFxQGjmIA3Wh4f02qg_@www.quantumachine.net>
From: Antonio Huete =?utf-8?b?Smltw6luZXo=?= <tuxillo@quantumachine.net>
References: <20171213230659.Horde.vwhTWZmuKur7cOTN7Z3EQbG@www.quantumachine.net>
	<20171213231245.Horde.jAACBvvNQ-ZX-jaLJxsTY8E@www.quantumachine.net>
In-Reply-To: <20171213231245.Horde.jAACBvvNQ-ZX-jaLJxsTY8E@www.quantumachine.net>
Content-Type: text/plain; charset=utf-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH] test/i386 - Allow TCG to boot with > 1TB memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com

 From daea6caf8d9e023d06a825a774b678d26d978209 Mon Sep 17 00:00:00 2001
From: Antonio Huete Jimenez <tuxillo@quantumachine.net>
Date: Tue, 12 Dec 2017 19:17:49 +0100
Subject: [PATCH] test/i386 - Allow TCG to boot with > 1TB memory.

Currently for TCG the cpu 'phys_bits' property can't be specified
as it is hardcoded to be either 36 or 40 bits.

This patch lets the user specify the physical address bits for the
cpu as long as it's between a defined range. It will fallback to
'default' values which are the current ones so the behaviour
when the property isn't specified remains as it is now.

Signed-off-by: Antonio Huete Jimenez <tuxillo@quantumachine.net>
---
  target/i386/cpu.c         | 11 +++++++----
  target/i386/cpu.h         | 15 +++++++++------
  target/i386/excp_helper.c |  2 +-
  3 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 045d66191f..63da043027 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3687,9 +3687,12 @@ static void x86_cpu_realizefn(DeviceState *dev,  
Error **errp)
                  return;
              }
          } else {
-            if (cpu->phys_bits && cpu->phys_bits != TCG_PHYS_ADDR_BITS) {
-                error_setg(errp, "TCG only supports phys-bits=%u",
-                                  TCG_PHYS_ADDR_BITS);
+            if (cpu->phys_bits &&
+                (cpu->phys_bits > TARGET_PHYS_ADDR_SPACE_BITS ||
+                 cpu->phys_bits < 32)) {
+                error_setg(errp, "phys-bits should be between 32 and %u "
+                           " (but is %u)",
+                           TARGET_PHYS_ADDR_SPACE_BITS, cpu->phys_bits);
                  return;
              }
          }
@@ -3698,7 +3701,7 @@ static void x86_cpu_realizefn(DeviceState *dev,  
Error **errp)
           * is the value used by TCG (40).
           */
          if (cpu->phys_bits == 0) {
-            cpu->phys_bits = TCG_PHYS_ADDR_BITS;
+            cpu->phys_bits = DEFAULT_PHYS_ADDR_BITS;
          }
      } else {
          /* For 32 bit systems don't use the user set value, but keep
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index b086b1528b..fcb7cc8b96 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -280,7 +280,6 @@
  #define PG_GLOBAL_MASK   (1 << PG_GLOBAL_BIT)
  #define PG_PSE_PAT_MASK  (1 << PG_PSE_PAT_BIT)
  #define PG_ADDRESS_MASK  0x000ffffffffff000LL
-#define PG_HI_RSVD_MASK  (PG_ADDRESS_MASK & ~PHYS_ADDR_MASK)
  #define PG_HI_USER_MASK  0x7ff0000000000000LL
  #define PG_PKRU_MASK     (15ULL << PG_PKRU_BIT)
  #define PG_NX_MASK       (1ULL << PG_NX_BIT)
@@ -1498,15 +1497,19 @@ uint64_t cpu_get_tsc(CPUX86State *env);
  #define TARGET_VIRT_ADDR_SPACE_BITS 32
  #endif

-/* XXX: This value should match the one returned by CPUID
- * and in exec.c */
+/*
+ * This value matches the one returned by CPUID when running in KVM mode
+ * but for TCG as the host might be a different architecture so rely on
+ * either what the user passed in the cpu property phys-bits or use the
+ * default value.
+ */
  # if defined(TARGET_X86_64)
-# define TCG_PHYS_ADDR_BITS 40
+# define DEFAULT_PHYS_ADDR_BITS 40
  # else
-# define TCG_PHYS_ADDR_BITS 36
+# define DEFAULT_PHYS_ADDR_BITS 36
  # endif

-#define PHYS_ADDR_MASK MAKE_64BIT_MASK(0, TCG_PHYS_ADDR_BITS)
+#define PHYS_ADDR_MASK(cpu) MAKE_64BIT_MASK(0, cpu->phys_bits)

  #define cpu_init(cpu_model) cpu_generic_init(TYPE_X86_CPU, cpu_model)

diff --git a/target/i386/excp_helper.c b/target/i386/excp_helper.c
index cef44495ab..835c4379a9 100644
--- a/target/i386/excp_helper.c
+++ b/target/i386/excp_helper.c
@@ -173,7 +173,7 @@ int x86_cpu_handle_mmu_fault(CPUState *cs, vaddr addr,
      int error_code = 0;
      int is_dirty, prot, page_size, is_write, is_user;
      hwaddr paddr;
-    uint64_t rsvd_mask = PG_HI_RSVD_MASK;
+    uint64_t rsvd_mask = (PG_ADDRESS_MASK & ~PHYS_ADDR_MASK(cpu));
      uint32_t page_offset;
      target_ulong vaddr;

-- 
2.14.1
