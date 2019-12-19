Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81128C3F68F
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:51:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EB9E2053B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:51:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IC8l/zLI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EB9E2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihx8u-0005UM-7V
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:51:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58656)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ihwxQ-0005Sd-Bd
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:39:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ihwxO-0006ip-CV
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:39:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:36402
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ihwxM-0006gi-JI
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:39:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576766351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2o6mDr1fG8NU9piwSzBHbLnyfs5bDrLIaLkFwXpQBd8=;
 b=IC8l/zLIqtPrI+gl4lVdByiPtofrbql6DedFd23T2RM5HlRU9BlbTloXva7lySd5qJ4mrc
 5FeeBxfYqhT2PlI06tXiqEmtjm8MbewLLaB8Y/k/NXF4l/EGj/U6UbnV64vWuhr6gZ5jzz
 V6ffOgAO1V6gYuVXBi5E9/CbW9+Xv/s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-246-evVQ1u4uNMOt03rTdSzGMg-1; Thu, 19 Dec 2019 09:39:07 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C37C9100F08C;
 Thu, 19 Dec 2019 14:39:06 +0000 (UTC)
Received: from localhost (ovpn-205-138.brq.redhat.com [10.40.205.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A84F963F60;
 Thu, 19 Dec 2019 14:39:05 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 12/18] iotests: Derive image names from $TEST_IMG
Date: Thu, 19 Dec 2019 15:38:12 +0100
Message-Id: <20191219143818.1646168-13-mreitz@redhat.com>
In-Reply-To: <20191219143818.1646168-1-mreitz@redhat.com>
References: <20191219143818.1646168-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: evVQ1u4uNMOt03rTdSzGMg-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Avoid creating images with custom filenames in $TEST_DIR, because
non-file protocols may want to keep $TEST_IMG (and all other test
images) in some other directory.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/200     | 3 +--
 tests/qemu-iotests/200.out | 4 ++--
 tests/qemu-iotests/229     | 3 +--
 tests/qemu-iotests/229.out | 6 +++---
 4 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/tests/qemu-iotests/200 b/tests/qemu-iotests/200
index a2cdd7f83d..616b632a86 100755
--- a/tests/qemu-iotests/200
+++ b/tests/qemu-iotests/200
@@ -44,8 +44,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow2 qed
 _supported_proto file
=20
-BACKING_IMG=3D"${TEST_DIR}/backing.img"
-TEST_IMG=3D"${TEST_DIR}/test.img"
+BACKING_IMG=3D"$TEST_IMG.base"
=20
 TEST_IMG=3D"$BACKING_IMG" _make_test_img 512M
 _make_test_img -F $IMGFMT -b "$BACKING_IMG" 512M
diff --git a/tests/qemu-iotests/200.out b/tests/qemu-iotests/200.out
index a6776070e4..5883f16ac3 100644
--- a/tests/qemu-iotests/200.out
+++ b/tests/qemu-iotests/200.out
@@ -1,6 +1,6 @@
 QA output created by 200
-Formatting 'TEST_DIR/backing.img', fmt=3DIMGFMT size=3D536870912
-Formatting 'TEST_DIR/test.img', fmt=3DIMGFMT size=3D536870912 backing_file=
=3DTEST_DIR/backing.img backing_fmt=3DIMGFMT
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D536870912
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D536870912 backing_file=
=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
 wrote 314572800/314572800 bytes at offset 512
 300 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
=20
diff --git a/tests/qemu-iotests/229 b/tests/qemu-iotests/229
index 866168b236..abc88f881f 100755
--- a/tests/qemu-iotests/229
+++ b/tests/qemu-iotests/229
@@ -47,8 +47,7 @@ _supported_proto file
 _supported_os Linux
=20
=20
-DEST_IMG=3D"$TEST_DIR/d.$IMGFMT"
-TEST_IMG=3D"$TEST_DIR/b.$IMGFMT"
+DEST_IMG=3D"$TEST_IMG.dest"
=20
 _make_test_img 2M
=20
diff --git a/tests/qemu-iotests/229.out b/tests/qemu-iotests/229.out
index 22350d75d7..ef96b85062 100644
--- a/tests/qemu-iotests/229.out
+++ b/tests/qemu-iotests/229.out
@@ -1,6 +1,6 @@
 QA output created by 229
-Formatting 'TEST_DIR/b.IMGFMT', fmt=3DIMGFMT size=3D2097152
-Formatting 'TEST_DIR/d.IMGFMT', fmt=3DIMGFMT size=3D1048576
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D2097152
+Formatting 'TEST_DIR/t.IMGFMT.dest', fmt=3DIMGFMT size=3D1048576
 wrote 2097152/2097152 bytes at offset 0
 2 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {'execute': 'qmp_capabilities'}
@@ -8,7 +8,7 @@ wrote 2097152/2097152 bytes at offset 0
=20
 =3D=3D=3D Starting drive-mirror, causing error & stop  =3D=3D=3D
=20
-{'execute': 'drive-mirror', 'arguments': {'device': 'testdisk', 'format': =
'IMGFMT', 'target': 'TEST_DIR/d.IMGFMT', 'sync': 'full', 'mode': 'existing'=
, 'on-source-error': 'stop', 'on-target-error': 'stop' }}
+{'execute': 'drive-mirror', 'arguments': {'device': 'testdisk', 'format': =
'IMGFMT', 'target': 'TEST_DIR/t.IMGFMT.dest', 'sync': 'full', 'mode': 'exis=
ting', 'on-source-error': 'stop', 'on-target-error': 'stop' }}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "testdisk"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event"=
: "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "testdisk"}}
 {"return": {}}
--=20
2.23.0


