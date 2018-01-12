Received: from eggs.gnu.org ([2001:4830:134:3::10]:41857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxZ1-0007gQ-IR
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:32:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1eZxYz-0005gp-26
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:59 -0500
Received: from mail-wr0-x244.google.com ([2a00:1450:400c:c0c::244]:43283)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1eZxYy-0005fL-Ot
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:31:57 -0500
Received: by mail-wr0-x244.google.com with SMTP id s13so5020237wra.10
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:31:56 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Jan 2018 12:30:55 +0100
Message-Id: <1515756676-3860-32-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
References: <1515756676-3860-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 31/52] target/i386: move hflags update code to a
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Tao Wu <lepton@google.com>

From: Tao Wu <lepton@google.com>

We will share the same code for hax/kvm.

Signed-off-by: Tao Wu <lepton@google.com>
Message-Id: <20180110195056.85403-1-lepton@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 target/i386/cpu.h |  2 ++
 target/i386/kvm.c | 40 +---------------------------------------
 3 files changed, 45 insertions(+), 39 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 3818d72..ad8196b 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4147,6 +4147,48 @@ static void x86_disas_set_info(CPUState *cs, disassemble_info *info)
     info->cap_insn_split = 8;
 }
 
+void x86_update_hflags(CPUX86State *env)
+{
+   uint32_t hflags;
+#define HFLAG_COPY_MASK \
+    ~( HF_CPL_MASK | HF_PE_MASK | HF_MP_MASK | HF_EM_MASK | \
+       HF_TS_MASK | HF_TF_MASK | HF_VM_MASK | HF_IOPL_MASK | \
+       HF_OSFXSR_MASK | HF_LMA_MASK | HF_CS32_MASK | \
+       HF_SS32_MASK | HF_CS64_MASK | HF_ADDSEG_MASK)
+
+    hflags = env->hflags & HFLAG_COPY_MASK;
+    hflags |= (env->segs[R_SS].flags >> DESC_DPL_SHIFT) & HF_CPL_MASK;
+    hflags |= (env->cr[0] & CR0_PE_MASK) << (HF_PE_SHIFT - CR0_PE_SHIFT);
+    hflags |= (env->cr[0] << (HF_MP_SHIFT - CR0_MP_SHIFT)) &
+                (HF_MP_MASK | HF_EM_MASK | HF_TS_MASK);
+    hflags |= (env->eflags & (HF_TF_MASK | HF_VM_MASK | HF_IOPL_MASK));
+
+    if (env->cr[4] & CR4_OSFXSR_MASK) {
+        hflags |= HF_OSFXSR_MASK;
+    }
+
+    if (env->efer & MSR_EFER_LMA) {
+        hflags |= HF_LMA_MASK;
+    }
+
+    if ((hflags & HF_LMA_MASK) && (env->segs[R_CS].flags & DESC_L_MASK)) {
+        hflags |= HF_CS32_MASK | HF_SS32_MASK | HF_CS64_MASK;
+    } else {
+        hflags |= (env->segs[R_CS].flags & DESC_B_MASK) >>
+                    (DESC_B_SHIFT - HF_CS32_SHIFT);
+        hflags |= (env->segs[R_SS].flags & DESC_B_MASK) >>
+                    (DESC_B_SHIFT - HF_SS32_SHIFT);
+        if (!(env->cr[0] & CR0_PE_MASK) || (env->eflags & VM_MASK) ||
+            !(hflags & HF_CS32_MASK)) {
+            hflags |= HF_ADDSEG_MASK;
+        } else {
+            hflags |= ((env->segs[R_DS].base | env->segs[R_ES].base |
+                        env->segs[R_SS].base) != 0) << HF_ADDSEG_SHIFT;
+        }
+    }
+    env->hflags = hflags;
+}
+
 static Property x86_cpu_properties[] = {
 #ifdef CONFIG_USER_ONLY
     /* apic_id = 0 by default for *-user, see commit 9886e834 */
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 62c4742..f64e5ed 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1778,4 +1778,6 @@ bool cpu_is_bsp(X86CPU *cpu);
 
 void x86_cpu_xrstor_all_areas(X86CPU *cpu, const X86XSaveArea *buf);
 void x86_cpu_xsave_all_areas(X86CPU *cpu, X86XSaveArea *buf);
+void x86_update_hflags(CPUX86State* env);
+
 #endif /* I386_CPU_H */
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index d23127c..825aea5 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -1891,7 +1891,6 @@ static int kvm_get_sregs(X86CPU *cpu)
 {
     CPUX86State *env = &cpu->env;
     struct kvm_sregs sregs;
-    uint32_t hflags;
     int bit, i, ret;
 
     ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_SREGS, &sregs);
@@ -1933,44 +1932,7 @@ static int kvm_get_sregs(X86CPU *cpu)
     env->efer = sregs.efer;
 
     /* changes to apic base and cr8/tpr are read back via kvm_arch_post_run */
-
-#define HFLAG_COPY_MASK \
-    ~( HF_CPL_MASK | HF_PE_MASK | HF_MP_MASK | HF_EM_MASK | \
-       HF_TS_MASK | HF_TF_MASK | HF_VM_MASK | HF_IOPL_MASK | \
-       HF_OSFXSR_MASK | HF_LMA_MASK | HF_CS32_MASK | \
-       HF_SS32_MASK | HF_CS64_MASK | HF_ADDSEG_MASK)
-
-    hflags = env->hflags & HFLAG_COPY_MASK;
-    hflags |= (env->segs[R_SS].flags >> DESC_DPL_SHIFT) & HF_CPL_MASK;
-    hflags |= (env->cr[0] & CR0_PE_MASK) << (HF_PE_SHIFT - CR0_PE_SHIFT);
-    hflags |= (env->cr[0] << (HF_MP_SHIFT - CR0_MP_SHIFT)) &
-                (HF_MP_MASK | HF_EM_MASK | HF_TS_MASK);
-    hflags |= (env->eflags & (HF_TF_MASK | HF_VM_MASK | HF_IOPL_MASK));
-
-    if (env->cr[4] & CR4_OSFXSR_MASK) {
-        hflags |= HF_OSFXSR_MASK;
-    }
-
-    if (env->efer & MSR_EFER_LMA) {
-        hflags |= HF_LMA_MASK;
-    }
-
-    if ((hflags & HF_LMA_MASK) && (env->segs[R_CS].flags & DESC_L_MASK)) {
-        hflags |= HF_CS32_MASK | HF_SS32_MASK | HF_CS64_MASK;
-    } else {
-        hflags |= (env->segs[R_CS].flags & DESC_B_MASK) >>
-                    (DESC_B_SHIFT - HF_CS32_SHIFT);
-        hflags |= (env->segs[R_SS].flags & DESC_B_MASK) >>
-                    (DESC_B_SHIFT - HF_SS32_SHIFT);
-        if (!(env->cr[0] & CR0_PE_MASK) || (env->eflags & VM_MASK) ||
-            !(hflags & HF_CS32_MASK)) {
-            hflags |= HF_ADDSEG_MASK;
-        } else {
-            hflags |= ((env->segs[R_DS].base | env->segs[R_ES].base |
-                        env->segs[R_SS].base) != 0) << HF_ADDSEG_SHIFT;
-        }
-    }
-    env->hflags = hflags;
+    x86_update_hflags(env);
 
     return 0;
 }
-- 
1.8.3.1
