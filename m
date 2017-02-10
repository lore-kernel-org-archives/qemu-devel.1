Received: from eggs.gnu.org ([2001:4830:134:3::10]:51825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ccE95-0002F0-Sj
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 11:34:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1ccE94-0005hW-Pt
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 11:34:03 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48468)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1ccE94-0005hE-II
	for qemu-devel@nongnu.org; Fri, 10 Feb 2017 11:34:02 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Feb 2017 16:28:23 +0000
Message-Id: <1486744104-15590-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1486744104-15590-1-git-send-email-peter.maydell@linaro.org>
References: <1486744104-15590-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 1/2] qemu-img: Use qemu_strtoul() rather than
 raw strtoul()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Some of the argument parsing in qemu-img uses strtoul() to parse
integer arguments.  This is tricky to get correct and in fact the
code does not get it right, because it assigns the result of
strtoul() to an 'int' variable and then tries to check for > INT_MAX.
Coverity correctly complains that the comparison is always false.

Rewrite to use qemu_strtoul(), which has a saner convention for
reporting conversion failures.

(Fixes CID 1356421, CID 1356422, CID 1356423.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 qemu-img.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 74e3362..aa71588 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3621,24 +3621,24 @@ static int img_bench(int argc, char **argv)
             break;
         case 'c':
         {
-            char *end;
-            errno = 0;
-            count = strtoul(optarg, &end, 0);
-            if (errno || *end || count > INT_MAX) {
+            unsigned long res;
+
+            if (qemu_strtoul(optarg, NULL, 0, &res) < 0 || res > INT_MAX) {
                 error_report("Invalid request count specified");
                 return 1;
             }
+            count = res;
             break;
         }
         case 'd':
         {
-            char *end;
-            errno = 0;
-            depth = strtoul(optarg, &end, 0);
-            if (errno || *end || depth > INT_MAX) {
+            unsigned long res;
+
+            if (qemu_strtoul(optarg, NULL, 0, &res) < 0 || res > INT_MAX) {
                 error_report("Invalid queue depth specified");
                 return 1;
             }
+            depth = res;
             break;
         }
         case 'f':
@@ -3705,24 +3705,24 @@ static int img_bench(int argc, char **argv)
             break;
         case OPTION_PATTERN:
         {
-            char *end;
-            errno = 0;
-            pattern = strtoul(optarg, &end, 0);
-            if (errno || *end || pattern > 0xff) {
+            unsigned long res;
+
+            if (qemu_strtoul(optarg, NULL, 0, &res) < 0 || res > 0xff) {
                 error_report("Invalid pattern byte specified");
                 return 1;
             }
+            pattern = res;
             break;
         }
         case OPTION_FLUSH_INTERVAL:
         {
-            char *end;
-            errno = 0;
-            flush_interval = strtoul(optarg, &end, 0);
-            if (errno || *end || flush_interval > INT_MAX) {
+            unsigned long res;
+
+            if (qemu_strtoul(optarg, NULL, 0, &res) < 0 || res > INT_MAX) {
                 error_report("Invalid flush interval specified");
                 return 1;
             }
+            flush_interval = res;
             break;
         }
         case OPTION_NO_DRAIN:
-- 
2.7.4
