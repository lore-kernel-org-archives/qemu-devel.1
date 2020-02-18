Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AD1C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:11:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9443F21D56
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 14:11:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H0HUKxZj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9443F21D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35778 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j43ac-0004lf-P3
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 09:11:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52817)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1j43Xi-0006s9-8k
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1j43Xh-0001Qj-2R
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:06 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45485
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1j43Xg-0001Q8-UC
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 09:08:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582034884;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vIDUTk9KHLVtiPqrbiBrAB8rWaD4h3Txg7iB+zN3HpQ=;
 b=H0HUKxZjI3A8EDF6ve1QR3CfFF+WTmBOFdc3jCJVRbjYnGWoKqyqsAucctc8ywhH3u2V5v
 Tm0dib0OycPKWrIqMtT5shsQ7Uq4Dh62KBm2twgOSPhdUe9gjFs7tAxrLGNA4JpB3eJyJV
 5vew/FyowOqYENMdqhr9BR6iJ+bg3og=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-YmKNp4VSMjer_HUrjhHprA-1; Tue, 18 Feb 2020 09:08:02 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4176F8010E8;
 Tue, 18 Feb 2020 14:08:01 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-181.ams2.redhat.com
 [10.36.117.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3A8A18B549;
 Tue, 18 Feb 2020 14:08:00 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 07/36] iotests: Test copy offloading with external data file
Date: Tue, 18 Feb 2020 15:06:53 +0100
Message-Id: <20200218140722.23876-8-kwolf@redhat.com>
In-Reply-To: <20200218140722.23876-1-kwolf@redhat.com>
References: <20200218140722.23876-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: YmKNp4VSMjer_HUrjhHprA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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

This adds a test for 'qemu-img convert' with copy offloading where the
target image has an external data file. If the test hosts supports it,
it tests both the case where copy offloading is supported and the case
where it isn't (otherwise we just test unsupported twice).

More specifically, the case with unsupported copy offloading tests
qcow2_alloc_cluster_abort() with external data files.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200211094900.17315-4-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/244     | 14 ++++++++++++++
 tests/qemu-iotests/244.out |  6 ++++++
 2 files changed, 20 insertions(+)

diff --git a/tests/qemu-iotests/244 b/tests/qemu-iotests/244
index 0d1efee6ef..2ec1815e6f 100755
--- a/tests/qemu-iotests/244
+++ b/tests/qemu-iotests/244
@@ -197,6 +197,20 @@ $QEMU_IO -c 'read -P 0x11 0 1M' -f $IMGFMT "$TEST_IMG"=
 | _filter_qemu_io
 $QEMU_IMG map --output=3Dhuman "$TEST_IMG" | _filter_testdir
 $QEMU_IMG map --output=3Djson "$TEST_IMG"
=20
+echo
+echo "=3D=3D=3D Copy offloading =3D=3D=3D"
+echo
+
+# Make use of copy offloading if the test host can provide it
+_make_test_img -o "data_file=3D$TEST_IMG.data" 64M
+$QEMU_IMG convert -f $IMGFMT -O $IMGFMT -n -C "$TEST_IMG.src" "$TEST_IMG"
+$QEMU_IMG compare -f $IMGFMT -F $IMGFMT "$TEST_IMG.src" "$TEST_IMG"
+
+# blkdebug doesn't support copy offloading, so this tests the error path
+$QEMU_IMG amend -f $IMGFMT -o "data_file=3Dblkdebug::$TEST_IMG.data" "$TES=
T_IMG"
+$QEMU_IMG convert -f $IMGFMT -O $IMGFMT -n -C "$TEST_IMG.src" "$TEST_IMG"
+$QEMU_IMG compare -f $IMGFMT -F $IMGFMT "$TEST_IMG.src" "$TEST_IMG"
+
 # success, all done
 echo "*** done"
 rm -f $seq.full
diff --git a/tests/qemu-iotests/244.out b/tests/qemu-iotests/244.out
index 6a3d0067cc..e6f4dc7993 100644
--- a/tests/qemu-iotests/244.out
+++ b/tests/qemu-iotests/244.out
@@ -122,4 +122,10 @@ Offset          Length          Mapped to       File
 0               0x100000        0               TEST_DIR/t.qcow2.data
 [{ "start": 0, "length": 1048576, "depth": 0, "zero": false, "data": true,=
 "offset": 0},
 { "start": 1048576, "length": 66060288, "depth": 0, "zero": true, "data": =
false}]
+
+=3D=3D=3D Copy offloading =3D=3D=3D
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864 data_file=3DT=
EST_DIR/t.IMGFMT.data
+Images are identical.
+Images are identical.
 *** done
--=20
2.20.1


