Received: from eggs.gnu.org ([2001:4830:134:3::10]:40086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9FZ-00020h-0G
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:10:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9FY-00034f-2t
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:10:08 -0500
Received: from mail.ispras.ru ([83.149.199.45]:38400)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eH9FX-00034Z-RQ
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 09:10:08 -0500
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 21 Nov 2017 17:10:05 +0300
Message-ID: <151127340497.6888.15997106699521359739.stgit@Misha-PC.lan02.inno>
In-Reply-To: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
References: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 30/45] windbg: implemented windbg_set_sr
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
index 63962b48dd..c59d1401ad 100755
--- a/target/i386/windbgstub.c
+++ b/target/i386/windbgstub.c
@@ -277,7 +277,22 @@ static void windbg_set_dr(CPUState *cpu, int index, target_ulong value)
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
