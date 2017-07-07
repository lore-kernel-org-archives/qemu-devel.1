Received: from eggs.gnu.org ([2001:4830:134:3::10]:41594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWl8-0004wF-Fq
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:09:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWl7-0007qb-DC
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:09:38 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Jul 2017 19:07:34 +0200
Message-Id: <1499447335-6125-20-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
References: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 019/100] blockdev: Print a warning for legacy
 drive options that belong to -device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Thomas Huth <thuth@redhat.com>

We likely do not want to carry these legacy -drive options along forever.
Let's emit a deprecation warning for the -drive options that have a
replacement with the -device option, so that the (hopefully few) remaining
users are aware of this and can adapt their scripts / behaviour accordingly.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 blockdev.c      | 14 ++++++++++++++
 qemu-options.hx |  9 +++++++--
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index f92dcf2..e2016b6 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -50,6 +50,7 @@
 #include "qmp-commands.h"
 #include "block/trace.h"
 #include "sysemu/arch_init.h"
+#include "sysemu/qtest.h"
 #include "qemu/cutils.h"
 #include "qemu/help_option.h"
 #include "qemu/throttle-options.h"
@@ -798,6 +799,9 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
     const char *filename;
     Error *local_err = NULL;
     int i;
+    const char *deprecated[] = {
+        "serial", "trans", "secs", "heads", "cyls", "addr"
+    };
 
     /* Change legacy command line options into QMP ones */
     static const struct {
@@ -881,6 +885,16 @@ DriveInfo *drive_new(QemuOpts *all_opts, BlockInterfaceType block_default_type)
                 "update your scripts.\n");
     }
 
+    /* Other deprecated options */
+    if (!qtest_enabled()) {
+        for (i = 0; i < ARRAY_SIZE(deprecated); i++) {
+            if (qemu_opt_get(legacy_opts, deprecated[i]) != NULL) {
+                error_report("'%s' is deprecated, please use the corresponding "
+                             "option of '-device' instead", deprecated[i]);
+            }
+        }
+    }
+
     /* Media type */
     value = qemu_opt_get(legacy_opts, "media");
     if (value) {
diff --git a/qemu-options.hx b/qemu-options.hx
index 297bd8a..ddab656 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -818,6 +818,8 @@ of available connectors of a given interface type.
 This option defines the type of the media: disk or cdrom.
 @item cyls=@var{c},heads=@var{h},secs=@var{s}[,trans=@var{t}]
 These options have the same definition as they have in @option{-hdachs}.
+These parameters are deprecated, use the corresponding parameters
+of @code{-device} instead.
 @item snapshot=@var{snapshot}
 @var{snapshot} is "on" or "off" and controls snapshot mode for the given drive
 (see @option{-snapshot}).
@@ -852,9 +854,12 @@ Specify which disk @var{format} will be used rather than detecting
 the format.  Can be used to specify format=raw to avoid interpreting
 an untrusted format header.
 @item serial=@var{serial}
-This option specifies the serial number to assign to the device.
+This option specifies the serial number to assign to the device. This
+parameter is deprecated, use the corresponding parameter of @code{-device}
+instead.
 @item addr=@var{addr}
-Specify the controller's PCI address (if=virtio only).
+Specify the controller's PCI address (if=virtio only). This parameter is
+deprecated, use the corresponding parameter of @code{-device} instead.
 @item werror=@var{action},rerror=@var{action}
 Specify which @var{action} to take on write and read errors. Valid actions are:
 "ignore" (ignore the error and try to continue), "stop" (pause QEMU),
-- 
1.8.3.1
