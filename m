Return-Path: <SRS0=d4IR=4I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20879C11D05
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:17:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF25A20659
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2020 16:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LMgw5oHb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF25A20659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45290 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4oWC-0001f4-03
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 11:17:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54976)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j4oOj-0005im-E0
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:09:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j4oOi-0006Bb-Bm
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:09:57 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48921
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j4oOi-0006BQ-87
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 11:09:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582214995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cxlR7vKbANcUPIfyDMHCSg6ZxhMzW1WqgzZTqXEeqG4=;
 b=LMgw5oHbQH5Ifnoo3S+Z+bH17L8tK8XpWG69aI7AN3rfWLcmJgwK7v2QOSz0jK+RC21J9e
 sTUyb8+uugu5w37Rx1bOpAk5xFU7BwChpYfBIPnQF2JMdH/A+ezlBRF7uYvsPkLQd8cxWW
 9TSpP4pjaeY4WvjuIl+jia6RB0HYMCU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-h7Nv1wEEPNeyXLPm67D9cw-1; Thu, 20 Feb 2020 11:09:51 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A52A71005512;
 Thu, 20 Feb 2020 16:09:50 +0000 (UTC)
Received: from localhost (unknown [10.36.118.38])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C71A291820;
 Thu, 20 Feb 2020 16:09:47 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 09/18] iotests/279: Fix for non-qcow2 formats
Date: Thu, 20 Feb 2020 17:07:01 +0100
Message-Id: <20200220160710.533297-10-mreitz@redhat.com>
In-Reply-To: <20200220160710.533297-1-mreitz@redhat.com>
References: <20200220160710.533297-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: h7Nv1wEEPNeyXLPm67D9cw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
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
Message-Id: <20191219144243.1763246-1-mreitz@redhat.com>
Tested-by: Thomas Huth <thuth@redhat.com>
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
2.24.1


