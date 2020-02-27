Return-Path: <SRS0=0TZc=4P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96AAC4BA24
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 01:15:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE78620656
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2020 01:15:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE78620656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j77m0-0003Mz-Se
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 20:15:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48790)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1j77l5-0002NE-5C
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 20:14:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1j77l4-0006C4-1U
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 20:14:35 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:44974 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1j77l0-0005wy-PU; Wed, 26 Feb 2020 20:14:31 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 1EA7F4290A3AA0A2ED32;
 Thu, 27 Feb 2020 09:14:25 +0800 (CST)
Received: from localhost.localdomain (10.175.104.216) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Thu, 27 Feb 2020 09:14:19 +0800
From: Pan Nengyuan <pannengyuan@huawei.com>
To: <kwolf@redhat.com>, <mreitz@redhat.com>
Subject: [PATCH v2 1/2] block/qcow2: do free crypto_opts in qcow2_close()
Date: Thu, 27 Feb 2020 09:29:49 +0800
Message-ID: <20200227012950.12256-2-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.18.2
In-Reply-To: <20200227012950.12256-1-pannengyuan@huawei.com>
References: <20200227012950.12256-1-pannengyuan@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.216]
X-CFilter-Loop: Reflected
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.35
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
Cc: euler.robot@huawei.com, Pan Nengyuan <pannengyuan@huawei.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'crypto_opts' forgot to free in qcow2_close(), this patch fix the bellow leak stack:

Direct leak of 24 byte(s) in 1 object(s) allocated from:
    #0 0x7f0edd81f970 in __interceptor_calloc (/lib64/libasan.so.5+0xef970)
    #1 0x7f0edc6d149d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5249d)
    #2 0x55d7eaede63d in qobject_input_start_struct /mnt/sdb/qemu-new/qemu_test/qemu/qapi/qobject-input-visitor.c:295
    #3 0x55d7eaed78b8 in visit_start_struct /mnt/sdb/qemu-new/qemu_test/qemu/qapi/qapi-visit-core.c:49
    #4 0x55d7eaf5140b in visit_type_QCryptoBlockOpenOptions qapi/qapi-visit-crypto.c:290
    #5 0x55d7eae43af3 in block_crypto_open_opts_init /mnt/sdb/qemu-new/qemu_test/qemu/block/crypto.c:163
    #6 0x55d7eacd2924 in qcow2_update_options_prepare /mnt/sdb/qemu-new/qemu_test/qemu/block/qcow2.c:1148
    #7 0x55d7eacd33f7 in qcow2_update_options /mnt/sdb/qemu-new/qemu_test/qemu/block/qcow2.c:1232
    #8 0x55d7eacd9680 in qcow2_do_open /mnt/sdb/qemu-new/qemu_test/qemu/block/qcow2.c:1512
    #9 0x55d7eacdc55e in qcow2_open_entry /mnt/sdb/qemu-new/qemu_test/qemu/block/qcow2.c:1792
    #10 0x55d7eacdc8fe in qcow2_open /mnt/sdb/qemu-new/qemu_test/qemu/block/qcow2.c:1819
    #11 0x55d7eac3742d in bdrv_open_driver /mnt/sdb/qemu-new/qemu_test/qemu/block.c:1317
    #12 0x55d7eac3e990 in bdrv_open_common /mnt/sdb/qemu-new/qemu_test/qemu/block.c:1575
    #13 0x55d7eac4442c in bdrv_open_inherit /mnt/sdb/qemu-new/qemu_test/qemu/block.c:3126
    #14 0x55d7eac45c3f in bdrv_open /mnt/sdb/qemu-new/qemu_test/qemu/block.c:3219
    #15 0x55d7ead8e8a4 in blk_new_open /mnt/sdb/qemu-new/qemu_test/qemu/block/block-backend.c:397
    #16 0x55d7eacde74c in qcow2_co_create /mnt/sdb/qemu-new/qemu_test/qemu/block/qcow2.c:3534
    #17 0x55d7eacdfa6d in qcow2_co_create_opts /mnt/sdb/qemu-new/qemu_test/qemu/block/qcow2.c:3668
    #18 0x55d7eac1c678 in bdrv_create_co_entry /mnt/sdb/qemu-new/qemu_test/qemu/block.c:485
    #19 0x55d7eb0024d2 in coroutine_trampoline /mnt/sdb/qemu-new/qemu_test/qemu/util/coroutine-ucontext.c:115

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index 3c754f616b..f16e7f7782 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2606,6 +2606,7 @@ static void qcow2_close(BlockDriverState *bs)
 
     qcrypto_block_free(s->crypto);
     s->crypto = NULL;
+    qapi_free_QCryptoBlockOpenOptions(s->crypto_opts);
 
     g_free(s->unknown_header_fields);
     cleanup_unknown_header_ext(bs);
-- 
2.18.2


