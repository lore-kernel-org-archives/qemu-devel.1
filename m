Received: from eggs.gnu.org ([2001:4830:134:3::10]:47750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lepton@google.com>) id 1eZMPb-0003I2-Tn
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 14:51:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lepton@google.com>) id 1eZMPa-0001cw-Uw
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 14:51:47 -0500
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:45006)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lepton@google.com>) id 1eZMPa-0001bT-Jq
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 14:51:46 -0500
Received: by mail-pg0-x243.google.com with SMTP id m20so194307pgc.11
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 11:51:46 -0800 (PST)
From: Tao Wu <lepton@google.com>
Date: Wed, 10 Jan 2018 11:50:55 -0800
Message-Id: <20180110195056.85403-2-lepton@google.com>
In-Reply-To: <20180110195056.85403-1-lepton@google.com>
References: <20180110064706.49777-1-lepton@google.com>
	<20180110195056.85403-1-lepton@google.com>
Subject: [Qemu-devel] [PATCH v2 2/3] target/i386: hax: change to use
 x86_update_hflags
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

Change to use x86_update_hflags instead of keeping another copy
at hax side. This also fix bug like HF_CPL_MASK should be SS.DPL,
not CS.DPL.

Signed-off-by: Tao Wu <lepton@google.com>
---
 target/i386/hax-all.c | 53 ++-------------------------------------------------
 1 file changed, 2 insertions(+), 51 deletions(-)

diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
index 3ce6950296..dc379373f7 100644
--- a/target/i386/hax-all.c
+++ b/target/i386/hax-all.c
@@ -31,6 +31,7 @@
 
 #include "qemu-common.h"
 #include "strings.h"
+#include "common_i386.h"
 #include "hax-i386.h"
 #include "sysemu/accel.h"
 #include "sysemu/sysemu.h"
@@ -782,56 +783,6 @@ static int hax_set_segments(CPUArchState *env, struct vcpu_state_t *sregs)
     return 0;
 }
 
-/*
- * After get the state from the kernel module, some
- * qemu emulator state need be updated also
- */
-static int hax_setup_qemu_emulator(CPUArchState *env)
-{
-
-#define HFLAG_COPY_MASK (~( \
-  HF_CPL_MASK | HF_PE_MASK | HF_MP_MASK | HF_EM_MASK | \
-  HF_TS_MASK | HF_TF_MASK | HF_VM_MASK | HF_IOPL_MASK | \
-  HF_OSFXSR_MASK | HF_LMA_MASK | HF_CS32_MASK | \
-  HF_SS32_MASK | HF_CS64_MASK | HF_ADDSEG_MASK))
-
-    uint32_t hflags;
-
-    hflags = (env->segs[R_CS].flags >> DESC_DPL_SHIFT) & HF_CPL_MASK;
-    hflags |= (env->cr[0] & CR0_PE_MASK) << (HF_PE_SHIFT - CR0_PE_SHIFT);
-    hflags |= (env->cr[0] << (HF_MP_SHIFT - CR0_MP_SHIFT)) &
-        (HF_MP_MASK | HF_EM_MASK | HF_TS_MASK);
-    hflags |= (env->eflags & (HF_TF_MASK | HF_VM_MASK | HF_IOPL_MASK));
-    hflags |= (env->cr[4] & CR4_OSFXSR_MASK) <<
-              (HF_OSFXSR_SHIFT - CR4_OSFXSR_SHIFT);
-
-    if (env->efer & MSR_EFER_LMA) {
-        hflags |= HF_LMA_MASK;
-    }
-
-    if ((hflags & HF_LMA_MASK) && (env->segs[R_CS].flags & DESC_L_MASK)) {
-        hflags |= HF_CS32_MASK | HF_SS32_MASK | HF_CS64_MASK;
-    } else {
-        hflags |= (env->segs[R_CS].flags & DESC_B_MASK) >>
-            (DESC_B_SHIFT - HF_CS32_SHIFT);
-        hflags |= (env->segs[R_SS].flags & DESC_B_MASK) >>
-            (DESC_B_SHIFT - HF_SS32_SHIFT);
-        if (!(env->cr[0] & CR0_PE_MASK) ||
-            (env->eflags & VM_MASK) || !(hflags & HF_CS32_MASK)) {
-            hflags |= HF_ADDSEG_MASK;
-        } else {
-            hflags |= ((env->segs[R_DS].base |
-                        env->segs[R_ES].base |
-                        env->segs[R_SS].base) != 0) << HF_ADDSEG_SHIFT;
-        }
-    }
-
-    hflags &= ~HF_SMM_MASK;
-
-    env->hflags = (env->hflags & HFLAG_COPY_MASK) | hflags;
-    return 0;
-}
-
 static int hax_sync_vcpu_register(CPUArchState *env, int set)
 {
     struct vcpu_state_t regs;
@@ -888,7 +839,7 @@ static int hax_sync_vcpu_register(CPUArchState *env, int set)
         }
     }
     if (!set) {
-        hax_setup_qemu_emulator(env);
+        x86_update_hflags(env);
     }
     return 0;
 }
-- 
2.16.0.rc1.238.g530d649a79-goog
