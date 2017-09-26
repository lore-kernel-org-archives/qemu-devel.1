Received: from eggs.gnu.org ([2001:4830:134:3::10]:58724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnfF-00039O-2M
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:04:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnfD-0008GH-L5
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:04:33 -0400
Received: from mail.ispras.ru ([83.149.199.45]:51662)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1dwnfD-0008G0-Ay
	for qemu-devel@nongnu.org; Tue, 26 Sep 2017 07:04:31 -0400
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Date: Tue, 26 Sep 2017 14:04:29 +0300
Message-ID: <150642386887.3900.11789274449160294712.stgit@Misha-PC.lan02.inno>
In-Reply-To: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
References: <150642384156.3900.3326424823772221077.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH 04/43] windbg: added '-windbg' option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: sw@weilnetz.de, lprosek@redhat.com, dovgaluk@ispras.ru, rkagan@virtuozzo.com, pbonzini@redhat.com, den@openvz.org

This option starts windbg server.

Signed-off-by: Mihail Abakumov <mikhail.abakumov@ispras.ru>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Signed-off-by: Dmitriy Koltunov <koltunov@ispras.ru>
---
 qemu-options.hx |    8 ++++++++
 vl.c            |    8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index 9f6e2adfff..1c84eb56d9 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3544,6 +3544,14 @@ Shorthand for -gdb tcp::1234, i.e. open a gdbserver on TCP port 1234
 (@pxref{gdb_usage}).
 ETEXI
 
+DEF("windbg", HAS_ARG, QEMU_OPTION_windbg, \
+    "-windbg         wait for windbg connection\n", QEMU_ARCH_I386)
+STEXI
+@item -windbg
+@findex -windbg
+Wait for windbg connection.
+ETEXI
+
 DEF("d", HAS_ARG, QEMU_OPTION_d, \
     "-d item1,...    enable logging of specified items (use '-d help' for a list of log items)\n",
     QEMU_ARCH_ALL)
diff --git a/vl.c b/vl.c
index 8e247cc2a2..d6378cf03f 100644
--- a/vl.c
+++ b/vl.c
@@ -80,6 +80,7 @@ int main(int argc, char **argv)
 #include "sysemu/sysemu.h"
 #include "sysemu/numa.h"
 #include "exec/gdbstub.h"
+#include "exec/windbgstub.h"
 #include "qemu/timer.h"
 #include "chardev/char.h"
 #include "qemu/bitmap.h"
@@ -2436,6 +2437,7 @@ struct device_config {
         DEV_VIRTCON,   /* -virtioconsole */
         DEV_DEBUGCON,  /* -debugcon */
         DEV_GDB,       /* -gdb, -s */
+        DEV_WINDBG,    /* -windbg */
         DEV_SCLP,      /* s390 sclp */
     } type;
     const char *cmdline;
@@ -3445,6 +3447,9 @@ int main(int argc, char **argv, char **envp)
             case QEMU_OPTION_gdb:
                 add_device_config(DEV_GDB, optarg);
                 break;
+            case QEMU_OPTION_windbg:
+                add_device_config(DEV_WINDBG, optarg);
+                break;
             case QEMU_OPTION_L:
                 if (is_help_option(optarg)) {
                     list_data_dirs = true;
@@ -4586,6 +4591,9 @@ int main(int argc, char **argv, char **envp)
         exit(1);
     }
 
+    if (foreach_device_config(DEV_WINDBG, windbg_server_start) < 0) {
+        exit(1);
+    }
     if (foreach_device_config(DEV_SERIAL, serial_parse) < 0)
         exit(1);
     if (foreach_device_config(DEV_PARALLEL, parallel_parse) < 0)
