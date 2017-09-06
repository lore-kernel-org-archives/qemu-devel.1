Received: from eggs.gnu.org ([2001:4830:134:3::10]:53522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dpgxW-0002az-9R
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 16:30:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dpgxR-00014Q-ED
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 16:30:02 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:47575)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dpgxR-00013Z-Ah
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 16:29:57 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed,  6 Sep 2017 16:28:47 -0400
Message-Id: <1504729728-23279-6-git-send-email-cota@braap.org>
In-Reply-To: <1504729728-23279-1-git-send-email-cota@braap.org>
References: <1504729728-23279-1-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC 5/6] vl: support -plugin option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Stefan Hajnoczi <stefanha@redhat.com>

From: Lluís Vilanova <vilanova@ac.upc.edu>

Signed-off-by: Lluís Vilanova <vilanova@ac.upc.edu>
[ cota: s/instrument/plugin ]
Signed-off-by: Emilio G. Cota <cota@braap.org>
---
 vl.c            | 10 ++++++++++
 qemu-options.hx | 17 +++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/vl.c b/vl.c
index fb6b2ef..d3d8adc 100644
--- a/vl.c
+++ b/vl.c
@@ -118,6 +118,7 @@ int main(int argc, char **argv)
 
 #include "trace-root.h"
 #include "trace/control.h"
+#include "qemu/plugin.h"
 #include "qemu/queue.h"
 #include "sysemu/arch_init.h"
 
@@ -3031,6 +3032,7 @@ int main(int argc, char **argv, char **envp)
     } BlockdevOptions_queue;
     QSIMPLEQ_HEAD(, BlockdevOptions_queue) bdo_queue
         = QSIMPLEQ_HEAD_INITIALIZER(bdo_queue);
+    struct qemu_plugin_list plugin_list = QTAILQ_HEAD_INITIALIZER(plugin_list);
 
     module_call_init(MODULE_INIT_TRACE);
 
@@ -3058,6 +3060,7 @@ int main(int argc, char **argv, char **envp)
     qemu_add_opts(&qemu_global_opts);
     qemu_add_opts(&qemu_mon_opts);
     qemu_add_opts(&qemu_trace_opts);
+    qemu_plugin_add_opts();
     qemu_add_opts(&qemu_option_rom_opts);
     qemu_add_opts(&qemu_machine_opts);
     qemu_add_opts(&qemu_accel_opts);
@@ -3999,6 +4002,9 @@ int main(int argc, char **argv, char **envp)
                 g_free(trace_file);
                 trace_file = trace_opt_parse(optarg);
                 break;
+            case QEMU_OPTION_plugin:
+                qemu_plugin_opt_parse(optarg, &plugin_list);
+                break;
             case QEMU_OPTION_readconfig:
                 {
                     int ret = qemu_read_config_file(optarg);
@@ -4185,6 +4191,10 @@ int main(int argc, char **argv, char **envp)
     }
     trace_init_file(trace_file);
 
+    if (qemu_plugin_load_list(&plugin_list)) {
+        exit(1);
+    }
+
     /* Open the logfile at this point and set the log mask if necessary.
      */
     if (log_file) {
diff --git a/qemu-options.hx b/qemu-options.hx
index 746b5fa..34557e6 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4064,6 +4064,23 @@ HXCOMM HX does not support conditional compilation of text.
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
2.7.4
