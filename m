Received: from eggs.gnu.org ([2001:4830:134:3::10]:50587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ebS4I-0003Gi-Kk
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:18:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ebS4C-0004wl-L1
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:18:26 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:42399)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1ebS4C-0004vN-DV
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:18:20 -0500
Received: by mail-wr0-x241.google.com with SMTP id e41so15000784wre.9
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 06:18:20 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 16 Jan 2018 15:17:12 +0100
Message-Id: <1516112253-14480-31-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1516112253-14480-1-git-send-email-pbonzini@redhat.com>
References: <1516112253-14480-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 30/51] target/i386: hax: change to use
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
Cc: Tao Wu <lepton@google.com>

From: Tao Wu <lepton@google.com>

Change to use x86_update_hflags instead of keeping another copy
at hax side. This also fix bug like HF_CPL_MASK should be SS.DPL,
not CS.DPL.

Signed-off-by: Tao Wu <lepton@google.com>
Message-Id: <20180110195056.85403-2-lepton@google.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hax-all.c | 52 +--------------------------------------------------
 1 file changed, 1 insertion(+), 51 deletions(-)

diff --git a/target/i386/hax-all.c b/target/i386/hax-all.c
index 3ce6950..07df73e 100644
--- a/target/i386/hax-all.c
+++ b/target/i386/hax-all.c
@@ -782,56 +782,6 @@ static int hax_set_segments(CPUArchState *env, struct vcpu_state_t *sregs)
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
@@ -888,7 +838,7 @@ static int hax_sync_vcpu_register(CPUArchState *env, int set)
         }
     }
     if (!set) {
-        hax_setup_qemu_emulator(env);
+        x86_update_hflags(env);
     }
     return 0;
 }
-- 
1.8.3.1
