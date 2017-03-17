Received: from eggs.gnu.org ([2001:4830:134:3::10]:37228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1copOd-0000zU-8C
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 06:46:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1copOZ-0000T8-6e
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 06:46:11 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri, 17 Mar 2017 18:45:41 +0800
Message-Id: <20170317104541.28979-4-stefanha@redhat.com>
In-Reply-To: <20170317104541.28979-1-stefanha@redhat.com>
References: <20170317104541.28979-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/3] qemu-img: print short help on getopt
 failure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, mreitz@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>

Printing the full help output obscures the error message for an invalid
command-line option or missing argument.

Before this patch:

  $ ./qemu-img --foo
  ...pages of output...

After this patch:

  $ ./qemu-img --foo
  qemu-img: unrecognized option '--foo'
  Try 'qemu-img --help' for more information

This patch adds the getopt ':' character so that it can distinguish
between missing arguments and unrecognized options.  This helps provide
more detailed error messages.

Suggested-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 qemu-img.c | 117 ++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 97 insertions(+), 20 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index c7ffabb..b220cf7 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -88,6 +88,16 @@ static void QEMU_NORETURN GCC_FMT_ATTR(1, 2) error_exit(const char *fmt, ...)
     exit(EXIT_FAILURE);
 }
 
+static void QEMU_NORETURN missing_argument(const char *option)
+{
+    error_exit("missing argument for option '%s'", option);
+}
+
+static void QEMU_NORETURN unrecognized_option(const char *option)
+{
+    error_exit("unrecognized option '%s'", option);
+}
+
 /* Please keep in synch with qemu-img.texi */
 static void QEMU_NORETURN help(void)
 {
@@ -406,13 +416,18 @@ static int img_create(int argc, char **argv)
             {"object", required_argument, 0, OPTION_OBJECT},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, "F:b:f:he6o:q",
+        c = getopt_long(argc, argv, ":F:b:f:he6o:q",
                         long_options, NULL);
         if (c == -1) {
             break;
         }
         switch(c) {
+        case ':':
+            missing_argument(argv[optind - 1]);
+            break;
         case '?':
+            unrecognized_option(argv[optind - 1]);
+            break;
         case 'h':
             help();
             break;
@@ -651,13 +666,18 @@ static int img_check(int argc, char **argv)
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, "hf:r:T:q",
+        c = getopt_long(argc, argv, ":hf:r:T:q",
                         long_options, &option_index);
         if (c == -1) {
             break;
         }
         switch(c) {
+        case ':':
+            missing_argument(argv[optind - 1]);
+            break;
         case '?':
+            unrecognized_option(argv[optind - 1]);
+            break;
         case 'h':
             help();
             break;
@@ -855,13 +875,18 @@ static int img_commit(int argc, char **argv)
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, "f:ht:b:dpq",
+        c = getopt_long(argc, argv, ":f:ht:b:dpq",
                         long_options, NULL);
         if (c == -1) {
             break;
         }
         switch(c) {
+        case ':':
+            missing_argument(argv[optind - 1]);
+            break;
         case '?':
+            unrecognized_option(argv[optind - 1]);
+            break;
         case 'h':
             help();
             break;
@@ -1190,13 +1215,18 @@ static int img_compare(int argc, char **argv)
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, "hf:F:T:pqs",
+        c = getopt_long(argc, argv, ":hf:F:T:pqs",
                         long_options, NULL);
         if (c == -1) {
             break;
         }
         switch (c) {
+        case ':':
+            missing_argument(argv[optind - 1]);
+            break;
         case '?':
+            unrecognized_option(argv[optind - 1]);
+            break;
         case 'h':
             help();
             break;
@@ -1926,13 +1956,18 @@ static int img_convert(int argc, char **argv)
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, "hf:O:B:ce6o:s:l:S:pt:T:qnm:W",
+        c = getopt_long(argc, argv, ":hf:O:B:ce6o:s:l:S:pt:T:qnm:W",
                         long_options, NULL);
         if (c == -1) {
             break;
         }
         switch(c) {
+        case ':':
+            missing_argument(argv[optind - 1]);
+            break;
         case '?':
+            unrecognized_option(argv[optind - 1]);
+            break;
         case 'h':
             help();
             break;
@@ -2502,13 +2537,18 @@ static int img_info(int argc, char **argv)
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, "f:h",
+        c = getopt_long(argc, argv, ":f:h",
                         long_options, &option_index);
         if (c == -1) {
             break;
         }
         switch(c) {
+        case ':':
+            missing_argument(argv[optind - 1]);
+            break;
         case '?':
+            unrecognized_option(argv[optind - 1]);
+            break;
         case 'h':
             help();
             break;
@@ -2713,13 +2753,18 @@ static int img_map(int argc, char **argv)
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, "f:h",
+        c = getopt_long(argc, argv, ":f:h",
                         long_options, &option_index);
         if (c == -1) {
             break;
         }
         switch (c) {
+        case ':':
+            missing_argument(argv[optind - 1]);
+            break;
         case '?':
+            unrecognized_option(argv[optind - 1]);
+            break;
         case 'h':
             help();
             break;
@@ -2835,13 +2880,18 @@ static int img_snapshot(int argc, char **argv)
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, "la:c:d:hq",
+        c = getopt_long(argc, argv, ":la:c:d:hq",
                         long_options, NULL);
         if (c == -1) {
             break;
         }
         switch(c) {
+        case ':':
+            missing_argument(argv[optind - 1]);
+            break;
         case '?':
+            unrecognized_option(argv[optind - 1]);
+            break;
         case 'h':
             help();
             return 0;
@@ -2988,13 +3038,18 @@ static int img_rebase(int argc, char **argv)
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, "hf:F:b:upt:T:q",
+        c = getopt_long(argc, argv, ":hf:F:b:upt:T:q",
                         long_options, NULL);
         if (c == -1) {
             break;
         }
         switch(c) {
+        case ':':
+            missing_argument(argv[optind - 1]);
+            break;
         case '?':
+            unrecognized_option(argv[optind - 1]);
+            break;
         case 'h':
             help();
             return 0;
@@ -3355,13 +3410,18 @@ static int img_resize(int argc, char **argv)
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, "f:hq",
+        c = getopt_long(argc, argv, ":f:hq",
                         long_options, NULL);
         if (c == -1) {
             break;
         }
         switch(c) {
+        case ':':
+            missing_argument(argv[optind - 1]);
+            break;
         case '?':
+            unrecognized_option(argv[optind - 1]);
+            break;
         case 'h':
             help();
             break;
@@ -3493,15 +3553,20 @@ static int img_amend(int argc, char **argv)
             {"image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, "ho:f:t:pq",
+        c = getopt_long(argc, argv, ":ho:f:t:pq",
                         long_options, NULL);
         if (c == -1) {
             break;
         }
 
         switch (c) {
-        case 'h':
+        case ':':
+            missing_argument(argv[optind - 1]);
+            break;
         case '?':
+            unrecognized_option(argv[optind - 1]);
+            break;
+        case 'h':
             help();
             break;
         case 'o':
@@ -3759,14 +3824,19 @@ static int img_bench(int argc, char **argv)
             {"no-drain", no_argument, 0, OPTION_NO_DRAIN},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, "hc:d:f:no:qs:S:t:w", long_options, NULL);
+        c = getopt_long(argc, argv, ":hc:d:f:no:qs:S:t:w", long_options, NULL);
         if (c == -1) {
             break;
         }
 
         switch (c) {
-        case 'h':
+        case ':':
+            missing_argument(argv[optind - 1]);
+            break;
         case '?':
+            unrecognized_option(argv[optind - 1]);
+            break;
+        case 'h':
             help();
             break;
         case 'c':
@@ -4093,7 +4163,7 @@ static int img_dd(int argc, char **argv)
         { 0, 0, 0, 0 }
     };
 
-    while ((c = getopt_long(argc, argv, "hf:O:", long_options, NULL))) {
+    while ((c = getopt_long(argc, argv, ":hf:O:", long_options, NULL))) {
         if (c == EOF) {
             break;
         }
@@ -4104,10 +4174,12 @@ static int img_dd(int argc, char **argv)
         case 'f':
             fmt = optarg;
             break;
+        case ':':
+            missing_argument(argv[optind - 1]);
+            break;
         case '?':
-            error_report("Try 'qemu-img --help' for more information.");
-            ret = -1;
-            goto out;
+            unrecognized_option(argv[optind - 1]);
+            break;
         case 'h':
             help();
             break;
@@ -4336,10 +4408,15 @@ int main(int argc, char **argv)
     qemu_add_opts(&qemu_source_opts);
     qemu_add_opts(&qemu_trace_opts);
 
-    while ((c = getopt_long(argc, argv, "+hVT:", long_options, NULL)) != -1) {
+    while ((c = getopt_long(argc, argv, "+:hVT:", long_options, NULL)) != -1) {
         switch (c) {
-        case 'h':
+        case ':':
+            missing_argument(argv[optind - 1]);
+            return 0;
         case '?':
+            unrecognized_option(argv[optind - 1]);
+            return 0;
+        case 'h':
             help();
             return 0;
         case 'V':
-- 
2.9.3
