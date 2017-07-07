Received: from eggs.gnu.org ([2001:4830:134:3::10]:41589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWl8-0004vs-8E
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:09:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dTWl7-0007qP-4g
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 13:09:38 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Jul 2017 19:07:33 +0200
Message-Id: <1499447335-6125-19-git-send-email-kwolf@redhat.com>
In-Reply-To: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
References: <1499447335-6125-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 018/100] qemu-img: drop -e and -6 options from
 the 'create' & 'convert' commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: "Daniel P. Berrange" <berrange@redhat.com>

The '-e' and '-6' options to the 'create' & 'convert' commands were
"deprecated" in favour of the more generic '-o' option many years ago:

  commit eec77d9e712bd4157a4e1c0b5a9249d168add738
  Author: Jes Sorensen <Jes.Sorensen@redhat.com>
  Date:   Tue Dec 7 17:44:34 2010 +0100

    qemu-img: Deprecate obsolete -6 and -e options

Except this was never actually a deprecation, which would imply giving
the user a warning while the functionality continues to work for a
number of releases before eventual removal. Instead the options were
immediately turned into an error + exit. Given that the functionality
is already broken, there's no point in keeping these psuedo-deprecation
messages around any longer.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 91ad6be..c5f00db 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -464,7 +464,7 @@ static int img_create(int argc, char **argv)
             {"object", required_argument, 0, OPTION_OBJECT},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":F:b:f:he6o:q",
+        c = getopt_long(argc, argv, ":F:b:f:ho:q",
                         long_options, NULL);
         if (c == -1) {
             break;
@@ -488,14 +488,6 @@ static int img_create(int argc, char **argv)
         case 'f':
             fmt = optarg;
             break;
-        case 'e':
-            error_report("option -e is deprecated, please use \'-o "
-                  "encryption\' instead!");
-            goto fail;
-        case '6':
-            error_report("option -6 is deprecated, please use \'-o "
-                  "compat6\' instead!");
-            goto fail;
         case 'o':
             if (!is_valid_option_list(optarg)) {
                 error_report("Invalid option list: %s", optarg);
@@ -1985,7 +1977,7 @@ static int img_convert(int argc, char **argv)
             {"target-image-opts", no_argument, 0, OPTION_TARGET_IMAGE_OPTS},
             {0, 0, 0, 0}
         };
-        c = getopt_long(argc, argv, ":hf:O:B:ce6o:s:l:S:pt:T:qnm:WU",
+        c = getopt_long(argc, argv, ":hf:O:B:co:s:l:S:pt:T:qnm:WU",
                         long_options, NULL);
         if (c == -1) {
             break;
@@ -2012,14 +2004,6 @@ static int img_convert(int argc, char **argv)
         case 'c':
             s.compressed = true;
             break;
-        case 'e':
-            error_report("option -e is deprecated, please use \'-o "
-                  "encryption\' instead!");
-            goto fail_getopt;
-        case '6':
-            error_report("option -6 is deprecated, please use \'-o "
-                  "compat6\' instead!");
-            goto fail_getopt;
         case 'o':
             if (!is_valid_option_list(optarg)) {
                 error_report("Invalid option list: %s", optarg);
-- 
1.8.3.1
