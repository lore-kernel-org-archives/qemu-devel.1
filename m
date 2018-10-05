Received: from eggs.gnu.org ([2001:4830:134:3::10]:56826)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8SM9-0006ZC-EN
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g8SM7-0006B4-Na
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:33 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54217)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g8SM7-00060v-Ci
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 11:49:31 -0400
Received: by mail-wm1-x344.google.com with SMTP id b19-v6so2315953wme.3
	for <qemu-devel@nongnu.org>; Fri, 05 Oct 2018 08:49:16 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri,  5 Oct 2018 16:48:52 +0100
Message-Id: <20181005154910.3099-4-alex.bennee@linaro.org>
In-Reply-To: <20181005154910.3099-1-alex.bennee@linaro.org>
References: <20181005154910.3099-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 03/21] linux-user: add -dfilter progtext
 shortcut
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

When debugging you often don't care about the libraries but just the
code in the testcase. Rather than make the user build this by hand
offer a shortcut.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 linux-user/main.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/linux-user/main.c b/linux-user/main.c
index 923cbb753a..a68674d0de 100644
--- a/linux-user/main.c
+++ b/linux-user/main.c
@@ -28,6 +28,7 @@
 #include "qemu/config-file.h"
 #include "qemu/cutils.h"
 #include "qemu/help_option.h"
+#include "qemu/range.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "tcg.h"
@@ -51,6 +52,8 @@ unsigned long mmap_min_addr;
 unsigned long guest_base;
 int have_guest_base;
 
+static bool dfilter_progtext;
+
 /*
  * When running 32-on-64 we should make sure we can fit all of the possible
  * guest address space into a contiguous chunk of virtual host memory.
@@ -222,6 +225,11 @@ static void handle_arg_log(const char *arg)
 
 static void handle_arg_dfilter(const char *arg)
 {
+    if (strcmp(arg, "progtext") == 0) {
+        dfilter_progtext = true;
+        return;
+    }
+
     qemu_set_dfilter_ranges(arg, NULL);
 }
 
@@ -423,7 +431,7 @@ static const struct qemu_argument arg_table[] = {
      "item[,...]", "enable logging of specified items "
      "(use '-d help' for a list of items)"},
     {"dfilter",    "QEMU_DFILTER",     true,  handle_arg_dfilter,
-     "range[,...]","filter logging based on address range"},
+     "range|progtext[,...]", "filter logging based on address range"},
     {"D",          "QEMU_LOG_FILENAME", true, handle_arg_log_filename,
      "logfile",     "write logs to 'logfile' (default stderr)"},
     {"p",          "QEMU_PAGESIZE",    true,  handle_arg_pagesize,
@@ -796,6 +804,12 @@ int main(int argc, char **argv, char **envp)
         qemu_log("auxv_start  0x" TARGET_ABI_FMT_lx "\n", info->saved_auxv);
     }
 
+    if (dfilter_progtext) {
+        Range r;
+        range_set_bounds(&r, info->start_code, info->end_code);
+        qemu_append_dfilter_range(r, NULL);
+    }
+
     target_set_brk(info->brk);
     syscall_init();
     signal_init();
-- 
2.17.1
