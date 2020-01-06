Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FBCC33C9B
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:17:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50AED20707
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 15:17:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PopviVM4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50AED20707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioU8B-0007jr-Sb
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 10:17:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44566)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1ioTbw-0007nw-8N
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:44:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1ioTbv-00016U-37
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:44:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42534
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ioTbu-000166-W4
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 09:44:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578321842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+G2RUZx0lySONatlvCEdCYt5JyxyNEJIdc3ZLiAijyY=;
 b=PopviVM4vwMaqbRfvtgFlZO6kcAsULw74TgCWpFRPn9NTg5s5tnKHwj+VHBuTUc/noeU9J
 lt9AMpJMCMyYuZUv4jEO91xctHQEfJq40V6a0SjqcKPnDPEdwL+C9GKeGnOsdgKEvB5FPd
 kJtcRXBXw74SFHohZxt+Zz38+NkZDJk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-WCXvJLr8PZiNYHUZAkYJYg-1; Mon, 06 Jan 2020 09:43:56 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 150FB8024DE;
 Mon,  6 Jan 2020 14:43:55 +0000 (UTC)
Received: from localhost (ovpn-117-91.ams2.redhat.com [10.36.117.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 872435D9D6;
 Mon,  6 Jan 2020 14:43:54 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 34/34] backup-top: Begin drain earlier
Date: Mon,  6 Jan 2020 15:42:06 +0100
Message-Id: <20200106144206.698920-35-mreitz@redhat.com>
In-Reply-To: <20200106144206.698920-1-mreitz@redhat.com>
References: <20200106144206.698920-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: WCXvJLr8PZiNYHUZAkYJYg-1
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

When dropping backup-top, we need to drain the node before freeing the
BlockCopyState.  Otherwise, requests may still be in flight and then the
assertion in shres_destroy() will fail.

(This becomes visible in intermittent failure of 056.)

Cc: qemu-stable@nongnu.org
Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20191219182638.104621-1-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/backup-top.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/backup-top.c b/block/backup-top.c
index 7cdb1f8eba..818d3f26b4 100644
--- a/block/backup-top.c
+++ b/block/backup-top.c
@@ -257,12 +257,12 @@ void bdrv_backup_top_drop(BlockDriverState *bs)
     BDRVBackupTopState *s =3D bs->opaque;
     AioContext *aio_context =3D bdrv_get_aio_context(bs);
=20
-    block_copy_state_free(s->bcs);
-
     aio_context_acquire(aio_context);
=20
     bdrv_drained_begin(bs);
=20
+    block_copy_state_free(s->bcs);
+
     s->active =3D false;
     bdrv_child_refresh_perms(bs, bs->backing, &error_abort);
     bdrv_replace_node(bs, backing_bs(bs), &error_abort);
--=20
2.24.1


