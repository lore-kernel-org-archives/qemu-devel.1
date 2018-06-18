Received: from eggs.gnu.org ([2001:4830:134:3::10]:57355)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fUz5T-0003Te-5q
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:41:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fUz5S-0004lw-2S
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:41:11 -0400
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:38652)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fUz5R-0004lL-S8
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 14:41:09 -0400
Received: by mail-pf0-x243.google.com with SMTP id b74-v6so8603233pfl.5
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 11:41:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Jun 2018 08:40:34 -1000
Message-Id: <20180618184046.6270-11-richard.henderson@linaro.org>
In-Reply-To: <20180618184046.6270-1-richard.henderson@linaro.org>
References: <20180618184046.6270-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 10/22] target/openrisc: Merge mmu_helper.c
 into mmu.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: shorne@gmail.com

With tlb_fill in mmu.c, we can simplify things further.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/mmu.c         | 11 ++++++++++
 target/openrisc/mmu_helper.c  | 40 -----------------------------------
 target/openrisc/Makefile.objs |  2 +-
 3 files changed, 12 insertions(+), 41 deletions(-)
 delete mode 100644 target/openrisc/mmu_helper.c

diff --git a/target/openrisc/mmu.c b/target/openrisc/mmu.c
index b2effaa6d7..9b4b5cf04f 100644
--- a/target/openrisc/mmu.c
+++ b/target/openrisc/mmu.c
@@ -240,4 +240,15 @@ hwaddr openrisc_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
         return phys_addr;
     }
 }
+
+void tlb_fill(CPUState *cs, target_ulong addr, int size,
+              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
+{
+    int ret = openrisc_cpu_handle_mmu_fault(cs, addr, size,
+                                            access_type, mmu_idx);
+    if (ret) {
+        /* Raise Exception.  */
+        cpu_loop_exit_restore(cs, retaddr);
+    }
+}
 #endif
diff --git a/target/openrisc/mmu_helper.c b/target/openrisc/mmu_helper.c
deleted file mode 100644
index 97e1d17b5a..0000000000
--- a/target/openrisc/mmu_helper.c
+++ /dev/null
@@ -1,40 +0,0 @@
-/*
- * OpenRISC MMU helper routines
- *
- * Copyright (c) 2011-2012 Jia Liu <proljc@gmail.com>
- *                         Zhizhou Zhang <etouzh@gmail.com>
- *
- * This library is free software; you can redistribute it and/or
- * modify it under the terms of the GNU Lesser General Public
- * License as published by the Free Software Foundation; either
- * version 2 of the License, or (at your option) any later version.
- *
- * This library is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- * Lesser General Public License for more details.
- *
- * You should have received a copy of the GNU Lesser General Public
- * License along with this library; if not, see <http://www.gnu.org/licenses/>.
- */
-
-#include "qemu/osdep.h"
-#include "cpu.h"
-#include "exec/exec-all.h"
-#include "exec/cpu_ldst.h"
-
-#ifndef CONFIG_USER_ONLY
-
-void tlb_fill(CPUState *cs, target_ulong addr, int size,
-              MMUAccessType access_type, int mmu_idx, uintptr_t retaddr)
-{
-    int ret;
-
-    ret = openrisc_cpu_handle_mmu_fault(cs, addr, size, access_type, mmu_idx);
-
-    if (ret) {
-        /* Raise Exception.  */
-        cpu_loop_exit_restore(cs, retaddr);
-    }
-}
-#endif
diff --git a/target/openrisc/Makefile.objs b/target/openrisc/Makefile.objs
index 1b98a911ea..957ce02199 100644
--- a/target/openrisc/Makefile.objs
+++ b/target/openrisc/Makefile.objs
@@ -1,7 +1,7 @@
 obj-$(CONFIG_SOFTMMU) += machine.o
 obj-y += cpu.o exception.o interrupt.o mmu.o translate.o
 obj-y += exception_helper.o fpu_helper.o \
-         interrupt_helper.o mmu_helper.o sys_helper.o
+         interrupt_helper.o sys_helper.o
 obj-y += gdbstub.o
 
 DECODETREE = $(SRC_PATH)/scripts/decodetree.py
-- 
2.17.1
