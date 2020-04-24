Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA06DC54FCB
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 13:01:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 853FC20728
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 13:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gpQScGQT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853FC20728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36130 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRxxb-000391-L3
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 09:01:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42460)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jRxrT-00074h-9S
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 08:55:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jRxrS-0003mQ-OS
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 08:55:18 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35815
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jRxrS-0003hu-8u
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 08:55:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587732914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y7XwFxjBycLsJyWWYO1B/FL9Z71mdoqs//Ta6VecmNo=;
 b=gpQScGQTLoNIg2dUFGJ69sJY5r7/8pVjex8M53izlNlk84OddDrRVOW42TNKertY3eyZ5V
 96Nz8r1S3b2OyHKj/dI0o+OKvFdX6cX39HDgYrSwJ3JSUeZ3b0WSgEj0BqTmbTPBN9IVOU
 mJsLZi6DzeeVvnCEJBDIGAyDG52XrRM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-pl0tdqwfNkGZfJYYSbn5Xw-1; Fri, 24 Apr 2020 08:55:10 -0400
X-MC-Unique: pl0tdqwfNkGZfJYYSbn5Xw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79553835B59;
 Fri, 24 Apr 2020 12:55:09 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-114.ams2.redhat.com
 [10.36.114.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F34116084A;
 Fri, 24 Apr 2020 12:55:07 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v7 08/10] iotests: Filter testfiles out in filter_img_info()
Date: Fri, 24 Apr 2020 14:54:46 +0200
Message-Id: <20200424125448.63318-9-kwolf@redhat.com>
In-Reply-To: <20200424125448.63318-1-kwolf@redhat.com>
References: <20200424125448.63318-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 03:54:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We want to keep TEST_IMG for the full path of the main test image, but
filter_testfiles() must be called for other test images before replacing
other things like the image format because the test directory path could
contain the format as a substring.

Insert a filter_testfiles() call between both.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 tests/qemu-iotests/iotests.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 7bc4934cd2..5f8c263d59 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -338,8 +338,9 @@ def filter_img_info(output, filename):
     for line in output.split('\n'):
         if 'disk size' in line or 'actual-size' in line:
             continue
-        line =3D line.replace(filename, 'TEST_IMG') \
-                   .replace(imgfmt, 'IMGFMT')
+        line =3D line.replace(filename, 'TEST_IMG')
+        line =3D filter_testfiles(line)
+        line =3D line.replace(imgfmt, 'IMGFMT')
         line =3D re.sub('iters: [0-9]+', 'iters: XXX', line)
         line =3D re.sub('uuid: [-a-f0-9]+', 'uuid: XXXXXXXX-XXXX-XXXX-XXXX=
-XXXXXXXXXXXX', line)
         line =3D re.sub('cid: [0-9]+', 'cid: XXXXXXXXXX', line)
--=20
2.25.3


