Received: from eggs.gnu.org ([2001:4830:134:3::10]:39994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9FM-0001ob-6P
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:10:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9FH-0002xZ-En
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:09:56 -0500
Received: from mail.ispras.ru ([83.149.199.45]:38322)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9FH-0002xM-1v
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:09:51 -0500
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 21 Nov 2017 17:09:48 +0300
Message-ID: <151127338809.6888.8871616354338249287.stgit@Misha-PC.lan02.inno>
In-Reply-To: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
References: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 27/45] windbg: implemented
 windbg_write_context
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
 target/i386/windbgstub.c |  212 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 212 insertions(+)

diff --git a/target/i386/windbgstub.c b/target/i386/windbgstub.c
index 1fccd8eee7..dc2a10f8e6 100755
--- a/target/i386/windbgstub.c
+++ b/target/i386/windbgstub.c
@@ -273,6 +273,12 @@ typedef struct _CPU_KPROCESSOR_STATE {
     CPU_KSPECIAL_REGISTERS SpecialRegisters;
 } CPU_KPROCESSOR_STATE, *PCPU_KPROCESSOR_STATE;
 
+static void windbg_set_dr(CPUState *cpu, int index, target_ulong value)
+{}
+
+static void windbg_set_sr(CPUState *cpu, int sr, uint16_t selector)
+{}
+
 static int windbg_read_context(CPUState *cpu, uint8_t *buf, int buf_size,
                                int offset, int len)
 {
@@ -378,6 +384,212 @@ static int windbg_read_context(CPUState *cpu, uint8_t *buf, int buf_size,
 static int windbg_write_context(CPUState *cpu, uint8_t *buf, int buf_size,
                                 int offset, int len)
 {
+    CPUArchState *env = cpu->env_ptr;
+    int mem_size, i, tmp;
+    uint8_t *mem_ptr = buf;
+
+    if (len < 0 || len > buf_size) {
+        WINDBG_ERROR("windbg_write_context: incorrect length %d", len);
+        return 1;
+    }
+
+    if (offset < 0 || offset + len > sizeof(CPU_CONTEXT)) {
+        WINDBG_ERROR("windbg_write_context: incorrect offset %d", offset);
+        return 2;
+    }
+
+    while (len > 0 && offset < sizeof(CPU_CONTEXT)) {
+        mem_size = 1;
+        switch (offset) {
+
+        case offsetof(CPU_CONTEXT, ContextFlags):
+            mem_size = sizeof_field(CPU_CONTEXT, ContextFlags);
+            break;
+
+        case offsetof(CPU_CONTEXT, Dr0):
+            mem_size = sizeof_field(CPU_CONTEXT, Dr0);
+            windbg_set_dr(cpu, 0, ldtul_p(buf + offset));
+            break;
+
+        case offsetof(CPU_CONTEXT, Dr1):
+            mem_size = sizeof_field(CPU_CONTEXT, Dr1);
+            windbg_set_dr(cpu, 1, ldtul_p(buf + offset));
+            break;
+
+        case offsetof(CPU_CONTEXT, Dr2):
+            mem_size = sizeof_field(CPU_CONTEXT, Dr2);
+            windbg_set_dr(cpu, 2, ldtul_p(buf + offset));
+            break;
+
+        case offsetof(CPU_CONTEXT, Dr3):
+            mem_size = sizeof_field(CPU_CONTEXT, Dr3);
+            windbg_set_dr(cpu, 3, ldtul_p(buf + offset));
+            break;
+
+        case offsetof(CPU_CONTEXT, Dr6):
+            mem_size = sizeof_field(CPU_CONTEXT, Dr6);
+            windbg_set_dr(cpu, 6, ldtul_p(buf + offset));
+            break;
+
+        case offsetof(CPU_CONTEXT, Dr7):
+            mem_size = sizeof_field(CPU_CONTEXT, Dr7);
+            windbg_set_dr(cpu, 7, ldtul_p(buf + offset));
+            break;
+
+        case offsetof(CPU_CONTEXT, FloatSave.ControlWord):
+            mem_size = sizeof_field(CPU_CONTEXT, FloatSave.ControlWord);
+            cpu_set_fpuc(env, ldl_p(buf + offset));
+            break;
+
+        case offsetof(CPU_CONTEXT, FloatSave.StatusWord):
+            mem_size = sizeof_field(CPU_CONTEXT, FloatSave.StatusWord);
+            tmp = ldl_p(buf + offset);
+            env->fpstt = (tmp >> 11) & 7;
+            env->fpus = tmp & ~0x3800;
+            break;
+
+        case offsetof(CPU_CONTEXT, FloatSave.TagWord):
+            mem_size = sizeof_field(CPU_CONTEXT, FloatSave.TagWord);
+            tmp = ldl_p(buf + offset);
+            for (i = 0; i < 8; ++i) {
+                env->fptags[i] = !((tmp >> i) & 1);
+            }
+            break;
+
+        case offsetof(CPU_CONTEXT, FloatSave.ErrorOffset):
+            mem_size = sizeof_field(CPU_CONTEXT, FloatSave.ErrorOffset);
+            UINT32_P(&env->fpip)[0] = ldl_p(buf + offset);
+            break;
+
+        case offsetof(CPU_CONTEXT, FloatSave.ErrorSelector):
+            mem_size = sizeof_field(CPU_CONTEXT, FloatSave.ErrorSelector);
+            UINT32_P(&env->fpip)[1] = ldl_p(buf + offset);
+            break;
+
+        case offsetof(CPU_CONTEXT, FloatSave.DataOffset):
+            mem_size = sizeof_field(CPU_CONTEXT, FloatSave.DataOffset);
+            UINT32_P(&env->fpdp)[0] = ldl_p(buf + offset);
+            break;
+
+        case offsetof(CPU_CONTEXT, FloatSave.DataSelector):
+            mem_size = sizeof_field(CPU_CONTEXT, FloatSave.DataSelector);
+            UINT32_P(&env->fpdp)[1] = ldl_p(buf + offset);
+            break;
+
+        case offsetof(CPU_CONTEXT, FloatSave.RegisterArea):
+            mem_size = sizeof_field(CPU_CONTEXT, FloatSave.RegisterArea);
+            for (i = 0; i < 8; ++i) {
+                memcpy(PTR(env->fpregs[i]), mem_ptr + i * 10, 10);
+            }
+            break;
+
+        case offsetof(CPU_CONTEXT, FloatSave.Cr0NpxState):
+            mem_size = sizeof_field(CPU_CONTEXT, FloatSave.Cr0NpxState);
+            env->xcr0 = ldl_p(buf + offset);
+            break;
+
+        case offsetof(CPU_CONTEXT, SegGs):
+            mem_size = sizeof_field(CPU_CONTEXT, SegGs);
+            windbg_set_sr(cpu, R_GS, lduw_p(buf + offset));
+            break;
+
+        case offsetof(CPU_CONTEXT, SegFs):
+            mem_size = sizeof_field(CPU_CONTEXT, SegFs);
+            windbg_set_sr(cpu, R_FS, lduw_p(buf + offset));
+            break;
+
+        case offsetof(CPU_CONTEXT, SegEs):
+            mem_size = sizeof_field(CPU_CONTEXT, SegEs);
+            windbg_set_sr(cpu, R_ES, lduw_p(buf + offset));
+            break;
+
+        case offsetof(CPU_CONTEXT, SegDs):
+            mem_size = sizeof_field(CPU_CONTEXT, SegDs);
+            windbg_set_sr(cpu, R_DS, lduw_p(buf + offset));
+            break;
+
+        case offsetof(CPU_CONTEXT, Edi):
+            mem_size = sizeof_field(CPU_CONTEXT, Edi);
+            env->regs[R_EDI] = ldl_p(buf + offset);
+            break;
+
+        case offsetof(CPU_CONTEXT, Esi):
+            mem_size = sizeof_field(CPU_CONTEXT, Esi);
+            env->regs[R_ESI] = ldl_p(buf + offset);
+            break;
+
+        case offsetof(CPU_CONTEXT, Ebx):
+            mem_size = sizeof_field(CPU_CONTEXT, Ebx);
+            env->regs[R_EBX] = ldl_p(buf + offset);
+            break;
+
+        case offsetof(CPU_CONTEXT, Edx):
+            mem_size = sizeof_field(CPU_CONTEXT, Edx);
+            env->regs[R_EDX] = ldl_p(buf + offset);
+            break;
+
+        case offsetof(CPU_CONTEXT, Ecx):
+            mem_size = sizeof_field(CPU_CONTEXT, Ecx);
+            env->regs[R_ECX] = ldl_p(buf + offset);
+            break;
+
+        case offsetof(CPU_CONTEXT, Eax):
+            mem_size = sizeof_field(CPU_CONTEXT, Eax);
+            env->regs[R_EAX] = ldl_p(buf + offset);
+            break;
+
+        case offsetof(CPU_CONTEXT, Ebp):
+            mem_size = sizeof_field(CPU_CONTEXT, Ebp);
+            env->regs[R_EBP] = ldl_p(buf + offset);
+            break;
+
+        case offsetof(CPU_CONTEXT, Eip):
+            mem_size = sizeof_field(CPU_CONTEXT, Eip);
+            env->eip = ldl_p(buf + offset);
+            break;
+
+        case offsetof(CPU_CONTEXT, SegCs):
+            mem_size = sizeof_field(CPU_CONTEXT, SegCs);
+            windbg_set_sr(cpu, R_CS, lduw_p(buf + offset));
+            break;
+
+        case offsetof(CPU_CONTEXT, EFlags):
+            mem_size = sizeof_field(CPU_CONTEXT, EFlags);
+            env->eflags = ldl_p(buf + offset);
+            break;
+
+        case offsetof(CPU_CONTEXT, Esp):
+            mem_size = sizeof_field(CPU_CONTEXT, Esp);
+            env->regs[R_ESP] = ldl_p(buf + offset);
+            break;
+
+        case offsetof(CPU_CONTEXT, SegSs):
+            mem_size = sizeof_field(CPU_CONTEXT, SegSs);
+            windbg_set_sr(cpu, R_SS, lduw_p(buf + offset));
+            break;
+
+        case offsetof(CPU_CONTEXT, ExtendedRegisters):
+            mem_size = sizeof_field(CPU_CONTEXT, ExtendedRegisters);
+
+            uint8_t *ptr = mem_ptr + 160;
+            for (i = 0; i < 8; ++i, ptr += 16) {
+                env->xmm_regs[i].ZMM_Q(0) = ldl_p(ptr);
+                env->xmm_regs[i].ZMM_Q(1) = ldl_p(ptr + 8);
+            }
+
+            cpu_set_mxcsr(env, ldl_p(mem_ptr + 24));
+            break;
+
+        default:
+            WINDBG_ERROR("write_context: Unknown offset %d", offset);
+            return -1;
+        }
+
+        mem_ptr += mem_size;
+        offset += mem_size;
+        len -= mem_size;
+    }
+
     return 0;
 }
 
