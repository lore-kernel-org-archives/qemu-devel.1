Received: from eggs.gnu.org ([2001:4830:134:3::10]:38586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eRKaI-0002Hc-Kt
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 11:17:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eRKaH-00046t-PK
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 11:17:38 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 19 Dec 2017 17:17:33 +0100
Message-Id: <1513700253-10045-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] monitor: Remove legacy "-mon default=on"
 parameter
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, qemu-trivial@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>

The "default" parameter of the "-mon" option is useless since
QEMU v2.4.0, and marked as deprecated since QEMU v2.8.0. That
should have been long enough to let people update their scripts,
so time to remove it now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 monitor.c     | 3 ---
 qemu-doc.texi | 9 ---------
 vl.c          | 4 ----
 3 files changed, 16 deletions(-)

diff --git a/monitor.c b/monitor.c
index e36fb53..e53c6e1 100644
--- a/monitor.c
+++ b/monitor.c
@@ -4141,9 +4141,6 @@ QemuOptsList qemu_mon_opts = {
             .name = "chardev",
             .type = QEMU_OPT_STRING,
         },{
-            .name = "default",  /* deprecated */
-            .type = QEMU_OPT_BOOL,
-        },{
             .name = "pretty",
             .type = QEMU_OPT_BOOL,
         },
diff --git a/qemu-doc.texi b/qemu-doc.texi
index d9861b3..6913b32 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2401,15 +2401,6 @@ setting ``-machine kernel_irqchip=off''.
 The ``-no-kvm'' argument is now a synonym for setting
 ``-machine accel=tcg''.
 
-@subsection -mon default=on (since 2.4.0)
-
-The ``default'' option to the ``-mon'' argument is
-now ignored. When multiple monitors were enabled, it
-indicated which monitor would receive log messages
-from the various subsystems. This feature is no longer
-required as messages are now only sent to the monitor
-in response to explicitly monitor commands.
-
 @subsection -vnc tls (since 2.5.0)
 
 The ``-vnc tls'' argument is now a synonym for setting
diff --git a/vl.c b/vl.c
index 2644400..4e7a7e4 100644
--- a/vl.c
+++ b/vl.c
@@ -2438,10 +2438,6 @@ static int mon_init_func(void *opaque, QemuOpts *opts, Error **errp)
     if (qemu_opt_get_bool(opts, "pretty", 0))
         flags |= MONITOR_USE_PRETTY;
 
-    if (qemu_opt_get_bool(opts, "default", 0)) {
-        error_report("option 'default' does nothing and is deprecated");
-    }
-
     chardev = qemu_opt_get(opts, "chardev");
     chr = qemu_chr_find(chardev);
     if (chr == NULL) {
-- 
1.8.3.1
