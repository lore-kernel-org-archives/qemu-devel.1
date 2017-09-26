Received: from eggs.gnu.org ([2001:4830:134:3::10]:59862)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnhU-0005ER-Q2
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:06:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnhT-0001Nv-L4
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:06:52 -0400
Received: from mail.ispras.ru ([83.149.199.45]:52214)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnhT-0001Nf-8q
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:06:51 -0400
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 26 Sep 2017 14:06:49 +0300
Message-ID: <150642400909.3900.15038274924629003575.stgit@Misha-PC.lan02.inno>
In-Reply-To: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 29/43] windbg: implemented windbg_write_ks_regs
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
 windbgstub-utils.c |  117 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 117 insertions(+)

diff --git a/windbgstub-utils.c b/windbgstub-utils.c
index 537ba9e2aa..f788df2736 100755
--- a/windbgstub-utils.c
+++ b/windbgstub-utils.c
@@ -631,7 +631,124 @@ static int windbg_read_ks_regs(CPUState *cpu, uint8_t *buf, int len,
 static int windbg_write_ks_regs(CPUState *cpu, uint8_t *buf, int len,
                                 int offset)
 {
+  #ifdef TARGET_X86_64 /* Unimplemented yet */
     return 0;
+  #else
+
+    CPUArchState *env = cpu->env_ptr;
+    int mem_size;
+    uint8_t *mem_ptr = buf;
+    while (len > 0 && offset < sizeof(CPU_KSPECIAL_REGISTERS)) {
+        mem_size = 1;
+        switch (offset) {
+
+        case offsetof(CPU_KSPECIAL_REGISTERS, Cr0):
+            mem_size = sizeof_field(CPU_KSPECIAL_REGISTERS, Cr0);
+            cpu_x86_update_cr0(env, ldtul_p(buf + offset));
+            break;
+
+        case offsetof(CPU_KSPECIAL_REGISTERS, Cr2):
+            mem_size = sizeof_field(CPU_KSPECIAL_REGISTERS, Cr2);
+            env->cr[2] = ldtul_p(buf + offset);
+            break;
+
+        case offsetof(CPU_KSPECIAL_REGISTERS, Cr3):
+            mem_size = sizeof_field(CPU_KSPECIAL_REGISTERS, Cr3);
+            cpu_x86_update_cr3(env, ldtul_p(buf + offset));
+            break;
+
+        case offsetof(CPU_KSPECIAL_REGISTERS, Cr4):
+            mem_size = sizeof_field(CPU_KSPECIAL_REGISTERS, Cr4);
+            cpu_x86_update_cr4(env, ldtul_p(buf + offset));
+            break;
+
+        case offsetof(CPU_KSPECIAL_REGISTERS, KernelDr0):
+            mem_size = sizeof_field(CPU_KSPECIAL_REGISTERS, KernelDr0);
+            windbg_set_dr(cpu, 0, ldtul_p(buf + offset));
+            break;
+
+        case offsetof(CPU_KSPECIAL_REGISTERS, KernelDr1):
+            mem_size = sizeof_field(CPU_KSPECIAL_REGISTERS, KernelDr1);
+            windbg_set_dr(cpu, 1, ldtul_p(buf + offset));
+            break;
+
+        case offsetof(CPU_KSPECIAL_REGISTERS, KernelDr2):
+            mem_size = sizeof_field(CPU_KSPECIAL_REGISTERS, KernelDr2);
+            windbg_set_dr(cpu, 2, ldtul_p(buf + offset));
+            break;
+
+        case offsetof(CPU_KSPECIAL_REGISTERS, KernelDr3):
+            mem_size = sizeof_field(CPU_KSPECIAL_REGISTERS, KernelDr3);
+            windbg_set_dr(cpu, 3, ldtul_p(buf + offset));
+            break;
+
+        case offsetof(CPU_KSPECIAL_REGISTERS, KernelDr6):
+            mem_size = sizeof_field(CPU_KSPECIAL_REGISTERS, KernelDr6);
+            windbg_set_dr(cpu, 6, ldtul_p(buf + offset));
+            break;
+
+        case offsetof(CPU_KSPECIAL_REGISTERS, KernelDr7):
+            mem_size = sizeof_field(CPU_KSPECIAL_REGISTERS, KernelDr7);
+            windbg_set_dr(cpu, 7, ldtul_p(buf + offset));
+            break;
+
+        case offsetof(CPU_KSPECIAL_REGISTERS, Gdtr.Pad):
+            mem_size = sizeof_field(CPU_KSPECIAL_REGISTERS, Gdtr.Pad);
+            env->gdt.selector = lduw_p(buf + offset);
+            break;
+
+        case offsetof(CPU_KSPECIAL_REGISTERS, Gdtr.Limit):
+            mem_size = sizeof_field(CPU_KSPECIAL_REGISTERS, Gdtr.Limit);
+            env->gdt.limit = lduw_p(buf + offset);
+            break;
+
+        case offsetof(CPU_KSPECIAL_REGISTERS, Gdtr.Base):
+            mem_size = sizeof_field(CPU_KSPECIAL_REGISTERS, Gdtr.Base);
+            env->gdt.base = ldtul_p(buf + offset);
+            break;
+
+        case offsetof(CPU_KSPECIAL_REGISTERS, Idtr.Pad):
+            mem_size = sizeof_field(CPU_KSPECIAL_REGISTERS, Idtr.Pad);
+            env->idt.selector = lduw_p(buf + offset);
+            break;
+
+        case offsetof(CPU_KSPECIAL_REGISTERS, Idtr.Limit):
+            mem_size = sizeof_field(CPU_KSPECIAL_REGISTERS, Idtr.Limit);
+            env->idt.limit = lduw_p(buf + offset);
+            break;
+
+        case offsetof(CPU_KSPECIAL_REGISTERS, Idtr.Base):
+            mem_size = sizeof_field(CPU_KSPECIAL_REGISTERS, Idtr.Base);
+            env->idt.base = ldtul_p(buf + offset);
+            break;
+
+        case offsetof(CPU_KSPECIAL_REGISTERS, Tr):
+            mem_size = sizeof_field(CPU_KSPECIAL_REGISTERS, Tr);
+            env->tr.selector = lduw_p(buf + offset);
+            break;
+
+        case offsetof(CPU_KSPECIAL_REGISTERS, Ldtr):
+            mem_size = sizeof_field(CPU_KSPECIAL_REGISTERS, Ldtr);
+            env->ldt.selector = lduw_p(buf + offset);
+            break;
+
+        case offsetof(CPU_KSPECIAL_REGISTERS, Reserved):
+            mem_size = sizeof_field(CPU_KSPECIAL_REGISTERS, Reserved);
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
+    return 0;
+
+  #endif
 }
 
 void kd_api_read_virtual_memory(CPUState *cpu, PacketData *pd)
