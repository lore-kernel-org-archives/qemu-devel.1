Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234EFC43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 10:50:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E722B21582
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 10:50:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VwY3csBf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E722B21582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihWuV-00089h-Lb
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 05:50:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38933)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ihWtA-0006iN-4C
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 05:49:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ihWt8-0000Mp-RW
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 05:49:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:60181
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ihWt8-0000LQ-NS
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 05:49:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576666146;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NQ8blW1zn3dXW9hfEFpcNE5wS+a4gWHTkFia3wL65/w=;
 b=VwY3csBf0wdrynaq8GGmIRYBQay9VYv7o+bTf4bARgGuCsRQTkWFGy5Fau8vp6+9MyPJMp
 vmaUJDBV01rCiEc2zZaFytM8gSGUZd4prQTVSwUiNFNfon9kYFjSnZSgFkr4s4h+nV8s/Y
 0iEGTD7PNakXWFzBqeKegqacYl9JALE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-Qg5KZFqLMB66xzHr8O1D5w-1; Wed, 18 Dec 2019 05:49:03 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E77ADB61;
 Wed, 18 Dec 2019 10:49:02 +0000 (UTC)
Received: from localhost (ovpn-205-177.brq.redhat.com [10.40.205.177])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 05E225D9E2;
 Wed, 18 Dec 2019 10:49:01 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 2/2] iotests: Fix IMGOPTSSYNTAX for nbd
Date: Wed, 18 Dec 2019 11:48:55 +0100
Message-Id: <20191218104855.42566-3-mreitz@redhat.com>
In-Reply-To: <20191218104855.42566-1-mreitz@redhat.com>
References: <20191218104855.42566-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: Qg5KZFqLMB66xzHr8O1D5w-1
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

There is no $SOCKDIR, only $SOCK_DIR.

Fixes: f3923a72f199b2c63747a7032db74730546f55c6
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/common.rc | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/common.rc b/tests/qemu-iotests/common.rc
index ffb47c3d5c..d088392ab6 100644
--- a/tests/qemu-iotests/common.rc
+++ b/tests/qemu-iotests/common.rc
@@ -217,7 +217,8 @@ if [ "$IMGOPTSSYNTAX" =3D "true" ]; then
         TEST_IMG=3D"$DRIVER,file.filename=3D$TEST_DIR/t.$IMGFMT"
     elif [ "$IMGPROTO" =3D "nbd" ]; then
         TEST_IMG_FILE=3D$TEST_DIR/t.$IMGFMT
-        TEST_IMG=3D"$DRIVER,file.driver=3Dnbd,file.type=3Dunix,file.path=
=3D$SOCKDIR/nbd"
+        TEST_IMG=3D"$DRIVER,file.driver=3Dnbd,file.type=3Dunix"
+        TEST_IMG=3D"$TEST_IMG,file.path=3D$SOCK_DIR/nbd"
     elif [ "$IMGPROTO" =3D "ssh" ]; then
         TEST_IMG_FILE=3D$TEST_DIR/t.$IMGFMT
         TEST_IMG=3D"$DRIVER,file.driver=3Dssh,file.host=3D127.0.0.1,file.p=
ath=3D$TEST_IMG_FILE"
--=20
2.23.0


