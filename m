Received: from eggs.gnu.org ([2001:4830:134:3::10]:46638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVUCz-0007mq-1a
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cVUCx-0004vA-Tu
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:13 -0500
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:35577)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cVUCx-0004uz-Pj
	for qemu-devel@nongnu.org; Sun, 22 Jan 2017 21:18:11 -0500
Received: by mail-qt0-x244.google.com with SMTP id f4so14077382qte.2
	for <qemu-devel@nongnu.org>; Sun, 22 Jan 2017 18:18:11 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Sun, 22 Jan 2017 18:17:36 -0800
Message-Id: <20170123021748.13170-15-rth@twiddle.net>
In-Reply-To: <20170123021748.13170-1-rth@twiddle.net>
References: <20170123021748.13170-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 14/26] linux-user: Add HPPA target_signal.h and
 target_cpu.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

The cpu.h structure that these manipulate hasn't been defined
yet, but we haven't enabled compilation yet either.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 linux-user/hppa/target_cpu.h    | 35 +++++++++++++++++++++++++++++++++++
 linux-user/hppa/target_signal.h | 29 +++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)
 create mode 100644 linux-user/hppa/target_cpu.h
 create mode 100644 linux-user/hppa/target_signal.h

diff --git a/linux-user/hppa/target_cpu.h b/linux-user/hppa/target_cpu.h
new file mode 100644
index 0000000..1a5ceca
--- /dev/null
+++ b/linux-user/hppa/target_cpu.h
@@ -0,0 +1,35 @@
+/*
+ * HPPA specific CPU ABI and functions for linux-user
+ *
+ *  Copyright (c) 2016  Richard Henderson
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+#ifndef ALPHA_TARGET_CPU_H
+#define ALPHA_TARGET_CPU_H
+
+static inline void cpu_clone_regs(CPUHPPAState *env, target_ulong newsp)
+{
+    if (newsp) {
+        env->gr[30] = newsp;
+    }
+    env->gr[28] = 0;
+}
+
+static inline void cpu_set_tls(CPUHPPAState *env, target_ulong newtls)
+{
+    env->cr27 = newtls;
+}
+
+#endif
diff --git a/linux-user/hppa/target_signal.h b/linux-user/hppa/target_signal.h
new file mode 100644
index 0000000..e115890
--- /dev/null
+++ b/linux-user/hppa/target_signal.h
@@ -0,0 +1,29 @@
+#ifndef HPPA_TARGET_SIGNAL_H
+#define HPPA_TARGET_SIGNAL_H
+
+#include "cpu.h"
+
+/* this struct defines a stack used during syscall handling */
+
+typedef struct target_sigaltstack {
+    abi_ulong ss_sp;
+    int32_t ss_flags;
+    abi_ulong ss_size;
+} target_stack_t;
+
+
+/*
+ * sigaltstack controls
+ */
+#define TARGET_SS_ONSTACK	1
+#define TARGET_SS_DISABLE	2
+
+#define TARGET_MINSIGSTKSZ	2048
+#define TARGET_SIGSTKSZ		8192
+
+static inline abi_ulong get_sp_from_cpustate(CPUHPPAState *state)
+{
+    return state->gr[30];
+}
+
+#endif /* HPPA_TARGET_SIGNAL_H */
-- 
2.9.3
