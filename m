Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FFEBC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 17:27:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D4C4227BF
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 17:27:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gbL46uJ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D4C4227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihzaM-0000VE-2B
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 12:27:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44053)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1ihzXr-0006G8-1V
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:25:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1ihzXp-00063H-26
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:25:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24116
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1ihzXo-00060U-SO
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 12:25:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576776300;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CN28InvE40S6icR90JvYy808t2h2ocVy/jxeJ0DcvKc=;
 b=gbL46uJ4XOCYGyHWtwa5u22bZ2jR/sjPG9Gt5/9jApLgKP/j8t2LDD3tJ3DK1k/rBb4K+t
 lf1xhzyLSTUT8I2C7OPliRdDlNxaHQebhf0Hl5oNVTEkVFvcrX++oFvKppjrrAXqQ/dhPx
 VPyLw+xkPBUupXAuSomROAElWRLRgq4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-338-4LeXxaG4PQmVFyal_wRBLw-1; Thu, 19 Dec 2019 12:24:56 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 19F57800EB8;
 Thu, 19 Dec 2019 17:24:55 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-53.ams2.redhat.com [10.36.117.53])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 23308620C0;
 Thu, 19 Dec 2019 17:24:53 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 05/30] qemu-img: fix info --backing-chain --image-opts
Date: Thu, 19 Dec 2019 18:24:16 +0100
Message-Id: <20191219172441.7289-6-kwolf@redhat.com>
In-Reply-To: <20191219172441.7289-1-kwolf@redhat.com>
References: <20191219172441.7289-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 4LeXxaG4PQmVFyal_wRBLw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Only apply --image-opts to the topmost image when listing an entire
backing chain.  It is incorrect to treat backing filenames as image
options.  Assuming we have the backing chain t.IMGFMT.base <-
t.IMGFMT.mid <- t.IMGFMT, qemu-img info fails as follows:

  $ qemu-img info --backing-chain --image-opts \
      driver=3Dqcow2,file.driver=3Dfile,file.filename=3Dt.IMGFMT
  qemu-img: Could not open 'TEST_DIR/t.IMGFMT.mid': Cannot find device=3DTE=
ST_DIR/t.IMGFMT.mid nor node_name=3DTEST_DIR/t.IMGFMT.mid

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c                 |  3 ++
 tests/qemu-iotests/279     | 57 ++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/279.out | 35 +++++++++++++++++++++++
 tests/qemu-iotests/group   |  1 +
 4 files changed, 96 insertions(+)
 create mode 100755 tests/qemu-iotests/279
 create mode 100644 tests/qemu-iotests/279.out

diff --git a/qemu-img.c b/qemu-img.c
index 95a24b9762..6233b8ca56 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2680,7 +2680,10 @@ static ImageInfoList *collect_image_info_list(bool i=
mage_opts,
=20
         blk_unref(blk);
=20
+        /* Clear parameters that only apply to the topmost image */
         filename =3D fmt =3D NULL;
+        image_opts =3D false;
+
         if (chain) {
             if (info->has_full_backing_filename) {
                 filename =3D info->full_backing_filename;
diff --git a/tests/qemu-iotests/279 b/tests/qemu-iotests/279
new file mode 100755
index 0000000000..6682376808
--- /dev/null
+++ b/tests/qemu-iotests/279
@@ -0,0 +1,57 @@
+#!/usr/bin/env bash
+#
+# Test qemu-img --backing-chain --image-opts
+#
+# Copyright (C) 2019 Red Hat, Inc.
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
+seq=3D$(basename "$0")
+echo "QA output created by $seq"
+
+status=3D1=09# failure is the default!
+
+_cleanup()
+{
+    _cleanup_test_img
+    rm -f "$TEST_IMG.mid"
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+
+# Backing files are required...
+_supported_fmt qcow qcow2 vmdk qed
+_supported_proto file
+_supported_os Linux
+
+TEST_IMG=3D"$TEST_IMG.base" _make_test_img 64M
+TEST_IMG=3D"$TEST_IMG.mid" _make_test_img -b "$TEST_IMG.base"
+_make_test_img -b "$TEST_IMG.mid"
+
+echo
+echo '=3D=3D qemu-img info --backing-chain =3D=3D'
+_img_info --backing-chain | _filter_img_info
+
+echo
+echo '=3D=3D qemu-img info --backing-chain --image-opts =3D=3D'
+TEST_IMG=3D"driver=3Dqcow2,file.driver=3Dfile,file.filename=3D$TEST_IMG" _=
img_info --backing-chain --image-opts | _filter_img_info
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=3D0
diff --git a/tests/qemu-iotests/279.out b/tests/qemu-iotests/279.out
new file mode 100644
index 0000000000..f4dc6c69cb
--- /dev/null
+++ b/tests/qemu-iotests/279.out
@@ -0,0 +1,35 @@
+QA output created by 279
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D67108864
+Formatting 'TEST_DIR/t.IMGFMT.mid', fmt=3DIMGFMT size=3D67108864 backing_f=
ile=3DTEST_DIR/t.IMGFMT.base
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 backing_file=
=3DTEST_DIR/t.IMGFMT.mid
+
+=3D=3D qemu-img info --backing-chain =3D=3D
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 64 MiB (67108864 bytes)
+backing file: TEST_DIR/t.IMGFMT.mid
+
+image: TEST_DIR/t.IMGFMT.mid
+file format: IMGFMT
+virtual size: 64 MiB (67108864 bytes)
+backing file: TEST_DIR/t.IMGFMT.base
+
+image: TEST_DIR/t.IMGFMT.base
+file format: IMGFMT
+virtual size: 64 MiB (67108864 bytes)
+
+=3D=3D qemu-img info --backing-chain --image-opts =3D=3D
+image: TEST_DIR/t.IMGFMT
+file format: IMGFMT
+virtual size: 64 MiB (67108864 bytes)
+backing file: TEST_DIR/t.IMGFMT.mid
+
+image: TEST_DIR/t.IMGFMT.mid
+file format: IMGFMT
+virtual size: 64 MiB (67108864 bytes)
+backing file: TEST_DIR/t.IMGFMT.base
+
+image: TEST_DIR/t.IMGFMT.base
+file format: IMGFMT
+virtual size: 64 MiB (67108864 bytes)
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 6b10a6a762..eb57ddc72c 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -286,3 +286,4 @@
 272 rw
 273 backing quick
 277 rw quick
+279 rw backing quick
--=20
2.20.1


