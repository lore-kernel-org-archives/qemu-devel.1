Received: from eggs.gnu.org ([209.51.188.92]:40788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goBN3-0002Zq-Sz
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:10:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goBN1-0008Dy-QY
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:10:57 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35825)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1goBN1-0008BL-Jf
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 13:10:55 -0500
Received: by mail-wm1-x341.google.com with SMTP id t200so15071697wmt.0
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 10:10:55 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	b18sm97910681wrw.83.2019.01.28.10.10.52 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 28 Jan 2019 10:10:53 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Jan 2019 18:10:24 +0000
Message-Id: <20190128181047.20781-4-peter.maydell@linaro.org>
In-Reply-To: <20190128181047.20781-1-peter.maydell@linaro.org>
References: <20190128181047.20781-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 03/26] gdbstub: fix gdb_get_cpu(s, pid,
 tid) when pid and/or tid are 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Luc Michel <luc.michel@greensocs.com>

a TID or PID value means "any thread" (resp. "any process"). This commit
fixes the different combinations when at least one value is 0.

When both are 0, the function now returns the first attached CPU,
instead of the CPU with TID 1, which is not necessarily attached or even
existent.

When PID is specified but TID is 0, the function returns the first CPU
in the process, or NULL if the process does not exist or is not
attached.

In other cases, it returns the corresponding CPU, while ignoring the PID
check when PID is 0.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20190119140000.11767-1-luc.michel@greensocs.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 gdbstub.c | 72 +++++++++++++++++++++++++++++++++----------------------
 1 file changed, 43 insertions(+), 29 deletions(-)

diff --git a/gdbstub.c b/gdbstub.c
index bfc7afb5096..d4cc6ecf99b 100644
--- a/gdbstub.c
+++ b/gdbstub.c
@@ -756,35 +756,6 @@ static CPUState *gdb_next_cpu_in_process(const GDBState *s, CPUState *cpu)
     return cpu;
 }
 
-static CPUState *gdb_get_cpu(const GDBState *s, uint32_t pid, uint32_t tid)
-{
-    GDBProcess *process;
-    CPUState *cpu;
-
-    if (!tid) {
-        /* 0 means any thread, we take the first one */
-        tid = 1;
-    }
-
-    cpu = find_cpu(tid);
-
-    if (cpu == NULL) {
-        return NULL;
-    }
-
-    process = gdb_get_cpu_process(s, cpu);
-
-    if (process->pid != pid) {
-        return NULL;
-    }
-
-    if (!process->attached) {
-        return NULL;
-    }
-
-    return cpu;
-}
-
 /* Return the cpu following @cpu, while ignoring unattached processes. */
 static CPUState *gdb_next_attached_cpu(const GDBState *s, CPUState *cpu)
 {
@@ -814,6 +785,49 @@ static CPUState *gdb_first_attached_cpu(const GDBState *s)
     return cpu;
 }
 
+static CPUState *gdb_get_cpu(const GDBState *s, uint32_t pid, uint32_t tid)
+{
+    GDBProcess *process;
+    CPUState *cpu;
+
+    if (!pid && !tid) {
+        /* 0 means any process/thread, we take the first attached one */
+        return gdb_first_attached_cpu(s);
+    } else if (pid && !tid) {
+        /* any thread in a specific process */
+        process = gdb_get_process(s, pid);
+
+        if (process == NULL) {
+            return NULL;
+        }
+
+        if (!process->attached) {
+            return NULL;
+        }
+
+        return get_first_cpu_in_process(s, process);
+    } else {
+        /* a specific thread */
+        cpu = find_cpu(tid);
+
+        if (cpu == NULL) {
+            return NULL;
+        }
+
+        process = gdb_get_cpu_process(s, cpu);
+
+        if (pid && process->pid != pid) {
+            return NULL;
+        }
+
+        if (!process->attached) {
+            return NULL;
+        }
+
+        return cpu;
+    }
+}
+
 static const char *get_feature_xml(const GDBState *s, const char *p,
                                    const char **newp, GDBProcess *process)
 {
-- 
2.20.1
