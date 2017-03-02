Received: from eggs.gnu.org ([2001:4830:134:3::10]:59630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cjWnH-0007xW-7Z
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:53:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cjWnG-0002TI-C0
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:53:43 -0500
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:34511)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cjWnG-0002T6-5f
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 14:53:42 -0500
Received: by mail-wr0-x234.google.com with SMTP id l37so60262185wrc.1
	for <qemu-devel@nongnu.org>; Thu, 02 Mar 2017 11:53:41 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu,  2 Mar 2017 19:53:30 +0000
Message-Id: <20170302195337.31558-5-alex.bennee@linaro.org>
In-Reply-To: <20170302195337.31558-1-alex.bennee@linaro.org>
References: <20170302195337.31558-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 04/11] translate: downgrade IRQ BQL asserts
 to tcg_debug_assert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, rth@twiddle.net, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org, mttcg@listserver.greensocs.com, fred.konrad@greensocs.com, a.rigo@virtualopensystems.com, cota@braap.org, bobby.prani@gmail.com, nikunj@linux.vnet.ibm.com, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

While on MTTCG hosts it is very important that updates to
cpu->interrupt_request are protected by the BQL not all guests have
been converted to the correct locking yet. As a result we are seeing
breaking on non-MTTCG enabled guests in production builds.

The locking in the guests needs to be fixed but while running single
threaded they will continue to work. By moving the asserts to
tcg_debug_asserts() they will still be useful during conversion
work (much like the existing assert_memory_lock/assert_tb_lock
asserts).

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 translate-all.c    | 2 +-
 translate-common.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/translate-all.c b/translate-all.c
index 9bac061c9b..7ee273410d 100644
--- a/translate-all.c
+++ b/translate-all.c
@@ -1928,7 +1928,7 @@ void dump_opcount_info(FILE *f, fprintf_function cpu_fprintf)
 
 void cpu_interrupt(CPUState *cpu, int mask)
 {
-    g_assert(qemu_mutex_iothread_locked());
+    tcg_debug_assert(qemu_mutex_iothread_locked());
     cpu->interrupt_request |= mask;
     cpu->tcg_exit_req = 1;
 }
diff --git a/translate-common.c b/translate-common.c
index d504dd0d33..24e05c077a 100644
--- a/translate-common.c
+++ b/translate-common.c
@@ -22,6 +22,7 @@
 #include "qom/cpu.h"
 #include "sysemu/cpus.h"
 #include "qemu/main-loop.h"
+#include "tcg.h"
 
 uintptr_t qemu_real_host_page_size;
 intptr_t qemu_real_host_page_mask;
@@ -31,7 +32,7 @@ intptr_t qemu_real_host_page_mask;
 static void tcg_handle_interrupt(CPUState *cpu, int mask)
 {
     int old_mask;
-    g_assert(qemu_mutex_iothread_locked());
+    tcg_debug_assert(qemu_mutex_iothread_locked());
 
     old_mask = cpu->interrupt_request;
     cpu->interrupt_request |= mask;
-- 
2.11.0
