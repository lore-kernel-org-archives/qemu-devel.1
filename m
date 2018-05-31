Received: from eggs.gnu.org ([2001:4830:134:3::10]:41997)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fOFxV-0000C3-I4
	for qemu-devel@nongnu.org; Thu, 31 May 2018 01:17:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fOFxU-0006IY-Dy
	for qemu-devel@nongnu.org; Thu, 31 May 2018 01:17:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58006 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fOFxU-0006I7-8o
	for qemu-devel@nongnu.org; Thu, 31 May 2018 01:17:08 -0400
From: Peter Xu <peterx@redhat.com>
Date: Thu, 31 May 2018 13:16:40 +0800
Message-Id: <20180531051641.8473-4-peterx@redhat.com>
In-Reply-To: <20180531051641.8473-1-peterx@redhat.com>
References: <20180531051641.8473-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC v2 3/4] monitor: remove "x-oob",
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, peterx@redhat.com, Eric Auger <eric.auger@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

There was a regression reported by Eric Auger before with OOB:

  http://lists.gnu.org/archive/html/qemu-devel/2018-03/msg06231.html

The fix is 951702f39c ("monitor: bind dispatch bh to iohandler context",
2018-04-10), which is in master already.

For the bug, we turned Out-Of-Band feature of monitors off for 2.12
release.  Now we turn that on again after the 2.12 release.

This patch partly reverts be933ffc23 (monitor: new parameter "x-oob"),
meanwhile turn it on again by default for non-MUX QMPs.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/monitor/monitor.h |  1 -
 monitor.c                 | 17 +----------------
 tests/qmp-test.c          |  2 +-
 vl.c                      |  5 -----
 4 files changed, 2 insertions(+), 23 deletions(-)

diff --git a/include/monitor/monitor.h b/include/monitor/monitor.h
index d6ab70cae2..0cb0538a31 100644
--- a/include/monitor/monitor.h
+++ b/include/monitor/monitor.h
@@ -13,7 +13,6 @@ extern Monitor *cur_mon;
 #define MONITOR_USE_READLINE  0x02
 #define MONITOR_USE_CONTROL   0x04
 #define MONITOR_USE_PRETTY    0x08
-#define MONITOR_USE_OOB       0x10
 
 bool monitor_cur_is_qmp(void);
 
diff --git a/monitor.c b/monitor.c
index 46814af533..f6f74239ad 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4558,19 +4558,7 @@ void monitor_init(Chardev *chr, int flags)
 {
     Monitor *mon = g_malloc(sizeof(*mon));
     bool use_readline = flags & MONITOR_USE_READLINE;
-    bool use_oob = flags & MONITOR_USE_OOB;
-
-    if (use_oob) {
-        if (CHARDEV_IS_MUX(chr)) {
-            error_report("Monitor Out-Of-Band is not supported with "
-                         "MUX typed chardev backend");
-            exit(1);
-        }
-        if (use_readline) {
-            error_report("Monitor Out-Of-band is only supported by QMP");
-            exit(1);
-        }
-    }
+    bool use_oob = (flags & MONITOR_USE_CONTROL) && !CHARDEV_IS_MUX(chr);
 
     monitor_data_init(mon, false, use_oob);
 
@@ -4672,9 +4660,6 @@ QemuOptsList qemu_mon_opts = {
         },{
             .name = "pretty",
             .type = QEMU_OPT_BOOL,
-        },{
-            .name = "x-oob",
-            .type = QEMU_OPT_BOOL,
         },
         { /* end of list */ }
     },
diff --git a/tests/qmp-test.c b/tests/qmp-test.c
index 88f867f8c0..c85a3964d9 100644
--- a/tests/qmp-test.c
+++ b/tests/qmp-test.c
@@ -89,7 +89,7 @@ static void test_qmp_protocol(void)
     g_assert(q);
     test_version(qdict_get(q, "version"));
     capabilities = qdict_get_qlist(q, "capabilities");
-    g_assert(capabilities && qlist_empty(capabilities));
+    g_assert(capabilities);
     qobject_unref(resp);
 
     /* Test valid command before handshake */
diff --git a/vl.c b/vl.c
index 038d7f8042..35e94a7032 100644
--- a/vl.c
+++ b/vl.c
@@ -2402,11 +2402,6 @@ static int mon_init_func(void *opaque, QemuOpts *opts, Error **errp)
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
2.17.0
