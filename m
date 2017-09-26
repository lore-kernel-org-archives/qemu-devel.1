Received: from eggs.gnu.org ([2001:4830:134:3::10]:59813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnhQ-0005AS-4U
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:06:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnhN-0001LY-TI
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:06:48 -0400
Received: from mail.ispras.ru ([83.149.199.45]:52194)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnhN-0001LJ-Mh
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:06:45 -0400
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 26 Sep 2017 14:06:43 +0300
Message-ID: <150642400352.3900.13935192906711901682.stgit@Misha-PC.lan02.inno>
In-Reply-To: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 28/43] windbg: implemented windbg_read_ks_regs
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
 windbgstub-utils.c |   38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/windbgstub-utils.c b/windbgstub-utils.c
index 73ff98dfbc..537ba9e2aa 100755
--- a/windbgstub-utils.c
+++ b/windbgstub-utils.c
@@ -587,6 +587,44 @@ static int windbg_write_context(CPUState *cpu, uint8_t *buf, int len,
 static int windbg_read_ks_regs(CPUState *cpu, uint8_t *buf, int len,
                                int offset)
 {
+    CPUArchState *env = cpu->env_ptr;
+    const bool new_mem = (len != sizeof(CPU_KSPECIAL_REGISTERS)
+                       || offset != 0);
+    CPU_KSPECIAL_REGISTERS *ckr;
+    if (new_mem) {
+        ckr = g_new(CPU_KSPECIAL_REGISTERS, 1);
+    } else {
+        ckr = (CPU_KSPECIAL_REGISTERS *) buf;
+    }
+
+    memset(ckr, 0, len);
+
+    ckr->Cr0 = ldl_p(&env->cr[0]);
+    ckr->Cr2 = ldl_p(&env->cr[2]);
+    ckr->Cr3 = ldl_p(&env->cr[3]);
+    ckr->Cr4 = ldl_p(&env->cr[4]);
+
+    ckr->KernelDr0 = ldtul_p(&env->dr[0]);
+    ckr->KernelDr1 = ldtul_p(&env->dr[1]);
+    ckr->KernelDr2 = ldtul_p(&env->dr[2]);
+    ckr->KernelDr3 = ldtul_p(&env->dr[3]);
+    ckr->KernelDr6 = ldtul_p(&env->dr[6]);
+    ckr->KernelDr7 = ldtul_p(&env->dr[7]);
+
+    ckr->Gdtr.Pad = lduw_p(&env->gdt.selector);
+    ckr->Idtr.Pad = lduw_p(&env->idt.selector);
+
+    ckr->Gdtr.Limit = lduw_p(&env->gdt.limit);
+    ckr->Gdtr.Base  = ldtul_p(&env->gdt.base);
+    ckr->Idtr.Limit = lduw_p(&env->idt.limit);
+    ckr->Idtr.Base  = ldtul_p(&env->idt.base);
+    ckr->Tr         = lduw_p(&env->tr.selector);
+    ckr->Ldtr       = lduw_p(&env->ldt.selector);
+
+    if (new_mem) {
+        memcpy(buf, (uint8_t *) ckr + offset, len);
+        g_free(ckr);
+    }
     return 0;
 }
 
