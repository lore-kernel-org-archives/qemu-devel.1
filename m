Received: from eggs.gnu.org ([2001:4830:134:3::10]:33538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUWff-000141-LL
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:52:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUWfc-0005Xk-HY
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:52:55 -0500
Received: from mail.ispras.ru ([83.149.199.45]:50110)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUWfb-0005VD-I9
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 07:52:52 -0500
From: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Date: Wed, 05 Dec 2018 15:52:48 +0300
Message-ID: <154401436826.8440.2782192448042850447.stgit@Misha-PC.lan02.inno>
In-Reply-To: <154401431697.8440.845616703562380651.stgit@Misha-PC.lan02.inno>
References: <154401431697.8440.845616703562380651.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 2 08/39] windbg: implement windbg_on_load
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
