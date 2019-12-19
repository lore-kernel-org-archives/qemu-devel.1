Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7DA0C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:56:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7377820684
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 14:56:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jL2nCr1I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7377820684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihxEB-0005NW-Gy
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 09:56:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50728)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ihx0u-0002eL-8Y
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:42:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ihx0t-0007NL-1S
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:42:52 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:46309
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ihx0s-0007LA-U9
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 09:42:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576766570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wNmQiC9ZrGOdwt0701lLFiP+74WWu7YPslv0UzWz0UM=;
 b=jL2nCr1IkcbS/xUI6JfS8/q1AcXE94wbB51ktlt/W39Z0SEE53NmgJeAGnMo6kL3rsDQ0B
 DlgKNywrMT2Fd1C/YYNnrGV0ZNH2KxExj1Lx6+b1yl9Bu+99ZixzxPACQHM83Dv+Hx3lMn
 Q576tXqDKFfh76qxcYcsle1zYPP7Rng=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-325-86tSfXpJMQSZSp7cHxAtfQ-1; Thu, 19 Dec 2019 09:42:47 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 27D0D8005B5;
 Thu, 19 Dec 2019 14:42:46 +0000 (UTC)
Received: from localhost (ovpn-205-138.brq.redhat.com [10.40.205.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B36055D9CD;
 Thu, 19 Dec 2019 14:42:45 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH] iotests/279: Fix for non-qcow2 formats
Date: Thu, 19 Dec 2019 15:42:43 +0100
Message-Id: <20191219144243.1763246-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 86tSfXpJMQSZSp7cHxAtfQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

First, driver=3Dqcow2 will not work so well with non-qcow2 formats (and
this test claims to support qcow, qed, and vmdk).

Second, vmdk will always report the backing file format to be vmdk.
Filter that out so the output looks like for all other formats.

Third, the flat vmdk subformats do not support backing files, so they
will not work with this test.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/279 | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/279 b/tests/qemu-iotests/279
index 6682376808..30d29b1cb2 100755
--- a/tests/qemu-iotests/279
+++ b/tests/qemu-iotests/279
@@ -38,6 +38,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 _supported_fmt qcow qcow2 vmdk qed
 _supported_proto file
 _supported_os Linux
+_unsupported_imgopts "subformat=3DmonolithicFlat" \
+                     "subformat=3DtwoGbMaxExtentFlat" \
=20
 TEST_IMG=3D"$TEST_IMG.base" _make_test_img 64M
 TEST_IMG=3D"$TEST_IMG.mid" _make_test_img -b "$TEST_IMG.base"
@@ -45,11 +47,12 @@ _make_test_img -b "$TEST_IMG.mid"
=20
 echo
 echo '=3D=3D qemu-img info --backing-chain =3D=3D'
-_img_info --backing-chain | _filter_img_info
+_img_info --backing-chain | _filter_img_info | grep -v 'backing file forma=
t'
=20
 echo
 echo '=3D=3D qemu-img info --backing-chain --image-opts =3D=3D'
-TEST_IMG=3D"driver=3Dqcow2,file.driver=3Dfile,file.filename=3D$TEST_IMG" _=
img_info --backing-chain --image-opts | _filter_img_info
+TEST_IMG=3D"driver=3D$IMGFMT,file.driver=3Dfile,file.filename=3D$TEST_IMG"=
 _img_info --backing-chain --image-opts \
+    | _filter_img_info | grep -v 'backing file format'
=20
 # success, all done
 echo "*** done"
--=20
2.23.0


