Return-Path: <SRS0=gZkW=SM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE7FC10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 20:25:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF7CE2082E
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Apr 2019 20:25:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF7CE2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37399 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEJmu-0002d5-Su
	for qemu-devel@archiver.kernel.org; Wed, 10 Apr 2019 16:25:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hEJiV-000713-MF
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 16:21:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hEJiT-0004Rw-7B
	for qemu-devel@nongnu.org; Wed, 10 Apr 2019 16:21:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hEJiN-0004Lu-Jh; Wed, 10 Apr 2019 16:20:59 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D16AA3097077;
	Wed, 10 Apr 2019 20:20:58 +0000 (UTC)
Received: from localhost (unknown [10.40.205.69])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 38F3F19C65;
	Wed, 10 Apr 2019 20:20:58 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Wed, 10 Apr 2019 22:20:29 +0200
Message-Id: <20190410202033.28617-8-mreitz@redhat.com>
In-Reply-To: <20190410202033.28617-1-mreitz@redhat.com>
References: <20190410202033.28617-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Wed, 10 Apr 2019 20:20:58 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 07/11] block: Leave BDS.backing_file constant
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190410202029.o348Q9uTN1XdzSMj8-T49kvlXrKveosfesI4p9-lFq4@z>

Parts of the block layer treat BDS.backing_file as if it were whatever
the image header says (i.e., if it is a relative path, it is relative to
the overlay), other parts treat it like a cache for
bs->backing->bs->filename (relative paths are relative to the CWD).
Considering bs->backing->bs->filename exists, let us make it mean the
former.

Among other things, this now allows the user to specify a base when
using qemu-img to commit an image file in a directory that is not the
CWD (assuming, everything uses relative filenames).

Before this patch:

$ ./qemu-img create -f qcow2 foo/bot.qcow2 1M
$ ./qemu-img create -f qcow2 -b bot.qcow2 foo/mid.qcow2
$ ./qemu-img create -f qcow2 -b mid.qcow2 foo/top.qcow2
$ ./qemu-img commit -b mid.qcow2 foo/top.qcow2
qemu-img: Did not find 'mid.qcow2' in the backing chain of 'foo/top.qcow2=
'
$ ./qemu-img commit -b foo/mid.qcow2 foo/top.qcow2
qemu-img: Did not find 'foo/mid.qcow2' in the backing chain of 'foo/top.q=
cow2'
$ ./qemu-img commit -b $PWD/foo/mid.qcow2 foo/top.qcow2
qemu-img: Did not find '[...]/foo/mid.qcow2' in the backing chain of 'foo=
/top.qcow2'

After this patch:

$ ./qemu-img commit -b mid.qcow2 foo/top.qcow2
Image committed.
$ ./qemu-img commit -b foo/mid.qcow2 foo/top.qcow2
qemu-img: Did not find 'foo/mid.qcow2' in the backing chain of 'foo/top.q=
cow2'
$ ./qemu-img commit -b $PWD/foo/mid.qcow2 foo/top.qcow2
Image committed.

With this change, bdrv_find_backing_image() must look at whether the
user has overridden a BDS's backing file.  If so, it can no longer use
bs->backing_file, but must instead compare the given filename against
the backing node's filename directly.

Note that this changes the QAPI output for a node's backing_file.  We
had very inconsistent output there (sometimes what the image header
said, sometimes the actual filename of the backing image).  This
inconsistent output was effectively useless, so we have to decide one
way or the other.  Considering that bs->backing_file usually at runtime
contained the path to the image relative to qemu's CWD (or absolute),
this patch changes QAPI's backing_file to always report the
bs->backing->bs->filename from now on.  If you want to receive the image
header information, you have to refer to full-backing-filename.

This necessitates a change to iotest 228.  The interesting information
it really wanted is the image header, and it can get that now, but it
has to use full-backing-filename instead of backing_file.  Because of
this patch's changes to bs->backing_file's behavior, we also need some
reference output changes.

Along with the changes to bs->backing_file, stop updating
BDS.backing_format in bdrv_backing_attach() as well.  This necessitates
a change to the reference output of iotest 191.

iotest 245 changes in behavior: With the backing node no longer
overriding the parent node's backing_file string, you can now omit the
@backing option when reopening a node with neither a default nor a
current backing file even if it used to have a backing node at some
point.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block_int.h  | 19 ++++++++++++++-----
 block.c                    | 35 ++++++++++++++++++++++++++++-------
 block/qapi.c               |  7 ++++---
 qemu-img.c                 | 12 ++++++++++--
 tests/qemu-iotests/191.out |  1 -
 tests/qemu-iotests/228     |  6 +++---
 tests/qemu-iotests/228.out |  6 +++---
 tests/qemu-iotests/245     |  4 +++-
 8 files changed, 65 insertions(+), 25 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 76c7c0a111..69524bc712 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -760,11 +760,20 @@ struct BlockDriverState {
     bool walking_aio_notifiers; /* to make removal during iteration safe=
 */
=20
     char filename[PATH_MAX];
-    char backing_file[PATH_MAX]; /* if non zero, the image is a diff of
-                                    this file image */
-    /* The backing filename indicated by the image header; if we ever
-     * open this file, then this is replaced by the resulting BDS's
-     * filename (i.e. after a bdrv_refresh_filename() run). */
+    /*
+     * If not empty, this image is a diff in relation to backing_file.
+     * Note that this is the name given in the image header and
+     * therefore may or may not be equal to .backing->bs->filename.
+     * If this field contains a relative path, it is to be resolved
+     * relatively to the overlay's location.
+     */
+    char backing_file[PATH_MAX];
+    /*
+     * The backing filename indicated by the image header.  Contrary
+     * to backing_file, if we ever open this file, auto_backing_file
+     * is replaced by the resulting BDS's filename (i.e. after a
+     * bdrv_refresh_filename() run).
+     */
     char auto_backing_file[PATH_MAX];
     char backing_format[16]; /* if non-zero and backing_file exists */
=20
diff --git a/block.c b/block.c
index 820244f52e..a4c2dda039 100644
--- a/block.c
+++ b/block.c
@@ -78,6 +78,8 @@ static BlockDriverState *bdrv_open_inherit(const char *=
filename,
                                            const BdrvChildRole *child_ro=
le,
                                            Error **errp);
=20
+static bool bdrv_backing_overridden(BlockDriverState *bs);
+
 /* If non-zero, use only whitelisted block drivers */
 static int use_bdrv_whitelist;
=20
@@ -1046,10 +1048,6 @@ static void bdrv_backing_attach(BdrvChild *c)
     bdrv_refresh_filename(backing_hd);
=20
     parent->open_flags &=3D ~BDRV_O_NO_BACKING;
-    pstrcpy(parent->backing_file, sizeof(parent->backing_file),
-            backing_hd->filename);
-    pstrcpy(parent->backing_format, sizeof(parent->backing_format),
-            backing_hd->drv ? backing_hd->drv->format_name : "");
=20
     bdrv_op_block_all(backing_hd, parent->backing_blocker);
     /* Otherwise we won't be able to commit or stream */
@@ -5048,6 +5046,7 @@ BlockDriverState *bdrv_find_backing_image(BlockDriv=
erState *bs,
     char *backing_file_full =3D NULL;
     char *filename_tmp =3D NULL;
     int is_protocol =3D 0;
+    bool filenames_refreshed =3D false;
     BlockDriverState *curr_bs =3D NULL;
     BlockDriverState *retval =3D NULL;
=20
@@ -5072,9 +5071,31 @@ BlockDriverState *bdrv_find_backing_image(BlockDri=
verState *bs,
     {
         BlockDriverState *bs_below =3D bdrv_backing_chain_next(curr_bs);
=20
-        /* If either of the filename paths is actually a protocol, then
-         * compare unmodified paths; otherwise make paths relative */
-        if (is_protocol || path_has_protocol(curr_bs->backing_file)) {
+        if (bdrv_backing_overridden(curr_bs)) {
+            /*
+             * If the backing file was overridden, we can only compare
+             * directly against the backing node's filename.
+             */
+
+            if (!filenames_refreshed) {
+                /*
+                 * This will automatically refresh all of the
+                 * filenames in the rest of the backing chain, so we
+                 * only need to do this once.
+                 */
+                bdrv_refresh_filename(bs_below);
+                filenames_refreshed =3D true;
+            }
+
+            if (strcmp(backing_file, bs_below->filename) =3D=3D 0) {
+                retval =3D bs_below;
+                break;
+            }
+        } else if (is_protocol || path_has_protocol(curr_bs->backing_fil=
e)) {
+            /*
+             * If either of the filename paths is actually a protocol, t=
hen
+             * compare unmodified paths; otherwise make paths relative.
+             */
             char *backing_file_full_ret;
=20
             if (strcmp(backing_file, curr_bs->backing_file) =3D=3D 0) {
diff --git a/block/qapi.c b/block/qapi.c
index e026d27077..d0c895808a 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -43,7 +43,7 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *b=
lk,
                                         BlockDriverState *bs, Error **er=
rp)
 {
     ImageInfo **p_image_info;
-    BlockDriverState *bs0;
+    BlockDriverState *bs0, *backing;
     BlockDeviceInfo *info;
=20
     if (!bs->drv) {
@@ -72,9 +72,10 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *=
blk,
         info->node_name =3D g_strdup(bs->node_name);
     }
=20
-    if (bs->backing_file[0]) {
+    backing =3D bdrv_filtered_cow_bs(bs);
+    if (backing) {
         info->has_backing_file =3D true;
-        info->backing_file =3D g_strdup(bs->backing_file);
+        info->backing_file =3D g_strdup(backing->filename);
     }
=20
     info->detect_zeroes =3D bs->detect_zeroes;
diff --git a/qemu-img.c b/qemu-img.c
index bcfbb743fc..836e22061c 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3305,7 +3305,7 @@ static int img_rebase(int argc, char **argv)
=20
     /* For safe rebasing we need to compare old and new backing file */
     if (!unsafe) {
-        char backing_name[PATH_MAX];
+        char *backing_name;
         QDict *options =3D NULL;
=20
         if (bs->backing_format[0] !=3D '\0') {
@@ -3319,16 +3319,24 @@ static int img_rebase(int argc, char **argv)
             }
             qdict_put_bool(options, BDRV_OPT_FORCE_SHARE, true);
         }
-        bdrv_get_backing_filename(bs, backing_name, sizeof(backing_name)=
);
+        backing_name =3D bdrv_get_full_backing_filename(bs, &local_err);
+        if (local_err) {
+            error_reportf_err(local_err,
+                              "Could not resolve old backing file name: =
");
+            ret =3D -1;
+            goto out;
+        }
         blk_old_backing =3D blk_new_open(backing_name, NULL,
                                        options, src_flags, &local_err);
         if (!blk_old_backing) {
             error_reportf_err(local_err,
                               "Could not open old backing file '%s': ",
                               backing_name);
+            g_free(backing_name);
             ret =3D -1;
             goto out;
         }
+        g_free(backing_name);
=20
         if (out_baseimg[0]) {
             const char *overlay_filename;
diff --git a/tests/qemu-iotests/191.out b/tests/qemu-iotests/191.out
index 3fc92bb56e..0b3c216b0c 100644
--- a/tests/qemu-iotests/191.out
+++ b/tests/qemu-iotests/191.out
@@ -605,7 +605,6 @@ wrote 65536/65536 bytes at offset 1048576
                     "backing-filename": "TEST_DIR/t.IMGFMT.base",
                     "dirty-flag": false
                 },
-                "backing-filename-format": "IMGFMT",
                 "virtual-size": 67108864,
                 "filename": "TEST_DIR/t.IMGFMT.ovl3",
                 "cluster-size": 65536,
diff --git a/tests/qemu-iotests/228 b/tests/qemu-iotests/228
index 9a50afd205..a1f3187212 100755
--- a/tests/qemu-iotests/228
+++ b/tests/qemu-iotests/228
@@ -34,7 +34,7 @@ def log_node_info(node):
=20
     log('bs->filename: ' + node['image']['filename'],
         filters=3D[filter_testfiles, filter_imgfmt])
-    log('bs->backing_file: ' + node['backing_file'],
+    log('bs->backing_file: ' + node['image']['full-backing-filename'],
         filters=3D[filter_testfiles, filter_imgfmt])
=20
     if 'backing-image' in node['image']:
@@ -70,8 +70,8 @@ with iotests.FilePath('base.img') as base_img_path, \
                 },
                 filters=3D[filter_qmp_testfiles, filter_qmp_imgfmt])
=20
-    # Filename should be plain, and the backing filename should not
-    # contain the "file:" prefix
+    # Filename should be plain, and the backing node filename should
+    # not contain the "file:" prefix
     log_node_info(vm.node_info('node0'))
=20
     vm.qmp_log('blockdev-del', node_name=3D'node0')
diff --git a/tests/qemu-iotests/228.out b/tests/qemu-iotests/228.out
index 4217df24fe..8c82009abe 100644
--- a/tests/qemu-iotests/228.out
+++ b/tests/qemu-iotests/228.out
@@ -4,7 +4,7 @@
 {"return": {}}
=20
 bs->filename: TEST_DIR/PID-top.img
-bs->backing_file: TEST_DIR/PID-base.img
+bs->backing_file: file:TEST_DIR/PID-base.img
 bs->backing->bs->filename: TEST_DIR/PID-base.img
=20
 {"execute": "blockdev-del", "arguments": {"node-name": "node0"}}
@@ -41,7 +41,7 @@ bs->backing->bs->filename: TEST_DIR/PID-base.img
 {"return": {}}
=20
 bs->filename: TEST_DIR/PID-top.img
-bs->backing_file: TEST_DIR/PID-base.img
+bs->backing_file: file:TEST_DIR/PID-base.img
 bs->backing->bs->filename: TEST_DIR/PID-base.img
=20
 {"execute": "blockdev-del", "arguments": {"node-name": "node0"}}
@@ -55,7 +55,7 @@ bs->backing->bs->filename: TEST_DIR/PID-base.img
 {"return": {}}
=20
 bs->filename: json:{"backing": {"driver": "null-co"}, "driver": "IMGFMT"=
, "file": {"driver": "file", "filename": "TEST_DIR/PID-top.img"}}
-bs->backing_file: null-co://
+bs->backing_file: TEST_DIR/PID-base.img
 bs->backing->bs->filename: null-co://
=20
 {"execute": "blockdev-del", "arguments": {"node-name": "node0"}}
diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
index a04c6235c1..1b191d4da7 100644
--- a/tests/qemu-iotests/245
+++ b/tests/qemu-iotests/245
@@ -722,7 +722,9 @@ class TestBlockdevReopen(iotests.QMPTestCase):
=20
         # Detach hd2 from hd0.
         self.reopen(opts, {'backing': None})
-        self.reopen(opts, {}, "backing is missing for 'hd0'")
+
+        # Without a backing file, we can omit 'backing' again
+        self.reopen(opts)
=20
         # Remove both hd0 and hd2
         result =3D self.vm.qmp('blockdev-del', conv_keys =3D True, node_=
name =3D 'hd0')
--=20
2.20.1


