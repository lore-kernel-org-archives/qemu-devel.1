Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19D9C54FCB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 15:07:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 892CB20857
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 15:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FzYsQ+dL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 892CB20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRdSF-00062A-Ml
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 11:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41090)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jRdMc-0005CD-BE
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:02:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1jRdMb-0005zL-Kz
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:02:06 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52022
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1jRdMb-0005x9-5a
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 11:02:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587654122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u5Eidx1Yt6KMP54AdhcbXRlQ2CX6b/Rz5TGA3RuquRw=;
 b=FzYsQ+dLL+pIeto7CenUKlKxOP3BND6VKLGOydZLAZE37D1uCTPEpctcaq0ZIMmfsPUueE
 xLJP4V1fUkRZgDUd4zLJexwmsg+qAfzUwbD6M47RLGi4gHii36gtV1YVUVZ7ETM6y1rrbv
 DhZ8pQ0wEC8My8OGHOBcebAiu08lp7A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-rBdrVW02MSSqdCRXC7g15w-1; Thu, 23 Apr 2020 11:02:00 -0400
X-MC-Unique: rBdrVW02MSSqdCRXC7g15w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 47CA583DE2D;
 Thu, 23 Apr 2020 15:01:59 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-28.ams2.redhat.com [10.36.114.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A787360C81;
 Thu, 23 Apr 2020 15:01:52 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v6 08/10] iotests: Filter testfiles out in filter_img_info()
Date: Thu, 23 Apr 2020 17:01:25 +0200
Message-Id: <20200423150127.142609-9-kwolf@redhat.com>
In-Reply-To: <20200423150127.142609-1-kwolf@redhat.com>
References: <20200423150127.142609-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 03:23:21
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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


