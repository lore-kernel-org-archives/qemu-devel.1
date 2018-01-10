Received: from eggs.gnu.org ([2001:4830:134:3::10]:47686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lepton@google.com>) id 1eZMPM-0003At-Qr
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 14:51:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lepton@google.com>) id 1eZMPL-0001KY-E5
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 14:51:32 -0500
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:34423)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lepton@google.com>) id 1eZMPL-0001Jd-26
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 14:51:31 -0500
Received: by mail-pg0-x244.google.com with SMTP id j4so232408pgp.1
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 11:51:30 -0800 (PST)
From: Tao Wu <lepton@google.com>
Date: Wed, 10 Jan 2018 11:50:54 -0800
Message-Id: <20180110195056.85403-1-lepton@google.com>
In-Reply-To: <20180110064706.49777-1-lepton@google.com>
References: <20180110064706.49777-1-lepton@google.com>
Subject: [Qemu-devel] [PATCH v2 1/3] target/i386: move hflags update code to
 a function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, Tao Wu <lepton@google.com>

We will share the same code for hax/kvm.

Signed-off-by: Tao Wu <lepton@google.com>
---
 target/i386/Makefile.objs |  2 +-
 target/i386/common_i386.c | 50 +++++++++++++++++++++++++++++++++++++++++++++++
 target/i386/common_i386.h | 14 +++++++++++++
 target/i386/kvm.c         | 41 ++------------------------------------
 4 files changed, 67 insertions(+), 40 deletions(-)
 create mode 100644 target/i386/common_i386.c
 create mode 100644 target/i386/common_i386.h

diff --git a/target/i386/Makefile.objs b/target/i386/Makefile.objs
index 44103a693b..072d502954 100644
--- a/target/i386/Makefile.objs
+++ b/target/i386/Makefile.objs
@@ -1,4 +1,4 @@
-obj-y += helper.o cpu.o gdbstub.o xsave_helper.o
+obj-y += helper.o cpu.o gdbstub.o xsave_helper.o common_i386.o
 obj-$(CONFIG_TCG) += translate.o
 obj-$(CONFIG_TCG) += bpt_helper.o cc_helper.o excp_helper.o fpu_helper.o
 obj-$(CONFIG_TCG) += int_helper.o mem_helper.o misc_helper.o mpx_helper.o
diff --git a/target/i386/common_i386.c b/target/i386/common_i386.c
new file mode 100644
index 0000000000..285d8bfa48
--- /dev/null
+++ b/target/i386/common_i386.c
@@ -0,0 +1,50 @@
+/*
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#include "common_i386.h"
+
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
+
+    return;
+}
diff --git a/target/i386/common_i386.h b/target/i386/common_i386.h
new file mode 100644
index 0000000000..ed2471de62
--- /dev/null
+++ b/target/i386/common_i386.h
@@ -0,0 +1,14 @@
+/* 
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef TARGET_I386_COMMON_I386_H
+#define TARGET_I386_COMMON_I386_H
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+
+void x86_update_hflags(CPUX86State* env);
+
+#endif
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index 6f69e2fcfd..f197eaf5c6 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -25,6 +25,7 @@
 #include "sysemu/sysemu.h"
 #include "sysemu/hw_accel.h"
 #include "sysemu/kvm_int.h"
+#include "common_i386.h"
 #include "kvm_i386.h"
 #include "hyperv.h"
 #include "hyperv-proto.h"
@@ -1877,7 +1878,6 @@ static int kvm_get_sregs(X86CPU *cpu)
 {
     CPUX86State *env = &cpu->env;
     struct kvm_sregs sregs;
-    uint32_t hflags;
     int bit, i, ret;
 
     ret = kvm_vcpu_ioctl(CPU(cpu), KVM_GET_SREGS, &sregs);
@@ -1919,44 +1919,7 @@ static int kvm_get_sregs(X86CPU *cpu)
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
2.16.0.rc1.238.g530d649a79-goog
