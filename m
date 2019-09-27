Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A009C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 09:50:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1975E2146E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 09:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1975E2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDmsz-0001L9-Tq
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 05:50:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33553)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iDmmZ-0003gR-KN
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:43:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iDmmY-00081Y-9l
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 05:43:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35236)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iDmmV-0007tX-Ij; Fri, 27 Sep 2019 05:43:19 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C297E4FCD9;
 Fri, 27 Sep 2019 09:43:18 +0000 (UTC)
Received: from localhost (ovpn-204-76.brq.redhat.com [10.40.204.76])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5BA03600C6;
 Fri, 27 Sep 2019 09:43:18 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 14/18] iotests: Make 110 work with data_file
Date: Fri, 27 Sep 2019 11:42:38 +0200
Message-Id: <20190927094242.11152-15-mreitz@redhat.com>
In-Reply-To: <20190927094242.11152-1-mreitz@redhat.com>
References: <20190927094242.11152-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Fri, 27 Sep 2019 09:43:18 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The only difference is that the json:{} filename of the image looks
different.  We actually do not care about that filename in this test, we
are only interested in (1) that there is a json:{} filename, and (2)
whether the backing filename can be constructed.

So just filter out the json:{} data, thus making this test pass both
with and without data_file.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/110     | 7 +++++--
 tests/qemu-iotests/110.out | 4 ++--
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/110 b/tests/qemu-iotests/110
index f78df0e6e1..34459dcd60 100755
--- a/tests/qemu-iotests/110
+++ b/tests/qemu-iotests/110
@@ -67,6 +67,7 @@ echo
 # Across blkdebug without a config file, you cannot reconstruct filename=
s, so
 # qemu is incapable of knowing the directory of the top image from the f=
ilename
 # alone. However, using bdrv_dirname(), it should still work.
+# (Filter out the json:{} filename so this test works with external data=
 files)
 TEST_IMG=3D"json:{
     'driver': '$IMGFMT',
     'file': {
@@ -82,7 +83,8 @@ TEST_IMG=3D"json:{
             }
         ]
     }
-}" _img_info | _filter_img_info | grep -v 'backing file format'
+}" _img_info | _filter_img_info | grep -v 'backing file format' \
+    | sed -e 's#^image: json:.*#image: json:{ /* filtered */ }#'
=20
 echo
 echo '=3D=3D=3D Backing name is always relative to the backed image =3D=3D=
=3D'
@@ -114,7 +116,8 @@ TEST_IMG=3D"json:{
             }
         ]
     }
-}" _img_info | _filter_img_info | grep -v 'backing file format'
+}" _img_info | _filter_img_info | grep -v 'backing file format' \
+    | sed -e 's#^image: json:.*#image: json:{ /* filtered */ }#'
=20
=20
 # success, all done
diff --git a/tests/qemu-iotests/110.out b/tests/qemu-iotests/110.out
index f60b26390e..f835553a99 100644
--- a/tests/qemu-iotests/110.out
+++ b/tests/qemu-iotests/110.out
@@ -11,7 +11,7 @@ backing file: t.IMGFMT.base (actual path: TEST_DIR/t.IM=
GFMT.base)
=20
 =3D=3D=3D Non-reconstructable filename =3D=3D=3D
=20
-image: json:{"driver": "IMGFMT", "file": {"set-state.0.event": "read_aio=
", "image": {"driver": "file", "filename": "TEST_DIR/t.IMGFMT"}, "driver"=
: "blkdebug", "set-state.0.new_state": 42}}
+image: json:{ /* filtered */ }
 file format: IMGFMT
 virtual size: 64 MiB (67108864 bytes)
 backing file: t.IMGFMT.base (actual path: TEST_DIR/t.IMGFMT.base)
@@ -22,7 +22,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D671=
08864 backing_file=3Dt.IMGFMT.b
=20
 =3D=3D=3D Nodes without a common directory =3D=3D=3D
=20
-image: json:{"driver": "IMGFMT", "file": {"children": [{"driver": "file"=
, "filename": "TEST_DIR/t.IMGFMT"}, {"driver": "file", "filename": "TEST_=
DIR/t.IMGFMT.copy"}], "driver": "quorum", "vote-threshold": 1}}
+image: json:{ /* filtered */ }
 file format: IMGFMT
 virtual size: 64 MiB (67108864 bytes)
 backing file: t.IMGFMT.base (cannot determine actual path)
--=20
2.21.0


