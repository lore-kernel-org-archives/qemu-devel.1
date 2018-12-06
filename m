Received: from eggs.gnu.org ([2001:4830:134:3::10]:41166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsJ7-0007YI-Hw
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:59:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsJ3-0003Yv-3R
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:59:05 -0500
Received: from mail.ispras.ru ([83.149.199.45]:59682)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1gUsJ2-0003YT-Pn
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 06:59:01 -0500
From: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Date: Thu, 06 Dec 2018 14:58:55 +0300
Message-ID: <154409753519.5432.11625154087705861472.stgit@Misha-PC.lan02.inno>
In-Reply-To: <154409751316.5432.3325938832238028060.stgit@Misha-PC.lan02.inno>
References: <154409751316.5432.3325938832238028060.stgit@Misha-PC.lan02.inno>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH v3 03/39] windbg: add -windbg option
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

Signed-off-by: Mikhail Abakumov <mikhail.abakumov@ispras.ru>
Acked-by: Alistair Francis <alistair.francis@xilinx.com>
Signed-off-by: Pavel Dovgalyuk <dovgaluk@ispras.ru>
---
 qemu-options.hx |    8 ++++++++
 vl.c            |    8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/qemu-options.hx b/qemu-options.hx
index f7df472f43..13b1157114 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3317,6 +3317,14 @@ Shorthand for -gdb tcp::1234, i.e. open a gdbserver on TCP port 1234
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
index fa25d1ae2d..bfcecf9a5c 100644
--- a/vl.c
+++ b/vl.c
@@ -76,6 +76,7 @@ int main(int argc, char **argv)
 #include "sysemu/sysemu.h"
 #include "sysemu/numa.h"
 #include "exec/gdbstub.h"
+#include "exec/windbgstub.h"
 #include "qemu/timer.h"
 #include "chardev/char.h"
 #include "qemu/bitmap.h"
@@ -2372,6 +2373,7 @@ struct device_config {
         DEV_VIRTCON,   /* -virtioconsole */
         DEV_DEBUGCON,  /* -debugcon */
         DEV_GDB,       /* -gdb, -s */
+        DEV_WINDBG,    /* -windbg */
         DEV_SCLP,      /* s390 sclp */
     } type;
     const char *cmdline;
@@ -3324,6 +3326,9 @@ int main(int argc, char **argv, char **envp)
             case QEMU_OPTION_gdb:
                 add_device_config(DEV_GDB, optarg);
                 break;
+            case QEMU_OPTION_windbg:
+                 add_device_config(DEV_WINDBG, optarg);
+                 break;
             case QEMU_OPTION_L:
                 if (is_help_option(optarg)) {
                     list_data_dirs = true;
@@ -4464,6 +4469,9 @@ int main(int argc, char **argv, char **envp)
     qemu_opts_foreach(qemu_find_opts("mon"),
                       mon_init_func, NULL, &error_fatal);
 
+    if (foreach_device_config(DEV_WINDBG, windbg_server_start) < 0) {
+        exit(1);
+    }
     if (foreach_device_config(DEV_SERIAL, serial_parse) < 0)
         exit(1);
     if (foreach_device_config(DEV_PARALLEL, parallel_parse) < 0)
