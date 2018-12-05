Received: from eggs.gnu.org ([2001:4830:134:3::10]:33583)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUWfj-00019T-Od
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:53:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUWfh-0005Zv-D1
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:52:59 -0500
Received: from mail.ispras.ru ([83.149.199.45]:50138)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUWfg-0005Za-GV
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:52:57 -0500
From: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Date: Wed, 05 Dec 2018 15:52:54 +0300
Message-ID: <154401437387.8440.5255137362760850609.stgit@Misha-PC.lan02.inno>
In-Reply-To: <154401431697.8440.845616703562380651.stgit@Misha-PC.lan02.inno>
References: <154401431697.8440.845616703562380651.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 2 09/39] windbg: implement find_KPCR
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

Signed-off-by: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
---
 target/i386/windbgstub.c |   32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/target/i386/windbgstub.c b/target/i386/windbgstub.c
index 1c1631d7c1..15a90e521c 100644
--- a/target/i386/windbgstub.c
+++ b/target/i386/windbgstub.c
@@ -12,6 +12,18 @@
 #include "qemu/osdep.h"
 #include "exec/windbgstub-utils.h"
 
+#ifdef TARGET_X86_64
+#define OFFSET_KPCR_SELF 0x18
+#else  /* TARGET_I386 */
+#define OFFSET_KPCR_SELF 0x1C
+#endif /* TARGET_I386 */
+
+#ifdef TARGET_X86_64
+#define TARGET_SAFE(i386_obj, x86_64_obj) x86_64_obj
+#else  /* TARGET_I386 */
+#define TARGET_SAFE(i386_obj, x86_64_obj) i386_obj
+#endif /* TARGET_I386 */
+
 static InitedAddr KPCR;
 #ifdef TARGET_X86_64
 static InitedAddr kdDebuggerDataBlock;
@@ -21,6 +33,26 @@ static InitedAddr kdVersion;
 
 static bool find_KPCR(CPUState *cs)
 {
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
+
+    if (!KPCR.is_init) {
+        KPCR.addr = env->segs[TARGET_SAFE(R_FS, R_GS)].base;
+
+        static target_ulong prev_KPCR;
+        if (!KPCR.addr || prev_KPCR == KPCR.addr) {
+            return false;
+        }
+        prev_KPCR = KPCR.addr;
+
+        if (KPCR.addr != VMEM_ADDR(cs, KPCR.addr + OFFSET_KPCR_SELF)) {
+            return false;
+        }
+        KPCR.is_init = true;
+
+        DPRINTF("find KPCR " FMT_ADDR "\n", KPCR.addr);
+    }
+
     return KPCR.is_init;
 }
 
