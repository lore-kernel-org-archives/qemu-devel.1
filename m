Received: from eggs.gnu.org ([2001:4830:134:3::10]:49874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <doug16k@gmail.com>) id 1fUTFB-00014k-NI
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 04:41:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <doug16k@gmail.com>) id 1fUTF8-0003si-Ii
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 04:41:05 -0400
Received: from mail-it0-x241.google.com ([2607:f8b0:4001:c0b::241]:35487)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <doug16k@gmail.com>) id 1fUTF8-0003rg-BP
	for qemu-devel@nongnu.org; Sun, 17 Jun 2018 04:41:02 -0400
Received: by mail-it0-x241.google.com with SMTP id a3-v6so8182814itd.0
	for <qemu-devel@nongnu.org>; Sun, 17 Jun 2018 01:41:02 -0700 (PDT)
From: Doug Gale <doug16k@gmail.com>
Date: Sun, 17 Jun 2018 04:40:25 -0400
Message-Id: <20180617084025.29198-1-doug16k@gmail.com>
Subject: [Qemu-devel] [PATCH] i386/monitor.c: make addresses canonical for
 "info mem" and "info tlb"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>, Doug Gale <doug16k@gmail.com>

Correct the output of the "info mem" and "info tlb" monitor commands to
correctly show canonical addresses.

In 48-bit addressing mode, the upper 16 bits of linear addresses are
equal to bit 47. In 57-bit addressing mode (LA57), the upper 7 bits of
linear addresses are equal to bit 56.

Signed-off-by: Doug Gale <doug16k@gmail.com>
---
 target/i386/monitor.c | 76 +++++++++++++++++++++++++------------------
 1 file changed, 44 insertions(+), 32 deletions(-)

diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index a890b3c2ab..99c97a63e2 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -35,21 +35,28 @@
 #include "sev_i386.h"
 #include "qapi/qapi-commands-misc.h"
 
-
-static void print_pte(Monitor *mon, CPUArchState *env, hwaddr addr,
-                      hwaddr pte, hwaddr mask)
+/* Perform linear address sign extension */
+static hwaddr addr_canonical(CPUArchState *env, hwaddr addr)
 {
 #ifdef TARGET_X86_64
     if (env->cr[4] & CR4_LA57_MASK) {
         if (addr & (1ULL << 56)) {
-            addr |= -1LL << 57;
+            addr |= (hwaddr)-(1LL << 57);
         }
     } else {
         if (addr & (1ULL << 47)) {
-            addr |= -1LL << 48;
+            addr |= (hwaddr)-(1LL << 48);
         }
     }
 #endif
+    return addr;
+}
+
+static void print_pte(Monitor *mon, CPUArchState *env, hwaddr addr,
+                      hwaddr pte, hwaddr mask)
+{
+    addr = addr_canonical(env, addr);
+
     monitor_printf(mon, TARGET_FMT_plx ": " TARGET_FMT_plx
                    " %c%c%c%c%c%c%c%c%c\n",
                    addr,
@@ -243,8 +250,8 @@ void hmp_info_tlb(Monitor *mon, const QDict *qdict)
     }
 }
 
-static void mem_print(Monitor *mon, hwaddr *pstart,
-                      int *plast_prot,
+static void mem_print(Monitor *mon, CPUArchState *env,
+                      hwaddr *pstart, int *plast_prot,
                       hwaddr end, int prot)
 {
     int prot1;
@@ -253,7 +260,9 @@ static void mem_print(Monitor *mon, hwaddr *pstart,
         if (*pstart != -1) {
             monitor_printf(mon, TARGET_FMT_plx "-" TARGET_FMT_plx " "
                            TARGET_FMT_plx " %c%c%c\n",
-                           *pstart, end, end - *pstart,
+                           addr_canonical(env, *pstart),
+                           addr_canonical(env, end),
+                           addr_canonical(env, end - *pstart),
                            prot1 & PG_USER_MASK ? 'u' : '-',
                            'r',
                            prot1 & PG_RW_MASK ? 'w' : '-');
@@ -283,7 +292,7 @@ static void mem_info_32(Monitor *mon, CPUArchState *env)
         if (pde & PG_PRESENT_MASK) {
             if ((pde & PG_PSE_MASK) && (env->cr[4] & CR4_PSE_MASK)) {
                 prot = pde & (PG_USER_MASK | PG_RW_MASK | PG_PRESENT_MASK);
-                mem_print(mon, &start, &last_prot, end, prot);
+                mem_print(mon, env, &start, &last_prot, end, prot);
             } else {
                 for(l2 = 0; l2 < 1024; l2++) {
                     cpu_physical_memory_read((pde & ~0xfff) + l2 * 4, &pte, 4);
@@ -295,16 +304,16 @@ static void mem_info_32(Monitor *mon, CPUArchState *env)
                     } else {
                         prot = 0;
                     }
-                    mem_print(mon, &start, &last_prot, end, prot);
+                    mem_print(mon, env, &start, &last_prot, end, prot);
                 }
             }
         } else {
             prot = 0;
-            mem_print(mon, &start, &last_prot, end, prot);
+            mem_print(mon, env, &start, &last_prot, end, prot);
         }
     }
     /* Flush last range */
-    mem_print(mon, &start, &last_prot, (hwaddr)1 << 32, 0);
+    mem_print(mon, env, &start, &last_prot, (hwaddr)1 << 32, 0);
 }
 
 static void mem_info_pae32(Monitor *mon, CPUArchState *env)
@@ -332,7 +341,7 @@ static void mem_info_pae32(Monitor *mon, CPUArchState *env)
                     if (pde & PG_PSE_MASK) {
                         prot = pde & (PG_USER_MASK | PG_RW_MASK |
                                       PG_PRESENT_MASK);
-                        mem_print(mon, &start, &last_prot, end, prot);
+                        mem_print(mon, env, &start, &last_prot, end, prot);
                     } else {
                         pt_addr = pde & 0x3fffffffff000ULL;
                         for (l3 = 0; l3 < 512; l3++) {
@@ -345,21 +354,21 @@ static void mem_info_pae32(Monitor *mon, CPUArchState *env)
                             } else {
                                 prot = 0;
                             }
-                            mem_print(mon, &start, &last_prot, end, prot);
+                            mem_print(mon, env, &start, &last_prot, end, prot);
                         }
                     }
                 } else {
                     prot = 0;
-                    mem_print(mon, &start, &last_prot, end, prot);
+                    mem_print(mon, env, &start, &last_prot, end, prot);
                 }
             }
         } else {
             prot = 0;
-            mem_print(mon, &start, &last_prot, end, prot);
+            mem_print(mon, env, &start, &last_prot, end, prot);
         }
     }
     /* Flush last range */
-    mem_print(mon, &start, &last_prot, (hwaddr)1 << 32, 0);
+    mem_print(mon, env, &start, &last_prot, (hwaddr)1 << 32, 0);
 }
 
 
@@ -389,7 +398,7 @@ static void mem_info_la48(Monitor *mon, CPUArchState *env)
                         prot = pdpe & (PG_USER_MASK | PG_RW_MASK |
                                        PG_PRESENT_MASK);
                         prot &= pml4e;
-                        mem_print(mon, &start, &last_prot, end, prot);
+                        mem_print(mon, env, &start, &last_prot, end, prot);
                     } else {
                         pd_addr = pdpe & 0x3fffffffff000ULL;
                         for (l3 = 0; l3 < 512; l3++) {
@@ -401,7 +410,8 @@ static void mem_info_la48(Monitor *mon, CPUArchState *env)
                                     prot = pde & (PG_USER_MASK | PG_RW_MASK |
                                                   PG_PRESENT_MASK);
                                     prot &= pml4e & pdpe;
-                                    mem_print(mon, &start, &last_prot, end, prot);
+                                    mem_print(mon, env, &start,
+                                              &last_prot, end, prot);
                                 } else {
                                     pt_addr = pde & 0x3fffffffff000ULL;
                                     for (l4 = 0; l4 < 512; l4++) {
@@ -418,27 +428,29 @@ static void mem_info_la48(Monitor *mon, CPUArchState *env)
                                         } else {
                                             prot = 0;
                                         }
-                                        mem_print(mon, &start, &last_prot, end, prot);
+                                        mem_print(mon, env, &start,
+                                                  &last_prot, end, prot);
                                     }
                                 }
                             } else {
                                 prot = 0;
-                                mem_print(mon, &start, &last_prot, end, prot);
+                                mem_print(mon, env, &start,
+                                          &last_prot, end, prot);
                             }
                         }
                     }
                 } else {
                     prot = 0;
-                    mem_print(mon, &start, &last_prot, end, prot);
+                    mem_print(mon, env, &start, &last_prot, end, prot);
                 }
             }
         } else {
             prot = 0;
-            mem_print(mon, &start, &last_prot, end, prot);
+            mem_print(mon, env, &start, &last_prot, end, prot);
         }
     }
     /* Flush last range */
-    mem_print(mon, &start, &last_prot, (hwaddr)1 << 48, 0);
+    mem_print(mon, env, &start, &last_prot, (hwaddr)1 << 48, 0);
 }
 
 static void mem_info_la57(Monitor *mon, CPUArchState *env)
@@ -457,7 +469,7 @@ static void mem_info_la57(Monitor *mon, CPUArchState *env)
         end = l0 << 48;
         if (!(pml5e & PG_PRESENT_MASK)) {
             prot = 0;
-            mem_print(mon, &start, &last_prot, end, prot);
+            mem_print(mon, env, &start, &last_prot, end, prot);
             continue;
         }
 
@@ -468,7 +480,7 @@ static void mem_info_la57(Monitor *mon, CPUArchState *env)
             end = (l0 << 48) + (l1 << 39);
             if (!(pml4e & PG_PRESENT_MASK)) {
                 prot = 0;
-                mem_print(mon, &start, &last_prot, end, prot);
+                mem_print(mon, env, &start, &last_prot, end, prot);
                 continue;
             }
 
@@ -479,7 +491,7 @@ static void mem_info_la57(Monitor *mon, CPUArchState *env)
                 end = (l0 << 48) + (l1 << 39) + (l2 << 30);
                 if (pdpe & PG_PRESENT_MASK) {
                     prot = 0;
-                    mem_print(mon, &start, &last_prot, end, prot);
+                    mem_print(mon, env, &start, &last_prot, end, prot);
                     continue;
                 }
 
@@ -487,7 +499,7 @@ static void mem_info_la57(Monitor *mon, CPUArchState *env)
                     prot = pdpe & (PG_USER_MASK | PG_RW_MASK |
                             PG_PRESENT_MASK);
                     prot &= pml5e & pml4e;
-                    mem_print(mon, &start, &last_prot, end, prot);
+                    mem_print(mon, env, &start, &last_prot, end, prot);
                     continue;
                 }
 
@@ -498,7 +510,7 @@ static void mem_info_la57(Monitor *mon, CPUArchState *env)
                     end = (l0 << 48) + (l1 << 39) + (l2 << 30) + (l3 << 21);
                     if (pde & PG_PRESENT_MASK) {
                         prot = 0;
-                        mem_print(mon, &start, &last_prot, end, prot);
+                        mem_print(mon, env, &start, &last_prot, end, prot);
                         continue;
                     }
 
@@ -506,7 +518,7 @@ static void mem_info_la57(Monitor *mon, CPUArchState *env)
                         prot = pde & (PG_USER_MASK | PG_RW_MASK |
                                 PG_PRESENT_MASK);
                         prot &= pml5e & pml4e & pdpe;
-                        mem_print(mon, &start, &last_prot, end, prot);
+                        mem_print(mon, env, &start, &last_prot, end, prot);
                         continue;
                     }
 
@@ -523,14 +535,14 @@ static void mem_info_la57(Monitor *mon, CPUArchState *env)
                         } else {
                             prot = 0;
                         }
-                        mem_print(mon, &start, &last_prot, end, prot);
+                        mem_print(mon, env, &start, &last_prot, end, prot);
                     }
                 }
             }
         }
     }
     /* Flush last range */
-    mem_print(mon, &start, &last_prot, (hwaddr)1 << 57, 0);
+    mem_print(mon, env, &start, &last_prot, (hwaddr)1 << 57, 0);
 }
 #endif /* TARGET_X86_64 */
 
-- 
2.17.1
