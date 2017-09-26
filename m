Received: from eggs.gnu.org ([2001:4830:134:3::10]:59749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnhG-00052b-EZ
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:06:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnhC-0001He-C6
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:06:38 -0400
Received: from mail.ispras.ru ([83.149.199.45]:52136)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnhC-0001HS-08
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:06:34 -0400
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 26 Sep 2017 14:06:31 +0300
Message-ID: <150642399172.3900.299369975046339119.stgit@Misha-PC.lan02.inno>
In-Reply-To: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 26/43] windbg: implemented windbg_read_context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sw@weilnetz.de, lprosek@redhat.com, dovgaluk@ispras.ru, rkagan@virtuozzo.com, pbonzini@redhat.com, den@openvz.org

Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
---
 windbgstub-utils.c |   90 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 89 insertions(+), 1 deletion(-)

diff --git a/windbgstub-utils.c b/windbgstub-utils.c
index c3ae2ddf5b..23bf4be9f0 100755
--- a/windbgstub-utils.c
+++ b/windbgstub-utils.c
@@ -280,7 +280,95 @@ static KDData *kd;
 static int windbg_read_context(CPUState *cpu, uint8_t *buf, int len,
                                int offset)
 {
-    return 0;
+    const bool new_mem = (len != sizeof(CPU_CONTEXT) || offset != 0);
+    CPUArchState *env = cpu->env_ptr;
+    CPU_CONTEXT *cc;
+    int err = 0;
+
+    if (new_mem) {
+        cc = g_new(CPU_CONTEXT, 1);
+    } else {
+        cc = (CPU_CONTEXT *) buf;
+    }
+
+    memset(cc, 0, len);
+
+    cc->ContextFlags = CPU_CONTEXT_ALL;
+
+    if (cc->ContextFlags & CPU_CONTEXT_SEGMENTS) {
+        cc->SegCs = lduw_p(&env->segs[R_CS].selector);
+        cc->SegDs = lduw_p(&env->segs[R_DS].selector);
+        cc->SegEs = lduw_p(&env->segs[R_ES].selector);
+        cc->SegFs = lduw_p(&env->segs[R_FS].selector);
+        cc->SegGs = lduw_p(&env->segs[R_GS].selector);
+        cc->SegSs = lduw_p(&env->segs[R_SS].selector);
+    }
+
+    if (cc->ContextFlags & CPU_CONTEXT_DEBUG_REGISTERS) {
+        cc->Dr0 = ldtul_p(&env->dr[0]);
+        cc->Dr1 = ldtul_p(&env->dr[1]);
+        cc->Dr2 = ldtul_p(&env->dr[2]);
+        cc->Dr3 = ldtul_p(&env->dr[3]);
+        cc->Dr6 = ldtul_p(&env->dr[6]);
+        cc->Dr7 = ldtul_p(&env->dr[7]);
+    }
+
+    if (cc->ContextFlags & CPU_CONTEXT_INTEGER) {
+        cc->Edi    = ldl_p(&env->regs[R_EDI]);
+        cc->Esi    = ldl_p(&env->regs[R_ESI]);
+        cc->Ebx    = ldl_p(&env->regs[R_EBX]);
+        cc->Edx    = ldl_p(&env->regs[R_EDX]);
+        cc->Ecx    = ldl_p(&env->regs[R_ECX]);
+        cc->Eax    = ldl_p(&env->regs[R_EAX]);
+        cc->Ebp    = ldl_p(&env->regs[R_EBP]);
+        cc->Esp    = ldl_p(&env->regs[R_ESP]);
+
+        cc->Eip    = ldl_p(&env->eip);
+        cc->EFlags = ldl_p(&env->eflags);
+    }
+
+    if (cc->ContextFlags & CPU_CONTEXT_FLOATING_POINT) {
+        uint32_t swd = 0, twd = 0;
+        swd = env->fpus & ~(7 << 11);
+        swd |= (env->fpstt & 7) << 11;
+        int i;
+        for (i = 0; i < 8; ++i) {
+            twd |= (!env->fptags[i]) << i;
+        }
+
+        cc->FloatSave.ControlWord    = ldl_p(&env->fpuc);
+        cc->FloatSave.StatusWord     = ldl_p(&swd);
+        cc->FloatSave.TagWord        = ldl_p(&twd);
+        cc->FloatSave.ErrorOffset    = ldl_p(PTR(env->fpip));
+        cc->FloatSave.ErrorSelector  = ldl_p(PTR(env->fpip) + 32);
+        cc->FloatSave.DataOffset     = ldl_p(PTR(env->fpdp));
+        cc->FloatSave.DataSelector   = ldl_p(PTR(env->fpdp) + 32);
+        cc->FloatSave.Cr0NpxState    = ldl_p(&env->xcr0);
+
+        for (i = 0; i < 8; ++i) {
+            memcpy(PTR(cc->FloatSave.RegisterArea[i * 10]),
+                   PTR(env->fpregs[i]), 10);
+        }
+    }
+
+    if (cc->ContextFlags & CPU_CONTEXT_EXTENDED_REGISTERS) {
+        uint8_t *ptr = cc->ExtendedRegisters + 160;
+        int i;
+        for (i = 0; i < 8; ++i, ptr += 16) {
+            stq_p(ptr,     env->xmm_regs[i].ZMM_Q(0));
+            stq_p(ptr + 8, env->xmm_regs[i].ZMM_Q(1));
+        }
+
+        stl_p(cc->ExtendedRegisters + 24, env->mxcsr);
+    }
+
+    cc->ContextFlags = ldl_p(&cc->ContextFlags);
+
+    if (new_mem) {
+        memcpy(buf, (uint8_t *) cc + offset, len);
+        g_free(cc);
+    }
+    return err;
 }
 
 static int windbg_write_context(CPUState *cpu, uint8_t *buf, int len,
