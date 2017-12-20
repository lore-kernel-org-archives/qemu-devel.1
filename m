Received: from eggs.gnu.org ([2001:4830:134:3::10]:47416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRij3-0004L7-Ez
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:04:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eRiiy-0002Qm-CC
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:04:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eRiiy-0002QJ-3m
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 13:04:12 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 20 Dec 2017 19:03:43 +0100
Message-Id: <20171220180358.29316-5-pbonzini@redhat.com>
In-Reply-To: <20171220180358.29316-1-pbonzini@redhat.com>
References: <20171220180358.29316-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 04/19] i386: hvf: use new helper functions for
 put/get xsave
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>, Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>

From: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>

This patch makes use of the helper functions for handling xsave in
xsave_helper.c, which are shared with kvm.

Signed-off-by: Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>
Message-Id: <20170913090522.4022-10-Sergio.G.DelReal@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/hvf-all.c          |  3 +-
 target/i386/hvf-utils/x86.h    |  7 -----
 target/i386/hvf-utils/x86hvf.c | 69 +++++++-----------------------------------
 3 files changed, 12 insertions(+), 67 deletions(-)

diff --git a/target/i386/hvf-all.c b/target/i386/hvf-all.c
index 85e246ff69..cfd7de4f6a 100644
--- a/target/i386/hvf-all.c
+++ b/target/i386/hvf-all.c
@@ -499,8 +499,7 @@ int hvf_init_vcpu(CPUState *cpu)
     hvf_reset_vcpu(cpu);
 
     x86cpu = X86_CPU(cpu);
-    x86cpu->env.kvm_xsave_buf = qemu_memalign(4096,
-                                 sizeof(struct hvf_xsave_buf));
+    x86cpu->env.kvm_xsave_buf = qemu_memalign(4096, 4096);
 
     hv_vcpu_enable_native_msr(cpu->hvf_fd, MSR_STAR, 1);
     hv_vcpu_enable_native_msr(cpu->hvf_fd, MSR_LSTAR, 1);
diff --git a/target/i386/hvf-utils/x86.h b/target/i386/hvf-utils/x86.h
index ca39d829d1..250364b448 100644
--- a/target/i386/hvf-utils/x86.h
+++ b/target/i386/hvf-utils/x86.h
@@ -373,13 +373,6 @@ struct HVFX86EmulatorState {
     uint8_t mmio_buf[4096];
 };
 
-/*
-* hvf xsave area
-*/
-struct hvf_xsave_buf {
-    uint32_t data[1024];
-};
-
 /* useful register access  macros */
 #define RIP(cpu)    (cpu->hvf_emul->rip)
 #define EIP(cpu)    ((uint32_t)cpu->hvf_emul->rip)
diff --git a/target/i386/hvf-utils/x86hvf.c b/target/i386/hvf-utils/x86hvf.c
index 1e687f4f89..15d65b2105 100644
--- a/target/i386/hvf-utils/x86hvf.c
+++ b/target/i386/hvf-utils/x86hvf.c
@@ -76,36 +76,13 @@ void hvf_get_segment(SegmentCache *qseg, struct vmx_segment *vmx_seg)
 void hvf_put_xsave(CPUState *cpu_state)
 {
 
-    int x;
-    struct hvf_xsave_buf *xsave;
-    
+    struct X86XSaveArea *xsave;
+
     xsave = X86_CPU(cpu_state)->env.kvm_xsave_buf;
-    memset(xsave, 0, sizeof(*xsave)); 
-    
-    memcpy(&xsave->data[4], &X86_CPU(cpu_state)->env.fpdp, sizeof(X86_CPU(cpu_state)->env.fpdp));
-    memcpy(&xsave->data[2], &X86_CPU(cpu_state)->env.fpip, sizeof(X86_CPU(cpu_state)->env.fpip));
-    memcpy(&xsave->data[8], &X86_CPU(cpu_state)->env.fpregs, sizeof(X86_CPU(cpu_state)->env.fpregs));
-    memcpy(&xsave->data[144], &X86_CPU(cpu_state)->env.ymmh_regs, sizeof(X86_CPU(cpu_state)->env.ymmh_regs));
-    memcpy(&xsave->data[288], &X86_CPU(cpu_state)->env.zmmh_regs, sizeof(X86_CPU(cpu_state)->env.zmmh_regs));
-    memcpy(&xsave->data[272], &X86_CPU(cpu_state)->env.opmask_regs, sizeof(X86_CPU(cpu_state)->env.opmask_regs));
-    memcpy(&xsave->data[240], &X86_CPU(cpu_state)->env.bnd_regs, sizeof(X86_CPU(cpu_state)->env.bnd_regs));
-    memcpy(&xsave->data[256], &X86_CPU(cpu_state)->env.bndcs_regs, sizeof(X86_CPU(cpu_state)->env.bndcs_regs));
-    memcpy(&xsave->data[416], &X86_CPU(cpu_state)->env.hi16_zmm_regs, sizeof(X86_CPU(cpu_state)->env.hi16_zmm_regs));
-    
-    xsave->data[0] = (uint16_t)X86_CPU(cpu_state)->env.fpuc;
-    xsave->data[0] |= (X86_CPU(cpu_state)->env.fpus << 16);
-    xsave->data[0] |= (X86_CPU(cpu_state)->env.fpstt & 7) << 11;
-    
-    for (x = 0; x < 8; ++x)
-        xsave->data[1] |= ((!X86_CPU(cpu_state)->env.fptags[x]) << x);
-    xsave->data[1] |= (uint32_t)(X86_CPU(cpu_state)->env.fpop << 16);
-    
-    memcpy(&xsave->data[40], &X86_CPU(cpu_state)->env.xmm_regs, sizeof(X86_CPU(cpu_state)->env.xmm_regs));
-    
-    xsave->data[6] = X86_CPU(cpu_state)->env.mxcsr;
-    *(uint64_t *)&xsave->data[128] = X86_CPU(cpu_state)->env.xstate_bv;
-    
-    if (hv_vcpu_write_fpstate(cpu_state->hvf_fd, xsave->data, 4096)){
+
+    x86_cpu_xsave_all_areas(X86_CPU(cpu_state), xsave);
+
+    if (hv_vcpu_write_fpstate(cpu_state->hvf_fd, (void*)xsave, 4096)) {
         abort();
     }
 }
@@ -187,39 +164,15 @@ void hvf_put_msrs(CPUState *cpu_state)
 
 void hvf_get_xsave(CPUState *cpu_state)
 {
-    int x;
-    struct hvf_xsave_buf *xsave;
-    
+    struct X86XSaveArea *xsave;
+
     xsave = X86_CPU(cpu_state)->env.kvm_xsave_buf;
-    
-    if (hv_vcpu_read_fpstate(cpu_state->hvf_fd, xsave->data, 4096)) {
+
+    if (hv_vcpu_read_fpstate(cpu_state->hvf_fd, (void*)xsave, 4096)) {
         abort();
     }
 
-    memcpy(&X86_CPU(cpu_state)->env.fpdp, &xsave->data[4], sizeof(X86_CPU(cpu_state)->env.fpdp));
-    memcpy(&X86_CPU(cpu_state)->env.fpip, &xsave->data[2], sizeof(X86_CPU(cpu_state)->env.fpip));
-    memcpy(&X86_CPU(cpu_state)->env.fpregs, &xsave->data[8], sizeof(X86_CPU(cpu_state)->env.fpregs));
-    memcpy(&X86_CPU(cpu_state)->env.ymmh_regs, &xsave->data[144], sizeof(X86_CPU(cpu_state)->env.ymmh_regs));
-    memcpy(&X86_CPU(cpu_state)->env.zmmh_regs, &xsave->data[288], sizeof(X86_CPU(cpu_state)->env.zmmh_regs));
-    memcpy(&X86_CPU(cpu_state)->env.opmask_regs, &xsave->data[272], sizeof(X86_CPU(cpu_state)->env.opmask_regs));
-    memcpy(&X86_CPU(cpu_state)->env.bnd_regs, &xsave->data[240], sizeof(X86_CPU(cpu_state)->env.bnd_regs));
-    memcpy(&X86_CPU(cpu_state)->env.bndcs_regs, &xsave->data[256], sizeof(X86_CPU(cpu_state)->env.bndcs_regs));
-    memcpy(&X86_CPU(cpu_state)->env.hi16_zmm_regs, &xsave->data[416], sizeof(X86_CPU(cpu_state)->env.hi16_zmm_regs));
-    
-    
-    X86_CPU(cpu_state)->env.fpuc = (uint16_t)xsave->data[0];
-    X86_CPU(cpu_state)->env.fpus = (uint16_t)(xsave->data[0] >> 16);
-    X86_CPU(cpu_state)->env.fpstt = (X86_CPU(cpu_state)->env.fpus >> 11) & 7;
-    X86_CPU(cpu_state)->env.fpop = (uint16_t)(xsave->data[1] >> 16);
-    
-    for (x = 0; x < 8; ++x)
-       X86_CPU(cpu_state)->env.fptags[x] =
-        ((((uint16_t)xsave->data[1] >> x) & 1) == 0);
-    
-    memcpy(&X86_CPU(cpu_state)->env.xmm_regs, &xsave->data[40], sizeof(X86_CPU(cpu_state)->env.xmm_regs));
-
-    X86_CPU(cpu_state)->env.mxcsr = xsave->data[6];
-    X86_CPU(cpu_state)->env.xstate_bv = *(uint64_t *)&xsave->data[128];
+    x86_cpu_xrstor_all_areas(X86_CPU(cpu_state), xsave);
 }
 
 void hvf_get_segments(CPUState *cpu_state)
-- 
2.14.3
