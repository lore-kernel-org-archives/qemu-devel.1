Received: from eggs.gnu.org ([209.51.188.92]:45649)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gtEW8-0002do-1M
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:33:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gtEW5-0003dk-QV
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:33:11 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:49606 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gtEW1-0002pL-QP
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 11:33:07 -0500
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 11 Feb 2019 17:31:22 +0100
Message-Id: <1549902684-21740-5-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1549902684-21740-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1549902684-21740-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 4/6] target/mips: hold BQL in mips_vpe_wake()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, arikalo@wavecomp.com, alex.bennee@linaro.org, pburton@wavecomp.com, cota@braap.org

From: Goran Ferenc <goran.ferenc@imgtec.com>

Hold BQL whenever mips_vpe_wake() is invoked.

Without this patch, MIPS MT with MTTCG enabled triggers an abort in
tcg_handle_interrupt() due to an unlocked access to cpu_interrupt().
This patch makes sure that the BQL is held in this case.

Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Acked-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
---
 target/mips/op_helper.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 8c53b3b..0f272a5 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -17,6 +17,7 @@
  * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
  */
 #include "qemu/osdep.h"
+#include "qemu/main-loop.h"
 #include "cpu.h"
 #include "internal.h"
 #include "qemu/host-utils.h"
@@ -638,7 +639,9 @@ static inline void mips_vpe_wake(MIPSCPU *c)
     /* Don't set ->halted =3D 0 directly, let it be done via cpu_has_wor=
k
        because there might be other conditions that state that c should
        be sleeping.  */
+    qemu_mutex_lock_iothread();
     cpu_interrupt(CPU(c), CPU_INTERRUPT_WAKE);
+    qemu_mutex_unlock_iothread();
 }
=20
 static inline void mips_vpe_sleep(MIPSCPU *cpu)
--=20
2.7.4
