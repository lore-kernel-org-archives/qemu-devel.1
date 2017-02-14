Received: from eggs.gnu.org ([2001:4830:134:3::10]:39444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cdijM-00010x-V7
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 14:25:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cdijL-0005L7-QJ
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 14:25:40 -0500
From: Eric Blake <eblake@redhat.com>
Date: Tue, 14 Feb 2017 13:25:23 -0600
Message-Id: <20170214192525.18624-6-eblake@redhat.com>
In-Reply-To: <20170214192525.18624-1-eblake@redhat.com>
References: <20170214192525.18624-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v5 5/7] blkdebug: Simplify override logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com

Rather than store into a local variable, then copy to the struct
if the value is valid, then reporting errors otherwise, it is
simpler to just store into the struct and report errors if the
value is invalid.  This however requires that the struct store
a 64-bit number, rather than a narrower type.  Move the errno
assignment into a label that will be reused from more places in
the next patch.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>

---
v5: no change
v4: fix typo in commit message, move errno assignment
v3: new patch
---
 block/blkdebug.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index b2d5f7d..2996152 100644
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
@@ -389,12 +388,9 @@ static int blkdebug_open(BlockDriverState *bs, QDict *options, int flags,
         bs->file->bs->supported_zero_flags;

     /* Set request alignment */
-    align = qemu_opt_get_size(opts, "align", 0);
-    if (align < INT_MAX && is_power_of_2(align)) {
-        s->align = align;
-    } else if (align) {
-        error_setg(errp, "Invalid alignment");
-        ret = -EINVAL;
+    s->align = qemu_opt_get_size(opts, "align", 0);
+    if (s->align && (s->align >= INT_MAX || !is_power_of_2(s->align))) {
+        error_setg(errp, "Invalid alignment, align must be integer power of 2");
         goto fail_unref;
     }

@@ -402,6 +398,7 @@ static int blkdebug_open(BlockDriverState *bs, QDict *options, int flags,
     goto out;

 fail_unref:
+    ret = -EINVAL;
     bdrv_unref_child(bs, bs->file);
 out:
     if (ret < 0) {
-- 
2.9.3
