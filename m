Received: from eggs.gnu.org ([2001:4830:134:3::10]:55268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cOSRm-0002cH-Je
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 12:00:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cOSRh-0005Bw-Rf
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 12:00:26 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue,  3 Jan 2017 17:00:10 +0000
Message-Id: <20170103170010.25905-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH] qemu-img: add support for --object with 'dd'
 command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>

The qemu-img dd command added --image-opts support, but missed
the corresponding --object support. This prevented passing
secrets (eg auth passwords) needed by certain disk images.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 qemu-img.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/qemu-img.c b/qemu-img.c
index 6949b73..138e37b 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3948,6 +3948,7 @@ static int img_dd(int argc, char **argv)
     };
     const struct option long_options[] = {
         { "help", no_argument, 0, 'h'},
+        { "object", required_argument, 0, OPTION_OBJECT},
         { "image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
         { 0, 0, 0, 0 }
     };
@@ -3970,6 +3971,14 @@ static int img_dd(int argc, char **argv)
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
@@ -4014,6 +4023,13 @@ static int img_dd(int argc, char **argv)
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
