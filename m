Received: from eggs.gnu.org ([2001:4830:134:3::10]:45587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dFMGG-000138-HT
	for qemu-devel@nongnu.org; Mon, 29 May 2017 11:07:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dFMGF-0006R1-JG
	for qemu-devel@nongnu.org; Mon, 29 May 2017 11:07:12 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 29 May 2017 17:06:47 +0200
Message-Id: <1496070414-6744-9-git-send-email-kwolf@redhat.com>
In-Reply-To: <1496070414-6744-1-git-send-email-kwolf@redhat.com>
References: <1496070414-6744-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 08/15] qemu-img: add support for --object with
 'dd' command
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

The qemu-img dd command added --image-opts support, but missed
the corresponding --object support. This prevented passing
secrets (eg auth passwords) needed by certain disk images.

Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-id: 20170515164712.6643-2-berrange@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qemu-img.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/qemu-img.c b/qemu-img.c
index b506839..181f499 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4158,6 +4158,7 @@ static int img_dd(int argc, char **argv)
     };
     const struct option long_options[] = {
         { "help", no_argument, 0, 'h'},
+        { "object", required_argument, 0, OPTION_OBJECT},
         { "image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
         { "force-share", no_argument, 0, 'U'},
         { 0, 0, 0, 0 }
@@ -4186,6 +4187,15 @@ static int img_dd(int argc, char **argv)
         case 'U':
             force_share = true;
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
@@ -4230,6 +4240,14 @@ static int img_dd(int argc, char **argv)
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
     blk1 = img_open(image_opts, in.filename, fmt, 0, false, false,
                     force_share);
 
-- 
1.8.3.1
