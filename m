Received: from eggs.gnu.org ([2001:4830:134:3::10]:46409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeWc-0004RH-Mx
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dSeWb-0007Wq-MI
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:02 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35222)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dSeWb-0007WI-Fc
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 03:15:01 -0400
Received: by mail-wm0-x242.google.com with SMTP id u23so30502493wma.2
	for <qemu-devel@nongnu.org>; Wed, 05 Jul 2017 00:15:01 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  5 Jul 2017 09:14:12 +0200
Message-Id: <1499238885-26161-10-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
References: <1499238885-26161-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 09/42] cpu: Introduce a wrapper for tlb_flush()
 that can be used in common code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>

From: Thomas Huth <thuth@redhat.com>

Commit 1f5c00cfdb8114c ("qom/cpu: move tlb_flush to cpu_common_reset")
moved the call to tlb_flush() from the target-specific reset handlers
into the common code qom/cpu.c file, and protected the call with
"#ifdef CONFIG_SOFTMMU" to avoid that it is called for linux-user
only targets. But since qom/cpu.c is common code, CONFIG_SOFTMMU is
*never* defined here, so the tlb_flush() was simply never executed
anymore. Fix it by introducing a wrapper for tlb_flush() in a file
that is re-compiled for each target, i.e. in translate-all.c.

Fixes: 1f5c00cfdb8114c1e3a13426588ceb64f82c9ddb
Reviewed-by: Richard Henderson <rth@twiddle.net>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1498454578-18709-5-git-send-email-thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/tcg/translate-all.c | 8 ++++++++
 include/exec/cpu-common.h | 2 ++
 qom/cpu.c                 | 5 ++---
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 93fb923..dc7e816 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -2223,3 +2223,11 @@ int page_unprotect(target_ulong address, uintptr_t pc)
     return 0;
 }
 #endif /* CONFIG_USER_ONLY */
+
+/* This is a wrapper for common code that can not use CONFIG_SOFTMMU */
+void tcg_flush_softmmu_tlb(CPUState *cs)
+{
+#ifdef CONFIG_SOFTMMU
+    tlb_flush(cs);
+#endif
+}
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 4d45a72..74341b1 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -28,6 +28,8 @@ void qemu_init_cpu_list(void);
 void cpu_list_lock(void);
 void cpu_list_unlock(void);
 
+void tcg_flush_softmmu_tlb(CPUState *cs);
+
 #if !defined(CONFIG_USER_ONLY)
 
 enum device_endian {
diff --git a/qom/cpu.c b/qom/cpu.c
index 585419b..7b20f84 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -26,6 +26,7 @@
 #include "qemu/notify.h"
 #include "qemu/log.h"
 #include "exec/log.h"
+#include "exec/cpu-common.h"
 #include "qemu/error-report.h"
 #include "sysemu/sysemu.h"
 #include "hw/qdev-properties.h"
@@ -293,9 +294,7 @@ static void cpu_common_reset(CPUState *cpu)
     if (tcg_enabled()) {
         cpu_tb_jmp_cache_clear(cpu);
 
-#ifdef CONFIG_SOFTMMU
-        tlb_flush(cpu, 0);
-#endif
+        tcg_flush_softmmu_tlb(cpu);
     }
 }
 
-- 
1.8.3.1
