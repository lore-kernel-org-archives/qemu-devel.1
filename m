Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B691BC00523
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 01:55:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 904FC21734
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 01:55:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 904FC21734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioHcN-0006fq-N9
	for qemu-devel@archiver.kernel.org; Sun, 05 Jan 2020 20:55:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41885)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1ioHbm-00067N-PH
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 20:55:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1ioHbl-0006FI-S6
 for qemu-devel@nongnu.org; Sun, 05 Jan 2020 20:55:06 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2283 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1ioHbj-000682-0d; Sun, 05 Jan 2020 20:55:03 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 9E0DD221AA39A676E0E5;
 Mon,  6 Jan 2020 09:54:54 +0800 (CST)
Received: from DESKTOP-9NTIQGG.china.huawei.com (10.173.221.136) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.439.0; Mon, 6 Jan 2020 09:54:46 +0800
From: <pannengyuan@huawei.com>
To: <eblake@redhat.com>
Subject: [PATCH] nbd: fix uninitialized variable warning
Date: Mon, 6 Jan 2020 09:54:43 +0800
Message-ID: <20200106015443.38540-1-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.221.136]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
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
Cc: zhang.zhanghailiang@huawei.com, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Pan Nengyuan <pannengyuan@huawei.com>,
 qemu-devel@nongnu.org, Euler Robot <euler.robot@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

Fixes:
/mnt/sdb/qemu/nbd/server.c: In function 'nbd_handle_request':
/mnt/sdb/qemu/nbd/server.c:2313:9: error: 'ret' may be used uninitialized=
 in this function [-Werror=3Dmaybe-uninitialized]
     int ret;

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
---
 nbd/server.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/nbd/server.c b/nbd/server.c
index 24ebc1a805..7eb3de0842 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -2310,7 +2310,7 @@ static coroutine_fn int nbd_handle_request(NBDClien=
t *client,
                                            NBDRequest *request,
                                            uint8_t *data, Error **errp)
 {
-    int ret;
+    int ret =3D 0;
     int flags;
     NBDExport *exp =3D client->exp;
     char *msg;
--=20
2.21.0.windows.1



