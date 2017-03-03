Received: from eggs.gnu.org ([2001:4830:134:3::10]:54597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cjmzP-0002Ct-2q
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:11:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cjmzO-0007cB-2i
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:11:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50322)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cjmzN-0007bU-Qh
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 08:11:18 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri,  3 Mar 2017 14:11:10 +0100
Message-Id: <20170303131113.25898-3-pbonzini@redhat.com>
In-Reply-To: <20170303131113.25898-1-pbonzini@redhat.com>
References: <20170303131113.25898-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 2/5] qemu-timer: do not include sysemu/cpus.h
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
Cc: alex.bennee@linaro.org

This dependency is the wrong way, and we will need util/qemu-timer.h from sysemu/cpus.h
in the next patch.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 cpu-exec.c            | 1 +
 hw/core/ptimer.c      | 1 +
 include/qemu/timer.h  | 1 -
 include/sysemu/cpus.h | 2 ++
 kvm-all.c             | 1 +
 monitor.c             | 1 +
 replay/replay.c       | 1 +
 translate-all.c       | 1 +
 util/main-loop.c      | 1 +
 util/qemu-timer.c     | 1 +
 10 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/cpu-exec.c b/cpu-exec.c
index 1a5ad48..6dbb4da 100644
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
index 0c94637..0fd6655 100644
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
index b68944d..d8fba78 100644
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
 
diff --git a/translate-all.c b/translate-all.c
index 956d54b..63b8f56 100644
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
index ad10bca..0b2d8c0 100644
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
2.9.3
