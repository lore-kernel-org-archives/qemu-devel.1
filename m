Received: from eggs.gnu.org ([2001:4830:134:3::10]:57899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dRyM4-0000GJ-3J
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 06:13:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dRyM2-0001jB-Sh
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 06:13:20 -0400
Received: from mga01.intel.com ([192.55.52.88]:14583)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1dRyM2-0001cL-JS
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 06:13:18 -0400
From: Yang Zhong <yang.zhong@intel.com>
Date: Mon,  3 Jul 2017 18:12:18 +0800
Message-Id: <1499076743-15477-11-git-send-email-yang.zhong@intel.com>
In-Reply-To: <1499076743-15477-1-git-send-email-yang.zhong@intel.com>
References: <1499076743-15477-1-git-send-email-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH v2 10/15] tcg: move tb related lock functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: pbonzini@redhat.com, rth@twiddle.net, thuth@redhat.com
Cc: qemu-devel@nongnu.org, anthony.xu@intel.com, a.rigo@virtualopensystems.com, yang.zhong@intel.com

Move tb_lock()/tb_unlock()/tb_lock_reset() from tcg.h to
translate-all.h. tb_lock()/tb_unlock() need be impelemnted
in accel/stubs/tcg-stub.c.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 accel/stubs/tcg-stub.c    | 8 ++++++++
 accel/tcg/cpu-exec.c      | 1 +
 accel/tcg/cputlb.c        | 1 +
 accel/tcg/translate-all.h | 3 +++
 tcg/tcg.h                 | 4 ----
 trace/control-target.c    | 1 -
 6 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/accel/stubs/tcg-stub.c b/accel/stubs/tcg-stub.c
index a9fe40a..a84a6e6 100644
--- a/accel/stubs/tcg-stub.c
+++ b/accel/stubs/tcg-stub.c
@@ -20,6 +20,14 @@
 #include "exec/cpu-all.h"
 
 
+void tb_lock(void)
+{
+}
+
+void tb_unlock(void)
+{
+}
+
 void tb_flush(CPUState *cpu)
 {
 }
diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
index 3581618..03b4ea2 100644
--- a/accel/tcg/cpu-exec.c
+++ b/accel/tcg/cpu-exec.c
@@ -21,6 +21,7 @@
 #include "trace.h"
 #include "disas/disas.h"
 #include "exec/exec-all.h"
+#include "translate-all.h"
 #include "tcg.h"
 #include "qemu/atomic.h"
 #include "sysemu/qtest.h"
diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
index 1900936..c0efd74 100644
--- a/accel/tcg/cputlb.c
+++ b/accel/tcg/cputlb.c
@@ -21,6 +21,7 @@
 #include "qemu/main-loop.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
+#include "translate-all.h"
 #include "exec/memory.h"
 #include "exec/address-spaces.h"
 #include "exec/cpu_ldst.h"
diff --git a/accel/tcg/translate-all.h b/accel/tcg/translate-all.h
index ba8e4d6..4774f78 100644
--- a/accel/tcg/translate-all.h
+++ b/accel/tcg/translate-all.h
@@ -23,6 +23,9 @@
 
 
 /* translate-all.c */
+void tb_lock(void);
+void tb_unlock(void);
+void tb_lock_reset(void);
 void tb_invalidate_phys_page_fast(tb_page_addr_t start, int len);
 void tb_invalidate_phys_page_range(tb_page_addr_t start, tb_page_addr_t end,
                                    int is_cpu_write_access);
diff --git a/tcg/tcg.h b/tcg/tcg.h
index 9e37722..da78721 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -757,10 +757,6 @@ void *tcg_malloc_internal(TCGContext *s, int size);
 void tcg_pool_reset(TCGContext *s);
 TranslationBlock *tcg_tb_alloc(TCGContext *s);
 
-void tb_lock(void);
-void tb_unlock(void);
-void tb_lock_reset(void);
-
 /* Called with tb_lock held.  */
 static inline void *tcg_malloc(int size)
 {
diff --git a/trace/control-target.c b/trace/control-target.c
index 6266e63..2a5efc7 100644
--- a/trace/control-target.c
+++ b/trace/control-target.c
@@ -11,7 +11,6 @@
 #include "cpu.h"
 #include "trace-root.h"
 #include "trace/control.h"
-#include "translate-all.h"
 
 
 void trace_event_set_state_dynamic_init(TraceEvent *ev, bool state)
-- 
1.9.1
