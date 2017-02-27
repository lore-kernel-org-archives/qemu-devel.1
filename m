Received: from eggs.gnu.org ([2001:4830:134:3::10]:35916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ciKgn-0004hV-Av
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:46:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ciKgk-0000Xe-61
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:46:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47150)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ciKgj-0000WE-L1
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 07:46:01 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BC307635E0
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 12:46:01 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-117-118.ams2.redhat.com
	[10.36.117.118])
	by int-mx13.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v1RCjpe2028718
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 07:46:01 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 27 Feb 2017 13:45:41 +0100
Message-Id: <20170227124551.8673-8-pbonzini@redhat.com>
In-Reply-To: <20170227124551.8673-1-pbonzini@redhat.com>
References: <20170227124551.8673-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 07/17] KVM: x86: cleanup SIGBUS handlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This patch should have no semantic change.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm.c | 81 ++++++++++++++++++++++++++++---------------------------
 1 file changed, 42 insertions(+), 39 deletions(-)

diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 27fd050..0c48dfd 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -469,31 +469,34 @@ int kvm_arch_on_sigbus_vcpu(CPUState *c, int code, void *addr)
     ram_addr_t ram_addr;
     hwaddr paddr;
 
-    if ((env->mcg_cap & MCG_SER_P) && addr
-        && (code == BUS_MCEERR_AR || code == BUS_MCEERR_AO)) {
+    if (code != BUS_MCEERR_AR && code != BUS_MCEERR_AO) {
+        return 1;
+    }
+
+    /* Because the MCE happened while running the VCPU, KVM could have
+     * injected action required MCEs too.  Action optional MCEs should
+     * be delivered to the main thread, which qemu_init_sigbus identifies
+     * as the "early kill" thread, but if we get one for whatever reason
+     * we just handle it just like the main thread would.
+     */
+    if ((env->mcg_cap & MCG_SER_P) && addr) {
         ram_addr = qemu_ram_addr_from_host(addr);
-        if (ram_addr == RAM_ADDR_INVALID ||
-            !kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
-            fprintf(stderr, "Hardware memory error for memory used by "
-                    "QEMU itself instead of guest system!\n");
-            /* Hope we are lucky for AO MCE */
-            if (code == BUS_MCEERR_AO) {
-                return 0;
-            } else {
-                hardware_memory_error();
-            }
-        }
-        kvm_hwpoison_page_add(ram_addr);
-        kvm_mce_inject(cpu, paddr, code);
-    } else {
-        if (code == BUS_MCEERR_AO) {
+        if (ram_addr != RAM_ADDR_INVALID &&
+            kvm_physical_memory_addr_from_host(c->kvm_state, addr, &paddr)) {
+            kvm_hwpoison_page_add(ram_addr);
+            kvm_mce_inject(cpu, paddr, code);
             return 0;
-        } else if (code == BUS_MCEERR_AR) {
-            hardware_memory_error();
-        } else {
-            return 1;
         }
+
+        fprintf(stderr, "Hardware memory error for memory used by "
+                "QEMU itself instead of guest system!\n");
+    }
+
+    if (code == BUS_MCEERR_AR) {
+        hardware_memory_error();
     }
+
+    /* Hope we are lucky for AO MCE */
     return 0;
 }
 
@@ -501,29 +504,29 @@ int kvm_arch_on_sigbus(int code, void *addr)
 {
     X86CPU *cpu = X86_CPU(first_cpu);
 
-    if ((cpu->env.mcg_cap & MCG_SER_P) && addr && code == BUS_MCEERR_AO) {
+    if (code != BUS_MCEERR_AR && code != BUS_MCEERR_AO) {
+        return 1;
+    }
+
+    if (code == BUS_MCEERR_AR) {
+        hardware_memory_error();
+    }
+
+    /* Hope we are lucky for AO MCE */
+    if ((cpu->env.mcg_cap & MCG_SER_P) && addr) {
         ram_addr_t ram_addr;
         hwaddr paddr;
 
-        /* Hope we are lucky for AO MCE */
         ram_addr = qemu_ram_addr_from_host(addr);
-        if (ram_addr == RAM_ADDR_INVALID ||
-            !kvm_physical_memory_addr_from_host(first_cpu->kvm_state,
-                                                addr, &paddr)) {
-            fprintf(stderr, "Hardware memory error for memory used by "
-                    "QEMU itself instead of guest system!: %p\n", addr);
-            return 0;
-        }
-        kvm_hwpoison_page_add(ram_addr);
-        kvm_mce_inject(X86_CPU(first_cpu), paddr, code);
-    } else {
-        if (code == BUS_MCEERR_AO) {
-            return 0;
-        } else if (code == BUS_MCEERR_AR) {
-            hardware_memory_error();
-        } else {
-            return 1;
+        if (ram_addr != RAM_ADDR_INVALID &&
+            kvm_physical_memory_addr_from_host(first_cpu->kvm_state,
+                                               addr, &paddr)) {
+            kvm_hwpoison_page_add(ram_addr);
+            kvm_mce_inject(X86_CPU(first_cpu), paddr, code);
         }
+
+        fprintf(stderr, "Hardware memory error for memory used by "
+                "QEMU itself instead of guest system!: %p\n", addr);
     }
     return 0;
 }
-- 
2.9.3
