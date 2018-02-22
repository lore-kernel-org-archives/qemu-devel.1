Received: from eggs.gnu.org ([2001:4830:134:3::10]:49300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1eovfW-0004eP-RG
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 13:32:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1eovfT-0005sR-Ay
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 13:32:34 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:35107 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1eovfT-0005Qb-2I
	for qemu-devel@nongnu.org; Thu, 22 Feb 2018 13:32:31 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 22 Feb 2018 19:31:41 +0100
Message-Id: <1519324303-5674-5-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1519324303-5674-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1519324303-5674-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v2 4/6] target/mips: hold BQL in mips_vpe_wake()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>, Fam Zheng <famz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>, Riku Voipio <riku.voipio@iki.fi>, Yongbok Kim <yongbok.kim@mips.com>, Aleksandar Markovic <aleksandar.markovic@mips.com>, Goran Ferenc <goran.ferenc@mips.com>, Miodrag Dinic <miodrag.dinic@mips.com>, Petar Jovanovic <petar.jovanovic@mips.com>, Raghu Gandham <raghu.gandham@mips.com>

From: Goran Ferenc <goran.ferenc@mips.com>

Hold BQL whenever mips_vpe_wake() is invoked.

Without this patch, MIPS MT with MTTCG enabled triggers an abort in
tcg_handle_interrupt() due to an unlocked access to cpu_interrupt().
This patch makes sure that the BQL is held in this case.

Signed-off-by: Goran Ferenc <goran.ferenc@mips.com>
Signed-off-by: Miodrag Dinic <miodrag.dinic@mips.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@mips.com>
---
 target/mips/op_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 6bd8e59..d71d916 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -17,6 +17,7 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
+#include "qemu/main-loop.h"
 #include "cpu.h"
 #include "internal.h"
 #include "qemu/host-utils.h"
@@ -542,7 +543,9 @@ static inline void mips_vpe_wake(MIPSCPU *c)
     /* Don't set ->halted = 0 directly, let it be done via cpu_has_work
        because there might be other conditions that state that c should
        be sleeping.  */
+    qemu_mutex_lock_iothread();
     cpu_interrupt(CPU(c), CPU_INTERRUPT_WAKE);
+    qemu_mutex_unlock_iothread();
 }
 
 static inline void mips_vpe_sleep(MIPSCPU *cpu)
-- 
2.7.4
