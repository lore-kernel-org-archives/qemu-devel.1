Return-Path: <SRS0=VGOL=SR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4310C10F0E
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 15:42:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6536120880
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2019 15:42:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6536120880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51914 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hG3l2-0007LC-5n
	for qemu-devel@archiver.kernel.org; Mon, 15 Apr 2019 11:42:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hG3jk-0006mq-Vm
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:41:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hG3jj-0004uv-T3
	for qemu-devel@nongnu.org; Mon, 15 Apr 2019 11:41:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52372)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hG3jh-0004r7-AW; Mon, 15 Apr 2019 11:41:33 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A4EE53092648;
	Mon, 15 Apr 2019 15:41:31 +0000 (UTC)
Received: from localhost (unknown [10.40.206.18])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 0795060BF3;
	Mon, 15 Apr 2019 15:41:30 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Mon, 15 Apr 2019 17:41:29 +0200
Message-Id: <20190415154129.31021-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Mon, 15 Apr 2019 15:41:31 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC] iotests: Fix iotests 110 and 126
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
	arbel.moshe@oracle.com, qemu-devel@nongnu.org,
	Max Reitz <mreitz@redhat.com>, liran.alon@oracle.com,
	yoav.elnekave@oracle.com, Sam Eiderman <shmuel.eiderman@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190415154129.szntK44YGZiVrkn8caUdHG0hv8pHKpLGdY8KNJniCYY@z>

A recent patch results in qemu-img reporting the backing file format of
vmdk images as vmdk.  This broke iotests 110 and 126.

Fixes: "vmdk: Set vmdk parent backing_format to vmdk"
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
RFC because:
(1) I'd prefer for this patch to be squashed into the patch mentioned
    above so we avoid broken iotests.
(2) Otherwise, I'd like for the "Fixes" line to contain a commit ID,
    which isn't stable yet, though.

I'd like to mention that these aren't the only broken iotests on
block-next; 059 (with vmdk) is broken, too.  I won't send a patch for
that, though, because to me the whole patch doesn't seem quite right
when compiling qemu with -m32.
---
 tests/qemu-iotests/110 | 10 +++++++---
 tests/qemu-iotests/126 | 10 +++++++---
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/110 b/tests/qemu-iotests/110
index fad672c1ae..33b169ffd4 100755
--- a/tests/qemu-iotests/110
+++ b/tests/qemu-iotests/110
@@ -53,8 +53,12 @@ TEST_IMG=3D"$TEST_IMG.base" _make_test_img 64M
 _make_test_img -b "$TEST_IMG_REL.base" 64M
 # qemu should be able to reconstruct the filename, so relative backing n=
ames
 # should work
+# (We have to filter the backing file format because vmdk always
+# reports it (as vmdk), whereas other image formats would do so only
+# with the backing_fmt creation option, which neither vmdk nor qcow
+# support)
 TEST_IMG=3D"json:{'driver':'$IMGFMT','file':{'driver':'file','filename':=
'$TEST_IMG'}}" \
-    _img_info | _filter_img_info
+    _img_info | _filter_img_info | grep -v 'backing file format'
=20
 echo
 echo '=3D=3D=3D Non-reconstructable filename =3D=3D=3D'
@@ -78,7 +82,7 @@ TEST_IMG=3D"json:{
             }
         ]
     }
-}" _img_info | _filter_img_info
+}" _img_info | _filter_img_info | grep -v 'backing file format'
=20
 echo
 echo '=3D=3D=3D Backing name is always relative to the backed image =3D=3D=
=3D'
@@ -110,7 +114,7 @@ TEST_IMG=3D"json:{
             }
         ]
     }
-}" _img_info | _filter_img_info
+}" _img_info | _filter_img_info | grep -v 'backing file format'
=20
=20
 # success, all done
diff --git a/tests/qemu-iotests/126 b/tests/qemu-iotests/126
index 96dc048d59..e3ee65c606 100755
--- a/tests/qemu-iotests/126
+++ b/tests/qemu-iotests/126
@@ -62,8 +62,12 @@ TOP_IMG=3D"$TEST_DIR/image:top.$IMGFMT"
 TEST_IMG=3D$BASE_IMG _make_test_img 64M
 TEST_IMG=3D$TOP_IMG _make_test_img -b ./image:base.$IMGFMT
=20
-# The default cluster size depends on the image format
-TEST_IMG=3D$TOP_IMG _img_info | grep -v 'cluster_size'
+# (1) The default cluster size depends on the image format
+# (2) vmdk only supports vmdk backing files, so it always reports the
+#     format of its backing file as such (but neither it nor qcow
+#     support the backing_fmt creation option, so we cannot use that to
+#     harmonize the output across all image formats this test supports)
+TEST_IMG=3D$TOP_IMG _img_info | grep -ve 'cluster_size' -e 'backing file=
 format'
=20
 _rm_test_img "$BASE_IMG"
 _rm_test_img "$TOP_IMG"
@@ -79,7 +83,7 @@ TOP_IMG=3D"file:image:top.$IMGFMT"
 TEST_IMG=3D$BASE_IMG _make_test_img 64M
 TEST_IMG=3D$TOP_IMG _make_test_img -b "$BASE_IMG"
=20
-TEST_IMG=3D$TOP_IMG _img_info | grep -v 'cluster_size'
+TEST_IMG=3D$TOP_IMG _img_info | grep -ve 'cluster_size' -e 'backing file=
 format'
=20
 _rm_test_img "$BASE_IMG"
 _rm_test_img "image:top.$IMGFMT"
--=20
2.20.1


