Received: from eggs.gnu.org ([2001:4830:134:3::10]:40656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhID-0001O4-EE
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:18:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhIC-0002Oz-G5
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:18:53 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:16:23 -0500
Message-Id: <20180723201748.25573-15-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 14/99] qemu-io: Use purely string blockdev
 options
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

Currently, qemu-io only uses string-valued blockdev options (as all are
converted directly from QemuOpts) -- with one exception: -U adds the
force-share option as a boolean.  This in itself is already a bit
questionable, but a real issue is that it also assumes the value already
existing in the options QDict would be a boolean, which is wrong.

That has the following effect:

$ ./qemu-io -r -U --image-opts \
    driver=file,filename=/dev/null,force-share=off
[1]    15200 segmentation fault (core dumped)  ./qemu-io -r -U
--image-opts driver=file,filename=/dev/null,force-share=off

Since @opts is converted from QemuOpts, the value must be a string, and
we have to compare it as such.  Consequently, it makes sense to also set
it as a string instead of a boolean.

Cc: qemu-stable@nongnu.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20180502202051.15493-2-mreitz@redhat.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
(cherry picked from commit 2a01c01f9ecb43af4c0a85fe6adc429ffc9c31b5)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qemu-io.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/qemu-io.c b/qemu-io.c
index e692c555e0..0755a30447 100644
--- a/qemu-io.c
+++ b/qemu-io.c
@@ -95,12 +95,12 @@ static int openfile(char *name, int flags, bool writethrough, bool force_share,
             opts = qdict_new();
         }
         if (qdict_haskey(opts, BDRV_OPT_FORCE_SHARE)
-            && !qdict_get_bool(opts, BDRV_OPT_FORCE_SHARE)) {
+            && strcmp(qdict_get_str(opts, BDRV_OPT_FORCE_SHARE), "on")) {
             error_report("-U conflicts with image options");
             QDECREF(opts);
             return 1;
         }
-        qdict_put_bool(opts, BDRV_OPT_FORCE_SHARE, true);
+        qdict_put_str(opts, BDRV_OPT_FORCE_SHARE, "on");
     }
     qemuio_blk = blk_new_open(name, NULL, opts, flags, &local_err);
     if (!qemuio_blk) {
-- 
2.17.1
