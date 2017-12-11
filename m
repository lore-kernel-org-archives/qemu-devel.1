Received: from eggs.gnu.org ([2001:4830:134:3::10]:34283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO3s-0002jA-F1
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:24:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO3o-00031X-Aa
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:24:00 -0500
Received: from mail.ispras.ru ([83.149.199.45]:43794)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO3n-000310-TO
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:23:56 -0500
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Mon, 11 Dec 2017 16:23:39 +0300
Message-ID: <151299861930.4808.752139561175998341.stgit@Misha-PC.lan02.inno>
In-Reply-To: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
References: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v4 25/46] windbg: implemented
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
index f72d164bb5..de3ffd78b0 100755
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
+        stl_p(&cc->FloatSave.ErrorOffset, env->fpip & 0xffffffff);
+        stl_p(&cc->FloatSave.ErrorSelector, (env->fpip >> 32) & 0xffffffff);
+        stl_p(&cc->FloatSave.DataOffset, env->fpdp & 0xffffffff);
+        stl_p(&cc->FloatSave.DataSelector, (env->fpdp >> 32) & 0xffffffff);
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
 
