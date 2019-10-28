Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A116CCA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:27:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6123A20873
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 12:27:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Py3Jr1yc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6123A20873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iP46z-00083q-Gm
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 08:27:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49892)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iP3vj-0001KY-Cb
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iP3vh-0001Ha-Sv
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32941
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iP3vh-0001HD-Px
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 08:15:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572264925;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+u3lp8jOpNBLwLVCT1zHP7gb5DU6N9uK+QT6kLBH7ew=;
 b=Py3Jr1yc3iFmNlOVE7w9HvLLPqIyImwKi1OMXksOA69zAnH1hSpMZnQZjn5fSd2tinG825
 byAkoDeWj6wHvjC7vGi0AGEF9dZ773yEQjlcT+F54wb1qgJ9d43tLnPGaCXp4v8W+f1fKr
 Sjkqf+BBHUMhP37GQW3Kj48WoB90/Ck=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-65-calFd69FMcKkOYYSNPTMAQ-1; Mon, 28 Oct 2019 08:15:21 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 802B5800FF1;
 Mon, 28 Oct 2019 12:15:20 +0000 (UTC)
Received: from localhost (ovpn-117-83.ams2.redhat.com [10.36.117.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1EFF4600C7;
 Mon, 28 Oct 2019 12:15:19 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 08/69] hbitmap: handle set/reset with zero length
Date: Mon, 28 Oct 2019 13:14:00 +0100
Message-Id: <20191028121501.15279-9-mreitz@redhat.com>
In-Reply-To: <20191028121501.15279-1-mreitz@redhat.com>
References: <20191028121501.15279-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: calFd69FMcKkOYYSNPTMAQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Passing zero length to these functions leads to unpredicted results.
Zero-length set/reset may occur in active-mirror, on zero-length write
(which is unlikely, but not guaranteed to never happen).

Let's just do nothing on zero-length request.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20191011090711.19940-2-vsementsov@virtuozzo.com
Reviewed-by: Max Reitz <mreitz@redhat.com>
Cc: qemu-stable@nongnu.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 util/hbitmap.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/util/hbitmap.c b/util/hbitmap.c
index 66db87c6ff..242c6e519c 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -387,6 +387,10 @@ void hbitmap_set(HBitmap *hb, uint64_t start, uint64_t=
 count)
     uint64_t first, n;
     uint64_t last =3D start + count - 1;
=20
+    if (count =3D=3D 0) {
+        return;
+    }
+
     trace_hbitmap_set(hb, start, count,
                       start >> hb->granularity, last >> hb->granularity);
=20
@@ -478,6 +482,10 @@ void hbitmap_reset(HBitmap *hb, uint64_t start, uint64=
_t count)
     uint64_t last =3D start + count - 1;
     uint64_t gran =3D 1ULL << hb->granularity;
=20
+    if (count =3D=3D 0) {
+        return;
+    }
+
     assert(QEMU_IS_ALIGNED(start, gran));
     assert(QEMU_IS_ALIGNED(count, gran) || (start + count =3D=3D hb->orig_=
size));
=20
--=20
2.21.0


