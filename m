Received: from eggs.gnu.org ([2001:4830:134:3::10]:56888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8SMA-0006aK-5P
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8SM8-0006Cb-Ia
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:34 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:43510)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g8SM8-00064t-2g
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:32 -0400
Received: by mail-wr1-x42a.google.com with SMTP id n1-v6so14043033wrt.10
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 08:49:22 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  5 Oct 2018 16:48:58 +0100
Message-Id: <20181005154910.3099-10-alex.bennee@linaro.org>
In-Reply-To: <20181005154910.3099-1-alex.bennee@linaro.org>
References: <20181005154910.3099-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 09/21] trace: suppress log output of trace
 points
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel.Dovgaluk@ispras.ru, vilanova@ac.upc.edu, cota@braap.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>

When multiple tracers are enabled and you want to save to binary we
shouldn't assume the user also wants to spam the log. They can always
override it manually if they want.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 util/log.c |  3 ---
 vl.c       | 18 ++++++++++++++++--
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/util/log.c b/util/log.c
index cc79a146d1..5759bf571f 100644
--- a/util/log.c
+++ b/util/log.c
@@ -56,9 +56,6 @@ static bool log_uses_own_buffers;
 void qemu_set_log(int log_flags)
 {
     qemu_loglevel = log_flags;
-#ifdef CONFIG_TRACE_LOG
-    qemu_loglevel |= LOG_TRACE;
-#endif
     if (!qemu_logfile &&
         (is_daemonized() ? logfilename != NULL : qemu_loglevel)) {
         if (logfilename) {
diff --git a/vl.c b/vl.c
index a867c9c4d9..795e025445 100644
--- a/vl.c
+++ b/vl.c
@@ -2908,6 +2908,7 @@ int main(int argc, char **argv, char **envp)
     Error *err = NULL;
     bool list_data_dirs = false;
     char *dir, **dirs;
+    int maybe_log_trace = 0;
     typedef struct BlockdevOptions_queue {
         BlockdevOptions *bdo;
         Location loc;
@@ -3985,6 +3986,19 @@ int main(int argc, char **argv, char **envp)
     }
     trace_init_file(trace_file);
 
+#if defined(CONFIG_TRACE_SIMPLE) && defined(CONFIG_TRACE_LOG)
+    /* If the user has both log and simple tracing enabled but hasn't
+     * defined a binary trace file ensure we enable the right logging
+     * flags.
+     */
+    if (!trace_file) {
+        maybe_log_trace = LOG_TRACE;
+    }
+#elif defined CONFIG_TRACE_LOG
+    /* with just CONFIG_TRACE_LOG we enable unconditionally */
+    maybe_log_trace = LOG_TRACE;
+#endif
+
     /* Open the logfile at this point and set the log mask if necessary.
      */
     if (log_file) {
@@ -3998,9 +4012,9 @@ int main(int argc, char **argv, char **envp)
             qemu_print_log_usage(stdout);
             exit(1);
         }
-        qemu_set_log(mask);
+        qemu_set_log(mask | maybe_log_trace);
     } else {
-        qemu_set_log(0);
+        qemu_set_log(maybe_log_trace);
     }
 
     /* add configured firmware directories */
-- 
2.17.1
