Received: from eggs.gnu.org ([2001:4830:134:3::10]:34762)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cfpkW-0008Eo-6K
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 10:19:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cfpkV-0007EV-C2
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 10:19:36 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 20 Feb 2017 15:19:18 +0000
Message-Id: <20170220151921.22842-2-berrange@redhat.com>
In-Reply-To: <20170220151921.22842-1-berrange@redhat.com>
References: <20170220151921.22842-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/4] qemu-img: add support for --object with
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
 qemu-img.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/qemu-img.c b/qemu-img.c
index cff22e3..739345e 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3951,6 +3951,7 @@ static int img_dd(int argc, char **argv)
     };
     const struct option long_options[] = {
         { "help", no_argument, 0, 'h'},
+        { "object", required_argument, 0, OPTION_OBJECT},
         { "image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
         { 0, 0, 0, 0 }
     };
@@ -3973,6 +3974,15 @@ static int img_dd(int argc, char **argv)
         case 'h':
             help();
             break;
+        case OPTION_OBJECT: {
+            QemuOpts *opts;
+            opts = qemu_opts_parse_noisily(&qemu_object_opts,
+                                           optarg, true);
+            if (!opts) {
+                ret = -1;
+                goto out;
+            }
+        }   break;
         case OPTION_IMAGE_OPTS:
             image_opts = true;
             break;
@@ -4017,6 +4027,14 @@ static int img_dd(int argc, char **argv)
         ret = -1;
         goto out;
     }
+
+    if (qemu_opts_foreach(&qemu_object_opts,
+                          user_creatable_add_opts_foreach,
+                          NULL, NULL)) {
+        ret = -1;
+        goto out;
+    }
+
     blk1 = img_open(image_opts, in.filename, fmt, 0, false, false);
 
     if (!blk1) {
-- 
2.9.3
