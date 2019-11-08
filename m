Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFB5DC5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 08:58:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89DC1214DA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 08:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RWhRkrBv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89DC1214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT05z-0001W0-KZ
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 03:58:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59465)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iT055-0000k0-O4
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 03:57:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iT054-0001OZ-DX
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 03:57:23 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32777
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1iT054-0001O5-A4
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 03:57:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573203441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=M3VHzExu9kepdAh4Bvw2a1unOJ4MZvBStw77GF66AEM=;
 b=RWhRkrBvTokFjkpks17cBj8M7rQMK9JPPamGW/zoIBUwX07buBODsdohNVCB0XaVaevOnR
 +vRpBmbTyWg0v6DhQRWqdkCpHLGZ0juLcOEu6UZvPkrc2/VhPdCAcsyCWNEqSgMYn27cJv
 F6FjHzo24f0w1BfPGhK27g1xG1HMU8c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-GAZ04qxCPamPBzivgrf8RQ-1; Fri, 08 Nov 2019 03:57:20 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DC84800054;
 Fri,  8 Nov 2019 08:57:19 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-116-227.ams2.redhat.com
 [10.36.116.227])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 22B6D1001DC0;
 Fri,  8 Nov 2019 08:57:17 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH] iotests: Fix "no qualified output" error path
Date: Fri,  8 Nov 2019 09:57:13 +0100
Message-Id: <20191108085713.27551-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: GAZ04qxCPamPBzivgrf8RQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The variable for error messages to be displayed is $results, not
$reason. Fix 'check' to print the "no qualified output" error message
again instead of having a failure without any message telling the user
why it failed.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 tests/qemu-iotests/check | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/check b/tests/qemu-iotests/check
index 588c453a94..5218728470 100755
--- a/tests/qemu-iotests/check
+++ b/tests/qemu-iotests/check
@@ -876,7 +876,7 @@ do
             if [ ! -f "$reference" ]
             then
                 status=3D"fail"
-                reason=3D"no qualified output"
+                results=3D"no qualified output"
                 err=3Dtrue
             else
                 if diff -w "$reference" $tmp.out >/dev/null 2>&1
--=20
2.20.1


