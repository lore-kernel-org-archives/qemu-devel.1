Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C10C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 17:02:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6A9720672
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 17:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iBczFjlv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6A9720672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsqyo-0006u0-VT
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 13:02:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39866)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jsqZd-0007w0-T9
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:36:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22100
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jsqZb-0004CV-Pk
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 12:36:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594139758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aORuYeoGufZzWhhAy1jwkNQHbMQmMo2DR1yYPUCz9Ec=;
 b=iBczFjlvxYoqxDnz6h6UIQWBmC6ordFF8u/OtU1GdWxE6SbZw1cu7esRrHgWMCqBfBV1Em
 a9d2iMtZxVD6d8JIFiEnKnmmoEZuGZYkx9Z2Nhkj6YW8DT/hL8084O/braIfDEbwLC19Wd
 +eHZIAwgIfawOgn8iD6zzvNfZsYjJYw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-kpQe7hhrMB6dFsHoy7teJg-1; Tue, 07 Jul 2020 12:35:53 -0400
X-MC-Unique: kpQe7hhrMB6dFsHoy7teJg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 672751005510;
 Tue,  7 Jul 2020 16:35:50 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-113.ams2.redhat.com
 [10.36.114.113])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 75B27512FE;
 Tue,  7 Jul 2020 16:35:49 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 07/12] qcow: Tolerate backing_fmt=
Date: Tue,  7 Jul 2020 18:34:59 +0200
Message-Id: <20200707163504.194740-8-kwolf@redhat.com>
In-Reply-To: <20200707163504.194740-1-kwolf@redhat.com>
References: <20200707163504.194740-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 06:04:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Blake <eblake@redhat.com>

qcow has no space in the metadata to store a backing format, and there
are existing qcow images backed both by raw or by other formats
(usually qcow) images, reliant on probing to tell the difference.  On
the bright side, because we probe every time, raw files are marked as
probed and we thus forbid a commit action into the backing file where
guest-controlled contents could change the result of the probe next
time around (the iotest added here proves that).

Still, allowing the user to specify the backing format during
creation, even if we can't record it, is a good thing.  This patch
blindly allows any value that resolves to a known driver, even if the
user's request is a mismatch from what probing finds; then the next
patch will further enhance things to verify that the user's request
matches what we actually probe.  With this and the next patch in
place, we will finally be ready to deprecate the creation of images
where a backing format was not explicitly specified by the user.

Note that this is only for QemuOpts usage; there is no change to the
QAPI to allow a format through -blockdev.

Add a new iotest 293 just for qcow, to demonstrate the latest
behavior, and to make it easier to show the improvements made in the
next patch.

Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200706203954.341758-6-eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow.c               | 20 ++++++++-
 tests/qemu-iotests/293     | 88 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/293.out | 60 ++++++++++++++++++++++++++
 tests/qemu-iotests/group   |  1 +
 4 files changed, 168 insertions(+), 1 deletion(-)
 create mode 100755 tests/qemu-iotests/293
 create mode 100644 tests/qemu-iotests/293.out

diff --git a/block/qcow.c b/block/qcow.c
index ee5d35fe20..e91aa2d8c4 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -940,11 +940,12 @@ static int coroutine_fn qcow_co_create_opts(BlockDriver *drv,
 {
     BlockdevCreateOptions *create_options = NULL;
     BlockDriverState *bs = NULL;
-    QDict *qdict;
+    QDict *qdict = NULL;
     Visitor *v;
     const char *val;
     Error *local_err = NULL;
     int ret;
+    char *backing_fmt;
 
     static const QDictRenames opt_renames[] = {
         { BLOCK_OPT_BACKING_FILE,       "backing-file" },
@@ -952,6 +953,17 @@ static int coroutine_fn qcow_co_create_opts(BlockDriver *drv,
         { NULL, NULL },
     };
 
+    /*
+     * We can't actually store a backing format, but can check that
+     * the user's request made sense.
+     */
+    backing_fmt = qemu_opt_get_del(opts, BLOCK_OPT_BACKING_FMT);
+    if (backing_fmt && !bdrv_find_format(backing_fmt)) {
+        error_setg(errp, "unrecognized backing format '%s'", backing_fmt);
+        ret = -EINVAL;
+        goto fail;
+    }
+
     /* Parse options and convert legacy syntax */
     qdict = qemu_opts_to_qdict_filtered(opts, NULL, &qcow_create_opts, true);
 
@@ -1018,6 +1030,7 @@ static int coroutine_fn qcow_co_create_opts(BlockDriver *drv,
 
     ret = 0;
 fail:
+    g_free(backing_fmt);
     qobject_unref(qdict);
     bdrv_unref(bs);
     qapi_free_BlockdevCreateOptions(create_options);
@@ -1152,6 +1165,11 @@ static QemuOptsList qcow_create_opts = {
             .type = QEMU_OPT_STRING,
             .help = "File name of a base image"
         },
+        {
+            .name = BLOCK_OPT_BACKING_FMT,
+            .type = QEMU_OPT_STRING,
+            .help = "Format of the backing image",
+        },
         {
             .name = BLOCK_OPT_ENCRYPT,
             .type = QEMU_OPT_BOOL,
diff --git a/tests/qemu-iotests/293 b/tests/qemu-iotests/293
new file mode 100755
index 0000000000..3823e95617
--- /dev/null
+++ b/tests/qemu-iotests/293
@@ -0,0 +1,88 @@
+#!/usr/bin/env bash
+#
+# Test qcow backing file warnings
+#
+# Copyright (C) 2020 Red Hat, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1 # failure is the default!
+
+_cleanup()
+{
+    _cleanup_test_img
+    _rm_test_img "$TEST_IMG.qcow2"
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+
+_supported_fmt qcow
+_supported_proto file
+_supported_os Linux
+
+size=32M
+
+echo
+echo "== qcow backed by qcow =="
+
+TEST_IMG="$TEST_IMG.base" _make_test_img $size
+_make_test_img -b "$TEST_IMG.base" $size
+_img_info
+_make_test_img -b "$TEST_IMG.base" -F $IMGFMT $size
+_img_info
+
+echo
+echo "== mismatched command line detection =="
+
+_make_test_img -b "$TEST_IMG.base" -F vmdk
+_make_test_img -b "$TEST_IMG.base" -F vmdk $size
+echo
+# Use of -u bypasses the backing format sanity check
+_make_test_img -u -b "$TEST_IMG.base" -F vmdk
+_make_test_img -u -b "$TEST_IMG.base" -F vmdk $size
+echo
+# But the format must still be recognized
+_make_test_img -b "$TEST_IMG.base" -F garbage $size
+_make_test_img -u -b "$TEST_IMG.base" -F garbage $size
+_img_info
+
+echo
+echo "== qcow backed by raw =="
+
+rm "$TEST_IMG.base"
+truncate --size=$size "$TEST_IMG.base"
+_make_test_img -b "$TEST_IMG.base" $size
+_img_info
+_make_test_img -b "$TEST_IMG.base" -F raw $size
+_img_info
+
+echo
+echo "== commit cannot change type of raw backing file =="
+TEST_IMG="$TEST_IMG.qcow2" IMGFMT=qcow2 _make_test_img $size
+truncate --size=$size "$TEST_IMG.qcow2"
+$QEMU_IMG convert -n -f raw -O $IMGFMT "$TEST_IMG.qcow2" "$TEST_IMG"
+$QEMU_IMG commit -f $IMGFMT "$TEST_IMG" && echo "unexpected success"
+TEST_IMG="$TEST_IMG.base" _img_info
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/293.out b/tests/qemu-iotests/293.out
new file mode 100644
index 0000000000..d07918b6d7
--- /dev/null
+++ b/tests/qemu-iotests/293.out
@@ -0,0 +1,60 @@
+QA output created by 293
+
+== qcow backed by qcow ==
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=33554432
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=33554432 backing_file=TEST_DIR/t.IMGFMT.base
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 32 MiB (33554432 bytes)
+cluster_size: 512
+backing file: TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=33554432 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=IMGFMT
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 32 MiB (33554432 bytes)
+cluster_size: 512
+backing file: TEST_DIR/t.IMGFMT.base
+
+== mismatched command line detection ==
+qemu-img: TEST_DIR/t.IMGFMT: invalid VMDK image descriptor
+Could not open backing image to determine size.
+qemu-img: warning: Could not verify backing image. This may become an error in future versions.
+invalid VMDK image descriptor
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=33554432 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=vmdk
+
+qemu-img: TEST_DIR/t.IMGFMT: Image creation needs a size parameter
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=33554432 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=vmdk
+
+qemu-img: warning: Could not verify backing image. This may become an error in future versions.
+Unknown driver 'garbage'
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=33554432 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=garbage
+qemu-img: TEST_DIR/t.IMGFMT: unrecognized backing format 'garbage'
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=33554432 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=garbage
+qemu-img: TEST_DIR/t.IMGFMT: unrecognized backing format 'garbage'
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 32 MiB (33554432 bytes)
+cluster_size: 512
+backing file: TEST_DIR/t.IMGFMT.base
+
+== qcow backed by raw ==
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=33554432 backing_file=TEST_DIR/t.IMGFMT.base
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 32 MiB (33554432 bytes)
+cluster_size: 512
+backing file: TEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=33554432 backing_file=TEST_DIR/t.IMGFMT.base backing_fmt=raw
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 32 MiB (33554432 bytes)
+cluster_size: 512
+backing file: TEST_DIR/t.IMGFMT.base
+
+== commit cannot change type of raw backing file ==
+Formatting 'TEST_DIR/t.qcow.IMGFMT', fmt=IMGFMT size=33554432
+qemu-img: Block job failed: Operation not permitted
+image: TEST_DIR/t.IMGFMT.base
+file format: raw
+virtual size: 32 MiB (33554432 bytes)
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index d886fa0cb3..0dcfffdcad 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -301,4 +301,5 @@
 290 rw auto quick
 291 rw quick
 292 rw auto quick
+293 backing quick
 297 meta
-- 
2.25.4


