Received: from eggs.gnu.org ([2001:4830:134:3::10]:39866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9FD-0001fs-2y
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:09:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9FB-0002vp-Qv
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:09:47 -0500
Received: from mail.ispras.ru ([83.149.199.45]:38284)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9FB-0002vY-Cd
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:09:45 -0500
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 21 Nov 2017 17:09:42 +0300
Message-ID: <151127338245.6888.12222392757436059555.stgit@Misha-PC.lan02.inno>
In-Reply-To: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
References: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 26/45] windbg: implemented
 windbg_read_context
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
 target/i386/windbgstub.c |   96 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/target/i386/windbgstub.c b/target/i386/windbgstub.c
index bf1afab1f8..1fccd8eee7 100755
--- a/target/i386/windbgstub.c
+++ b/target/i386/windbgstub.c
@@ -276,6 +276,102 @@ typedef struct _CPU_KPROCESSOR_STATE {
 static int windbg_read_context(CPUState *cpu, uint8_t *buf, int buf_size,
                                int offset, int len)
 {
+    CPUArchState *env = cpu->env_ptr;
+    CPU_CONTEXT *cc;
+    bool new_mem;
+
+    if (len < 0 || len > buf_size) {
+        WINDBG_ERROR("windbg_read_context: incorrect length %d", len);
+        return 1;
+    }
+
+    if (offset < 0 || offset + len > sizeof(CPU_CONTEXT)) {
+        WINDBG_ERROR("windbg_read_context: incorrect offset %d", offset);
+        return 2;
+    }
+
+    new_mem = len != sizeof(CPU_CONTEXT) || offset != 0;
+    if (new_mem) {
+        cc = g_new0(CPU_CONTEXT, 1);
+    } else {
+        cc = (CPU_CONTEXT *) buf;
+        memset(cc, 0, sizeof(CPU_CONTEXT));
+    }
+
+    cc->ContextFlags = CPU_CONTEXT_ALL;
+
+    if (cc->ContextFlags & CPU_CONTEXT_SEGMENTS) {
+        stw_p(&cc->SegCs, env->segs[R_CS].selector);
+        stw_p(&cc->SegDs, env->segs[R_DS].selector);
+        stw_p(&cc->SegEs, env->segs[R_ES].selector);
+        stw_p(&cc->SegFs, env->segs[R_FS].selector);
+        stw_p(&cc->SegGs, env->segs[R_GS].selector);
+        stw_p(&cc->SegSs, env->segs[R_SS].selector);
+    }
+
+    if (cc->ContextFlags & CPU_CONTEXT_DEBUG_REGISTERS) {
+        sttul_p(&cc->Dr0, env->dr[0]);
+        sttul_p(&cc->Dr1, env->dr[1]);
+        sttul_p(&cc->Dr2, env->dr[2]);
+        sttul_p(&cc->Dr3, env->dr[3]);
+        sttul_p(&cc->Dr6, env->dr[6]);
+        sttul_p(&cc->Dr7, env->dr[7]);
+    }
+
+    if (cc->ContextFlags & CPU_CONTEXT_INTEGER) {
+        stl_p(&cc->Edi, env->regs[R_EDI]);
+        stl_p(&cc->Esi, env->regs[R_ESI]);
+        stl_p(&cc->Ebx, env->regs[R_EBX]);
+        stl_p(&cc->Edx, env->regs[R_EDX]);
+        stl_p(&cc->Ecx, env->regs[R_ECX]);
+        stl_p(&cc->Eax, env->regs[R_EAX]);
+        stl_p(&cc->Ebp, env->regs[R_EBP]);
+        stl_p(&cc->Esp, env->regs[R_ESP]);
+        stl_p(&cc->Eip, env->eip);
+        stl_p(&cc->EFlags, env->eflags);
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
+        stl_p(&cc->FloatSave.ControlWord, env->fpuc);
+        stl_p(&cc->FloatSave.StatusWord, swd);
+        stl_p(&cc->FloatSave.TagWord, twd);
+        stl_p(&cc->FloatSave.ErrorOffset, UINT32_P(&env->fpip)[0]);
+        stl_p(&cc->FloatSave.ErrorSelector, UINT32_P(&env->fpip)[1]);
+        stl_p(&cc->FloatSave.DataOffset, UINT32_P(&env->fpdp)[0]);
+        stl_p(&cc->FloatSave.DataSelector, UINT32_P(&env->fpdp)[1]);
+        stl_p(&cc->FloatSave.Cr0NpxState, env->xcr0);
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
+    stl_p(&cc->ContextFlags, cc->ContextFlags);
+
+    if (new_mem) {
+        memcpy(buf, (uint8_t *) cc + offset, len);
+        g_free(cc);
+    }
     return 0;
 }
 
