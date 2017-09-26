Received: from eggs.gnu.org ([2001:4830:134:3::10]:59923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnhe-0005LJ-Lu
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:07:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnhZ-0001R8-4X
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:07:02 -0400
Received: from mail.ispras.ru ([83.149.199.45]:52232)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnhY-0001Qt-T2
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:06:57 -0400
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 26 Sep 2017 14:06:54 +0300
Message-ID: <150642401464.3900.4498315263812458770.stgit@Misha-PC.lan02.inno>
In-Reply-To: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 30/43] windbg: implemented windbg_set_sr
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
 windbgstub-utils.c |   17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/windbgstub-utils.c b/windbgstub-utils.c
index f788df2736..238db03714 100755
--- a/windbgstub-utils.c
+++ b/windbgstub-utils.c
@@ -281,7 +281,22 @@ static void windbg_set_dr(CPUState *cpu, int index, target_ulong value)
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
 
 static int windbg_read_context(CPUState *cpu, uint8_t *buf, int len,
                                int offset)
