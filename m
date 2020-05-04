Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97B2C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 21:17:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4E6C206A4
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 21:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UBcEL043"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4E6C206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jViTF-0006O0-Lq
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 17:17:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jViQU-0003wW-6E
 for qemu-devel@nongnu.org; Mon, 04 May 2020 17:14:58 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:50905
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jViQT-0000oy-GX
 for qemu-devel@nongnu.org; Mon, 04 May 2020 17:14:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588626896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=31dqIqUDKnqlmZMDCenW/Ew7xptQt0PLlXwqQjzyVL0=;
 b=UBcEL043EBqCsJRhOItuP2CsreWMGdp1YLl5VwUoSrljYQRGRqMwN2hDOig4CeEhYlg0uN
 KsBHObXSURANJkaclgBDlvXq/AjRKbEEyzD2d9Fao48N/cmw7NzS2XUfCjmcUh+yRW3jNw
 4vcE3N9AmiMurNu18lI6ROFDR+qawqQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79-AszOWea5MvCv6YRiDZntbg-1; Mon, 04 May 2020 17:14:52 -0400
X-MC-Unique: AszOWea5MvCv6YRiDZntbg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D7AB462;
 Mon,  4 May 2020 21:14:51 +0000 (UTC)
Received: from blue.redhat.com (ovpn-114-73.phx2.redhat.com [10.3.114.73])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DE5C36FF1B;
 Mon,  4 May 2020 21:14:50 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 3/4] block/nbd-client: drop max_block restriction from
 block_status
Date: Mon,  4 May 2020 16:14:37 -0500
Message-Id: <20200504211438.195926-4-eblake@redhat.com>
In-Reply-To: <20200504211438.195926-1-eblake@redhat.com>
References: <20200504211438.195926-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/04 16:03:08
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

The NBD spec was updated (see nbd.git commit 9f30fedb) so that
max_block doesn't relate to NBD_CMD_BLOCK_STATUS. So, drop the
restriction.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200401150112.9557-2-vsementsov@virtuozzo.com>
[eblake: tweak commit message to call out NBD commit]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/nbd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/nbd.c b/block/nbd.c
index 2160859f6499..d4d518a780c9 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1320,9 +1320,7 @@ static int coroutine_fn nbd_client_co_block_status(
     NBDRequest request =3D {
         .type =3D NBD_CMD_BLOCK_STATUS,
         .from =3D offset,
-        .len =3D MIN(MIN_NON_ZERO(QEMU_ALIGN_DOWN(INT_MAX,
-                                                bs->bl.request_alignment),
-                                s->info.max_block),
+        .len =3D MIN(QEMU_ALIGN_DOWN(INT_MAX, bs->bl.request_alignment),
                    MIN(bytes, s->info.size - offset)),
         .flags =3D NBD_CMD_FLAG_REQ_ONE,
     };
--=20
2.26.2


