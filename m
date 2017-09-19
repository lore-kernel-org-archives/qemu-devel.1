Received: from eggs.gnu.org ([2001:4830:134:3::10]:49198)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duK3j-00089i-BQ
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:03:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1duK3i-0003mq-AN
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:03:35 -0400
Received: from mail-io0-x231.google.com ([2607:f8b0:4001:c06::231]:49512)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1duK3i-0003mT-6V
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 11:03:34 -0400
Received: by mail-io0-x231.google.com with SMTP id 21so726216iof.6
	for <qemu-devel@nongnu.org>; Tue, 19 Sep 2017 08:03:34 -0700 (PDT)
Received: from bigtime.twiddle.net (162.189-204-159.bestel.com.mx.
	[189.204.159.162])
	by smtp.gmail.com with ESMTPSA id h63sm360621otb.59.2017.09.19.08.03.31
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 19 Sep 2017 08:03:32 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 19 Sep 2017 10:03:13 -0500
Message-Id: <20170919150313.10833-9-richard.henderson@linaro.org>
In-Reply-To: <20170919150313.10833-1-richard.henderson@linaro.org>
References: <20170919150313.10833-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 8/8] disas: Remove monitor_disas_is_physical
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Even though there is only one monitor, and thus no race on this
global data object, there is also no point in having it.  We can
just as well record the decision in the read_memory_function that
we select.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 disas.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/disas.c b/disas.c
index b4e4fc409e..c3606b3986 100644
--- a/disas.c
+++ b/disas.c
@@ -513,19 +513,11 @@ const char *lookup_symbol(target_ulong orig_addr)
 
 #include "monitor/monitor.h"
 
-static int monitor_disas_is_physical;
-
 static int
-monitor_read_memory (bfd_vma memaddr, bfd_byte *myaddr, int length,
-                     struct disassemble_info *info)
+physical_read_memory (bfd_vma memaddr, bfd_byte *myaddr, int length,
+                      struct disassemble_info *info)
 {
-    CPUDebug *s = container_of(info, CPUDebug, info);
-
-    if (monitor_disas_is_physical) {
-        cpu_physical_memory_read(memaddr, myaddr, length);
-    } else {
-        cpu_memory_rw_debug(s->cpu, memaddr, myaddr, length, 0);
-    }
+    cpu_physical_memory_read(memaddr, myaddr, length);
     return 0;
 }
 
@@ -540,8 +532,8 @@ void monitor_disas(Monitor *mon, CPUState *cpu,
     INIT_DISASSEMBLE_INFO(s.info, (FILE *)mon, monitor_fprintf);
 
     s.cpu = cpu;
-    monitor_disas_is_physical = is_physical;
-    s.info.read_memory_func = monitor_read_memory;
+    s.info.read_memory_func
+        = (is_physical ? physical_read_memory : target_read_memory);
     s.info.print_address_func = generic_print_address;
     s.info.buffer_vma = pc;
     s.info.cap_arch = -1;
-- 
2.13.5
