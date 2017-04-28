Received: from eggs.gnu.org ([2001:4830:134:3::10]:55808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4CbB-0001zc-SR
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:34:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d4CbB-0001Mv-2k
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:34:41 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 28 Apr 2017 22:33:28 +0200
Message-Id: <1493411622-5343-21-git-send-email-kwolf@redhat.com>
In-Reply-To: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
References: <1493411622-5343-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 20/34] qemu-img/convert: Use @opts for one thing
 only
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

From: Max Reitz <mreitz@redhat.com>

After storing the creation options for the new image into @opts, we
fetch some things for our own information, like the backing file name,
or whether to use encryption or preallocation.

With the -n parameter, there will not be any creation options; this is
not too bad because this just means that querying a NULL @opts will
always return the default value.

However, we also use @opts for the --object options. Therefore, @opts is
not necessarily NULL if -n was specified; instead, it may contain those
options. In practice, this probably does not cause any problems because
there most likely is no object that supports any of the parameters we
query here, but this is neither something we should rely on nor does
this variable reuse make the code very nice to read.

Therefore, just use a separate variable for the --object options.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index b94fc11..e0503ae 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2049,13 +2049,15 @@ static int img_convert(int argc, char **argv)
         case 'W':
             s.wr_in_order = false;
             break;
-        case OPTION_OBJECT:
-            opts = qemu_opts_parse_noisily(&qemu_object_opts,
-                                           optarg, true);
-            if (!opts) {
+        case OPTION_OBJECT: {
+            QemuOpts *object_opts;
+            object_opts = qemu_opts_parse_noisily(&qemu_object_opts,
+                                                  optarg, true);
+            if (!object_opts) {
                 goto fail_getopt;
             }
             break;
+        }
         case OPTION_IMAGE_OPTS:
             image_opts = true;
             break;
-- 
1.8.3.1
