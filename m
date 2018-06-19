Received: from eggs.gnu.org ([2001:4830:134:3::10]:46916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5jQ-0002z2-V8
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:46:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fV5jQ-0000nU-0n
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 21:46:53 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 18 Jun 2018 20:42:39 -0500
Message-Id: <20180619014319.28272-74-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
References: <20180619014319.28272-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 073/113] qemu-img: Use only string options in
 img_open_opts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Max Reitz <mreitz@redhat.com>

From: Max Reitz <mreitz@redhat.com>

img_open_opts() takes a QemuOpts and converts them to a QDict, so all
values therein are strings.  Then it may try to call qdict_get_bool(),
however, which will fail with a segmentation fault every time:

$ ./qemu-img info -U --image-opts \
    driver=file,filename=/dev/null,force-share=off
[1]    27869 segmentation fault (core dumped)  ./qemu-img info -U
--image-opts driver=file,filename=/dev/null,force-share=off

Fix this by using qdict_get_str() and comparing the value as a string.
Also, when adding a force-share value to the QDict, add it as a string
so it fits the rest of the dict.

Cc: qemu-stable@nongnu.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20180502202051.15493-3-mreitz@redhat.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
(cherry picked from commit 4615f87832d2fcb7a544bedeece2741bf8c21f94)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qemu-img.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 03da42dae2..86060aab71 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -276,12 +276,12 @@ static BlockBackend *img_open_opts(const char *optstr,
     options = qemu_opts_to_qdict(opts, NULL);
     if (force_share) {
         if (qdict_haskey(options, BDRV_OPT_FORCE_SHARE)
-            && !qdict_get_bool(options, BDRV_OPT_FORCE_SHARE)) {
+            && strcmp(qdict_get_str(options, BDRV_OPT_FORCE_SHARE), "on")) {
             error_report("--force-share/-U conflicts with image options");
             QDECREF(options);
             return NULL;
         }
-        qdict_put_bool(options, BDRV_OPT_FORCE_SHARE, true);
+        qdict_put_str(options, BDRV_OPT_FORCE_SHARE, "on");
     }
     blk = blk_new_open(NULL, NULL, options, flags, &local_err);
     if (!blk) {
-- 
2.11.0
