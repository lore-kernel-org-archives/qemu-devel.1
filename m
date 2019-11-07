Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F706C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 16:41:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0A112087E
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 16:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QC38qTnM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0A112087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSkr7-0008VM-KV
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 11:41:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42494)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iSkml-0002p7-L1
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:37:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iSkmk-0005a7-8s
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:37:27 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56200
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iSkmk-0005Ze-5I
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 11:37:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573144645;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O7HEiW3x3N7L9UuZAz3QDeD1idqO8sas2Xrf9+oL1f4=;
 b=QC38qTnM7heSnIfkTm2JPLbefXPtqmywv7QH06+ULSxw+AJHU5jagVZ63Gn0Yqt45qHFwc
 RDaIzfKiRuI8Z0xmOMf9Pr6zUoAcr9KFvJS1wKEbbjYVLsO7Eu2AxaF9Q6Fnpv2KhFPJEB
 eUytOIKMT/mWip75EY3asQ8Xjhx3nVo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-0PvwgImfPKWZnkGLjXcCKg-1; Thu, 07 Nov 2019 11:37:21 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F2B09107ACC3;
 Thu,  7 Nov 2019 16:37:20 +0000 (UTC)
Received: from localhost (ovpn-117-149.ams2.redhat.com [10.36.117.149])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F62C5C298;
 Thu,  7 Nov 2019 16:37:20 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 05/22] iotests: Filter refcount_order in 036
Date: Thu,  7 Nov 2019 17:36:51 +0100
Message-Id: <20191107163708.833192-6-mreitz@redhat.com>
In-Reply-To: <20191107163708.833192-1-mreitz@redhat.com>
References: <20191107163708.833192-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: 0PvwgImfPKWZnkGLjXcCKg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Kevin Wolf <kwolf@redhat.com>, Maxim Levitsky <mlevitsk@redhat.com>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This test can run just fine with other values for refcount_bits, so we
should filter the value from qcow2.py's dump-header.  In fact, we can
filter everything but the feature bits and header extensions, because
that is what the test is about.

(036 currently ignores user-specified image options, but that will be
fixed in the next patch.)

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 tests/qemu-iotests/036     |  9 ++++---
 tests/qemu-iotests/036.out | 48 --------------------------------------
 2 files changed, 6 insertions(+), 51 deletions(-)

diff --git a/tests/qemu-iotests/036 b/tests/qemu-iotests/036
index f06ff67408..5f929ad3be 100755
--- a/tests/qemu-iotests/036
+++ b/tests/qemu-iotests/036
@@ -55,7 +55,8 @@ $PYTHON qcow2.py "$TEST_IMG" set-feature-bit incompatible=
 63
=20
 # Without feature table
 $PYTHON qcow2.py "$TEST_IMG" del-header-ext 0x6803f857
-$PYTHON qcow2.py "$TEST_IMG" dump-header
+$PYTHON qcow2.py "$TEST_IMG" dump-header | grep features
+$PYTHON qcow2.py "$TEST_IMG" dump-header-exts
 _img_info
=20
 # With feature table containing bit 63
@@ -103,14 +104,16 @@ echo =3D=3D=3D Create image with unknown autoclear fe=
ature bit =3D=3D=3D
 echo
 _make_test_img 64M
 $PYTHON qcow2.py "$TEST_IMG" set-feature-bit autoclear 63
-$PYTHON qcow2.py "$TEST_IMG" dump-header
+$PYTHON qcow2.py "$TEST_IMG" dump-header | grep features
+$PYTHON qcow2.py "$TEST_IMG" dump-header-exts
=20
 echo
 echo =3D=3D=3D Repair image =3D=3D=3D
 echo
 _check_test_img -r all
=20
-$PYTHON qcow2.py "$TEST_IMG" dump-header
+$PYTHON qcow2.py "$TEST_IMG" dump-header | grep features
+$PYTHON qcow2.py "$TEST_IMG" dump-header-exts
=20
 # success, all done
 echo "*** done"
diff --git a/tests/qemu-iotests/036.out b/tests/qemu-iotests/036.out
index 15229a9604..0b52b934e1 100644
--- a/tests/qemu-iotests/036.out
+++ b/tests/qemu-iotests/036.out
@@ -3,25 +3,9 @@ QA output created by 036
 =3D=3D=3D Image with unknown incompatible feature bit =3D=3D=3D
=20
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
-magic                     0x514649fb
-version                   3
-backing_file_offset       0x0
-backing_file_size         0x0
-cluster_bits              16
-size                      67108864
-crypt_method              0
-l1_size                   1
-l1_table_offset           0x30000
-refcount_table_offset     0x10000
-refcount_table_clusters   1
-nb_snapshots              0
-snapshot_offset           0x0
 incompatible_features     [63]
 compatible_features       []
 autoclear_features        []
-refcount_order            4
-header_length             104
-
 qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Unsupported IMGFMT feature(s=
): Unknown incompatible feature: 8000000000000000
 qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Unsupported IMGFMT feature(s=
): Test feature
=20
@@ -37,25 +21,9 @@ qemu-img: Could not open 'TEST_DIR/t.IMGFMT': Unsupporte=
d IMGFMT feature(s): tes
 =3D=3D=3D Create image with unknown autoclear feature bit =3D=3D=3D
=20
 Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
-magic                     0x514649fb
-version                   3
-backing_file_offset       0x0
-backing_file_size         0x0
-cluster_bits              16
-size                      67108864
-crypt_method              0
-l1_size                   1
-l1_table_offset           0x30000
-refcount_table_offset     0x10000
-refcount_table_clusters   1
-nb_snapshots              0
-snapshot_offset           0x0
 incompatible_features     []
 compatible_features       []
 autoclear_features        [63]
-refcount_order            4
-header_length             104
-
 Header extension:
 magic                     0x6803f857
 length                    192
@@ -65,25 +33,9 @@ data                      <binary>
 =3D=3D=3D Repair image =3D=3D=3D
=20
 No errors were found on the image.
-magic                     0x514649fb
-version                   3
-backing_file_offset       0x0
-backing_file_size         0x0
-cluster_bits              16
-size                      67108864
-crypt_method              0
-l1_size                   1
-l1_table_offset           0x30000
-refcount_table_offset     0x10000
-refcount_table_clusters   1
-nb_snapshots              0
-snapshot_offset           0x0
 incompatible_features     []
 compatible_features       []
 autoclear_features        []
-refcount_order            4
-header_length             104
-
 Header extension:
 magic                     0x6803f857
 length                    192
--=20
2.23.0


