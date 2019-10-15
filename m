Return-Path: <SRS0=6OCO=YI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2137CECE588
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 14:38:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC7CB20854
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Oct 2019 14:38:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC7CB20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKNy3-0000WI-NC
	for qemu-devel@archiver.kernel.org; Tue, 15 Oct 2019 10:38:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36232)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iKNo4-0006tX-Dd
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 10:28:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iKNo3-0000AX-1P
 for qemu-devel@nongnu.org; Tue, 15 Oct 2019 10:28:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37386)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iKNny-00006Q-3r; Tue, 15 Oct 2019 10:28:08 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F359380167D;
 Tue, 15 Oct 2019 14:28:04 +0000 (UTC)
Received: from localhost (ovpn-117-226.ams2.redhat.com [10.36.117.226])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9330B60BC6;
 Tue, 15 Oct 2019 14:28:04 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 13/21] iotests: Avoid qemu-img create
Date: Tue, 15 Oct 2019 16:27:21 +0200
Message-Id: <20191015142729.18123-14-mreitz@redhat.com>
In-Reply-To: <20191015142729.18123-1-mreitz@redhat.com>
References: <20191015142729.18123-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.67]); Tue, 15 Oct 2019 14:28:05 +0000 (UTC)
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Use _make_test_img whenever possible.  This way, we will not ignore
user-specified image options.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 tests/qemu-iotests/094 | 2 +-
 tests/qemu-iotests/111 | 3 +--
 tests/qemu-iotests/123 | 2 +-
 tests/qemu-iotests/153 | 2 +-
 tests/qemu-iotests/200 | 4 ++--
 5 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/tests/qemu-iotests/094 b/tests/qemu-iotests/094
index 9343e09492..d645952d54 100755
--- a/tests/qemu-iotests/094
+++ b/tests/qemu-iotests/094
@@ -45,7 +45,7 @@ _supported_proto nbd
 _unsupported_imgopts "subformat=3DmonolithicFlat" "subformat=3DtwoGbMaxE=
xtentFlat"
=20
 _make_test_img 64M
-$QEMU_IMG create -f $IMGFMT "$TEST_DIR/source.$IMGFMT" 64M | _filter_img=
_create
+TEST_IMG_FILE=3D"$TEST_DIR/source.$IMGFMT" IMGPROTO=3Dfile _make_test_im=
g 64M
=20
 _launch_qemu -drive if=3Dnone,id=3Dsrc,file=3D"$TEST_DIR/source.$IMGFMT"=
,format=3Draw \
              -nodefaults
diff --git a/tests/qemu-iotests/111 b/tests/qemu-iotests/111
index 490a5bbcb5..3b43d1bd83 100755
--- a/tests/qemu-iotests/111
+++ b/tests/qemu-iotests/111
@@ -41,8 +41,7 @@ _supported_fmt qed qcow qcow2 vmdk
 _supported_proto file
 _unsupported_imgopts "subformat=3DmonolithicFlat" "subformat=3DtwoGbMaxE=
xtentFlat"
=20
-$QEMU_IMG create -f $IMGFMT -b "$TEST_IMG.inexistent" "$TEST_IMG" 2>&1 \
-    | _filter_testdir | _filter_imgfmt
+_make_test_img -b "$TEST_IMG.inexistent"
=20
 # success, all done
 echo '*** done'
diff --git a/tests/qemu-iotests/123 b/tests/qemu-iotests/123
index d33950eb54..74d40d0478 100755
--- a/tests/qemu-iotests/123
+++ b/tests/qemu-iotests/123
@@ -44,7 +44,7 @@ _supported_os Linux
 SRC_IMG=3D"$TEST_DIR/source.$IMGFMT"
=20
 _make_test_img 1M
-$QEMU_IMG create -f $IMGFMT "$SRC_IMG" 1M | _filter_img_create
+TEST_IMG_FILE=3D$SRC_IMG IMGPROTO=3Dfile _make_test_img 1M
=20
 $QEMU_IO -c 'write -P 42 0 1M' "$SRC_IMG" | _filter_qemu_io
=20
diff --git a/tests/qemu-iotests/153 b/tests/qemu-iotests/153
index c969a1a16f..e59090259c 100755
--- a/tests/qemu-iotests/153
+++ b/tests/qemu-iotests/153
@@ -98,7 +98,7 @@ for opts1 in "" "read-only=3Don" "read-only=3Don,force-=
share=3Don"; do
=20
     echo
     echo "=3D=3D Creating test image =3D=3D"
-    $QEMU_IMG create -f $IMGFMT "${TEST_IMG}" -b ${TEST_IMG}.base | _fil=
ter_img_create
+    _make_test_img -b "${TEST_IMG}.base"
=20
     echo
     echo "=3D=3D Launching QEMU, opts: '$opts1' =3D=3D"
diff --git a/tests/qemu-iotests/200 b/tests/qemu-iotests/200
index 72d431f251..d904885136 100755
--- a/tests/qemu-iotests/200
+++ b/tests/qemu-iotests/200
@@ -46,8 +46,8 @@ _supported_proto file
 BACKING_IMG=3D"${TEST_DIR}/backing.img"
 TEST_IMG=3D"${TEST_DIR}/test.img"
=20
-${QEMU_IMG} create -f $IMGFMT "${BACKING_IMG}" 512M | _filter_img_create
-${QEMU_IMG} create -f $IMGFMT -F $IMGFMT "${TEST_IMG}" -b "${BACKING_IMG=
}" 512M | _filter_img_create
+TEST_IMG=3D"$BACKING_IMG" _make_test_img 512M
+_make_test_img -F $IMGFMT -b "$BACKING_IMG" 512M
=20
 ${QEMU_IO} -c "write -P 0xa5 512 300M" "${BACKING_IMG}" | _filter_qemu_i=
o
=20
--=20
2.21.0


