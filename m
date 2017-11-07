Received: from eggs.gnu.org ([2001:4830:134:3::10]:34683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eC5SC-0005nD-Qs
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:06:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eC5S9-0008SY-AQ
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:06:16 -0500
Received: from mail-wm0-x241.google.com ([2a00:1450:400c:c09::241]:49140)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eC5S9-0008Rh-4Q
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 10:06:13 -0500
Received: by mail-wm0-x241.google.com with SMTP id p75so4402192wmg.3
	for <qemu-devel@nongnu.org>; Tue, 07 Nov 2017 07:06:13 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  7 Nov 2017 15:05:50 +0000
Message-Id: <20171107150558.22131-3-alex.bennee@linaro.org>
In-Reply-To: <20171107150558.22131-1-alex.bennee@linaro.org>
References: <20171107150558.22131-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RISU PATCH 02/10] risu.c: split out setting up options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: Dave.Martin@arm.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This is a prerequisite to properly handling architecture specific
options.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 risu.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/risu.c b/risu.c
index 47471c6..a5d155d 100644
--- a/risu.c
+++ b/risu.c
@@ -282,6 +282,21 @@ void usage(void)
             "(default 9191)\n");
 }
 
+struct option * setup_options(char **short_opts)
+{
+    static struct option default_longopts[] = {
+        {"help", no_argument, 0, '?'},
+        {"master", no_argument, &ismaster, 1},
+        {"host", required_argument, 0, 'h'},
+        {"port", required_argument, 0, 'p'},
+        {"test-fp-exc", no_argument, &test_fp_exc, 1},
+        {0, 0, 0, 0}
+    };
+
+    *short_opts = "h:p:t:";
+    return default_longopts;
+}
+
 int main(int argc, char **argv)
 {
     /* some handy defaults to make testing easier */
@@ -289,20 +304,14 @@ int main(int argc, char **argv)
     char *hostname = "localhost";
     char *imgfile;
     char *trace_fn = NULL;
+    struct option *longopts;
+    char *shortopts;
 
-    /* TODO clean this up later */
+    longopts = setup_options(&shortopts);
 
     for (;;) {
-        static struct option longopts[] = {
-            {"help", no_argument, 0, '?'},
-            {"master", no_argument, &ismaster, 1},
-            {"host", required_argument, 0, 'h'},
-            {"port", required_argument, 0, 'p'},
-            {"test-fp-exc", no_argument, &test_fp_exc, 1},
-            {0, 0, 0, 0}
-        };
         int optidx = 0;
-        int c = getopt_long(argc, argv, "h:p:t:", longopts, &optidx);
+        int c = getopt_long(argc, argv, shortopts, longopts, &optidx);
         if (c == -1) {
             break;
         }
-- 
2.14.2
