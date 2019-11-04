Return-Path: <SRS0=KlJF=Y4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E455ACA9ECF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 09:05:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B070E222CD
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2019 09:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I4cMF+WZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B070E222CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRYJ4-0000jW-4p
	for qemu-devel@archiver.kernel.org; Mon, 04 Nov 2019 04:05:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iRYHV-0007N7-Ol
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 04:04:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iRYHJ-00032t-PK
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 04:04:05 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37480
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iRYHJ-0002yb-8N
 for qemu-devel@nongnu.org; Mon, 04 Nov 2019 04:04:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1572858237;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2gqxhpNHUfIaIwcmwOFm6C8eab2g7cgHMKq1J40k/qM=;
 b=I4cMF+WZ7PwjgNsxKJ4XV9luq3uL8aB5iODDFUKJQLQXlTTVb6sS4MKn1Br61HsqIfOQCm
 nQYYWhMWK4MQLxA0B2H3pdIftm2m21uWpiXNqRzy4d96HSvthhGJ9rs8O4XZ1OyoIf5q0h
 VUxlN/popWF83lKwHvFaLHSkBisp1J4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-44-CbRMszHVMPSk0lywyLO3cw-1; Mon, 04 Nov 2019 04:03:54 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CFAF1005500;
 Mon,  4 Nov 2019 09:03:53 +0000 (UTC)
Received: from localhost (ovpn-117-85.ams2.redhat.com [10.36.117.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F330C60874;
 Mon,  4 Nov 2019 09:03:52 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 2/5] block/block-copy: fix s->copy_size for compressed cluster
Date: Mon,  4 Nov 2019 10:03:44 +0100
Message-Id: <20191104090347.27278-3-mreitz@redhat.com>
In-Reply-To: <20191104090347.27278-1-mreitz@redhat.com>
References: <20191104090347.27278-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: CbRMszHVMPSk0lywyLO3cw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

0e2402452f1f20429 allowed writes larger than cluster, but that's
unsupported for compressed write. Fix it.

Fixes: 0e2402452f1f20429
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20191029150934.26416-1-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/block-copy.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/block-copy.c b/block/block-copy.c
index c39cc9cffe..79798a1567 100644
--- a/block/block-copy.c
+++ b/block/block-copy.c
@@ -109,9 +109,9 @@ BlockCopyState *block_copy_state_new(BdrvChild *source,=
 BdrvChild *target,
         s->use_copy_range =3D false;
         s->copy_size =3D cluster_size;
     } else if (write_flags & BDRV_REQ_WRITE_COMPRESSED) {
-        /* Compression is not supported for copy_range */
+        /* Compression supports only cluster-size writes and no copy-range=
. */
         s->use_copy_range =3D false;
-        s->copy_size =3D MAX(cluster_size, BLOCK_COPY_MAX_BUFFER);
+        s->copy_size =3D cluster_size;
     } else {
         /*
          * copy_range does not respect max_transfer (it's a TODO), so we f=
actor
--=20
2.21.0


