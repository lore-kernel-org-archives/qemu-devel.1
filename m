Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD65CC4CEC5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 13:49:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6A352075C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 13:49:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6A352075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8PTb-00051I-U7
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 09:49:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39188)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i8PQm-0002qG-Vb
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:46:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i8PQl-0001Px-RA
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 09:46:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49746)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i8PQj-0001O7-IJ; Thu, 12 Sep 2019 09:46:37 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D98CF3082E57;
 Thu, 12 Sep 2019 13:46:36 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-179.ams2.redhat.com
 [10.36.116.179])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C9876600C4;
 Thu, 12 Sep 2019 13:46:35 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 12 Sep 2019 15:45:52 +0200
Message-Id: <20190912134604.22019-11-kwolf@redhat.com>
In-Reply-To: <20190912134604.22019-1-kwolf@redhat.com>
References: <20190912134604.22019-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Thu, 12 Sep 2019 13:46:36 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 10/22] iotests: Restrict nbd Python tests to nbd
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

From: Max Reitz <mreitz@redhat.com>

We have two Python unittest-style tests that test NBD.  As such, they
should specify supported_protocols=3D['nbd'] so they are skipped when the
user wants to test some other protocol.

Furthermore, we should restrict their choice of formats to 'raw'.  The
idea of a protocol/format combination is to use some format over some
protocol; but we always use the raw format over NBD.  It does not really
matter what the NBD server uses on its end, and it is not a useful test
of the respective format driver anyway.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/147 | 5 ++---
 tests/qemu-iotests/205 | 3 ++-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/tests/qemu-iotests/147 b/tests/qemu-iotests/147
index 2d84fddb01..ab8480b9a4 100755
--- a/tests/qemu-iotests/147
+++ b/tests/qemu-iotests/147
@@ -287,6 +287,5 @@ class BuiltinNBD(NBDBlockdevAddBase):
=20
=20
 if __name__ =3D=3D '__main__':
-    # Need to support image creation
-    iotests.main(supported_fmts=3D['vpc', 'parallels', 'qcow', 'vdi', 'q=
cow2',
-                                 'vmdk', 'raw', 'vhdx', 'qed'])
+    iotests.main(supported_fmts=3D['raw'],
+                 supported_protocols=3D['nbd'])
diff --git a/tests/qemu-iotests/205 b/tests/qemu-iotests/205
index b8a86c446e..76f6c5fa2b 100755
--- a/tests/qemu-iotests/205
+++ b/tests/qemu-iotests/205
@@ -153,4 +153,5 @@ class TestNbdServerRemove(iotests.QMPTestCase):
=20
=20
 if __name__ =3D=3D '__main__':
-    iotests.main(supported_fmts=3D['generic'])
+    iotests.main(supported_fmts=3D['raw'],
+                 supported_protocols=3D['nbd'])
--=20
2.20.1


