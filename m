Received: from eggs.gnu.org ([209.51.188.92]:48798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWpS-00039U-6n
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hBWpR-0000Ga-7o
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:46 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:39890)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hBWpQ-0000FA-U7
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:44:45 -0400
Received: by mail-pg1-x542.google.com with SMTP id k3so7586312pga.6
	for <qemu-devel@nongnu.org>; Tue, 02 Apr 2019 20:44:44 -0700 (PDT)
Received: from cloudburst.imgcgcw.net ([147.50.13.10])
	by smtp.gmail.com with ESMTPSA id
	z6sm26753214pgo.31.2019.04.02.20.44.41 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 02 Apr 2019 20:44:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  3 Apr 2019 10:43:52 +0700
Message-Id: <20190403034358.21999-21-richard.henderson@linaro.org>
In-Reply-To: <20190403034358.21999-1-richard.henderson@linaro.org>
References: <20190403034358.21999-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 20/26] target/tilegx: Convert to
 CPUClass::tlb_fill
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/tilegx/cpu.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/target/tilegx/cpu.c b/target/tilegx/cpu.c
index bfe9be59b5..be50976c6f 100644
--- a/target/tilegx/cpu.c
+++ b/target/tilegx/cpu.c
@@ -24,6 +24,8 @@
 #include "qemu-common.h"
 #include "hw/qdev-properties.h"
 #include "linux-user/syscall_defs.h"
+#include "exec/exec-all.h"
+
 
 static void tilegx_cpu_dump_state(CPUState *cs, FILE *f,
                                   fprintf_function cpu_fprintf, int flags)
@@ -111,8 +113,9 @@ static void tilegx_cpu_do_interrupt(CPUState *cs)
     cs->exception_index = -1;
 }
 
-static int tilegx_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
-                                       int rw, int mmu_idx)
+static bool tilegx_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
+                                MMUAccessType access_type, int mmu_idx,
+                                bool probe, uintptr_t retaddr)
 {
     TileGXCPU *cpu = TILEGX_CPU(cs);
 
@@ -122,7 +125,7 @@ static int tilegx_cpu_handle_mmu_fault(CPUState *cs, vaddr address, int size,
     cpu->env.signo = TARGET_SIGSEGV;
     cpu->env.sigcode = 0;
 
-    return 1;
+    cpu_loop_exit_restore(cs, retaddr);
 }
 
 static bool tilegx_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
@@ -152,7 +155,7 @@ static void tilegx_cpu_class_init(ObjectClass *oc, void *data)
     cc->cpu_exec_interrupt = tilegx_cpu_exec_interrupt;
     cc->dump_state = tilegx_cpu_dump_state;
     cc->set_pc = tilegx_cpu_set_pc;
-    cc->handle_mmu_fault = tilegx_cpu_handle_mmu_fault;
+    cc->tlb_fill = tilegx_cpu_tlb_fill;
     cc->gdb_num_core_regs = 0;
     cc->tcg_initialize = tilegx_tcg_init;
 }
-- 
2.17.1
