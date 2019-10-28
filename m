Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308E8CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:19:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEA152086D
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XQc2qqvY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEA152086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP3ze-0005RC-Cn
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 08:19:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49707)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP3vU-000169-7D
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP3vS-00018X-VY
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:12 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47099
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP3vS-00017t-RW
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572264910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WZKGwwrQNIsZCQmXWzekNWbQo7lQgOe1Uzx83/bgdcA=;
 b=XQc2qqvYSUaxq0UB4r8+0hLVjnF4hN8LviXHwzwKoUA/WSzmno1tTDpRah2Gpn4CI3k3Kp
 HHTRyhkGOS1NJyUdT/Z1zhD9VdQfzjMJaybWDKXd86YZJhqG43JInfhjrfpqaGfOSH7AI9
 0v0yYyMN1B8kOGdjWiEjOcoHt4In1B0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-cAv2Zm1INu-ZXoyXqgbtYQ-1; Mon, 28 Oct 2019 08:15:06 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D25F7800FF1;
 Mon, 28 Oct 2019 12:15:05 +0000 (UTC)
Received: from localhost (ovpn-117-83.ams2.redhat.com [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 78793261A7;
 Mon, 28 Oct 2019 12:15:05 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 01/69] iotests: Prefer null-co over null-aio
Date: Mon, 28 Oct 2019 13:13:53 +0100
Message-Id: <20191028121501.15279-2-mreitz@redhat.com>
In-Reply-To: <20191028121501.15279-1-mreitz@redhat.com>
References: <20191028121501.15279-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: cAv2Zm1INu-ZXoyXqgbtYQ-1
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We use null-co basically everywhere in the iotests.  Unless we want to
test null-aio specifically, we should use it instead (for consistency).

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-id: 20190917092004.999-2-mreitz@redhat.com
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/093 | 7 +++----
 tests/qemu-iotests/245 | 2 +-
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/tests/qemu-iotests/093 b/tests/qemu-iotests/093
index 3c4f5173ce..50c1e7f2ec 100755
--- a/tests/qemu-iotests/093
+++ b/tests/qemu-iotests/093
@@ -267,13 +267,12 @@ class ThrottleTestCoroutine(ThrottleTestCase):
     test_img =3D "null-co://"
=20
 class ThrottleTestGroupNames(iotests.QMPTestCase):
-    test_img =3D "null-aio://"
     max_drives =3D 3
=20
     def setUp(self):
         self.vm =3D iotests.VM()
         for i in range(0, self.max_drives):
-            self.vm.add_drive(self.test_img,
+            self.vm.add_drive("null-co://",
                               "throttling.iops-total=3D100,file.read-zeroe=
s=3Don")
         self.vm.launch()
=20
@@ -376,10 +375,10 @@ class ThrottleTestRemovableMedia(iotests.QMPTestCase)=
:
=20
     def test_removable_media(self):
         # Add a couple of dummy nodes named cd0 and cd1
-        result =3D self.vm.qmp("blockdev-add", driver=3D"null-aio",
+        result =3D self.vm.qmp("blockdev-add", driver=3D"null-co",
                              read_zeroes=3DTrue, node_name=3D"cd0")
         self.assert_qmp(result, 'return', {})
-        result =3D self.vm.qmp("blockdev-add", driver=3D"null-aio",
+        result =3D self.vm.qmp("blockdev-add", driver=3D"null-co",
                              read_zeroes=3DTrue, node_name=3D"cd1")
         self.assert_qmp(result, 'return', {})
=20
diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
index 41218d5f1d..e66a23c5f0 100644
--- a/tests/qemu-iotests/245
+++ b/tests/qemu-iotests/245
@@ -598,7 +598,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
         ##################
         ###### null ######
         ##################
-        opts =3D {'driver': 'null-aio', 'node-name': 'root', 'size': 1024}
+        opts =3D {'driver': 'null-co', 'node-name': 'root', 'size': 1024}
=20
         result =3D self.vm.qmp('blockdev-add', conv_keys =3D False, **opts=
)
         self.assert_qmp(result, 'return', {})
--=20
2.21.0


