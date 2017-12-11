Received: from eggs.gnu.org ([2001:4830:134:3::10]:34351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO46-00034a-AV
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:24:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO45-0003AL-8W
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:24:14 -0500
Received: from mail.ispras.ru ([83.149.199.45]:43858)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eOO44-00039p-Rr
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 08:24:13 -0500
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Mon, 11 Dec 2017 16:23:57 +0300
Message-ID: <151299863740.4808.1182471630198342338.stgit@Misha-PC.lan02.inno>
In-Reply-To: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
References: <151299847127.4808.14646046517426494416.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v4 28/46] windbg: implemented
 windbg_write_ks_regs
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
 target/i386/windbgstub.c |  111 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/target/i386/windbgstub.c b/target/i386/windbgstub.c
index da7d1eae0c..25a0ee8a66 100755
--- a/target/i386/windbgstub.c
+++ b/target/i386/windbgstub.c
@@ -645,6 +645,117 @@ static int windbg_read_ks_regs(CPUState *cpu, uint8_t *buf, int buf_size,
 static int windbg_write_ks_regs(CPUState *cpu, uint8_t *buf, int buf_size,
                                 int offset, int len)
 {
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
     return 0;
 }
 
