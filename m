Received: from eggs.gnu.org ([2001:4830:134:3::10]:35962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ciKgo-0004id-KB
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:46:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ciKgm-0000Zu-E8
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:46:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ciKgm-0000Yo-34
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:46:04 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3AB324E4C6
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 12:46:04 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-117-118.ams2.redhat.com
	[10.36.117.118])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1RCjpe4028718
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 07:46:03 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 27 Feb 2017 13:45:43 +0100
Message-Id: <20170227124551.8673-10-pbonzini@redhat.com>
In-Reply-To: <20170227124551.8673-1-pbonzini@redhat.com>
References: <20170227124551.8673-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 09/17] KVM: remove kvm_arch_on_sigbus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Build it on kvm_arch_on_sigbus_vcpu instead.  They do the same
for "action optional" SIGBUSes, and the main thread should never get
"action required" SIGBUSes because it blocks the signal.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/kvm.h |  1 -
 kvm-all.c            |  9 ++++++++-
 target/arm/kvm.c     |  5 -----
 target/i386/kvm.c    | 40 +++++-----------------------------------
 target/mips/kvm.c    |  6 ------
 target/ppc/kvm.c     |  5 -----
 target/s390x/kvm.c   |  5 -----
 7 files changed, 13 insertions(+), 58 deletions(-)

diff --git a/include/sysemu/kvm.h b/include/sysemu/kvm.h
index 3045ee7..6ecb61c 100644
--- a/include/sysemu/kvm.h
+++ b/include/sysemu/kvm.h
@@ -358,7 +358,6 @@ bool kvm_vcpu_id_is_valid(int vcpu_id);
 unsigned long kvm_arch_vcpu_id(CPUState *cpu);
 
 int kvm_arch_on_sigbus_vcpu(CPUState *cpu, int code, void *addr);
-int kvm_arch_on_sigbus(int code, void *addr);
 
 void kvm_arch_init_irq_routing(KVMState *s);
 
diff --git a/kvm-all.c b/kvm-all.c
index 0c94637..a433ad3 100644
--- a/kvm-all.c
+++ b/kvm-all.c
@@ -2391,6 +2391,7 @@ int kvm_set_signal_mask(CPUState *cpu, const sigset_t *sigset)
 
     return r;
 }
+
 int kvm_on_sigbus_vcpu(CPUState *cpu, int code, void *addr)
 {
     return kvm_arch_on_sigbus_vcpu(cpu, code, addr);
@@ -2398,7 +2399,13 @@ int kvm_on_sigbus_vcpu(CPUState *cpu, int code, void *addr)
 
 int kvm_on_sigbus(int code, void *addr)
 {
-    return kvm_arch_on_sigbus(code, addr);
+    /* Action required MCE kills the process if SIGBUS is blocked.  Because
+     * that's what happens in the I/O thread, where we handle MCE via signalfd,
+     * we can only get action optional here.
+     */
+    assert(code != BUS_MCEERR_AR);
+    kvm_arch_on_sigbus_vcpu(first_cpu, code, addr);
+    return 0;
 }
 
 int kvm_create_device(KVMState *s, uint64_t type, bool test)
diff --git a/target/arm/kvm.c b/target/arm/kvm.c
index 395e986..e5218f6 100644
--- a/target/arm/kvm.c
+++ b/target/arm/kvm.c
@@ -565,11 +565,6 @@ int kvm_arch_on_sigbus_vcpu(CPUState *cs, int code, void *addr)
     return 1;
 }
 
-int kvm_arch_on_sigbus(int code, void *addr)
-{
-    return 1;
-}
-
 /* The #ifdef protections are until 32bit headers are imported and can
  * be removed once both 32 and 64 bit reach feature parity.
  */
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index f49a786..2adf992 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -462,14 +462,13 @@ int kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
     ram_addr_t ram_addr;
     hwaddr paddr;
 
+    /* If we get an action required MCE, it has been injected by KVM
+     * while the VM was running.  An action optional MCE instead should
+     * be coming from the main thread, which qemu_init_sigbus identifies
+     * as the "early kill" thread.
+     */
     assert(code == BUS_MCEERR_AR || code == BUS_MCEERR_AO);
 
-    /* Because the MCE happened while running the VCPU, KVM could have
-     * injected action required MCEs too.  Action optional MCEs should
-     * be delivered to the main thread, which qemu_init_sigbus identifies
-     * as the "early kill" thread, but if we get one for whatever reason
-     * we just handle it just like the main thread would.
-     */
     if ((env->mcg_cap & MCG_SER_P) && addr) {
         ram_addr = qemu_ram_addr_from_host(addr);
         if (ram_addr != RAM_ADDR_INVALID &&
@@ -491,35 +490,6 @@ int kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
     return 0;
 }
 
-int kvm_arch_on_sigbus(int code, void *addr)
-{
-    X86CPU *cpu = X86_CPU(first_cpu);
-
-    assert(code == BUS_MCEERR_AR || code == BUS_MCEERR_AO);
-
-    if (code == BUS_MCEERR_AR) {
-        hardware_memory_error();
-    }
-
-    /* Hope we are lucky for AO MCE */
-    if ((cpu->env.mcg_cap & MCG_SER_P) && addr) {
-        ram_addr_t ram_addr;
-        hwaddr paddr;
-
-        ram_addr = qemu_ram_addr_from_host(addr);
-        if (ram_addr != RAM_ADDR_INVALID &&
-            kvm_physical_memory_addr_from_host(first_cpu->kvm_state,
-                                               addr, &paddr)) {
-            kvm_hwpoison_page_add(ram_addr);
-            kvm_mce_inject(X86_CPU(first_cpu), paddr, code);
-        }
-
-        fprintf(stderr, "Hardware memory error for memory used by "
-                "QEMU itself instead of guest system!: %p\n", addr);
-    }
-    return 0;
-}
-
 static int kvm_inject_mce_oldstyle(X86CPU *cpu)
 {
     CPUX86State *env = &cpu->env;
diff --git a/target/mips/kvm.c b/target/mips/kvm.c
index 998c341..3e686e7 100644
--- a/target/mips/kvm.c
+++ b/target/mips/kvm.c
@@ -186,12 +186,6 @@ int kvm_arch_on_sigbus_vcpu(CPUState *cs, int code, void *addr)
     return 1;
 }
 
-int kvm_arch_on_sigbus(int code, void *addr)
-{
-    DPRINTF("%s\n", __func__);
-    return 1;
-}
-
 void kvm_arch_init_irq_routing(KVMState *s)
 {
 }
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 52bbea5..bc011c6 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2587,11 +2587,6 @@ int kvm_arch_on_sigbus_vcpu(CPUState *cpu, int code, void *addr)
     return 1;
 }
 
-int kvm_arch_on_sigbus(int code, void *addr)
-{
-    return 1;
-}
-
 void kvm_arch_init_irq_routing(KVMState *s)
 {
 }
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 5ec050c..e7eea6d 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -2145,11 +2145,6 @@ int kvm_arch_on_sigbus_vcpu(CPUState *cpu, int code, void *addr)
     return 1;
 }
 
-int kvm_arch_on_sigbus(int code, void *addr)
-{
-    return 1;
-}
-
 void kvm_s390_io_interrupt(uint16_t subchannel_id,
                            uint16_t subchannel_nr, uint32_t io_int_parm,
                            uint32_t io_int_word)
-- 
2.9.3
