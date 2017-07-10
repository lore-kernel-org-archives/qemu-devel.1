Received: from eggs.gnu.org ([2001:4830:134:3::10]:60764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dUauj-00061N-0c
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:47:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dUauf-0003WS-RM
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:47:57 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:34150)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dUauf-0003W7-Ie
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:47:53 -0400
Received: by mail-wr0-x236.google.com with SMTP id 77so144029784wrb.1
	for <qemu-devel@nongnu.org>; Mon, 10 Jul 2017 08:47:53 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 10 Jul 2017 16:47:44 +0100
Message-Id: <20170710154749.13624-2-alex.bennee@linaro.org>
In-Reply-To: <20170710154749.13624-1-alex.bennee@linaro.org>
References: <20170710154749.13624-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 1/6] include/exec/exec-all: document common
 exit conditions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, rth@twiddle.net, cota@braap.org
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

As a precursor to later patches attempt to come up with a more
concrete wording for what each of the common exit cases would be.

CC: Emilio G. Cota <cota@braap.org>
CC: Richard Henderson <rth@twiddle.net>
CC: Lluís Vilanova <vilanova@ac.upc.edu>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 include/exec/exec-all.h | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
index 8096d64a1d..a23894f687 100644
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
2.13.0
