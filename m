Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB2F8C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:49:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61AAE20857
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 15:49:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lm/bHpmI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61AAE20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joU8C-00025p-Fc
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 11:49:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joTjJ-0006sU-RH
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:23:57 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51338
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1joTjF-0001Sa-JZ
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 11:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593098632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l0p1Y32ov7w5zxhMPPmCe1IkJ7BaMhdsxK94Oj7LLh4=;
 b=Lm/bHpmInW5mq7fZB6w1xLMlv4MIfBU6HX//+JXawTkxCukGYLsGW1N/vILZc8bvLT/Ojh
 K10KcvSP7kJf46I8tKBBY341xLqTPdxbVFguO0jnu3kmGu718rzd5ttSi5QjSmVCDqx2ep
 2RQdjKU7k8+dijcXschTdHhI7NH8ASA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-p_MAEfi_NjCra6Ayp2hSOA-1; Thu, 25 Jun 2020 11:23:50 -0400
X-MC-Unique: p_MAEfi_NjCra6Ayp2hSOA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A842AA0BD9;
 Thu, 25 Jun 2020 15:23:49 +0000 (UTC)
Received: from localhost (ovpn-113-182.ams2.redhat.com [10.36.113.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1F15E10013D9;
 Thu, 25 Jun 2020 15:23:48 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v7 41/47] block: Leave BDS.backing_file constant
Date: Thu, 25 Jun 2020 17:22:09 +0200
Message-Id: <20200625152215.941773-42-mreitz@redhat.com>
In-Reply-To: <20200625152215.941773-1-mreitz@redhat.com>
References: <20200625152215.941773-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
qemu-img: Did not find 'mid.qcow2' in the backing chain of 'foo/top.qcow2'
$ ./qemu-img commit -b foo/mid.qcow2 foo/top.qcow2
qemu-img: Did not find 'foo/mid.qcow2' in the backing chain of 'foo/top.qcow2'
$ ./qemu-img commit -b $PWD/foo/mid.qcow2 foo/top.qcow2
qemu-img: Did not find '[...]/foo/mid.qcow2' in the backing chain of 'foo/top.qcow2'

After this patch:

$ ./qemu-img commit -b mid.qcow2 foo/top.qcow2
Image committed.
$ ./qemu-img commit -b foo/mid.qcow2 foo/top.qcow2
qemu-img: Did not find 'foo/mid.qcow2' in the backing chain of 'foo/top.qcow2'
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
BDS.backing_format in bdrv_backing_attach() as well.  In order not to
change our externally visible behavior (incompatibly), we have to let
bdrv_query_image_info() try to get the image format from bs->backing if
bs->backing_format is unset.  (The QAPI schema describes
backing-filename-format as "the format of the backing file", so it is
not necessarily what the image header says, but just the format of the
file referenced by backing-filename (if known).)

iotest 245 changes in behavior: With the backing node no longer
overriding the parent node's backing_file string, you can now omit the
@backing option when reopening a node with neither a default nor a
current backing file even if it used to have a backing node at some
point.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block_int.h  | 21 ++++++++++++++++-----
 block.c                    | 35 +++++++++++++++++++++++++++--------
 block/qapi.c               | 17 +++++++++++++----
 tests/qemu-iotests/228     |  6 +++---
 tests/qemu-iotests/228.out |  6 +++---
 tests/qemu-iotests/245     |  4 +++-
 6 files changed, 65 insertions(+), 24 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index e5a328c389..465a601955 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -835,11 +835,20 @@ struct BlockDriverState {
     bool walking_aio_notifiers; /* to make removal during iteration safe */
 
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
 
@@ -1041,6 +1050,8 @@ BlockDriver *bdrv_probe_all(const uint8_t *buf, int buf_size,
 void bdrv_parse_filename_strip_prefix(const char *filename, const char *prefix,
                                       QDict *options);
 
+bool bdrv_backing_overridden(BlockDriverState *bs);
+
 
 /**
  * bdrv_add_before_write_notifier:
diff --git a/block.c b/block.c
index a19f243997..af8d85bcf2 100644
--- a/block.c
+++ b/block.c
@@ -1153,10 +1153,6 @@ static void bdrv_backing_attach(BdrvChild *c)
     bdrv_refresh_filename(backing_hd);
 
     parent->open_flags &= ~BDRV_O_NO_BACKING;
-    pstrcpy(parent->backing_file, sizeof(parent->backing_file),
-            backing_hd->filename);
-    pstrcpy(parent->backing_format, sizeof(parent->backing_format),
-            backing_hd->drv ? backing_hd->drv->format_name : "");
 
     bdrv_op_block_all(backing_hd, parent->backing_blocker);
     /* Otherwise we won't be able to commit or stream */
@@ -5693,6 +5689,7 @@ BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
     char *backing_file_full = NULL;
     char *filename_tmp = NULL;
     int is_protocol = 0;
+    bool filenames_refreshed = false;
     BlockDriverState *curr_bs = NULL;
     BlockDriverState *retval = NULL;
     BlockDriverState *bs_below;
@@ -5718,9 +5715,31 @@ BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
     {
         bs_below = bdrv_backing_chain_next(curr_bs);
 
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
+                filenames_refreshed = true;
+            }
+
+            if (strcmp(backing_file, bs_below->filename) == 0) {
+                retval = bs_below;
+                break;
+            }
+        } else if (is_protocol || path_has_protocol(curr_bs->backing_file)) {
+            /*
+             * If either of the filename paths is actually a protocol, then
+             * compare unmodified paths; otherwise make paths relative.
+             */
             char *backing_file_full_ret;
 
             if (strcmp(backing_file, curr_bs->backing_file) == 0) {
@@ -6821,7 +6840,7 @@ static bool append_strong_runtime_options(QDict *d, BlockDriverState *bs)
 /* Note: This function may return false positives; it may return true
  * even if opening the backing file specified by bs's image header
  * would result in exactly bs->backing. */
-static bool bdrv_backing_overridden(BlockDriverState *bs)
+bool bdrv_backing_overridden(BlockDriverState *bs)
 {
     if (bs->backing) {
         return strcmp(bs->auto_backing_file,
diff --git a/block/qapi.c b/block/qapi.c
index 2628323b63..5da6d7e6e0 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -47,7 +47,7 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
                                         Error **errp)
 {
     ImageInfo **p_image_info;
-    BlockDriverState *bs0;
+    BlockDriverState *bs0, *backing;
     BlockDeviceInfo *info;
 
     if (!bs->drv) {
@@ -76,9 +76,10 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
         info->node_name = g_strdup(bs->node_name);
     }
 
-    if (bs->backing_file[0]) {
+    backing = bdrv_cow_bs(bs);
+    if (backing) {
         info->has_backing_file = true;
-        info->backing_file = g_strdup(bs->backing_file);
+        info->backing_file = g_strdup(backing->filename);
     }
 
     if (!QLIST_EMPTY(&bs->dirty_bitmaps)) {
@@ -314,6 +315,8 @@ void bdrv_query_image_info(BlockDriverState *bs,
     backing_filename = bs->backing_file;
     if (backing_filename[0] != '\0') {
         char *backing_filename2;
+        const char *backing_format = NULL;
+
         info->backing_filename = g_strdup(backing_filename);
         info->has_backing_filename = true;
         backing_filename2 = bdrv_get_full_backing_filename(bs, NULL);
@@ -326,7 +329,13 @@ void bdrv_query_image_info(BlockDriverState *bs,
         }
 
         if (bs->backing_format[0]) {
-            info->backing_filename_format = g_strdup(bs->backing_format);
+            backing_format = bs->backing_format;
+        } else if (bs->backing && bs->backing->bs->drv &&
+                   !bdrv_backing_overridden(bs)) {
+            backing_format = bs->backing->bs->drv->format_name;
+        }
+        if (backing_format) {
+            info->backing_filename_format = g_strdup(backing_format);
             info->has_backing_filename_format = true;
         }
         g_free(backing_filename2);
diff --git a/tests/qemu-iotests/228 b/tests/qemu-iotests/228
index da0900fb82..90800ecc6a 100755
--- a/tests/qemu-iotests/228
+++ b/tests/qemu-iotests/228
@@ -36,7 +36,7 @@ def log_node_info(node):
 
     log('bs->filename: ' + node['image']['filename'],
         filters=[filter_testfiles, filter_imgfmt])
-    log('bs->backing_file: ' + node['backing_file'],
+    log('bs->backing_file: ' + node['image']['full-backing-filename'],
         filters=[filter_testfiles, filter_imgfmt])
 
     if 'backing-image' in node['image']:
@@ -72,8 +72,8 @@ with iotests.FilePath('base.img') as base_img_path, \
                 },
                 filters=[filter_qmp_testfiles, filter_qmp_imgfmt])
 
-    # Filename should be plain, and the backing filename should not
-    # contain the "file:" prefix
+    # Filename should be plain, and the backing node filename should
+    # not contain the "file:" prefix
     log_node_info(vm.node_info('node0'))
 
     vm.qmp_log('blockdev-del', node_name='node0')
diff --git a/tests/qemu-iotests/228.out b/tests/qemu-iotests/228.out
index 4217df24fe..8c82009abe 100644
--- a/tests/qemu-iotests/228.out
+++ b/tests/qemu-iotests/228.out
@@ -4,7 +4,7 @@
 {"return": {}}
 
 bs->filename: TEST_DIR/PID-top.img
-bs->backing_file: TEST_DIR/PID-base.img
+bs->backing_file: file:TEST_DIR/PID-base.img
 bs->backing->bs->filename: TEST_DIR/PID-base.img
 
 {"execute": "blockdev-del", "arguments": {"node-name": "node0"}}
@@ -41,7 +41,7 @@ bs->backing->bs->filename: TEST_DIR/PID-base.img
 {"return": {}}
 
 bs->filename: TEST_DIR/PID-top.img
-bs->backing_file: TEST_DIR/PID-base.img
+bs->backing_file: file:TEST_DIR/PID-base.img
 bs->backing->bs->filename: TEST_DIR/PID-base.img
 
 {"execute": "blockdev-del", "arguments": {"node-name": "node0"}}
@@ -55,7 +55,7 @@ bs->backing->bs->filename: TEST_DIR/PID-base.img
 {"return": {}}
 
 bs->filename: json:{"backing": {"driver": "null-co"}, "driver": "IMGFMT", "file": {"driver": "file", "filename": "TEST_DIR/PID-top.img"}}
-bs->backing_file: null-co://
+bs->backing_file: TEST_DIR/PID-base.img
 bs->backing->bs->filename: null-co://
 
 {"execute": "blockdev-del", "arguments": {"node-name": "node0"}}
diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
index 4f5f0bb901..5035763765 100755
--- a/tests/qemu-iotests/245
+++ b/tests/qemu-iotests/245
@@ -724,7 +724,9 @@ class TestBlockdevReopen(iotests.QMPTestCase):
 
         # Detach hd2 from hd0.
         self.reopen(opts, {'backing': None})
-        self.reopen(opts, {}, "backing is missing for 'hd0'")
+
+        # Without a backing file, we can omit 'backing' again
+        self.reopen(opts)
 
         # Remove both hd0 and hd2
         result = self.vm.qmp('blockdev-del', conv_keys = True, node_name = 'hd0')
-- 
2.26.2


