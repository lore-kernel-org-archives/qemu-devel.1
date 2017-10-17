Received: from eggs.gnu.org ([2001:4830:134:3::10]:34261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e4Rej-0004mJ-PR
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:11:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e4Ref-0006MD-12
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:11:37 -0400
Received: from mail.ispras.ru ([83.149.199.45]:57064)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e4Ree-0006Lk-Or
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:11:32 -0400
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 17 Oct 2017 16:11:29 +0300
Message-ID: <150824588939.6816.8686431398510628144.stgit@Misha-PC.lan02.inno>
In-Reply-To: <150824572545.6816.5099701189660002212.stgit@Misha-PC.lan02.inno>
References: <150824572545.6816.5099701189660002212.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 28/43] windbg: implemented
 windbg_read_ks_regs
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
 target/i386/windbgstub.c |   39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/target/i386/windbgstub.c b/target/i386/windbgstub.c
index 490dadbae1..b22584a45a 100755
--- a/target/i386/windbgstub.c
+++ b/target/i386/windbgstub.c
@@ -594,6 +594,45 @@ static int windbg_write_context(CPUState *cpu, uint8_t *buf, int buf_size,
 static int windbg_read_ks_regs(CPUState *cpu, uint8_t *buf, int buf_size,
                                int offset, int len)
 {
+    CPUArchState *env = cpu->env_ptr;
+    CPU_KSPECIAL_REGISTERS *ckr;
+    bool new_mem;
+
+    new_mem = (len != sizeof(CPU_KSPECIAL_REGISTERS) || offset != 0);
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
 
