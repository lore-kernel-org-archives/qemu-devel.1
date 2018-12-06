Received: from eggs.gnu.org ([2001:4830:134:3::10]:41382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsJZ-0007ny-QX
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:59:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsJV-0004HB-Mj
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:59:33 -0500
Received: from mail.ispras.ru ([83.149.199.45]:59842)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsJV-0004EE-6p
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:59:29 -0500
From: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Date: Thu, 06 Dec 2018 14:59:23 +0300
Message-ID: <154409756345.5432.7482714936303293010.stgit@Misha-PC.lan02.inno>
In-Reply-To: <154409751316.5432.3325938832238028060.stgit@Misha-PC.lan02.inno>
References: <154409751316.5432.3325938832238028060.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 08/39] windbg: implement windbg_on_load
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

Define addresses that must be found on loading stage.

Signed-off-by: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
---
 target/i386/windbgstub.c |   48 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 47 insertions(+), 1 deletion(-)

diff --git a/target/i386/windbgstub.c b/target/i386/windbgstub.c
index e55054c63d..1c1631d7c1 100644
--- a/target/i386/windbgstub.c
+++ b/target/i386/windbgstub.c
@@ -12,11 +12,57 @@
 #include "qemu/osdep.h"
 #include "exec/windbgstub-utils.h"
 
+static InitedAddr KPCR;
+#ifdef TARGET_X86_64
+static InitedAddr kdDebuggerDataBlock;
+#else  /* TARGET_I386 */
+static InitedAddr kdVersion;
+#endif /* TARGET_I386 */
+
+static bool find_KPCR(CPUState *cs)
+{
+    return KPCR.is_init;
+}
+
+#ifdef TARGET_X86_64
+static bool find_kdDebuggerDataBlock(CPUState *cs)
+{
+    return kdDebuggerDataBlock.is_init;
+}
+#else  /* TARGET_I386 */
+static bool find_kdVersion(CPUState *cs)
+{
+    return kdVersion.is_init;
+}
+#endif /* TARGET_I386 */
+
 bool windbg_on_load(void)
 {
-    return false;
+    CPUState *cs = qemu_get_cpu(0);
+
+    if (!find_KPCR(cs)) {
+        return false;
+    }
+
+#ifdef TARGET_X86_64
+    if (!find_kdDebuggerDataBlock(cs)) {
+        return false;
+    }
+#else
+    if (!find_kdVersion(cs)) {
+        return false;
+    }
+#endif
+
+    return true;
 }
 
 void windbg_on_reset(void)
 {
+    KPCR.is_init = false;
+#ifdef TARGET_X86_64
+    kdDebuggerDataBlock.is_init = false;
+#else
+    kdVersion.is_init = false;
+#endif
 }
