Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E4EC2BB1D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 12:39:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C10620719
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 12:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WBWqSfws"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C10620719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLnVS-0000jF-IU
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 08:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34717)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jLnUB-0007Xd-6C
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 08:37:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jLnUA-0006mM-1u
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 08:37:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46483
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jLnU6-0006kO-3x
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 08:37:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586263061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ese7sDnkOl2TttdL7Z3dDx9mHq1RyE6x+22JvmNhHBg=;
 b=WBWqSfwsCjXgaZjTw1jSMPxFXqV7XxD49xmz6CcaWePjZ6KYvfR4CaZ0EDWHxGWDxjPtXE
 jGFy45l/Ab2SKFPdO4HTcEH1YvmuRGVtlAEY9dgy+jJZdof2fDWXAM1qUJc2BEWWXRoYI3
 twZTaKnl0r5Zevb8ly/jR2tJ2fihy0Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-171-oBFHmciuO-yU0ksCRPLrIg-1; Tue, 07 Apr 2020 08:37:39 -0400
X-MC-Unique: oBFHmciuO-yU0ksCRPLrIg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 669651B18BC0;
 Tue,  7 Apr 2020 12:37:38 +0000 (UTC)
Received: from localhost (ovpn-114-84.ams2.redhat.com [10.36.114.84])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 05FED5C28E;
 Tue,  7 Apr 2020 12:37:37 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 3/5] qcow2: Check request size in
 qcow2_co_pwritev_compressed_part()
Date: Tue,  7 Apr 2020 14:37:25 +0200
Message-Id: <20200407123727.829933-4-mreitz@redhat.com>
In-Reply-To: <20200407123727.829933-1-mreitz@redhat.com>
References: <20200407123727.829933-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
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

From: Alberto Garcia <berto@igalia.com>

When issuing a compressed write request the number of bytes must be a
multiple of the cluster size or reach the end of the last cluster.

With the current code such requests are allowed and we hit an
assertion:

   $ qemu-img create -f qcow2 img.qcow2 1M
   $ qemu-io -c 'write -c 0 32k' img.qcow2

   qemu-io: block/qcow2.c:4257: qcow2_co_pwritev_compressed_task:
   Assertion `bytes =3D=3D s->cluster_size || (bytes < s->cluster_size &&
              (offset + bytes =3D=3D bs->total_sectors << BDRV_SECTOR_BITS)=
)' failed.
   Aborted

This patch fixes a regression introduced in 0d483dce38

Signed-off-by: Alberto Garcia <berto@igalia.com>
Message-Id: <20200406143401.26854-1-berto@igalia.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index e8cbcc1ec1..b524b0c53f 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4355,6 +4355,11 @@ qcow2_co_pwritev_compressed_part(BlockDriverState *b=
s,
         return -EINVAL;
     }
=20
+    if (offset_into_cluster(s, bytes) &&
+        (offset + bytes) !=3D (bs->total_sectors << BDRV_SECTOR_BITS)) {
+        return -EINVAL;
+    }
+
     while (bytes && aio_task_pool_status(aio) =3D=3D 0) {
         uint64_t chunk_size =3D MIN(bytes, s->cluster_size);
=20
--=20
2.25.1


