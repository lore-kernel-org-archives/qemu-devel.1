Received: from eggs.gnu.org ([2001:4830:134:3::10]:60537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1cEdWL-0006AX-Dn
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 09:48:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1cEdWK-0001LV-Lj
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 09:48:33 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:37309)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Julian_Brown@mentor.com>)
	id 1cEdWK-0001LL-G3
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 09:48:32 -0500
Received: from nat-ies.mentorg.com ([192.94.31.2]
	helo=SVR-IES-MBX-04.mgc.mentorg.com)
	by relay1.mentorg.com with esmtp
	id 1cEdWJ-0002Fi-Do from Julian_Brown@mentor.com
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 06:48:31 -0800
From: Julian Brown <julian@codesourcery.com>
Date: Wed, 7 Dec 2016 06:48:14 -0800
Message-ID: <9b13837a216eb358896a11709e7b4befdd5083db.1481121503.git.julian@codesourcery.com>
In-Reply-To: <cover.1481121503.git.julian@codesourcery.com>
References: <cover.1481121503.git.julian@codesourcery.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v2 2/6] Infer endianness from SCTLR reset value.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This patch uses the reset value of the SCTLR register (e.g. as modified
by the "cfgend" parameter introduced by the previous patch) to set the
endianness used by QEMU when invoked with a null kernel, e.g. from GDB:

  (gdb) target remote | qemu-arm-system [options] -cpu=cortex-a15,cfgend=yes \
          -kernel /dev/null
  (gdb) load
  (gdb) [...]

In this scenario, the usual method of probing the kernel binary for the
correct endianness to use will not work.

Signed-off-by: Julian Brown <julian@codesourcery.com>
---
 hw/arm/boot.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 942416d..68a6574 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -894,7 +894,21 @@ static void arm_load_kernel_notify(Notifier *notifier, void *data)
         entry = info->loader_start + kernel_load_offset;
         kernel_size = load_image_targphys(info->kernel_filename, entry,
                                           info->ram_size - kernel_load_offset);
-        is_linux = 1;
+        if (kernel_size > 0) {
+            is_linux = 1;
+        } else {
+            /* We've been launched with a kernel of /dev/null or similar.
+             * Infer endianness from the reset value of the SCTLR for this
+             * CPU/board.  (This can be altered using the cfgend parameter.)
+             */
+            if (!arm_feature(&cpu->env, ARM_FEATURE_V7) &&
+                (cpu->reset_sctlr & SCTLR_B) != 0)
+                info->endianness = ARM_ENDIANNESS_BE32;
+            else if ((cpu->reset_sctlr & SCTLR_EE) != 0)
+                info->endianness = ARM_ENDIANNESS_BE8;
+            else
+                info->endianness = ARM_ENDIANNESS_LE;
+        }
     }
     if (kernel_size < 0) {
         fprintf(stderr, "qemu: could not load kernel '%s'\n",
-- 
2.8.1
