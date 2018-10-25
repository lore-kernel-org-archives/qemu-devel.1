Received: from eggs.gnu.org ([2001:4830:134:3::10]:40309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKg-0006hl-1v
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1gFjKc-0000MV-5f
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:03 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:37971)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1gFjKb-0000C5-Oq
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 13:22:01 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Thu, 25 Oct 2018 13:20:51 -0400
Message-Id: <20181025172057.20414-43-cota@braap.org>
In-Reply-To: <20181025172057.20414-1-cota@braap.org>
References: <20181025172057.20414-1-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC 42/48] vl: support -plugin option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>

From: Lluís Vilanova <vilanova@ac.upc.edu>

Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
[ cota: s/instrument/plugin ]
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 vl.c            | 11 +++++++++++
 qemu-options.hx | 17 +++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/vl.c b/vl.c
index 4e25c78bff..ebb188552e 100644
--- a/vl.c
+++ b/vl.c
@@ -111,6 +111,7 @@ int main(int argc, char **argv)
 
 #include "trace-root.h"
 #include "trace/control.h"
+#include "qemu/plugin.h"
 #include "qemu/queue.h"
 #include "sysemu/arch_init.h"
 
@@ -2962,6 +2963,7 @@ int main(int argc, char **argv, char **envp)
     } BlockdevOptions_queue;
     QSIMPLEQ_HEAD(, BlockdevOptions_queue) bdo_queue
         = QSIMPLEQ_HEAD_INITIALIZER(bdo_queue);
+    struct qemu_plugin_list plugin_list = QTAILQ_HEAD_INITIALIZER(plugin_list);
 
     module_call_init(MODULE_INIT_TRACE);
 
@@ -2990,6 +2992,7 @@ int main(int argc, char **argv, char **envp)
     qemu_add_opts(&qemu_global_opts);
     qemu_add_opts(&qemu_mon_opts);
     qemu_add_opts(&qemu_trace_opts);
+    qemu_plugin_add_opts();
     qemu_add_opts(&qemu_option_rom_opts);
     qemu_add_opts(&qemu_machine_opts);
     qemu_add_opts(&qemu_accel_opts);
@@ -3806,6 +3809,9 @@ int main(int argc, char **argv, char **envp)
                 g_free(trace_file);
                 trace_file = trace_opt_parse(optarg);
                 break;
+            case QEMU_OPTION_plugin:
+                qemu_plugin_opt_parse(optarg, &plugin_list);
+                break;
             case QEMU_OPTION_readconfig:
                 {
                     int ret = qemu_read_config_file(optarg);
@@ -4107,6 +4113,11 @@ int main(int argc, char **argv, char **envp)
                                machine_class->default_machine_opts, 0);
     }
 
+    /* process plugin before CPUs are created, but once -smp has been parsed */
+    if (qemu_plugin_load_list(&plugin_list)) {
+        exit(1);
+    }
+
     qemu_opts_foreach(qemu_find_opts("device"),
                       default_driver_check, NULL, NULL);
     qemu_opts_foreach(qemu_find_opts("global"),
diff --git a/qemu-options.hx b/qemu-options.hx
index f139459e80..5cd1d84df4 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -3838,6 +3838,23 @@ HXCOMM HX does not support conditional compilation of text.
 @findex -trace
 @include qemu-option-trace.texi
 ETEXI
+DEF("plugin", HAS_ARG, QEMU_OPTION_plugin,
+    "-plugin [file=]<file>[,arg=<string>]\n"
+    "                load a plugin\n",
+    QEMU_ARCH_ALL)
+STEXI
+@item -plugin file=@var{file}[,arg=@var{string}]
+@findex -plugin
+
+Load a plugin.
+
+@table @option
+@item file=@var{file}
+Load the given plugin from a shared library file.
+@item arg=@var{string}
+Argument string passed to the plugin. (Can be given multiple times.)
+@end table
+ETEXI
 
 HXCOMM Internal use
 DEF("qtest", HAS_ARG, QEMU_OPTION_qtest, "", QEMU_ARCH_ALL)
-- 
2.17.1
