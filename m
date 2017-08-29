Received: from eggs.gnu.org ([2001:4830:134:3::10]:48134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCV-0001Ku-Sq
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCS-0005VD-LI
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:15 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53332
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCS-0005Ue-GS
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:12 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0E9gk081527
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:12 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cmurncrp0-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:16:11 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 20:16:11 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:14:16 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-42-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 41/79] blkdebug: Simplify override logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>

From: Eric Blake <eblake@redhat.com>

Rather than store into a local variable, then copy to the struct
if the value is valid, then reporting errors otherwise, it is
simpler to just store into the struct and report errors if the
value is invalid.  This however requires that the struct store
a 64-bit number, rather than a narrower type.  Likewise, setting
a sane errno value in ret prior to the sequence of parsing and
jumping to out: on error makes it easier for the next patch to
add a chain of similar checks.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-id: 20170429191419.30051-8-eblake@redhat.com
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
(cherry picked from commit 3dc834f8795a46f919d90b1e5369308628858601)
* prereq for 81c219a
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/blkdebug.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index a3dc5f6..2b934ef 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -38,7 +38,7 @@
 typedef struct BDRVBlkdebugState {
     int state;
     int new_state;
-    int align;
+    uint64_t align;
 
     /* For blkdebug_refresh_filename() */
     char *config_file;
@@ -353,7 +353,6 @@ static int blkdebug_open(BlockDriverState *bs, QDict *options, int flags,
     BDRVBlkdebugState *s = bs->opaque;
     QemuOpts *opts;
     Error *local_err = NULL;
-    uint64_t align;
     int ret;
 
     opts = qemu_opts_create(&runtime_opts, NULL, 0, &error_abort);
@@ -387,20 +386,17 @@ static int blkdebug_open(BlockDriverState *bs, QDict *options, int flags,
         bs->file->bs->supported_write_flags;
     bs->supported_zero_flags = (BDRV_REQ_FUA | BDRV_REQ_MAY_UNMAP) &
         bs->file->bs->supported_zero_flags;
+    ret = -EINVAL;
 
     /* Set request alignment */
-    align = qemu_opt_get_size(opts, "align", 0);
-    if (align < INT_MAX && is_power_of_2(align)) {
-        s->align = align;
-    } else if (align) {
-        error_setg(errp, "Invalid alignment");
-        ret = -EINVAL;
+    s->align = qemu_opt_get_size(opts, "align", 0);
+    if (s->align && (s->align >= INT_MAX || !is_power_of_2(s->align))) {
+        error_setg(errp, "Cannot meet constraints with align %" PRIu64,
+                   s->align);
         goto out;
     }
 
     ret = 0;
-    goto out;
-
 out:
     if (ret < 0) {
         g_free(s->config_file);
-- 
2.7.4
