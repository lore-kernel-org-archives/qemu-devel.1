Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71753C10DCE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 08:39:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DDBD20724
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 08:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XDv0Td9m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DDBD20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCfrH-0007Mu-ER
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 04:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45507)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jCfoA-000277-JU
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 04:36:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1jCfo9-00069o-Id
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 04:36:42 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29369
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1jCfo8-00068Q-F6
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 04:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584088600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vPB4oQ5LeeBSZP6WQFTmgTeb7Cj2OlsvPKnBSWKdkso=;
 b=XDv0Td9mkBoaEujEIln8T22F4vpGyaX+gZ4nqqzPskUqq011LK1Jm8UVMrV6f6Pphdihms
 +6mnJ9j28+o97oshhCGb1eD1h7WPzp4X3OfIZ11VVv/QfBjs/itj8S3Ib1Qj9+dcYS9eRT
 SEOLAAi5SIizxjDj3FSSt9nTIVv3/n8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-pCcpMtzoOqu1oDCBLdFoXg-1; Fri, 13 Mar 2020 04:36:35 -0400
X-MC-Unique: pCcpMtzoOqu1oDCBLdFoXg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C64121084420;
 Fri, 13 Mar 2020 08:36:34 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-117-85.ams2.redhat.com [10.36.117.85])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 204DF92D37;
 Fri, 13 Mar 2020 08:36:31 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 3/3] iotests: Increase pause_wait() timeout
Date: Fri, 13 Mar 2020 09:36:17 +0100
Message-Id: <20200313083617.8326-4-kwolf@redhat.com>
In-Reply-To: <20200313083617.8326-1-kwolf@redhat.com>
References: <20200313083617.8326-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Waiting for only 1 second proved to be too short on a loaded system,
resulting in false positives when testing pull requests. Increase the
timeout a bit to make this less likely.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/iotests.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index b859c303a2..7bc4934cd2 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -925,7 +925,7 @@ class QMPTestCase(unittest.TestCase):
         self.assert_qmp(event, 'data/type', 'mirror')
=20
     def pause_wait(self, job_id=3D'job0'):
-        with Timeout(1, "Timeout waiting for job to pause"):
+        with Timeout(3, "Timeout waiting for job to pause"):
             while True:
                 result =3D self.vm.qmp('query-block-jobs')
                 found =3D False
--=20
2.20.1


