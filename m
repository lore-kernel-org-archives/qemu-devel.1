Received: from eggs.gnu.org ([2001:4830:134:3::10]:36749)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cnp9j-0003YQ-No
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cnp9i-0006gS-Fp
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:39 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33434)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cnp9i-0006fw-73
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 12:18:38 -0400
Received: by mail-wm0-x242.google.com with SMTP id n11so610229wma.0
	for <qemu-devel@nongnu.org>; Tue, 14 Mar 2017 09:18:38 -0700 (PDT)
Received: from 640k.lan (94-39-132-181.adsl-ull.clienti.tiscali.it.
	[94.39.132.181])
	by smtp.gmail.com with ESMTPSA id k195sm408197wmd.7.2017.03.14.09.18.36
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 14 Mar 2017 09:18:36 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 14 Mar 2017 17:18:15 +0100
Message-Id: <1489508300-48184-14-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1489508300-48184-1-git-send-email-pbonzini@redhat.com>
References: <1489508300-48184-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 13/18] qemu-timer: do not include sysemu/cpus.h
 from util/qemu-timer.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This dependency is the wrong way, and we will need util/qemu-timer.h from
sysemu/cpus.h in the next patch.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpu-exec.c               | 1 +
 hw/core/ptimer.c         | 1 +
 hw/ppc/pnv.c             | 1 +
 include/qemu/timer.h     | 1 -
 include/sysemu/cpus.h    | 2 ++
 kvm-all.c                | 1 +
 monitor.c                | 1 +
 replay/replay.c          | 1 +
 target/alpha/translate.c | 1 +
 translate-all.c          | 1 +
 util/main-loop.c         | 1 +
 util/qemu-timer.c        | 1 +
 12 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/cpu-exec.c b/cpu-exec.c
index d04dd91..748cb66 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -33,6 +33,7 @@
 #if defined(TARGET_I386) && !defined(CONFIG_USER_ONLY)
 #include "hw/i386/apic.h"
 #endif
+#include "sysemu/cpus.h"
 #include "sysemu/replay.h"
 
 /* -icount align implementation. */
diff --git a/hw/core/ptimer.c b/hw/core/ptimer.c
index 59ccb00..7221c68 100644
--- a/hw/core/ptimer.c
+++ b/hw/core/ptimer.c
@@ -13,6 +13,7 @@
 #include "sysemu/replay.h"
 #include "sysemu/qtest.h"
 #include "block/aio.h"
+#include "sysemu/cpus.h"
 
 #define DELTA_ADJUST     1
 #define DELTA_NO_ADJUST -1
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 09f0d22..3fa722a 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -21,6 +21,7 @@
 #include "qapi/error.h"
 #include "sysemu/sysemu.h"
 #include "sysemu/numa.h"
+#include "sysemu/cpus.h"
 #include "hw/hw.h"
 #include "target/ppc/cpu.h"
 #include "qemu/log.h"
diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 26e6285..91cd8c8 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -4,7 +4,6 @@
 #include "qemu-common.h"
 #include "qemu/notify.h"
 #include "qemu/host-utils.h"
-#include "sysemu/cpus.h"
 
 #define NANOSECONDS_PER_SECOND 1000000000LL
 
diff --git a/include/sysemu/cpus.h b/include/sysemu/cpus.h
index a73b5d4..e521a91 100644
--- a/include/sysemu/cpus.h
+++ b/include/sysemu/cpus.h
@@ -1,6 +1,8 @@
 #ifndef QEMU_CPUS_H
 #define QEMU_CPUS_H
 
+#include "qemu/timer.h"
+
 /* cpus.c */
 bool qemu_in_vcpu_thread(void);
 void qemu_init_cpu_loop(void);
diff --git a/kvm-all.c b/kvm-all.c
index 9040bd5..90b8573 100644
--- a/kvm-all.c
+++ b/kvm-all.c
@@ -29,6 +29,7 @@
 #include "hw/s390x/adapter.h"
 #include "exec/gdbstub.h"
 #include "sysemu/kvm_int.h"
+#include "sysemu/cpus.h"
 #include "qemu/bswap.h"
 #include "exec/memory.h"
 #include "exec/ram_addr.h"
diff --git a/monitor.c b/monitor.c
index f11893e..be282ec 100644
--- a/monitor.c
+++ b/monitor.c
@@ -77,6 +77,7 @@
 #include "qapi-event.h"
 #include "qmp-introspect.h"
 #include "sysemu/qtest.h"
+#include "sysemu/cpus.h"
 #include "qemu/cutils.h"
 #include "qapi/qmp/dispatch.h"
 
diff --git a/replay/replay.c b/replay/replay.c
index 1835b99..78e2a7e 100644
--- a/replay/replay.c
+++ b/replay/replay.c
@@ -16,6 +16,7 @@
 #include "replay-internal.h"
 #include "qemu/timer.h"
 #include "qemu/main-loop.h"
+#include "sysemu/cpus.h"
 #include "sysemu/sysemu.h"
 #include "qemu/error-report.h"
 
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 055286a..df5d695 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -19,6 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "sysemu/cpus.h"
 #include "disas/disas.h"
 #include "qemu/host-utils.h"
 #include "exec/exec-all.h"
diff --git a/translate-all.c b/translate-all.c
index 34480ae..b3ee876 100644
--- a/translate-all.c
+++ b/translate-all.c
@@ -57,6 +57,7 @@
 #include "qemu/timer.h"
 #include "qemu/main-loop.h"
 #include "exec/log.h"
+#include "sysemu/cpus.h"
 
 /* #define DEBUG_TB_INVALIDATE */
 /* #define DEBUG_TB_FLUSH */
diff --git a/util/main-loop.c b/util/main-loop.c
index ca7bb07..7efc229 100644
--- a/util/main-loop.c
+++ b/util/main-loop.c
@@ -28,6 +28,7 @@
 #include "qemu/timer.h"
 #include "qemu/sockets.h"	// struct in_addr needed for libslirp.h
 #include "sysemu/qtest.h"
+#include "sysemu/cpus.h"
 #include "slirp/libslirp.h"
 #include "qemu/main-loop.h"
 #include "block/aio.h"
diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 2f20151..ac99340 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -27,6 +27,7 @@
 #include "qemu/timer.h"
 #include "sysemu/replay.h"
 #include "sysemu/sysemu.h"
+#include "sysemu/cpus.h"
 
 #ifdef CONFIG_POSIX
 #include <pthread.h>
-- 
1.8.3.1
