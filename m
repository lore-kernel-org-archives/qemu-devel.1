Received: from eggs.gnu.org ([2001:4830:134:3::10]:56922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8SMA-0006ai-LT
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8SM8-0006Cm-MT
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:34 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:32859)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g8SM8-000655-7V
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:32 -0400
Received: by mail-wr1-x444.google.com with SMTP id e4-v6so14082628wrs.0
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 08:49:22 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  5 Oct 2018 16:48:59 +0100
Message-Id: <20181005154910.3099-11-alex.bennee@linaro.org>
In-Reply-To: <20181005154910.3099-1-alex.bennee@linaro.org>
References: <20181005154910.3099-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 10/21] qom/cpu: add a cpu_exit trace event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel.Dovgaluk@ispras.ru, vilanova@ac.upc.edu, cota@braap.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>

This is useful for tracing cpu_exit events where we signal the CPU to
come back to the main loop.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 qom/cpu.c        | 3 +++
 qom/trace-events | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/qom/cpu.c b/qom/cpu.c
index 92599f3541..5a77ff6acd 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -19,6 +19,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "trace.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "qom/cpu.h"
@@ -111,6 +112,8 @@ void cpu_reset_interrupt(CPUState *cpu, int mask)
 
 void cpu_exit(CPUState *cpu)
 {
+    trace_cpu_exit(cpu, cpu->cpu_index);
+
     atomic_set(&cpu->exit_request, 1);
     /* Ensure cpu_exec will see the exit request after TCG has exited.  */
     smp_wmb();
diff --git a/qom/trace-events b/qom/trace-events
index 5d86fbf019..1162dd86fe 100644
--- a/qom/trace-events
+++ b/qom/trace-events
@@ -1,5 +1,9 @@
 # See docs/devel/tracing.txt for syntax documentation.
 
+# qom/cpu.c
+# cpu_exit events
+cpu_exit(void *cpu, int id) "cpu:%p id:%d"
+
 # qom/object.c
 object_dynamic_cast_assert(const char *type, const char *target, const char *file, int line, const char *func) "%s->%s (%s:%d:%s)"
 object_class_dynamic_cast_assert(const char *type, const char *target, const char *file, int line, const char *func) "%s->%s (%s:%d:%s)"
-- 
2.17.1
