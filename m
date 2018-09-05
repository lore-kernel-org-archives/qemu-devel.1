Received: from eggs.gnu.org ([2001:4830:134:3::10]:37877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fxREq-0007B6-UR
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 02:24:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fxREo-0008Ak-BJ
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 02:24:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44464 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fxREm-0007AW-FJ
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 02:24:25 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 861207788F
	for <qemu-devel@nongnu.org>; Wed,  5 Sep 2018 06:23:47 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed,  5 Sep 2018 14:23:10 +0800
Message-Id: <20180905062313.4059-4-peterx@redhat.com>
In-Reply-To: <20180905062313.4059-1-peterx@redhat.com>
References: <20180905062313.4059-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v8 3/6] monitor: remove "x-oob",
 turn oob on by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

OOB commands were introduced in commit cf869d53172.  Unfortunately, we
ran into a regression, and had to disable them by default for 2.12
(commit be933ffc23).

  http://lists.gnu.org/archive/html/qemu-devel/2018-03/msg06231.html

The regression has since been fixed (commit 951702f39c7 "monitor: bind
dispatch bh to iohandler context").  Time to re-enable OOB.

This patch partly reverts be933ffc23 (monitor: new parameter "x-oob"),
and turns it on again for non-MUX QMPs.  Note that we can't enable
Out-Of-Band for monitors with MUX-typed chardev backends, because not
all the chardev frontends can run without main thread, or can run in
multiple threads.

Some trivial touch-up in the test code is required to make sure qmp-test
won't break.

Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/monitor/monitor.h |  1 -
 monitor.c                 | 22 ++++++----------------
 tests/libqtest.c          |  2 +-
 tests/qmp-test.c          |  2 +-
 vl.c                      |  5 -----
 5 files changed, 8 insertions(+), 24 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index 76873c0d40..281480a1e5 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -13,7 +13,6 @@ extern __thread Monitor *cur_mon;
 #define MONITOR_USE_READLINE  0x02
 #define MONITOR_USE_CONTROL   0x04
 #define MONITOR_USE_PRETTY    0x08
-#define MONITOR_USE_OOB       0x10
 
 #define QMP_REQ_QUEUE_LEN_MAX 8
 
diff --git a/monitor.c b/monitor.c
index c2c9853f75..a465b69c62 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4524,19 +4524,12 @@ void monitor_init(Chardev *chr, int flags)
 {
     Monitor *mon = g_malloc(sizeof(*mon));
     bool use_readline = flags & MONITOR_USE_READLINE;
-    bool use_oob = flags & MONITOR_USE_OOB;
-
-    if (use_oob) {
-        if (CHARDEV_IS_MUX(chr)) {
-            error_report("Monitor out-of-band is not supported with "
-                         "MUX typed chardev backend");
-            exit(1);
-        }
-        if (use_readline) {
-            error_report("Monitor out-of-band is only supported by QMP");
-            exit(1);
-        }
-    }
+    /*
+     * Note: we can't enable Out-Of-Band for monitors with MUX-typed
+     * chardev backends, because not all the chardev frontends can run
+     * without main thread, or can run in multiple threads.
+     */
+    bool use_oob = (flags & MONITOR_USE_CONTROL) && !CHARDEV_IS_MUX(chr);
 
     monitor_data_init(mon, false, use_oob);
 
@@ -4626,9 +4619,6 @@ QemuOptsList qemu_mon_opts = {
         },{
             .name = "pretty",
             .type = QEMU_OPT_BOOL,
-        },{
-            .name = "x-oob",
-            .type = QEMU_OPT_BOOL,
         },
         { /* end of list */ }
     },
diff --git a/tests/libqtest.c b/tests/libqtest.c
index d635c5bea0..ebd92f22f6 100644
--- a/tests/libqtest.c
+++ b/tests/libqtest.c
@@ -231,7 +231,7 @@ QTestState *qtest_init_without_qmp_handshake(bool use_oob,
                                   "-display none "
                                   "%s", qemu_binary, socket_path,
                                   getenv("QTEST_LOG") ? "/dev/fd/2" : "/dev/null",
-                                  qmp_socket_path, use_oob ? ",x-oob=on" : "",
+                                  qmp_socket_path, "",
                                   extra_args ?: "");
         execlp("/bin/sh", "sh", "-c", command, NULL);
         exit(1);
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 4ae2245484..5302bd07b9 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -143,7 +143,7 @@ static void test_qmp_protocol(void)
     g_assert(q);
     test_version(qdict_get(q, "version"));
     capabilities = qdict_get_qlist(q, "capabilities");
-    g_assert(capabilities && qlist_empty(capabilities));
+    g_assert(capabilities);
     qobject_unref(resp);
 
     /* Test valid command before handshake */
diff --git a/vl.c b/vl.c
index 10dd690e30..0206f0c512 100644
--- a/vl.c
+++ b/vl.c
@@ -2323,11 +2323,6 @@ static int mon_init_func(void *opaque, QemuOpts *opts, Error **errp)
     if (qemu_opt_get_bool(opts, "pretty", 0))
         flags |= MONITOR_USE_PRETTY;
 
-    /* OOB is off by default */
-    if (qemu_opt_get_bool(opts, "x-oob", 0)) {
-        flags |= MONITOR_USE_OOB;
-    }
-
     chardev = qemu_opt_get(opts, "chardev");
     chr = qemu_chr_find(chardev);
     if (chr == NULL) {
-- 
2.17.1
