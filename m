Received: from eggs.gnu.org ([2001:4830:134:3::10]:34068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sergio.g.delreal@gmail.com>) id 1ds3cO-0001Wm-ID
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:06:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sergio.g.delreal@gmail.com>) id 1ds3cN-0007Ww-1k
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:06:00 -0400
Received: from mail-vk0-x242.google.com ([2607:f8b0:400c:c05::242]:37926)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sergio.g.delreal@gmail.com>)
	id 1ds3cM-0007WK-SK
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 05:05:58 -0400
Received: by mail-vk0-x242.google.com with SMTP id o22so3314246vke.5
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 02:05:58 -0700 (PDT)
From: Sergio Andres Gomez Del Real <sergio.g.delreal@gmail.com>
Date: Wed, 13 Sep 2017 04:05:17 -0500
Message-Id: <20170913090522.4022-10-Sergio.G.DelReal@gmail.com>
In-Reply-To: <20170913090522.4022-1-Sergio.G.DelReal@gmail.com>
References: <20170913090522.4022-1-Sergio.G.DelReal@gmail.com>
Subject: [Qemu-devel] [PATCH v4 09/14] hvf: use new helper functions for
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
Cc: pbonzini@redhat.com, stefanha@gmail.com, Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>

This patch makes use of the helper functions for handling xsave in
xsave_helper.c, which are shared with kvm.

Signed-off-by: Sergio Andres Gomez Del Real <Sergio.G.DelReal@gmail.com>
---
 target/i386/hvf-utils/x86hvf.c | 63 ++++++------------------------------------
 1 file changed, 8 insertions(+), 55 deletions(-)

diff --git a/target/i386/hvf-utils/x86hvf.c b/target/i386/hvf-utils/x86hvf.c
index 1e687f4f89..dd0710d056 100644
--- a/target/i386/hvf-utils/x86hvf.c
+++ b/target/i386/hvf-utils/x86hvf.c
@@ -76,36 +76,13 @@ void hvf_get_segment(SegmentCache *qseg, struct vmx_segment *vmx_seg)
 void hvf_put_xsave(CPUState *cpu_state)
 {
 
-    int x;
     struct hvf_xsave_buf *xsave;
-    
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
+    if (hv_vcpu_write_fpstate(cpu_state->hvf_fd, xsave->data, 4096)) {
         abort();
     }
 }
@@ -187,39 +164,15 @@ void hvf_put_msrs(CPUState *cpu_state)
 
 void hvf_get_xsave(CPUState *cpu_state)
 {
-    int x;
     struct hvf_xsave_buf *xsave;
-    
+
     xsave = X86_CPU(cpu_state)->env.kvm_xsave_buf;
-    
+
     if (hv_vcpu_read_fpstate(cpu_state->hvf_fd, xsave->data, 4096)) {
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
2.14.1
