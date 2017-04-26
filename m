Received: from eggs.gnu.org ([2001:4830:134:3::10]:49608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d3NHb-0001Vf-Sd
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:47:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d3NHV-0002Ki-VW
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 09:47:03 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 26 Apr 2017 15:46:47 +0200
Message-Id: <20170426134649.9042-2-mreitz@redhat.com>
In-Reply-To: <20170426134649.9042-1-mreitz@redhat.com>
References: <20170426134649.9042-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/3] qemu-img/convert: Use @opts for one
 thing only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

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

Therefore, just use an own variable for the --object options.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 qemu-img.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index b2c4dc9613..ae6f27f899 100644
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
2.12.2
