Received: from eggs.gnu.org ([2001:4830:134:3::10]:43743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cxtNT-0003YA-D6
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 06:50:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cxtNR-0004SP-JD
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 06:50:27 -0400
Received: from mail-wr0-x233.google.com ([2a00:1450:400c:c0c::233]:36195)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cxtNR-0004SC-DG
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 06:50:25 -0400
Received: by mail-wr0-x233.google.com with SMTP id c55so92540068wrc.3
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 03:50:25 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue, 11 Apr 2017 11:50:30 +0100
Message-Id: <20170411105031.28904-3-alex.bennee@linaro.org>
In-Reply-To: <20170411105031.28904-1-alex.bennee@linaro.org>
References: <20170411105031.28904-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 2/3] cpus: dump TLB flush counts as trace
 event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: bobby.prani@gmail.com, rth@twiddle.net, stefanha@redhat.com
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

This can be pre-processed later from the trace file.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 cpus.c       | 6 ++++++
 trace-events | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/cpus.c b/cpus.c
index 740b8dc3f8..fae7344df5 100644
--- a/cpus.c
+++ b/cpus.c
@@ -50,6 +50,8 @@
 #include "qapi-event.h"
 #include "hw/nmi.h"
 #include "sysemu/replay.h"
+#include "exec/cputlb.h"
+#include "trace-root.h"
 
 #ifdef CONFIG_LINUX
 
@@ -1252,6 +1254,10 @@ static int tcg_cpu_exec(CPUState *cpu)
     int64_t ti;
 #endif
 
+    trace_tlb_flush_stats(tlb_self_flush_count,
+                          tlb_async_flush_count,
+                          tlb_synced_flush_count);
+
 #ifdef CONFIG_PROFILER
     ti = profile_getclock();
 #endif
diff --git a/trace-events b/trace-events
index b07a09ba95..fc23e15d25 100644
--- a/trace-events
+++ b/trace-events
@@ -94,6 +94,9 @@ disable exec_tb(void *tb, uintptr_t pc) "tb:%p pc=0x%"PRIxPTR
 disable exec_tb_nocache(void *tb, uintptr_t pc) "tb:%p pc=0x%"PRIxPTR
 disable exec_tb_exit(void *last_tb, unsigned int flags) "tb:%p flags=%x"
 
+# cpus.c
+tlb_flush_stats(int self, int async, int synced) "self:%d async:%d synced:%d"
+
 # translate-all.c
 translate_block(void *tb, uintptr_t pc, uint8_t *tb_code) "tb:%p, pc:0x%"PRIxPTR", tb_code:%p"
 
-- 
2.11.0
