Received: from eggs.gnu.org ([2001:4830:134:3::10]:59489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1d2qzo-0004JQ-MH
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 23:18:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <programmingkidx@gmail.com>) id 1d2qzk-0003RB-In
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 23:18:32 -0400
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:35330)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <programmingkidx@gmail.com>)
	id 1d2qzk-0003Qz-DQ
	for qemu-devel@nongnu.org; Mon, 24 Apr 2017 23:18:28 -0400
Received: by mail-io0-x242.google.com with SMTP id d203so52470001iof.2
	for <qemu-devel@nongnu.org>; Mon, 24 Apr 2017 20:18:28 -0700 (PDT)
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8366F7D4-6288-406E-8C64-2FE3777FC0C3@gmail.com>
Content-Transfer-Encoding: 7bit
From: G 3 <programmingkidx@gmail.com>
Date: Mon, 24 Apr 2017 23:18:25 -0400
Subject: [Qemu-devel] [PATCH 2/9] Add risu_ppc.c file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-devel@nongnu.org qemu-devel" <qemu-devel@nongnu.org>

Add the risu_ppc.c file. It defines several functions used by risu.

Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
---
  risu_ppc.c | 41 +++++++++++++++++++++++++++++++++++++++++
  1 file changed, 41 insertions(+)
  create mode 100644 risu_ppc.c

diff --git a/risu_ppc.c b/risu_ppc.c
new file mode 100644
index 0000000..70a1cf7
--- /dev/null
+++ b/risu_ppc.c
@@ -0,0 +1,41 @@
+/*****************************************************************
+ * File: risu_ppc.c
+ * Date: 3-27-2017
+ * Description: Implement advance_pc(), set_ucontext_paramreg(),
+ *              get_reginfo_paramreg(), get_risuop()
+ *****************************************************************/
+
+#include "risu.h"
+
+/* Advances the program counter register to the next instruction */
+void advance_pc(void *vuc)
+{
+    ucontext_t *uc = (ucontext_t*)vuc;
+    uc->uc_mcontext->ss.srr0 += 4;
+}
+
+/* Sets register r0 to the address of a memory block. */
+void set_ucontext_paramreg(void *vuc, uint64_t value)
+{
+    ucontext_t *uc = vuc;
+    uc->uc_mcontext->ss.r0 = value;
+}
+
+/*
+ * Returns the register that keeps track of a memory block address.
+ * Used for the load and store to memory instructions like LFD.
+ * Returns general purpose register r0.
+ */
+uint64_t get_reginfo_paramreg(struct reginfo *ri)
+{
+    return ri->gpr[0];
+}
+
+int get_risuop(struct reginfo *ri)
+{
+    uint32_t insn = ri->faulting_insn;
+    uint32_t op = insn & 0xf;
+    uint32_t key = insn & ~0xf;
+    uint32_t risukey = 0x00005af0;
+    return (key != risukey) ? -1 : op;
+}
-- 
2.10.2
