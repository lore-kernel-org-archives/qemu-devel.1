Received: from eggs.gnu.org ([2001:4830:134:3::10]:48519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVeyr-000522-0E
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:20:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dVeym-00076j-Fy
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:20:36 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:36768)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dVeym-00075m-9L
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 10:20:32 -0400
Received: by mail-wm0-f49.google.com with SMTP id 62so25143198wmw.1
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 07:20:32 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 13 Jul 2017 15:19:23 +0100
Message-Id: <20170713141928.25419-2-alex.bennee@linaro.org>
In-Reply-To: <20170713141928.25419-1-alex.bennee@linaro.org>
References: <20170713141928.25419-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v4 1/6] include/exec/exec-all: document common
 exit conditions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, "Emilio G . Cota" <cota@braap.org>, Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

As a precursor to later patches attempt to come up with a more
concrete wording for what each of the common exit cases would be.

CC: Emilio G. Cota <cota@braap.org>
CC: Richard Henderson <rth@twiddle.net>
CC: Lluís Vilanova <vilanova@ac.upc.edu>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <rth@twiddle.net>
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
