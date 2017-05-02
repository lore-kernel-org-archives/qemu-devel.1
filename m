Received: from eggs.gnu.org ([2001:4830:134:3::10]:53784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d5Z6P-0006js-Ex
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:48:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d5Z6L-0002vu-FO
	for qemu-devel@nongnu.org; Tue, 02 May 2017 10:48:33 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue,  2 May 2017 15:47:41 +0100
Message-Id: <20170502144744.26815-2-berrange@redhat.com>
In-Reply-To: <20170502144744.26815-1-berrange@redhat.com>
References: <20170502144744.26815-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v7 1/4] qemu-img: add support for --object with
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
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

The qemu-img dd command added --image-opts support, but missed
the corresponding --object support. This prevented passing
secrets (eg auth passwords) needed by certain disk images.

Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 qemu-img.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/qemu-img.c b/qemu-img.c
index c719636..34f49c2 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4086,6 +4086,7 @@ static int img_dd(int argc, char **argv)
     };
     const struct option long_options[] = {
         { "help", no_argument, 0, 'h'},
+        { "object", required_argument, 0, OPTION_OBJECT},
         { "image-opts", no_argument, 0, OPTION_IMAGE_OPTS},
         { 0, 0, 0, 0 }
     };
@@ -4110,6 +4111,15 @@ static int img_dd(int argc, char **argv)
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
@@ -4154,6 +4164,14 @@ static int img_dd(int argc, char **argv)
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
