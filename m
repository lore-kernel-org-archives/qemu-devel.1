Received: from eggs.gnu.org ([2001:4830:134:3::10]:38199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f0Lmo-0002D3-Nt
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 02:39:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1f0Lmn-0006iU-Ry
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 02:39:18 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33378 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1f0Lmn-0006iG-O8
	for qemu-devel@nongnu.org; Mon, 26 Mar 2018 02:39:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5759A402B023
	for <qemu-devel@nongnu.org>; Mon, 26 Mar 2018 06:39:17 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Mon, 26 Mar 2018 14:38:56 +0800
Message-Id: <20180326063901.27425-4-peterx@redhat.com>
In-Reply-To: <20180326063901.27425-1-peterx@redhat.com>
References: <20180326063901.27425-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.12 3/8] monitor: new parameter "x-oob"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Add new parameter to optionally enable Out-Of-Band for a QMP server.

An example command line:

  ./qemu-system-x86_64 -chardev stdio,id=char0 \
                       -mon chardev=char0,mode=control,x-oob=on

By default, Out-Of-Band is off.

It is not allowed if either MUX or non-QMP is detected, since
Out-Of-Band is currently only for QMP, and non-MUX chardev backends.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/monitor/monitor.h |  1 +
 monitor.c                 | 22 ++++++++++++++++++++--
 vl.c                      |  5 +++++
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 0cb0538a31..d6ab70cae2 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -13,6 +13,7 @@ extern Monitor *cur_mon;
 #define MONITOR_USE_READLINE  0x02
 #define MONITOR_USE_CONTROL   0x04
 #define MONITOR_USE_PRETTY    0x08
+#define MONITOR_USE_OOB       0x10
 
 bool monitor_cur_is_qmp(void);
 
diff --git a/monitor.c b/monitor.c
index eba98df9da..d77ccc8785 100644
--- a/monitor.c
+++ b/monitor.c
@@ -36,6 +36,7 @@
 #include "net/slirp.h"
 #include "chardev/char-fe.h"
 #include "chardev/char-io.h"
+#include "chardev/char-mux.h"
 #include "ui/qemu-spice.h"
 #include "sysemu/numa.h"
 #include "monitor/monitor.h"
@@ -4568,12 +4569,26 @@ static void monitor_qmp_setup_handlers_bh(void *opaque)
 void monitor_init(Chardev *chr, int flags)
 {
     Monitor *mon = g_malloc(sizeof(*mon));
+    bool use_readline = flags & MONITOR_USE_READLINE;
+    bool use_oob = flags & MONITOR_USE_OOB;
+
+    if (use_oob) {
+        if (CHARDEV_IS_MUX(chr)) {
+            error_report("Monitor Out-Of-Band is not supported with "
+                         "MUX typed chardev backend");
+            exit(1);
+        }
+        if (use_readline) {
+            error_report("Monitor Out-Of-band is only supported by QMP");
+            exit(1);
+        }
+    }
 
-    monitor_data_init(mon, false, false);
+    monitor_data_init(mon, false, use_oob);
 
     qemu_chr_fe_init(&mon->chr, chr, &error_abort);
     mon->flags = flags;
-    if (flags & MONITOR_USE_READLINE) {
+    if (use_readline) {
         mon->rs = readline_init(monitor_readline_printf,
                                 monitor_readline_flush,
                                 mon,
@@ -4669,6 +4684,9 @@ QemuOptsList qemu_mon_opts = {
         },{
             .name = "pretty",
             .type = QEMU_OPT_BOOL,
+        },{
+            .name = "x-oob",
+            .type = QEMU_OPT_BOOL,
         },
         { /* end of list */ }
     },
diff --git a/vl.c b/vl.c
index c81cc86607..5fd01bd5f6 100644
--- a/vl.c
+++ b/vl.c
@@ -2404,6 +2404,11 @@ static int mon_init_func(void *opaque, QemuOpts *opts, Error **errp)
     if (qemu_opt_get_bool(opts, "pretty", 0))
         flags |= MONITOR_USE_PRETTY;
 
+    /* OOB is off by default */
+    if (qemu_opt_get_bool(opts, "x-oob", 0)) {
+        flags |= MONITOR_USE_OOB;
+    }
+
     chardev = qemu_opt_get(opts, "chardev");
     chr = qemu_chr_find(chardev);
     if (chr == NULL) {
-- 
2.14.3
