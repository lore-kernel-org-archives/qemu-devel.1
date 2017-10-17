Received: from eggs.gnu.org ([2001:4830:134:3::10]:34432)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e4Rew-0004vw-5C
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:11:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e4Rev-0006aL-7K
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:11:50 -0400
Received: from mail.ispras.ru ([83.149.199.45]:57108)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1e4Reu-0006Zo-Vw
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 09:11:49 -0400
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 17 Oct 2017 16:11:40 +0300
Message-ID: <150824590066.6816.17516686057228279307.stgit@Misha-PC.lan02.inno>
In-Reply-To: <150824572545.6816.5099701189660002212.stgit@Misha-PC.lan02.inno>
References: <150824572545.6816.5099701189660002212.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v2 30/43] windbg: implemented windbg_set_sr
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
 target/i386/windbgstub.c |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/target/i386/windbgstub.c b/target/i386/windbgstub.c
index fbb42d05bd..d67ad8cf0c 100755
--- a/target/i386/windbgstub.c
+++ b/target/i386/windbgstub.c
@@ -275,7 +275,22 @@ static void windbg_set_dr(CPUState *cpu, int index, target_ulong value)
 {}
 
 static void windbg_set_sr(CPUState *cpu, int sr, uint16_t selector)
-{}
+{
+    CPUArchState *env = cpu->env_ptr;
+
+    if (selector != env->segs[sr].selector &&
+        (!(env->cr[0] & CR0_PE_MASK) || (env->eflags & VM_MASK))) {
+        unsigned int limit, flags;
+        target_ulong base;
+
+        int dpl = (env->eflags & VM_MASK) ? 3 : 0;
+        base = selector << 4;
+        limit = 0xffff;
+        flags = DESC_P_MASK | DESC_S_MASK | DESC_W_MASK |
+                DESC_A_MASK | (dpl << DESC_DPL_SHIFT);
+        cpu_x86_load_seg_cache(env, sr, selector, base, limit, flags);
+    }
+}
 
 static int windbg_read_context(CPUState *cpu, uint8_t *buf, int buf_size,
                                int offset, int len)
