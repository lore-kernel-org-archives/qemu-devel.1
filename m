Received: from eggs.gnu.org ([2001:4830:134:3::10]:60034)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDyFV-0003TV-L3
	for qemu-devel@nongnu.org; Wed, 02 May 2018 16:21:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fDyFU-0005OD-Je
	for qemu-devel@nongnu.org; Wed, 02 May 2018 16:21:13 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  2 May 2018 22:20:50 +0200
Message-Id: <20180502202051.15493-3-mreitz@redhat.com>
In-Reply-To: <20180502202051.15493-1-mreitz@redhat.com>
References: <20180502202051.15493-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 2/3] qemu-img: Use only string options in
 img_open_opts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-stable@nongnu.org

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
---
 qemu-img.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 855fa52514..42b60917b0 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -277,12 +277,12 @@ static BlockBackend *img_open_opts(const char *optstr,
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
2.14.3
