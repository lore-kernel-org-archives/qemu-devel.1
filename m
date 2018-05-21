Received: from eggs.gnu.org ([2001:4830:134:3::10]:50652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1fKjoL-0002Fc-Rm
	for qemu-devel@nongnu.org; Mon, 21 May 2018 08:21:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@walle.cc>) id 1fKjoK-0007lq-Og
	for qemu-devel@nongnu.org; Mon, 21 May 2018 08:21:09 -0400
From: Michael Walle <michael@walle.cc>
Date: Mon, 21 May 2018 14:21:00 +0200
Message-Id: <20180521122100.22602-3-michael@walle.cc>
In-Reply-To: <20180521122100.22602-1-michael@walle.cc>
References: <20180521122100.22602-1-michael@walle.cc>
Subject: [Qemu-devel] [PATCH v2 2/2] target/lm32: hold BQL in gdbstub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Michael Walle <michael@walle.cc>, qemu-stable@nongnu.org

Changing the IP/IM registers may cause interrupts, so hold the BQL.

Cc: qemu-stable@nongnu.org
Signed-off-by: Michael Walle <michael@walle.cc>
---
 target/lm32/gdbstub.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/target/lm32/gdbstub.c b/target/lm32/gdbstub.c
index cf929dd392..dac9418a2b 100644
--- a/target/lm32/gdbstub.c
+++ b/target/lm32/gdbstub.c
@@ -18,6 +18,7 @@
  * License along with this library; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
+#include "qemu/main-loop.h"
 #include "qemu-common.h"
 #include "cpu.h"
 #include "exec/gdbstub.h"
@@ -82,10 +83,14 @@ int lm32_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
             env->ie = tmp;
             break;
         case 37:
+            qemu_mutex_lock_iothread();
             lm32_pic_set_im(env->pic_state, tmp);
+            qemu_mutex_unlock_iothread();
             break;
         case 38:
+            qemu_mutex_lock_iothread();
             lm32_pic_set_ip(env->pic_state, tmp);
+            qemu_mutex_unlock_iothread();
             break;
         }
     }
-- 
2.11.0
