Received: from eggs.gnu.org ([2001:4830:134:3::10]:56051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1etxed-0000FS-6K
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 10:40:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1etxeX-0004q1-3S
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 10:40:27 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:46972)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1etxeW-0004oO-SC
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 10:40:21 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  8 Mar 2018 15:40:16 +0000
Message-Id: <20180308154016.22228-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] unicore32: Mark as deprecated
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

We intend to remove the unicore32 target code:

 * It has had no changes since 2012 that were not tree-wide
   maintenance/API changes/other global updates
 * We dropped the linux-user unicore32 support in 2016 because of a
   clash between the 'old ABI' that it was implementing and the ABI
   that's actually in the upstream Linux kernel, and there have been
   no moves to get this fixed so we could re-enable it, nor any
   complaints when it went away
 * Linux is now planning to drop unicore support:
   https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1619640.html
 * there is apparently no upstream gcc support for the architecture
 * nobody has ever reported a bug or problem to us about it

This commit patches the unicore32 target to warn on startup that it
is deprecated, and adds a note to our documentation's deprecation
section.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I proposed deprecation of unicore32 on 27th Feb:
https://lists.gnu.org/archive/html/qemu-devel/2018-02/msg06634.html
and got several 'yes'es and no objections. This is the "changing
the codebase" part of that, ready for the 2.12 codefreeze.

We should also note this in the 2.12 Changelog.
---
 target/unicore32/cpu.c | 11 +++++++++++
 qemu-doc.texi          |  5 +++++
 2 files changed, 16 insertions(+)

diff --git a/target/unicore32/cpu.c b/target/unicore32/cpu.c
index 29d160a88d..e95fa55b8e 100644
--- a/target/unicore32/cpu.c
+++ b/target/unicore32/cpu.c
@@ -19,6 +19,8 @@
 #include "migration/vmstate.h"
 #include "exec/exec-all.h"
 #include "fpu/softfloat.h"
+#include "sysemu/qtest.h"
+#include "qemu/error-report.h"
 
 static void uc32_cpu_set_pc(CPUState *cs, vaddr value)
 {
@@ -120,6 +122,15 @@ static void uc32_cpu_initfn(Object *obj)
 #endif
 
     tlb_flush(cs);
+
+    /* We can't do this in class_init because the qtest_enabled
+     * flag hasn't yet been initialized there. Luckily the Unicore32
+     * machines don't support SMP so the message will only appear once.
+     */
+    if (!qtest_enabled()) {
+        warn_report("qemu-system-unicore32 is deprecated "
+                    "and will be removed in a future QEMU release.");
+    }
 }
 
 static const VMStateDescription vmstate_uc32_cpu = {
diff --git a/qemu-doc.texi b/qemu-doc.texi
index 39e38c87ec..0e8609c11c 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2779,6 +2779,11 @@ support page sizes < 4096 any longer.
 The ``xlnx-ep108'' machine has been replaced by the ``xlnx-zcu102'' machine.
 The ``xlnx-zcu102'' machine has the same features and capabilites in QEMU.
 
+@subsection Unicore32 targets (since 2.12.0)
+
+The ``unicore32'' CPU target and ``qemu-system-unicore32'' will be removed,
+since this architecture is unmaintained.
+
 @node License
 @appendix License
 
-- 
2.16.2
