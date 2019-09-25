Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07445C432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 18:37:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFEB121655
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 18:37:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFEB121655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDCAQ-0006Qx-0w
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 14:37:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36884)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iDC5k-0001T1-WF
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:32:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iDC5k-0007g8-0S
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 14:32:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38536)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iDC5g-0007bO-VW; Wed, 25 Sep 2019 14:32:41 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3BCD969066;
 Wed, 25 Sep 2019 18:32:40 +0000 (UTC)
Received: from localhost (unknown [10.40.205.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CA901816F;
 Wed, 25 Sep 2019 18:32:39 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH 3/3] iotests: Use stat -c %b in 125
Date: Wed, 25 Sep 2019 20:32:31 +0200
Message-Id: <20190925183231.11196-4-mreitz@redhat.com>
In-Reply-To: <20190925183231.11196-1-mreitz@redhat.com>
References: <20190925183231.11196-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Wed, 25 Sep 2019 18:32:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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

125 should not use qemu-img to get the on-disk image size, because that
reports it in a human-readable format that is useless to us.  Just use
stat instead (like we do to get the image file length).

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/125 | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/125 b/tests/qemu-iotests/125
index 0ef51f1e21..4e31aa4e5f 100755
--- a/tests/qemu-iotests/125
+++ b/tests/qemu-iotests/125
@@ -34,8 +34,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
=20
 get_image_size_on_host()
 {
-    $QEMU_IMG info -f "$IMGFMT" "$TEST_IMG" | grep "disk size" \
-        | sed -e 's/^[^0-9]*\([0-9]\+\).*$/\1/'
+    echo $(($(stat -c '%b * %B' "$TEST_IMG_FILE")))
 }
=20
 # get standard environment and filters
--=20
2.21.0


