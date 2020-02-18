Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08E7C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 10:45:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A1E5206E2
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 10:45:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XeXNgRQv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A1E5206E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j40O1-0005SR-PF
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 05:45:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52416)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1j40EO-0002YQ-3p
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 05:35:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1j40EN-0007go-5d
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 05:35:56 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60852
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1j40EN-0007gc-1K
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 05:35:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1582022154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6Ng67lvkKpwyx6+Ab/FS8/+s7Ayy26WAiL5em8dKNTc=;
 b=XeXNgRQv6/QbszFZX94p2mOBHBfk10S3ggOtjgQ0zykOU3MtzBG1UgPfLwcSdM56HUaAh5
 p6XkmVNAtwGj54RPKQjbBQM4h8AVWZ6ncx6+H2z5NC+ztZ6dWfj1NiIr1oWIc76nBLGYfu
 bek8LIsorQg01PtuTAMw8bebIn3sRp4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-vkRicEyVP5SOoA-T0Y90bA-1; Tue, 18 Feb 2020 05:35:48 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C4A07800D48;
 Tue, 18 Feb 2020 10:35:47 +0000 (UTC)
Received: from localhost (unknown [10.36.118.17])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3DDC719E9C;
 Tue, 18 Feb 2020 10:35:47 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 17/19] iotests: Use self.image_len in TestRepairQuorum
Date: Tue, 18 Feb 2020 11:34:52 +0100
Message-Id: <20200218103454.296704-18-mreitz@redhat.com>
In-Reply-To: <20200218103454.296704-1-mreitz@redhat.com>
References: <20200218103454.296704-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: vkRicEyVP5SOoA-T0Y90bA-1
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org,
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
index 084da6baf3..1d9e64ff6d 100755
--- a/tests/qemu-iotests/041
+++ b/tests/qemu-iotests/041
@@ -872,7 +872,7 @@ class TestRepairQuorum(iotests.QMPTestCase):
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
2.24.1


