Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52848C43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 03:35:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A1E22073B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 03:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A1E22073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ichvR-0001im-KZ
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 22:35:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46962)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1ichsQ-0007Xj-1H
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 22:32:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1ichsN-0005ez-Tw
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 22:32:25 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2275 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1ichsH-0005Ug-Gs; Wed, 04 Dec 2019 22:32:19 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 0962F1780982CBE37420;
 Thu,  5 Dec 2019 11:32:08 +0800 (CST)
Received: from HGHY2P002143101.china.huawei.com (10.184.39.213) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Thu, 5 Dec 2019 11:31:59 +0800
From: <pannengyuan@huawei.com>
To: <eblake@redhat.com>, <kwolf@redhat.com>, <mreitz@redhat.com>
Subject: [PATCH v4 2/2] block/nbd: fix memory leak in nbd_open()
Date: Thu, 5 Dec 2019 11:29:02 +0800
Message-ID: <1575516542-54640-3-git-send-email-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.7.2.windows.1
In-Reply-To: <1575516542-54640-1-git-send-email-pannengyuan@huawei.com>
References: <1575516542-54640-1-git-send-email-pannengyuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.184.39.213]
X-CFilter-Loop: Reflected
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
Cc: liyiting@huawei.com, Vladimir
 Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, zhang.zhanghailiang@huawei.com,
 qemu-block@nongnu.org, Pan Nengyuan <pannengyuan@huawei.com>,
 qemu-devel@nongnu.org, qemu-stable <qemu-stable@nongnu.org>,
 kuhn.chenqun@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

In currently implementation there will be a memory leak when
nbd_client_connect() returns error status. Here is an easy way to
reproduce:

1. run qemu-iotests as follow and check the result with asan:
    ./check -raw 143

Following is the asan output backtrack:
Direct leak of 40 byte(s) in 1 object(s) allocated from:
    #0 0x7f629688a560 in calloc (/usr/lib64/libasan.so.3+0xc7560)
    #1 0x7f6295e7e015 in g_malloc0  (/usr/lib64/libglib-2.0.so.0+0x50015)
    #2 0x56281dab4642 in qobject_input_start_struct  /mnt/sdb/qemu-4.2.0-rc0/qapi/qobject-input-visitor.c:295
    #3 0x56281dab1a04 in visit_start_struct  /mnt/sdb/qemu-4.2.0-rc0/qapi/qapi-visit-core.c:49
    #4 0x56281dad1827 in visit_type_SocketAddress  qapi/qapi-visit-sockets.c:386
    #5 0x56281da8062f in nbd_config   /mnt/sdb/qemu-4.2.0-rc0/block/nbd.c:1716
    #6 0x56281da8062f in nbd_process_options /mnt/sdb/qemu-4.2.0-rc0/block/nbd.c:1829
    #7 0x56281da8062f in nbd_open /mnt/sdb/qemu-4.2.0-rc0/block/nbd.c:1873

Direct leak of 15 byte(s) in 1 object(s) allocated from:
    #0 0x7f629688a3a0 in malloc (/usr/lib64/libasan.so.3+0xc73a0)
    #1 0x7f6295e7dfbd in g_malloc (/usr/lib64/libglib-2.0.so.0+0x4ffbd)
    #2 0x7f6295e96ace in g_strdup (/usr/lib64/libglib-2.0.so.0+0x68ace)
    #3 0x56281da804ac in nbd_process_options /mnt/sdb/qemu-4.2.0-rc0/block/nbd.c:1834
    #4 0x56281da804ac in nbd_open /mnt/sdb/qemu-4.2.0-rc0/block/nbd.c:1873

Indirect leak of 24 byte(s) in 1 object(s) allocated from:
    #0 0x7f629688a3a0 in malloc (/usr/lib64/libasan.so.3+0xc73a0)
    #1 0x7f6295e7dfbd in g_malloc (/usr/lib64/libglib-2.0.so.0+0x4ffbd)
    #2 0x7f6295e96ace in g_strdup (/usr/lib64/libglib-2.0.so.0+0x68ace)
    #3 0x56281dab41a3 in qobject_input_type_str_keyval /mnt/sdb/qemu-4.2.0-rc0/qapi/qobject-input-visitor.c:536
    #4 0x56281dab2ee9 in visit_type_str /mnt/sdb/qemu-4.2.0-rc0/qapi/qapi-visit-core.c:297
    #5 0x56281dad0fa1 in visit_type_UnixSocketAddress_members qapi/qapi-visit-sockets.c:141
    #6 0x56281dad17b6 in visit_type_SocketAddress_members qapi/qapi-visit-sockets.c:366
    #7 0x56281dad186a in visit_type_SocketAddress qapi/qapi-visit-sockets.c:393
    #8 0x56281da8062f in nbd_config /mnt/sdb/qemu-4.2.0-rc0/block/nbd.c:1716
    #9 0x56281da8062f in nbd_process_options /mnt/sdb/qemu-4.2.0-rc0/block/nbd.c:1829
    #10 0x56281da8062f in nbd_open /mnt/sdb/qemu-4.2.0-rc0/block/nbd.c:1873

Fixes: 8f071c9db506e03ab
Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: qemu-stable <qemu-stable@nongnu.org>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
Changes v2 to v1:
- add a new function to do the common cleanups (suggested by Stefano
  Garzarella).
---
Changes v3 to v2:
- split in two patches(suggested by Stefano Garzarella)
---
Changes v4 to v3:
- replace function name from nbd_free_bdrvstate_prop to
  nbd_clear_bdrvstate and add Fixes tag.
---
 block/nbd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/nbd.c b/block/nbd.c
index 8b4a65a..9062409 100644
--- a/block/nbd.c
+++ b/block/nbd.c
@@ -1891,6 +1891,7 @@ static int nbd_open(BlockDriverState *bs, QDict *options, int flags,
 
     ret = nbd_client_connect(bs, errp);
     if (ret < 0) {
+        nbd_clear_bdrvstate(s);
         return ret;
     }
     /* successfully connected */
-- 
2.7.2.windows.1



