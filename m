Received: from eggs.gnu.org ([2001:4830:134:3::10]:46470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eJmZj-0000yX-0z
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 15:33:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1eJmZh-0003id-Pb
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 15:33:51 -0500
From: David Hildenbrand <david@redhat.com>
Date: Tue, 28 Nov 2017 21:33:17 +0100
Message-Id: <20171128203326.6062-8-david@redhat.com>
In-Reply-To: <20171128203326.6062-1-david@redhat.com>
References: <20171128203326.6062-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 for-2.12 07/15] s390x: handle exceptions
 during s390_cpu_virt_mem_rw() correctly (TCG)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

s390_cpu_virt_mem_rw() must always return, so callers can react on
an exception (e.g. see ioinst_handle_stcrw()). For TCG, there was one
case where a cpu loop exit was triggered. Fix that up.

However, for TCG we always have to exit the cpu loop (and restore the
cpu state before that) if we injected a program interrupt. So let's
introduce and use s390_cpu_virt_mem_handle_exc() in code that is not
purely KVM.

Directly pass the retaddr we already have available in these functions.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/s390x/s390-pci-inst.c  |  7 +++++++
 target/s390x/cpu.h        |  1 +
 target/s390x/ioinst.c     | 21 ++++++++++++++++++---
 target/s390x/mmu_helper.c | 19 ++++++++++++++++++-
 4 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
index 15ba8f55ae..3671432a29 100644
--- a/hw/s390x/s390-pci-inst.c
+++ b/hw/s390x/s390-pci-inst.c
@@ -163,6 +163,7 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra)
     }
 
     if (s390_cpu_virt_mem_read(cpu, env->regs[r2], r2, buffer, sizeof(*reqh))) {
+        s390_cpu_virt_mem_handle_exc(cpu, ra);
         return 0;
     }
     reqh = (ClpReqHdr *)buffer;
@@ -174,6 +175,7 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra)
 
     if (s390_cpu_virt_mem_read(cpu, env->regs[r2], r2, buffer,
                                req_len + sizeof(*resh))) {
+        s390_cpu_virt_mem_handle_exc(cpu, ra);
         return 0;
     }
     resh = (ClpRspHdr *)(buffer + req_len);
@@ -189,6 +191,7 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra)
 
     if (s390_cpu_virt_mem_read(cpu, env->regs[r2], r2, buffer,
                                req_len + res_len)) {
+        s390_cpu_virt_mem_handle_exc(cpu, ra);
         return 0;
     }
 
@@ -308,6 +311,7 @@ int clp_service_call(S390CPU *cpu, uint8_t r2, uintptr_t ra)
 out:
     if (s390_cpu_virt_mem_write(cpu, env->regs[r2], r2, buffer,
                                 req_len + res_len)) {
+        s390_cpu_virt_mem_handle_exc(cpu, ra);
         return 0;
     }
     setcc(cpu, cc);
@@ -692,6 +696,7 @@ int pcistb_service_call(S390CPU *cpu, uint8_t r1, uint8_t r3, uint64_t gaddr,
     }
 
     if (s390_cpu_virt_mem_read(cpu, gaddr, ar, buffer, len)) {
+        s390_cpu_virt_mem_handle_exc(cpu, ra);
         return 0;
     }
 
@@ -848,6 +853,7 @@ int mpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
     }
 
     if (s390_cpu_virt_mem_read(cpu, fiba, ar, (uint8_t *)&fib, sizeof(fib))) {
+        s390_cpu_virt_mem_handle_exc(cpu, ra);
         return 0;
     }
 
@@ -1029,6 +1035,7 @@ int stpcifc_service_call(S390CPU *cpu, uint8_t r1, uint64_t fiba, uint8_t ar,
 
 out:
     if (s390_cpu_virt_mem_write(cpu, fiba, ar, (uint8_t *)&fib, sizeof(fib))) {
+        s390_cpu_virt_mem_handle_exc(cpu, ra);
         return 0;
     }
 
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index e21d63ae04..617f9b0148 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -735,6 +735,7 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
         s390_cpu_virt_mem_rw(cpu, laddr, ar, dest, len, true)
 #define s390_cpu_virt_mem_check_write(cpu, laddr, ar, len)   \
         s390_cpu_virt_mem_rw(cpu, laddr, ar, NULL, len, true)
+void s390_cpu_virt_mem_handle_exc(S390CPU *cpu, uintptr_t ra);
 
 
 /* sigp.c */
diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
index 4b6d38f946..0851bf6fef 100644
--- a/target/s390x/ioinst.c
+++ b/target/s390x/ioinst.c
@@ -120,6 +120,7 @@ void ioinst_handle_msch(S390CPU *cpu, uint64_t reg1, uint32_t ipb, uintptr_t ra)
         return;
     }
     if (s390_cpu_virt_mem_read(cpu, addr, ar, &schib, sizeof(schib))) {
+        s390_cpu_virt_mem_handle_exc(cpu, ra);
         return;
     }
     if (ioinst_disassemble_sch_ident(reg1, &m, &cssid, &ssid, &schid) ||
@@ -176,6 +177,7 @@ void ioinst_handle_ssch(S390CPU *cpu, uint64_t reg1, uint32_t ipb, uintptr_t ra)
         return;
     }
     if (s390_cpu_virt_mem_read(cpu, addr, ar, &orig_orb, sizeof(orb))) {
+        s390_cpu_virt_mem_handle_exc(cpu, ra);
         return;
     }
     copy_orb_from_guest(&orb, &orig_orb);
@@ -212,9 +214,12 @@ void ioinst_handle_stcrw(S390CPU *cpu, uint32_t ipb, uintptr_t ra)
 
     if (s390_cpu_virt_mem_write(cpu, addr, ar, &crw, sizeof(crw)) == 0) {
         setcc(cpu, cc);
-    } else if (cc == 0) {
-        /* Write failed: requeue CRW since STCRW is a suppressing instruction */
-        css_undo_stcrw(&crw);
+    } else {
+        if (cc == 0) {
+            /* Write failed: requeue CRW since STCRW is suppressing */
+            css_undo_stcrw(&crw);
+        }
+        s390_cpu_virt_mem_handle_exc(cpu, ra);
     }
 }
 
@@ -243,6 +248,8 @@ void ioinst_handle_stsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb,
          */
         if (!s390_cpu_virt_mem_check_write(cpu, addr, ar, sizeof(schib))) {
             program_interrupt_ra(env, PGM_OPERAND, 4, ra);
+        } else {
+            s390_cpu_virt_mem_handle_exc(cpu, ra);
         }
         return;
     }
@@ -268,11 +275,13 @@ void ioinst_handle_stsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb,
     if (cc != 3) {
         if (s390_cpu_virt_mem_write(cpu, addr, ar, &schib,
                                     sizeof(schib)) != 0) {
+            s390_cpu_virt_mem_handle_exc(cpu, ra);
             return;
         }
     } else {
         /* Access exceptions have a higher priority than cc3 */
         if (s390_cpu_virt_mem_check_write(cpu, addr, ar, sizeof(schib)) != 0) {
+            s390_cpu_virt_mem_handle_exc(cpu, ra);
             return;
         }
     }
@@ -309,6 +318,7 @@ int ioinst_handle_tsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb, uintptr_t ra)
     /* 0 - status pending, 1 - not status pending, 3 - not operational */
     if (cc != 3) {
         if (s390_cpu_virt_mem_write(cpu, addr, ar, &irb, irb_len) != 0) {
+            s390_cpu_virt_mem_handle_exc(cpu, ra);
             return -EFAULT;
         }
         css_do_tsch_update_subch(sch);
@@ -316,6 +326,7 @@ int ioinst_handle_tsch(S390CPU *cpu, uint64_t reg1, uint32_t ipb, uintptr_t ra)
         irb_len = sizeof(irb) - sizeof(irb.emw);
         /* Access exceptions have a higher priority than cc3 */
         if (s390_cpu_virt_mem_check_write(cpu, addr, ar, irb_len) != 0) {
+            s390_cpu_virt_mem_handle_exc(cpu, ra);
             return -EFAULT;
         }
     }
@@ -611,6 +622,7 @@ void ioinst_handle_chsc(S390CPU *cpu, uint32_t ipb, uintptr_t ra)
      * care of req->len here first.
      */
     if (s390_cpu_virt_mem_read(cpu, addr, reg, buf, sizeof(ChscReq))) {
+        s390_cpu_virt_mem_handle_exc(cpu, ra);
         return;
     }
     req = (ChscReq *)buf;
@@ -645,9 +657,12 @@ void ioinst_handle_chsc(S390CPU *cpu, uint32_t ipb, uintptr_t ra)
     if (!s390_cpu_virt_mem_write(cpu, addr + len, reg, res,
                                  be16_to_cpu(res->len))) {
         setcc(cpu, 0);    /* Command execution complete */
+    } else {
+        s390_cpu_virt_mem_handle_exc(cpu, ra);
     }
 }
 
+
 #define SCHM_REG1_RES(_reg) (_reg & 0x000000000ffffffc)
 #define SCHM_REG1_MBK(_reg) ((_reg & 0x00000000f0000000) >> 28)
 #define SCHM_REG1_UPD(_reg) ((_reg & 0x0000000000000002) >> 1)
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index 31e3f3f415..39da9aeef4 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -22,6 +22,7 @@
 #include "internal.h"
 #include "kvm_s390x.h"
 #include "sysemu/kvm.h"
+#include "exec/exec-all.h"
 #include "trace.h"
 #include "hw/s390x/storage-keys.h"
 
@@ -458,7 +459,7 @@ static int translate_pages(S390CPU *cpu, vaddr addr, int nr_pages,
         }
         if (!address_space_access_valid(&address_space_memory, pages[i],
                                         TARGET_PAGE_SIZE, is_write)) {
-            program_interrupt(env, PGM_ADDRESSING, ILEN_AUTO);
+            trigger_pgm_exception(env, PGM_ADDRESSING, ILEN_AUTO);
             return -EFAULT;
         }
         addr += TARGET_PAGE_SIZE;
@@ -478,6 +479,9 @@ static int translate_pages(S390CPU *cpu, vaddr addr, int nr_pages,
  *
  * Copy from/to guest memory using logical addresses. Note that we inject a
  * program interrupt in case there is an error while accessing the memory.
+ *
+ * This function will always return (also for TCG), make sure to call
+ * s390_cpu_virt_mem_handle_exc() to properly exit the CPU loop.
  */
 int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
                          int len, bool is_write)
@@ -514,6 +518,19 @@ int s390_cpu_virt_mem_rw(S390CPU *cpu, vaddr laddr, uint8_t ar, void *hostbuf,
     return ret;
 }
 
+void s390_cpu_virt_mem_handle_exc(S390CPU *cpu, uintptr_t ra)
+{
+    /* KVM will handle the interrupt automatically, TCG has to exit the TB */
+    #ifdef CONFIG_TCG
+    if (tcg_enabled()) {
+        if (ra) {
+            cpu_restore_state(CPU(cpu), ra);
+        }
+        cpu_loop_exit(CPU(cpu));
+    }
+    #endif
+}
+
 /**
  * Translate a real address into a physical (absolute) address.
  * @param raddr  the real address
-- 
2.14.3
