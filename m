Received: from eggs.gnu.org ([2001:4830:134:3::10]:59182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dX5Oh-0007yH-2Y
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:45:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dX5Og-0002Kc-5D
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:45:11 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37639)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dX5Of-00029H-TL
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:45:10 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dX5OT-0003SV-4q
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 13:44:57 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 17 Jul 2017 13:44:40 +0100
Message-Id: <1500295494-8991-5-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1500295494-8991-1-git-send-email-peter.maydell@linaro.org>
References: <1500295494-8991-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 04/18] include/exec/exec-all: document common
 exit conditions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Alex Bennée <alex.bennee@linaro.org>

As a precursor to later patches attempt to come up with a more
concrete wording for what each of the common exit cases would be.

CC: Emilio G. Cota <cota@braap.org>
CC: Richard Henderson <rth@twiddle.net>
CC: Lluís Vilanova <vilanova@ac.upc.edu>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
Message-id: 20170713141928.25419-2-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/exec/exec-all.h | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index bf8da2a..6b6e287 100644
--- a/include/exec/exec-all.h
+++ b/include/exec/exec-all.h
@@ -35,11 +35,34 @@ typedef abi_ulong tb_page_addr_t;
 typedef ram_addr_t tb_page_addr_t;
 #endif
 
-/* is_jmp field values */
+/* DisasContext is_jmp field values
+ *
+ * is_jmp starts as DISAS_NEXT. The translator will keep processing
+ * instructions until an exit condition is reached. If we reach the
+ * exit condition and is_jmp is still DISAS_NEXT (because of some
+ * other condition) we simply "jump" to the next address.
+ * The remaining exit cases are:
+ *
+ *   DISAS_JUMP    - Only the PC was modified dynamically (e.g computed)
+ *   DISAS_TB_JUMP - Only the PC was modified statically (e.g. branch)
+ *
+ * In these cases as long as the PC is updated we can chain to the
+ * next TB either by exiting the loop or looking up the next TB via
+ * the loookup helper.
+ *
+ *   DISAS_UPDATE  - CPU State was modified dynamically
+ *
+ * This covers any other CPU state which necessities us exiting the
+ * TCG code to the main run-loop. Typically this includes anything
+ * that might change the interrupt state.
+ *
+ * Individual translators may define additional exit cases to deal
+ * with per-target special conditions.
+ */
 #define DISAS_NEXT    0 /* next instruction can be analyzed */
 #define DISAS_JUMP    1 /* only pc was modified dynamically */
-#define DISAS_UPDATE  2 /* cpu state was modified dynamically */
-#define DISAS_TB_JUMP 3 /* only pc was modified statically */
+#define DISAS_TB_JUMP 2 /* only pc was modified statically */
+#define DISAS_UPDATE  3 /* cpu state was modified dynamically */
 
 #include "qemu/log.h"
 
-- 
2.7.4
