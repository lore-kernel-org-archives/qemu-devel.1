Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74AD9CA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:27:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4194720717
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:27:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hC/03T75"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4194720717
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53182 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP47H-0008On-2I
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 08:27:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50062)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP3vx-0001eZ-V1
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP3vw-0001PL-PC
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33383
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP3vw-0001PD-Li
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572264940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7AegR6O/GB/NSUyImdF/YuOZTD70N9BVgHZLYSLHW7s=;
 b=hC/03T75ZtwXp3WNQ+UZgWf9Mxgb7fEXB+yCjJFA5wliIePn5O5e1DutB7j2QtL38/sSpa
 CGbl37EkfpUXf5PThiPgwagfekQWbaetlxBZqzQo82at4/Nc870Tp+FQnmYXRvU7/pa7xO
 ojF4tAMLa8AeFXxRyhxkXF0xLwRvlO4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-zWWSmfdTO-SirtPf3j-0YQ-1; Mon, 28 Oct 2019 08:15:37 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DD79B1804970;
 Mon, 28 Oct 2019 12:15:36 +0000 (UTC)
Received: from localhost (ovpn-117-83.ams2.redhat.com [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 826426084E;
 Mon, 28 Oct 2019 12:15:36 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 16/69] iotests: Filter $SOCK_DIR
Date: Mon, 28 Oct 2019 13:14:08 +0100
Message-Id: <20191028121501.15279-17-mreitz@redhat.com>
In-Reply-To: <20191028121501.15279-1-mreitz@redhat.com>
References: <20191028121501.15279-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: zWWSmfdTO-SirtPf3j-0YQ-1
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

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20191017133155.5327-5-mreitz@redhat.com
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/common.filter | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/common.filter b/tests/qemu-iotests/common.f=
ilter
index 9f418b4881..0ee6042524 100644
--- a/tests/qemu-iotests/common.filter
+++ b/tests/qemu-iotests/common.filter
@@ -43,7 +43,8 @@ _filter_qom_path()
 # replace occurrences of the actual TEST_DIR value with TEST_DIR
 _filter_testdir()
 {
-    $SED -e "s#$TEST_DIR/#TEST_DIR/#g"
+    $SED -e "s#$TEST_DIR/#TEST_DIR/#g" \
+         -e "s#$SOCK_DIR/#SOCK_DIR/#g"
 }
=20
 # replace occurrences of the actual IMGFMT value with IMGFMT
@@ -124,6 +125,7 @@ _filter_img_create()
     $SED -e "s#$REMOTE_TEST_DIR#TEST_DIR#g" \
         -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" \
         -e "s#$TEST_DIR#TEST_DIR#g" \
+        -e "s#$SOCK_DIR#SOCK_DIR#g" \
         -e "s#$IMGFMT#IMGFMT#g" \
         -e 's#nbd:127.0.0.1:10810#TEST_DIR/t.IMGFMT#g' \
         -e "s# encryption=3Doff##g" \
@@ -160,6 +162,7 @@ _filter_img_info()
     $SED -e "s#$REMOTE_TEST_DIR#TEST_DIR#g" \
         -e "s#$IMGPROTO:$TEST_DIR#TEST_DIR#g" \
         -e "s#$TEST_DIR#TEST_DIR#g" \
+        -e "s#$SOCK_DIR#SOCK_DIR#g" \
         -e "s#$IMGFMT#IMGFMT#g" \
         -e 's#nbd://127.0.0.1:10810$#TEST_DIR/t.IMGFMT#g' \
         -e 's#json.*vdisk-id.*vxhs"}}#TEST_DIR/t.IMGFMT#' \
@@ -219,6 +222,7 @@ _filter_nbd()
     $SED -e '/nbd\/.*\.c:/d' \
         -e 's#127\.0\.0\.1:[0-9]*#127.0.0.1:PORT#g' \
         -e "s#?socket=3D$TEST_DIR#?socket=3DTEST_DIR#g" \
+        -e "s#?socket=3D$SOCK_DIR#?socket=3DSOCK_DIR#g" \
         -e 's#\(foo\|PORT/\?\|.sock\): Failed to .*$#\1#'
 }
=20
--=20
2.21.0


