Received: from eggs.gnu.org ([2001:4830:134:3::10]:41999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1cUc5c-0000ye-42
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:31:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Julian_Brown@mentor.com>) id 1cUc5a-0003iC-Cp
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:31:00 -0500
Received: from relay1.mentorg.com ([192.94.38.131]:41447)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Julian_Brown@mentor.com>)
	id 1cUc5a-0003hj-6E
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 11:30:58 -0500
Received: from nat-ies.mentorg.com ([192.94.31.2]
	helo=SVR-IES-MBX-04.mgc.mentorg.com)
	by relay1.mentorg.com with esmtp
	id 1cUc5Z-000538-3H from Julian_Brown@mentor.com
	for qemu-devel@nongnu.org; Fri, 20 Jan 2017 08:30:57 -0800
From: Julian Brown <julian@codesourcery.com>
Date: Fri, 20 Jan 2017 08:30:27 -0800
Message-ID: <129304e20fcdc1ca7b9022c7c2c73fd9a7d5cb4a.1484929304.git.julian@codesourcery.com>
In-Reply-To: <cover.1484929304.git.julian@codesourcery.com>
References: <cover.1484929304.git.julian@codesourcery.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 2/7] Honour reset_sctlr EE/B bits during
 reset.
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
endianness used by QEMU when it is invoked without a kernel or firmware
image. The intended use case is loading code via GDB as follows:

  (gdb) target remote | qemu-arm-system [options] -cpu=cortex-a15,cfgend=yes
  (gdb) load
  (gdb) [...]

The idea being to start a board in a "reset" state in the selected
endianness so that communication with GDB works properly. (The previous
version of the patch used "-kernel /dev/null" for the same purpose:
this version avoids that, and also avoids fiddling with info->endianness
setting.)

Signed-off-by: Julian Brown <julian@codesourcery.com>
---
 hw/arm/boot.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index ff621e4..c059bd2 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -646,6 +646,33 @@ static void do_cpu_reset(void *opaque)
                 info->secondary_cpu_reset_hook(cpu, info);
             }
         }
+    } else {
+	/* No kernel image or firmware has been supplied.  Reset to the
+	 * default endianness for the current board (e.g. so that code loaded
+	 * via the gdb stub interface does the right thing).
+	 */
+	if (arm_feature(env, ARM_FEATURE_V7)) {
+	    int i;
+	    if (cpu->reset_sctlr & SCTLR_EE) {
+		env->cp15.sctlr_el[1] |= SCTLR_E0E;
+		for (i = 1; i < 4; ++i) {
+		    env->cp15.sctlr_el[i] |= SCTLR_EE;
+		}
+		env->uncached_cpsr |= CPSR_E;
+	    } else {
+                env->cp15.sctlr_el[1] &= ~SCTLR_E0E;
+                for (i = 1; i < 4; ++i) {
+                    env->cp15.sctlr_el[i] &= ~SCTLR_EE;
+                }
+                env->uncached_cpsr &= ~CPSR_E;
+	    }
+	} else {
+	    if (cpu->reset_sctlr & SCTLR_B) {
+		env->cp15.sctlr_el[1] |= SCTLR_B;
+	    } else {
+		env->cp15.sctlr_el[1] &= ~SCTLR_B;
+	    }
+	}
     }
 }
 
-- 
2.8.1
