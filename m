Return-Path: <SRS0=6DzB=ZD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D882BC17445
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:21:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6EED2067B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2019 16:21:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="azRDV1ax"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6EED2067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUCRx-0005Oq-Cp
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 11:21:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39252)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iUC9r-0008SD-Ge
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:03:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iUC9q-0002zO-Fh
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:03:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59241
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iUC9q-0002zE-CZ
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 11:03:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573488194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0x6FV2Rgv9rlxoxQjtMI8X+Lb/rJSquGcr1RaAZH9qI=;
 b=azRDV1axok/d0VXJSgRV4WmLw2Fy3mWCCLzyHzFbPn4v5hJDHKP1EoJfLGqqEmloGRo4LA
 lhd3MuNOgyH7M0n3mkXMCC+TME65wNjIR2wZnk3Lt6ipmt5HRq7SEOAO19AxfzGkguLjVz
 lDrzPg/zVx6QwRrWNsz+WhsP56LrM50=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-69-xrm1mkQJNoaDfcNx6rK19A-1; Mon, 11 Nov 2019 11:03:10 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4129C805D9A;
 Mon, 11 Nov 2019 16:03:09 +0000 (UTC)
Received: from localhost (ovpn-117-116.ams2.redhat.com [10.36.117.116])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AA77D10027B3;
 Mon, 11 Nov 2019 16:03:08 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-5.0 v2 16/23] iotests: Use complete_and_wait() in 155
Date: Mon, 11 Nov 2019 17:02:09 +0100
Message-Id: <20191111160216.197086-17-mreitz@redhat.com>
In-Reply-To: <20191111160216.197086-1-mreitz@redhat.com>
References: <20191111160216.197086-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: xrm1mkQJNoaDfcNx6rK19A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

This way, we get to see errors during the completion phase.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/155 | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/155 b/tests/qemu-iotests/155
index e19485911c..d7ef2579d3 100755
--- a/tests/qemu-iotests/155
+++ b/tests/qemu-iotests/155
@@ -163,12 +163,7 @@ class MirrorBaseClass(BaseClass):
=20
         self.assert_qmp(result, 'return', {})
=20
-        self.vm.event_wait('BLOCK_JOB_READY')
-
-        result =3D self.vm.qmp('block-job-complete', device=3D'mirror-job'=
)
-        self.assert_qmp(result, 'return', {})
-
-        self.vm.event_wait('BLOCK_JOB_COMPLETED')
+        self.complete_and_wait('mirror-job')
=20
     def testFull(self):
         self.runMirror('full')
--=20
2.23.0


