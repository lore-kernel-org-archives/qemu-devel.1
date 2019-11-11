Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3D03C43331
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:18:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF40D21783
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:18:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GTA/Y3dP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF40D21783
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUCOt-0001fY-9u
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 11:18:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39386)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iUCA9-0000NN-Rg
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:03:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iUCA7-00039I-Hw
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:03:33 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52825
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iUCA5-00038N-0g
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:03:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573488208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kIme/mNdsrkmmm0aGxqarwdyfyoRKfnPiYA6KQ8nt1k=;
 b=GTA/Y3dP3xUr3ccttDKVnm9RBcoBLlFF1eZVQpy4MOBVetb+HMtX9QGWXgr0z1P31SHyJb
 HjrR3kBeZ/u3jIEsKOHwwxCn81GPJfoIpQ4W7rovGP0MKB8LnDoGhDlIfx7Bowz6SSdRLt
 UGzQJrKmVcaD/qrxz6hWUbu6fOJwIUA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-224-SUcwdxAGPYensn6jeUpPpA-1; Mon, 11 Nov 2019 11:03:22 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E0330107ACE4;
 Mon, 11 Nov 2019 16:03:20 +0000 (UTC)
Received: from localhost (ovpn-117-116.ams2.redhat.com [10.36.117.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5C8413DBB;
 Mon, 11 Nov 2019 16:03:20 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 v2 20/23] iotests: Use self.image_len in
 TestRepairQuorum
Date: Mon, 11 Nov 2019 17:02:13 +0100
Message-Id: <20191111160216.197086-21-mreitz@redhat.com>
In-Reply-To: <20191111160216.197086-1-mreitz@redhat.com>
References: <20191111160216.197086-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: SUcwdxAGPYensn6jeUpPpA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

041's TestRepairQuorum has its own image_len, no need to refer to
TestSingleDrive.  (This patch allows commenting out TestSingleDrive to
speed up 041 during test testing.)

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/041 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
index d636cb7f1d..0c1af45639 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -881,7 +881,7 @@ class TestRepairQuorum(iotests.QMPTestCase):
         # Add each individual quorum images
         for i in self.IMAGES:
             qemu_img('create', '-f', iotests.imgfmt, i,
-                     str(TestSingleDrive.image_len))
+                     str(self.image_len))
             # Assign a node name to each quorum image in order to manipula=
te
             # them
             opts =3D "node-name=3Dimg%i" % self.IMAGES.index(i)
--=20
2.23.0


