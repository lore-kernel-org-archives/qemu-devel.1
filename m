Received: from eggs.gnu.org ([2001:4830:134:3::10]:41456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsJk-0007yg-Cy
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:59:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsJg-0004g9-Ep
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:59:44 -0500
Received: from mail.ispras.ru ([83.149.199.45]:59890)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsJg-0004eO-67
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:59:40 -0500
From: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Date: Thu, 06 Dec 2018 14:59:34 +0300
Message-ID: <154409757468.5432.12472108589196536809.stgit@Misha-PC.lan02.inno>
In-Reply-To: <154409751316.5432.3325938832238028060.stgit@Misha-PC.lan02.inno>
References: <154409751316.5432.3325938832238028060.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 10/39] windbg: implement find_kdVersion
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
 target/i386/windbgstub.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/target/i386/windbgstub.c b/target/i386/windbgstub.c
index 15a90e521c..dc58f5a8cc 100644
--- a/target/i386/windbgstub.c
+++ b/target/i386/windbgstub.c
@@ -16,6 +16,7 @@
 #define OFFSET_KPCR_SELF 0x18
 #else  /* TARGET_I386 */
 #define OFFSET_KPCR_SELF 0x1C
+#define OFFSET_KPCR_VERSION 0x34
 #endif /* TARGET_I386 */
 
 #ifdef TARGET_X86_64
@@ -64,6 +65,16 @@ static bool find_kdDebuggerDataBlock(CPUState *cs)
 #else  /* TARGET_I386 */
 static bool find_kdVersion(CPUState *cs)
 {
+    if (!kdVersion.is_init && KPCR.is_init) {
+        kdVersion.addr = VMEM_ADDR(cs, KPCR.addr + OFFSET_KPCR_VERSION);
+        if (!kdVersion.addr) {
+            return false;
+        }
+        kdVersion.is_init = true;
+
+        DPRINTF("find kdVersion " FMT_ADDR, kdVersion.addr);
+    }
+
     return kdVersion.is_init;
 }
 #endif /* TARGET_I386 */
