Received: from eggs.gnu.org ([2001:4830:134:3::10]:48445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cZcbX-0003Bx-4F
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 07:04:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cZcbT-0001qh-NJ
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 07:04:39 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  3 Feb 2017 12:02:49 +0000
Message-Id: <20170203120254.15062-2-berrange@redhat.com>
In-Reply-To: <20170203120254.15062-1-berrange@redhat.com>
References: <20170203120254.15062-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/6] qemu-img: add support for --object with
 'dd' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The qemu-img dd command added --image-opts support, but missed
the corresponding --object support. This prevented passing
secrets (eg auth passwords) needed by certain disk images.

Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 qemu-img.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/qemu-img.c b/qemu-img.c
index 74e3362..391a141 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3949,6 +3949,7 @@ static int img_dd(int argc, char **argv)
     };
     const struct option long_options[] = {
         { "help", no_argument, 0, 'h'},
+        { "object", required_argument, 0, OPTION_OBJECT},
         { "image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
         { 0, 0, 0, 0 }
     };
@@ -3971,6 +3972,14 @@ static int img_dd(int argc, char **argv)
         case 'h':
             help();
             break;
+        case OPTION_OBJECT: {
+            QemuOpts *opts;
+            opts = qemu_opts_parse_noisily(&qemu_object_opts,
+                                           optarg, true);
+            if (!opts) {
+                return 1;
+            }
+        }   break;
         case OPTION_IMAGE_OPTS:
             image_opts = true;
             break;
@@ -4015,6 +4024,13 @@ static int img_dd(int argc, char **argv)
         ret = -1;
         goto out;
     }
+
+    if (qemu_opts_foreach(&qemu_object_opts,
+                          user_creatable_add_opts_foreach,
+                          NULL, NULL)) {
+        return 1;
+    }
+
     blk1 = img_open(image_opts, in.filename, fmt, 0, false, false);
 
     if (!blk1) {
-- 
2.9.3
