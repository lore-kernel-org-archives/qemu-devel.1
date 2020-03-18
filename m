Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BFDAC10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 20:28:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCAA72077A
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 20:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W3ifwqdH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCAA72077A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58186 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEfIo-0004iJ-2H
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 16:28:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57273)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1jEfFd-0007s2-E4
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 16:25:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1jEfFc-0003zr-88
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 16:25:17 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:49901)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1jEfFc-0003xs-3u
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 16:25:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584563115;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ahENl3BNbjiX9217T8D2HNUwmfnYsYvdtYYCuVYsDWw=;
 b=W3ifwqdHFaYXFlBxhuYdsMI+3QZe4ZeHa4vyTmhQuTbpH/+j8LqmhAF7MLuc6BeNiqPuEh
 iSbhTg4rZI+kd80RRhaEJtNPKlpgDAS0lRh1lQyuIVac1N6yoWaNJmM+rLCp978xG58IHp
 irEEDWUqOlCzxMK6E9zg3OuA5cZjUZE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-56-yTiTQA3kOvKA9ahtJvZO6w-1; Wed, 18 Mar 2020 16:25:13 -0400
X-MC-Unique: yTiTQA3kOvKA9ahtJvZO6w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 24FB68EA6E6;
 Wed, 18 Mar 2020 20:24:48 +0000 (UTC)
Received: from probe.redhat.com (ovpn-112-191.rdu2.redhat.com [10.10.112.191])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C94C7610B0;
 Wed, 18 Mar 2020 20:24:27 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org, jsnow@redhat.com,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL v2 02/11] hbitmap: assert that we don't create bitmap larger
 than INT64_MAX
Date: Wed, 18 Mar 2020 16:23:32 -0400
Message-Id: <20200318202341.6961-3-jsnow@redhat.com>
In-Reply-To: <20200318202341.6961-1-jsnow@redhat.com>
References: <20200318202341.6961-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, libvir-list@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

We have APIs which returns signed int64_t, to be able to return error.
Therefore we can't handle bitmaps with absolute size larger than
(INT64_MAX+1). Still, keep maximum to be INT64_MAX which is a bit
safer.

Note, that bitmaps are used to represent disk images, which can't
exceed INT64_MAX anyway.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-id: 20200205112041.6003-2-vsementsov@virtuozzo.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 util/hbitmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/util/hbitmap.c b/util/hbitmap.c
index 242c6e519c..7f9b3e0cd7 100644
--- a/util/hbitmap.c
+++ b/util/hbitmap.c
@@ -716,6 +716,7 @@ HBitmap *hbitmap_alloc(uint64_t size, int granularity)
     HBitmap *hb =3D g_new0(struct HBitmap, 1);
     unsigned i;
=20
+    assert(size <=3D INT64_MAX);
     hb->orig_size =3D size;
=20
     assert(granularity >=3D 0 && granularity < 64);
@@ -746,6 +747,7 @@ void hbitmap_truncate(HBitmap *hb, uint64_t size)
     uint64_t num_elements =3D size;
     uint64_t old;
=20
+    assert(size <=3D INT64_MAX);
     hb->orig_size =3D size;
=20
     /* Size comes in as logical elements, adjust for granularity. */
--=20
2.21.1


