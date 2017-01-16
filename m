Received: from eggs.gnu.org ([2001:4830:134:3::10]:57918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cTAcv-0000h6-HB
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:59:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cTAcu-0008V5-OM
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:59:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33280)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cTAcu-0008Up-IO
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 11:59:24 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A0FF8C04B316
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 16:59:24 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-116-100.ams2.redhat.com
	[10.36.116.100])
	by int-mx14.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v0GGxGUq001760
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 11:59:24 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 16 Jan 2017 17:58:49 +0100
Message-Id: <20170116165916.8575-6-pbonzini@redhat.com>
In-Reply-To: <20170116165916.8575-1-pbonzini@redhat.com>
References: <20170116165916.8575-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 05/32] stubs: merge all monitor stubs in one
 file, remove monitor_cur_is_qmp stub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

monitor_cur_is_qmp was previously used by other stubs, but it's not
since 397d30e ("qemu-error: remove dependency of stubs on monitor",
2016-11-01).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 stubs/Makefile.objs           |  4 +---
 stubs/mon-is-qmp.c            | 10 ----------
 stubs/monitor-init.c          |  7 -------
 stubs/{get-fd.c => monitor.c} |  6 ++++++
 4 files changed, 7 insertions(+), 20 deletions(-)
 delete mode 100644 stubs/mon-is-qmp.c
 delete mode 100644 stubs/monitor-init.c
 rename stubs/{get-fd.c => monitor.c} (75%)

diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
index 2b5bb74..9fc373e 100644
--- a/stubs/Makefile.objs
+++ b/stubs/Makefile.objs
@@ -15,7 +15,6 @@ stub-obj-y += fdset-find-fd.o
 stub-obj-y += fdset-get-fd.o
 stub-obj-y += fdset-remove-fd.o
 stub-obj-y += gdbstub.o
-stub-obj-y += get-fd.o
 stub-obj-y += get-next-serial.o
 stub-obj-y += get-vm-name.o
 stub-obj-y += iothread.o
@@ -23,8 +22,7 @@ stub-obj-y += iothread-lock.o
 stub-obj-y += is-daemonized.o
 stub-obj-y += machine-init-done.o
 stub-obj-y += migr-blocker.o
-stub-obj-y += mon-is-qmp.o
-stub-obj-y += monitor-init.o
+stub-obj-y += monitor.o
 stub-obj-y += notify-event.o
 stub-obj-y += qtest.o
 stub-obj-y += replay.o
diff --git a/stubs/mon-is-qmp.c b/stubs/mon-is-qmp.c
deleted file mode 100644
index a8344ce..0000000
--- a/stubs/mon-is-qmp.c
+++ /dev/null
@@ -1,10 +0,0 @@
-#include "qemu/osdep.h"
-#include "qemu-common.h"
-#include "monitor/monitor.h"
-
-Monitor *cur_mon;
-
-bool monitor_cur_is_qmp(void)
-{
-    return false;
-}
diff --git a/stubs/monitor-init.c b/stubs/monitor-init.c
deleted file mode 100644
index de1bc7c..0000000
--- a/stubs/monitor-init.c
+++ /dev/null
@@ -1,7 +0,0 @@
-#include "qemu/osdep.h"
-#include "qemu-common.h"
-#include "monitor/monitor.h"
-
-void monitor_init(CharDriverState *chr, int flags)
-{
-}
diff --git a/stubs/get-fd.c b/stubs/monitor.c
similarity index 75%
rename from stubs/get-fd.c
rename to stubs/monitor.c
index 7dfdfb5..1d574b1 100644
--- a/stubs/get-fd.c
+++ b/stubs/monitor.c
@@ -3,8 +3,14 @@
 #include "qemu-common.h"
 #include "monitor/monitor.h"
 
+Monitor *cur_mon = NULL;
+
 int monitor_get_fd(Monitor *mon, const char *name, Error **errp)
 {
     error_setg(errp, "only QEMU supports file descriptor passing");
     return -1;
 }
+
+void monitor_init(CharDriverState *chr, int flags)
+{
+}
-- 
2.9.3
