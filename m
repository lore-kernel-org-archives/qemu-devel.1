Return-Path: <SRS0=r7Ry=6C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCC4DC2BA19
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 06:30:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F22F214AF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Apr 2020 06:30:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F22F214AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPh0A-0002wj-Jz
	for qemu-devel@archiver.kernel.org; Sat, 18 Apr 2020 02:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jPgwO-00026r-R2
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 02:27:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jPgwM-0006TS-Fx
 for qemu-devel@nongnu.org; Sat, 18 Apr 2020 02:26:59 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3673 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1jPgwE-0004N2-Tu; Sat, 18 Apr 2020 02:26:51 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id A998E56E407A6C3971DD;
 Sat, 18 Apr 2020 14:26:32 +0800 (CST)
Received: from huawei.com (10.133.205.93) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.487.0; Sat, 18 Apr 2020
 14:26:23 +0800
From: Chen Qun <kuhn.chenqun@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-trivial@nongnu.org>
Subject: [PATCH] block/iscsi:fix heap-buffer-overflow in iscsi_aio_ioctl_cb
Date: Sat, 18 Apr 2020 14:26:02 +0800
Message-ID: <20200418062602.10776-1-kuhn.chenqun@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.133.205.93]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.190
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
Cc: Kevin Wolf <kwolf@redhat.com>, zhang.zhanghailiang@huawei.com,
 qemu-block@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Peter Lieven <pl@kamp.de>, Prasad J Pandit <ppandit@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Euler Robot <euler.robot@huawei.com>, Chen Qun <kuhn.chenqun@huawei.com>,
 Max Reitz <mreitz@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is an overflow, the source 'datain.data[2]' is 100 bytes,
 but the 'ss' is 252 bytes.This may cause a security issue because
 we can access a lot of unrelated memory data.

The len for sbp copy data should take the minimum of mx_sb_len and
 sb_len_wr, not the maximum.

If we use iscsi device for VM backend storage, ASAN show stack:

READ of size 252 at 0xfffd149dcfc4 thread T0
    #0 0xaaad433d0d34 in __asan_memcpy (aarch64-softmmu/qemu-system-aarch=
64+0x2cb0d34)
    #1 0xaaad45f9d6d0 in iscsi_aio_ioctl_cb /qemu/block/iscsi.c:996:9
    #2 0xfffd1af0e2dc  (/usr/lib64/iscsi/libiscsi.so.8+0xe2dc)
    #3 0xfffd1af0d174  (/usr/lib64/iscsi/libiscsi.so.8+0xd174)
    #4 0xfffd1af19fac  (/usr/lib64/iscsi/libiscsi.so.8+0x19fac)
    #5 0xaaad45f9acc8 in iscsi_process_read /qemu/block/iscsi.c:403:5
    #6 0xaaad4623733c in aio_dispatch_handler /qemu/util/aio-posix.c:467:=
9
    #7 0xaaad4622f350 in aio_dispatch_handlers /qemu/util/aio-posix.c:510=
:20
    #8 0xaaad4622f350 in aio_dispatch /qemu/util/aio-posix.c:520
    #9 0xaaad46215944 in aio_ctx_dispatch /qemu/util/async.c:298:5
    #10 0xfffd1bed12f4 in g_main_context_dispatch (/lib64/libglib-2.0.so.=
0+0x512f4)
    #11 0xaaad46227de0 in glib_pollfds_poll /qemu/util/main-loop.c:219:9
    #12 0xaaad46227de0 in os_host_main_loop_wait /qemu/util/main-loop.c:2=
42
    #13 0xaaad46227de0 in main_loop_wait /qemu/util/main-loop.c:518
    #14 0xaaad43d9d60c in qemu_main_loop /qemu/softmmu/vl.c:1662:9
    #15 0xaaad4607a5b0 in main /qemu/softmmu/main.c:49:5
    #16 0xfffd1a460b9c in __libc_start_main (/lib64/libc.so.6+0x20b9c)
    #17 0xaaad43320740 in _start (aarch64-softmmu/qemu-system-aarch64+0x2=
c00740)

0xfffd149dcfc4 is located 0 bytes to the right of 100-byte region [0xfffd=
149dcf60,0xfffd149dcfc4)
allocated by thread T0 here:
    #0 0xaaad433d1e70 in __interceptor_malloc (aarch64-softmmu/qemu-syste=
m-aarch64+0x2cb1e70)
    #1 0xfffd1af0e254  (/usr/lib64/iscsi/libiscsi.so.8+0xe254)
    #2 0xfffd1af0d174  (/usr/lib64/iscsi/libiscsi.so.8+0xd174)
    #3 0xfffd1af19fac  (/usr/lib64/iscsi/libiscsi.so.8+0x19fac)
    #4 0xaaad45f9acc8 in iscsi_process_read /qemu/block/iscsi.c:403:5
    #5 0xaaad4623733c in aio_dispatch_handler /qemu/util/aio-posix.c:467:=
9
    #6 0xaaad4622f350 in aio_dispatch_handlers /qemu/util/aio-posix.c:510=
:20
    #7 0xaaad4622f350 in aio_dispatch /qemu/util/aio-posix.c:520
    #8 0xaaad46215944 in aio_ctx_dispatch /qemu/util/async.c:298:5
    #9 0xfffd1bed12f4 in g_main_context_dispatch (/lib64/libglib-2.0.so.0=
+0x512f4)
    #10 0xaaad46227de0 in glib_pollfds_poll /qemu/util/main-loop.c:219:9
    #11 0xaaad46227de0 in os_host_main_loop_wait /qemu/util/main-loop.c:2=
42
    #12 0xaaad46227de0 in main_loop_wait /qemu/util/main-loop.c:518
    #13 0xaaad43d9d60c in qemu_main_loop /qemu/softmmu/vl.c:1662:9
    #14 0xaaad4607a5b0 in main /qemu/softmmu/main.c:49:5
    #15 0xfffd1a460b9c in __libc_start_main (/lib64/libc.so.6+0x20b9c)
    #16 0xaaad43320740 in _start (aarch64-softmmu/qemu-system-aarch64+0x2=
c00740)

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
v1->v2:
Use MIN() macro for mx_sb_len and sb_len_wr.
(Base comments from Michael S. Tsirkin, Stefan Hajnoczi, Kevin Wolf)

Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Prasad J Pandit <ppandit@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Lieven <pl@kamp.de>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: qemu-block@nongnu.org
---
 block/iscsi.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 4e216bd8aa..0b4b7210df 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -991,8 +991,7 @@ iscsi_aio_ioctl_cb(struct iscsi_context *iscsi, int s=
tatus,
         acb->ioh->driver_status |=3D SG_ERR_DRIVER_SENSE;
=20
         acb->ioh->sb_len_wr =3D acb->task->datain.size - 2;
-        ss =3D (acb->ioh->mx_sb_len >=3D acb->ioh->sb_len_wr) ?
-             acb->ioh->mx_sb_len : acb->ioh->sb_len_wr;
+        ss =3D MIN(acb->ioh->mx_sb_len, acb->ioh->sb_len_wr);
         memcpy(acb->ioh->sbp, &acb->task->datain.data[2], ss);
     }
=20
--=20
2.23.0



