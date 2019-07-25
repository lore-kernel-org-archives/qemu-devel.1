Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D18DC7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:59:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 448EB2238C
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 15:59:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 448EB2238C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqg8z-00076A-Bl
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 11:59:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55027)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hqg8C-00049b-5f
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:58:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hqg88-0006Wq-5m
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 11:58:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38238)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hqg83-0006SC-DD; Thu, 25 Jul 2019 11:58:04 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1511D81F11;
 Thu, 25 Jul 2019 15:57:55 +0000 (UTC)
Received: from localhost (ovpn-117-225.ams2.redhat.com [10.36.117.225])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B07A060606;
 Thu, 25 Jul 2019 15:57:54 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Date: Thu, 25 Jul 2019 17:57:34 +0200
Message-Id: <20190725155735.11872-7-mreitz@redhat.com>
In-Reply-To: <20190725155735.11872-1-mreitz@redhat.com>
References: <20190725155735.11872-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Thu, 25 Jul 2019 15:57:55 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 6/7] iotests: Disable 110 for
 vmdk.twoGbMaxExtentSparse
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

The error message for the test case where we have a quorum node for
which no directory name can be generated is different: For
twoGbMaxExtentSparse, it complains that it cannot open the extent file.
For other (sub)formats, it just notes that it cannot determine the
backing file path.  Both are fine, but just disable twoGbMaxExtentSparse
for simplicity's sake.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/110 | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/110 b/tests/qemu-iotests/110
index 2cdc7c8a72..2ef516baf1 100755
--- a/tests/qemu-iotests/110
+++ b/tests/qemu-iotests/110
@@ -40,7 +40,8 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # Any format supporting backing files
 _supported_fmt qed qcow qcow2 vmdk
 _supported_proto file
-_unsupported_imgopts "subformat=3DmonolithicFlat" "subformat=3DtwoGbMaxE=
xtentFlat"
+_unsupported_imgopts "subformat=3DmonolithicFlat" "subformat=3DtwoGbMaxE=
xtentFlat" \
+                     "subformat=3DtwoGbMaxExtentSparse"
=20
 TEST_IMG_REL=3D$(basename "$TEST_IMG")
=20
--=20
2.21.0


