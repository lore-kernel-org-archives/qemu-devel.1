Received: from eggs.gnu.org ([2001:4830:134:3::10]:56931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8SMA-0006aj-Q7
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8SM8-0006D1-Qf
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:34 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:38979)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g8SM8-00068q-B9
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:32 -0400
Received: by mail-wr1-x42f.google.com with SMTP id 61-v6so13303655wrb.6
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 08:49:29 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  5 Oct 2018 16:49:07 +0100
Message-Id: <20181005154910.3099-19-alex.bennee@linaro.org>
In-Reply-To: <20181005154910.3099-1-alex.bennee@linaro.org>
References: <20181005154910.3099-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 18/21] linux-user: allow dumping of plugin
 status at end of run
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel.Dovgaluk@ispras.ru, vilanova@ac.upc.edu, cota@braap.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

As we don't have a monitor in linux-user mode we need some way of
exporting our data to the world. We introduce a new -d option (plugin)
which turns on the existing LOG_TRACE flag which qemu_plugin_status()
will dump output to before we finally exit.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 linux-user/exit.c | 12 ++++++++++++
 util/log.c        |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/linux-user/exit.c b/linux-user/exit.c
index 14e94e28fa..2f9e016207 100644
--- a/linux-user/exit.c
+++ b/linux-user/exit.c
@@ -17,12 +17,23 @@
  *  along with this program; if not, see <http://www.gnu.org/licenses/>.
  */
 #include "qemu/osdep.h"
+#include "qemu/plugins.h"
 #include "qemu.h"
 
 #ifdef CONFIG_GCOV
 extern void __gcov_dump(void);
 #endif
 
+static void plugin_report(void)
+{
+#ifdef CONFIG_TRACE_PLUGIN
+    GString *plugin_report = qemu_plugin_status("");
+    qemu_log_mask(LOG_TRACE, "%s", plugin_report->str);
+    g_string_free(plugin_report, true);
+#endif
+}
+
+
 void preexit_cleanup(CPUArchState *env, int code)
 {
 #ifdef TARGET_GPROF
@@ -31,5 +42,6 @@ void preexit_cleanup(CPUArchState *env, int code)
 #ifdef CONFIG_GCOV
         __gcov_dump();
 #endif
+        plugin_report();
         gdb_exit(env, code);
 }
diff --git a/util/log.c b/util/log.c
index 5759bf571f..d4423277e0 100644
--- a/util/log.c
+++ b/util/log.c
@@ -288,6 +288,8 @@ const QEMULogItem qemu_log_items[] = {
     { CPU_LOG_TB_NOCHAIN, "nochain",
       "do not chain compiled TBs so that \"exec\" and \"cpu\" show\n"
       "complete traces" },
+    { LOG_TRACE, "plugin",
+      "show summary plugin information at end of run." },
     { 0, NULL, NULL },
 };
 
-- 
2.17.1
