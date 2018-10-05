Received: from eggs.gnu.org ([2001:4830:134:3::10]:60111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8SSH-0005zp-84
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:55:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8SSC-0004eb-Ni
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:55:53 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:53776)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g8SSC-0004eN-Fz
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:55:48 -0400
Received: by mail-wm1-x32d.google.com with SMTP id b19-v6so2333565wme.3
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 08:55:48 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  5 Oct 2018 16:49:04 +0100
Message-Id: <20181005154910.3099-16-alex.bennee@linaro.org>
In-Reply-To: <20181005154910.3099-1-alex.bennee@linaro.org>
References: <20181005154910.3099-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 15/21] trace: add linux-user plugin support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel.Dovgaluk@ispras.ru, vilanova@ac.upc.edu, cota@braap.org, Aaron Lindsay <aclindsa@gmail.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

From: Aaron Lindsay <aclindsa@gmail.com>

Signed-off-by: Aaron Lindsay <aclindsa@gmail.com>
[AJB: ifdeffery]
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 linux-user/main.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/linux-user/main.c b/linux-user/main.c
index a68674d0de..9fbb827fe0 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -38,6 +38,7 @@
 #include "trace/control.h"
 #include "target_elf.h"
 #include "cpu_loop-common.h"
+#include "qemu/plugins.h"
 
 char *exec_path;
 
@@ -393,6 +394,13 @@ static void handle_arg_trace(const char *arg)
     trace_file = trace_opt_parse(arg);
 }
 
+#ifdef CONFIG_TRACE_PLUGIN
+static void handle_arg_plugin(const char *arg)
+{
+    qemu_plugin_parse_cmd_args(arg);
+}
+#endif
+
 struct qemu_argument {
     const char *argv;
     const char *env;
@@ -444,6 +452,10 @@ static const struct qemu_argument arg_table[] = {
      "",           "Seed for pseudo-random number generator"},
     {"trace",      "QEMU_TRACE",       true,  handle_arg_trace,
      "",           "[[enable=]<pattern>][,events=<file>][,file=<file>]"},
+#ifdef CONFIG_TRACE_PLUGIN
+    {"plugin",     "QEMU_PLUGIN",      true,  handle_arg_plugin,
+     "",           "file=<plugin_so>[,args=<args>]"},
+#endif
     {"version",    "QEMU_VERSION",     false, handle_arg_version,
      "",           "display version information and exit"},
     {NULL, NULL, false, NULL, NULL, NULL}
@@ -830,6 +842,9 @@ int main(int argc, char **argv, char **envp)
         }
         gdb_handlesig(cpu, 0);
     }
+
+    qemu_plugins_init();
+
     cpu_loop(env);
     /* never exits */
     return 0;
-- 
2.17.1
