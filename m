Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C593C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 08:15:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54792204FD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 08:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="Uh2srD4e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54792204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41954 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNvFn-0007pC-H5
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 04:15:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <antonkuchin@yandex-team.ru>) id 1hNvDp-0006oH-Q5
	for qemu-devel@nongnu.org; Tue, 07 May 2019 04:13:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <antonkuchin@yandex-team.ru>) id 1hNvDo-0004nZ-VE
	for qemu-devel@nongnu.org; Tue, 07 May 2019 04:13:09 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:59318)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <antonkuchin@yandex-team.ru>)
	id 1hNvDm-0004ls-8R; Tue, 07 May 2019 04:13:06 -0400
Received: from mxbackcorp1o.mail.yandex.net (mxbackcorp1o.mail.yandex.net
	[IPv6:2a02:6b8:0:1a2d::301])
	by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 703E82E0AFA;
	Tue,  7 May 2019 11:13:04 +0300 (MSK)
Received: from smtpcorp1j.mail.yandex.net (smtpcorp1j.mail.yandex.net
	[2a02:6b8:0:1619::137])
	by mxbackcorp1o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id
	3uaFGNXsiA-D3UC2Eeb; Tue, 07 May 2019 11:13:04 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; 
	t=1557216784; bh=aBVu0BFcr7SV1Ac/Td1wiG1yDkmWdggwwMy2v3ciw2s=;
	h=Message-Id:Date:Subject:To:From:Cc;
	b=Uh2srD4eqOWTgeaRE6jOhaP+Qq4aM5jPlZZYXj74togHIB4MilQXNuyRKsnUapeTI
	+MhYnjBm6heFOzP71gt2oBPCNUdVdowW/zf6hnkoxE3zALYfw8LlzlX/V87O2jxgPk
	r1vvk5WdiS4P4kEzi1+kEwaGEQeM4l5HxqYEgVSE=
Authentication-Results: mxbackcorp1o.mail.yandex.net;
	dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
	[2a02:6b8:0:408:250:b6ff:fe97:2682])
	by smtpcorp1j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id
	U0bTkyutKU-D3JCDnte; Tue, 07 May 2019 11:13:03 +0300
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client certificate not present)
From: Anton Kuchin <antonkuchin@yandex-team.ru>
To: qemu-devel@nongnu.org
Date: Tue,  7 May 2019 11:12:56 +0300
Message-Id: <20190507081256.27599-1-antonkuchin@yandex-team.ru>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 77.88.29.217
Subject: [Qemu-devel] [PATCH] block: remove bs from lists before closing
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Anton Kuchin <antonkuchin@yandex-team.ru>,
	yc-core@yandex-team.ru, qemu-block@nongnu.org,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Close involves flush that can be performed asynchronously and bs
must be protected from being referenced before it is deleted.

Signed-off-by: Anton Kuchin <antonkuchin@yandex-team.ru>
---
 block.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index 9ae5c0ed2f..b505271a4d 100644
--- a/block.c
+++ b/block.c
@@ -4083,14 +4083,14 @@ static void bdrv_delete(BlockDriverState *bs)
     assert(bdrv_op_blocker_is_empty(bs));
     assert(!bs->refcnt);
=20
-    bdrv_close(bs);
-
     /* remove from list, if necessary */
     if (bs->node_name[0] !=3D '\0') {
         QTAILQ_REMOVE(&graph_bdrv_states, bs, node_list);
     }
     QTAILQ_REMOVE(&all_bdrv_states, bs, bs_list);
=20
+    bdrv_close(bs);
+
     g_free(bs);
 }
=20
--=20
2.19.1


