Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65942C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:01:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A9E420873
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 14:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LHTyCexg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A9E420873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC1vE-0005WH-9G
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 10:01:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36247)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1jC1n0-0004AR-NC
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:52:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1jC1mz-0002c9-8X
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:52:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59442
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1jC1mz-0002bM-2d
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 09:52:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583934762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rt2DJofwlsydorUG4WNvEXwSgForzgRNZkfRso1DZJE=;
 b=LHTyCexg+hPBtvLX0impr5PI63r/K4tVWrplaWWnqnbQLOqVqJKirsob/DIC2o6cjiV5Qs
 6DaVZ9nrbzjQh8yGZx/Lb+Q9x1ZNjUHEU8YLWNTl2zTzRkrP0KyB2jRmP9FpOh9IQPmo7Y
 2LKhOasMq6VcMrPLQaUo+dQDCchhVJs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-157-wyWZmO4rNp-yL716BjXVyA-1; Wed, 11 Mar 2020 09:52:40 -0400
X-MC-Unique: wyWZmO4rNp-yL716BjXVyA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9641D107ACCA;
 Wed, 11 Mar 2020 13:52:39 +0000 (UTC)
Received: from localhost (ovpn-117-216.ams2.redhat.com [10.36.117.216])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C809C92973;
 Wed, 11 Mar 2020 13:52:38 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 08/19] block/qcow2: do free crypto_opts in qcow2_close()
Date: Wed, 11 Mar 2020 14:52:02 +0100
Message-Id: <20200311135213.1242028-9-mreitz@redhat.com>
In-Reply-To: <20200311135213.1242028-1-mreitz@redhat.com>
References: <20200311135213.1242028-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

From: Pan Nengyuan <pannengyuan@huawei.com>

'crypto_opts' forgot to free in qcow2_close(), this patch fix the bellow le=
ak stack:

Direct leak of 24 byte(s) in 1 object(s) allocated from:
    #0 0x7f0edd81f970 in __interceptor_calloc (/lib64/libasan.so.5+0xef970)
    #1 0x7f0edc6d149d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5249d)
    #2 0x55d7eaede63d in qobject_input_start_struct /mnt/sdb/qemu-new/qemu_=
test/qemu/qapi/qobject-input-visitor.c:295
    #3 0x55d7eaed78b8 in visit_start_struct /mnt/sdb/qemu-new/qemu_test/qem=
u/qapi/qapi-visit-core.c:49
    #4 0x55d7eaf5140b in visit_type_QCryptoBlockOpenOptions qapi/qapi-visit=
-crypto.c:290
    #5 0x55d7eae43af3 in block_crypto_open_opts_init /mnt/sdb/qemu-new/qemu=
_test/qemu/block/crypto.c:163
    #6 0x55d7eacd2924 in qcow2_update_options_prepare /mnt/sdb/qemu-new/qem=
u_test/qemu/block/qcow2.c:1148
    #7 0x55d7eacd33f7 in qcow2_update_options /mnt/sdb/qemu-new/qemu_test/q=
emu/block/qcow2.c:1232
    #8 0x55d7eacd9680 in qcow2_do_open /mnt/sdb/qemu-new/qemu_test/qemu/blo=
ck/qcow2.c:1512
    #9 0x55d7eacdc55e in qcow2_open_entry /mnt/sdb/qemu-new/qemu_test/qemu/=
block/qcow2.c:1792
    #10 0x55d7eacdc8fe in qcow2_open /mnt/sdb/qemu-new/qemu_test/qemu/block=
/qcow2.c:1819
    #11 0x55d7eac3742d in bdrv_open_driver /mnt/sdb/qemu-new/qemu_test/qemu=
/block.c:1317
    #12 0x55d7eac3e990 in bdrv_open_common /mnt/sdb/qemu-new/qemu_test/qemu=
/block.c:1575
    #13 0x55d7eac4442c in bdrv_open_inherit /mnt/sdb/qemu-new/qemu_test/qem=
u/block.c:3126
    #14 0x55d7eac45c3f in bdrv_open /mnt/sdb/qemu-new/qemu_test/qemu/block.=
c:3219
    #15 0x55d7ead8e8a4 in blk_new_open /mnt/sdb/qemu-new/qemu_test/qemu/blo=
ck/block-backend.c:397
    #16 0x55d7eacde74c in qcow2_co_create /mnt/sdb/qemu-new/qemu_test/qemu/=
block/qcow2.c:3534
    #17 0x55d7eacdfa6d in qcow2_co_create_opts /mnt/sdb/qemu-new/qemu_test/=
qemu/block/qcow2.c:3668
    #18 0x55d7eac1c678 in bdrv_create_co_entry /mnt/sdb/qemu-new/qemu_test/=
qemu/block.c:485
    #19 0x55d7eb0024d2 in coroutine_trampoline /mnt/sdb/qemu-new/qemu_test/=
qemu/util/coroutine-ucontext.c:115

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200227012950.12256-2-pannengyuan@huawei.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/qcow2.c b/block/qcow2.c
index f667349e50..d44b45633d 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2610,6 +2610,7 @@ static void qcow2_close(BlockDriverState *bs)
=20
     qcrypto_block_free(s->crypto);
     s->crypto =3D NULL;
+    qapi_free_QCryptoBlockOpenOptions(s->crypto_opts);
=20
     g_free(s->unknown_header_fields);
     cleanup_unknown_header_ext(bs);
--=20
2.24.1


