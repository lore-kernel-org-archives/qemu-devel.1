Received: from eggs.gnu.org ([2001:4830:134:3::10]:53487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dpgxU-0002Zl-A5
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 16:30:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cota@braap.org>) id 1dpgxR-00014W-FA
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 16:30:00 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52465)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cota@braap.org>) id 1dpgxR-00013a-Ap
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 16:29:57 -0400
From: "Emilio G. Cota" <cota@braap.org>
Date: Wed,  6 Sep 2017 16:28:48 -0400
Message-Id: <1504729728-23279-7-git-send-email-cota@braap.org>
In-Reply-To: <1504729728-23279-1-git-send-email-cota@braap.org>
References: <1504729728-23279-1-git-send-email-cota@braap.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC 6/6] linux-user: support -plugin option
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
 linux-user/main.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/linux-user/main.c b/linux-user/main.c
index 31c8f1a..211ee02 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -27,6 +27,7 @@
 #include "qemu/config-file.h"
 #include "qemu/cutils.h"
 #include "qemu/help_option.h"
+#include "qemu/plugin.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "tcg.h"
@@ -4014,6 +4015,15 @@ static void handle_arg_trace(const char *arg)
     trace_file = trace_opt_parse(arg);
 }
 
+static struct qemu_plugin_list plugins = QTAILQ_HEAD_INITIALIZER(plugins);
+
+#ifdef CONFIG_PLUGINS
+static void handle_arg_plugin(const char *arg)
+{
+    qemu_plugin_opt_parse(arg, &plugins);
+}
+#endif
+
 struct qemu_argument {
     const char *argv;
     const char *env;
@@ -4063,6 +4073,10 @@ static const struct qemu_argument arg_table[] = {
      "",           "Seed for pseudo-random number generator"},
     {"trace",      "QEMU_TRACE",       true,  handle_arg_trace,
      "",           "[[enable=]<pattern>][,events=<file>][,file=<file>]"},
+#ifdef CONFIG_PLUGINS
+    {"plugin",     "QEMU_PLUGIN",      true,  handle_arg_plugin,
+     "",           "[file=]<file>[,arg=<string>]"},
+#endif
     {"version",    "QEMU_VERSION",     false, handle_arg_version,
      "",           "display version information and exit"},
     {NULL, NULL, false, NULL, NULL, NULL}
@@ -4252,6 +4266,7 @@ int main(int argc, char **argv, char **envp)
     srand(time(NULL));
 
     qemu_add_opts(&qemu_trace_opts);
+    qemu_plugin_add_opts();
 
     optind = parse_args(argc, argv);
 
@@ -4259,6 +4274,9 @@ int main(int argc, char **argv, char **envp)
         exit(1);
     }
     trace_init_file(trace_file);
+    if (qemu_plugin_load_list(&plugins)) {
+        exit(1);
+    }
 
     /* Zero out regs */
     memset(regs, 0, sizeof(struct target_pt_regs));
-- 
2.7.4
