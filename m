Received: from eggs.gnu.org ([2001:4830:134:3::10]:38972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdaJV-0005vS-5D
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cdaJT-0003SR-PX
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 05:26:25 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 14 Feb 2017 11:26:07 +0100
Message-Id: <1487067971-10443-21-git-send-email-armbru@redhat.com>
In-Reply-To: <1487067971-10443-1-git-send-email-armbru@redhat.com>
References: <1487067971-10443-1-git-send-email-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH 20/24] qemu-img: Wrap cvtnum() around
 qemu_strtosz()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qemu-img.c | 58 +++++++++++++++++++++++++++++++---------------------------
 1 file changed, 31 insertions(+), 27 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 4407244..2a47966 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -368,6 +368,19 @@ static int add_old_style_options(const char *fmt, QemuOpts *opts,
     return 0;
 }
 
+static int64_t cvtnum(const char *s)
+{
+    char *end;
+    int64_t ret;
+
+    ret = qemu_strtosz(s, &end);
+    if (*end != '\0') {
+        /* Detritus at the end of the string */
+        return -EINVAL;
+    }
+    return ret;
+}
+
 static int img_create(int argc, char **argv)
 {
     int c;
@@ -461,9 +474,9 @@ static int img_create(int argc, char **argv)
     /* Get image size, if specified */
     if (optind < argc) {
         int64_t sval;
-        char *end;
-        sval = qemu_strtosz(argv[optind++], &end);
-        if (sval < 0 || *end) {
+
+        sval = cvtnum(argv[optind++]);
+        if (sval < 0) {
             if (sval == -ERANGE) {
                 error_report("Image size must be less than 8 EiB!");
             } else {
@@ -1861,9 +1874,9 @@ static int img_convert(int argc, char **argv)
         case 'S':
         {
             int64_t sval;
-            char *end;
-            sval = qemu_strtosz(optarg, &end);
-            if (sval < 0 || *end) {
+
+            sval = cvtnum(optarg);
+            if (sval < 0) {
                 error_report("Invalid minimum zero buffer size for sparse output specified");
                 ret = -1;
                 goto fail_getopt;
@@ -3648,10 +3661,8 @@ static int img_bench(int argc, char **argv)
             break;
         case 'o':
         {
-            char *end;
-            errno = 0;
-            offset = qemu_strtosz(optarg, &end);
-            if (offset < 0|| *end) {
+            offset = cvtnum(optarg);
+            if (offset < 0) {
                 error_report("Invalid offset specified");
                 return 1;
             }
@@ -3664,10 +3675,9 @@ static int img_bench(int argc, char **argv)
         case 's':
         {
             int64_t sval;
-            char *end;
 
-            sval = qemu_strtosz(optarg, &end);
-            if (sval < 0 || sval > INT_MAX || *end) {
+            sval = cvtnum(optarg);
+            if (sval < 0 || sval > INT_MAX) {
                 error_report("Invalid buffer size specified");
                 return 1;
             }
@@ -3678,10 +3688,9 @@ static int img_bench(int argc, char **argv)
         case 'S':
         {
             int64_t sval;
-            char *end;
 
-            sval = qemu_strtosz(optarg, &end);
-            if (sval < 0 || sval > INT_MAX || *end) {
+            sval = cvtnum(optarg);
+            if (sval < 0 || sval > INT_MAX) {
                 error_report("Invalid step size specified");
                 return 1;
             }
@@ -3840,12 +3849,11 @@ static int img_dd_bs(const char *arg,
                      struct DdIo *in, struct DdIo *out,
                      struct DdInfo *dd)
 {
-    char *end;
     int64_t res;
 
-    res = qemu_strtosz(arg, &end);
+    res = cvtnum(arg);
 
-    if (res <= 0 || res > INT_MAX || *end) {
+    if (res <= 0 || res > INT_MAX) {
         error_report("invalid number: '%s'", arg);
         return 1;
     }
@@ -3858,11 +3866,9 @@ static int img_dd_count(const char *arg,
                         struct DdIo *in, struct DdIo *out,
                         struct DdInfo *dd)
 {
-    char *end;
+    dd->count = cvtnum(arg);
 
-    dd->count = qemu_strtosz(arg, &end);
-
-    if (dd->count < 0 || *end) {
+    if (dd->count < 0) {
         error_report("invalid number: '%s'", arg);
         return 1;
     }
@@ -3892,11 +3898,9 @@ static int img_dd_skip(const char *arg,
                        struct DdIo *in, struct DdIo *out,
                        struct DdInfo *dd)
 {
-    char *end;
+    in->offset = cvtnum(arg);
 
-    in->offset = qemu_strtosz(arg, &end);
-
-    if (in->offset < 0 || *end) {
+    if (in->offset < 0) {
         error_report("invalid number: '%s'", arg);
         return 1;
     }
-- 
2.7.4
