Received: from eggs.gnu.org ([2001:4830:134:3::10]:53079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fqMMT-0007kM-32
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:47:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1fqMMS-000678-FG
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 13:47:05 -0400
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 16 Aug 2018 10:46:44 -0700
Message-Id: <20180816174645.30364-2-jcmvbkbc@gmail.com>
In-Reply-To: <20180816174645.30364-1-jcmvbkbc@gmail.com>
References: <20180816174645.30364-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 1/2] target/xtensa: fix gdbstub register counts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>, qemu-stable@nongnu.org

This fixes communication with gdb in the presence of type-5 (TIE state
mapped on user registers) and type-7 (special case of masked registers)
registers in the xtensa core config.

Cc: qemu-stable@nongnu.org
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/xtensa/helper.c b/target/xtensa/helper.c
index c9a613270036..efb3cef12813 100644
--- a/target/xtensa/helper.c
+++ b/target/xtensa/helper.c
@@ -100,7 +100,9 @@ void xtensa_finalize_config(XtensaConfig *config)
         unsigned n_core_regs = 0;
 
         for (i = 0; config->gdb_regmap.reg[i].targno >= 0; ++i) {
-            if (config->gdb_regmap.reg[i].type != 6) {
+            if (config->gdb_regmap.reg[i].type != 5 &&
+                config->gdb_regmap.reg[i].type != 6 &&
+                config->gdb_regmap.reg[i].type != 7) {
                 ++n_regs;
                 if ((config->gdb_regmap.reg[i].flags & 0x1) == 0) {
                     ++n_core_regs;
-- 
2.11.0
