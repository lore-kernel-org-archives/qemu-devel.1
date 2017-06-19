Received: from eggs.gnu.org ([2001:4830:134:3::10]:49702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dMyAL-0001C2-Dm
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 11:00:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dMyAH-0003qD-Gy
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 11:00:33 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 19 Jun 2017 16:00:02 +0100
Message-Id: <20170619150002.3033-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH] qemu-img: don't shadow opts variable in
 img_dd()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Reda Sallahi <fullmanet@gmail.com>

It's confusing when two different variables have the same name in one
function.

Cc: Reda Sallahi <fullmanet@gmail.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 qemu-img.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 0ad698d..c285c2f 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -4249,15 +4249,12 @@ static int img_dd(int argc, char **argv)
         case 'U':
             force_share = true;
             break;
-        case OPTION_OBJECT: {
-            QemuOpts *opts;
-            opts = qemu_opts_parse_noisily(&qemu_object_opts,
-                                           optarg, true);
-            if (!opts) {
+        case OPTION_OBJECT:
+            if (!qemu_opts_parse_noisily(&qemu_object_opts, optarg, true)) {
                 ret = -1;
                 goto out;
             }
-        }   break;
+            break;
         case OPTION_IMAGE_OPTS:
             image_opts = true;
             break;
-- 
2.9.4
