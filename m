Return-Path: <SRS0=QWrs=3F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8483CC33CB1
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 08:57:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E0E4207E0
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2020 08:57:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E0E4207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1is0xj-0000sg-Gh
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 03:57:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33426)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pannengyuan@huawei.com>) id 1is0wv-0008Gc-8i
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 03:56:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pannengyuan@huawei.com>) id 1is0wu-0000ZB-49
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 03:56:21 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:57982 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pannengyuan@huawei.com>)
 id 1is0wr-0000UC-0d; Thu, 16 Jan 2020 03:56:17 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 90F37CE213EE441F4ADE;
 Thu, 16 Jan 2020 16:56:09 +0800 (CST)
Received: from DESKTOP-9NTIQGG.china.huawei.com (10.173.221.136) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Thu, 16 Jan 2020 16:56:03 +0800
From: <pannengyuan@huawei.com>
To: <kwolf@redhat.com>, <mreitz@redhat.com>
Subject: [PATCH] block: fix memleaks in bdrv_refresh_filename
Date: Thu, 16 Jan 2020 16:56:00 +0800
Message-ID: <20200116085600.24056-1-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.221.136]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
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
Cc: Euler Robot <euler.robot@huawei.com>, Pan Nengyuan <pannengyuan@huawei.com>,
 zhang.zhanghailiang@huawei.com, qemu-block@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pan Nengyuan <pannengyuan@huawei.com>

If we call the qmp 'query-block' while qemu is working on
'block-commit', it will cause memleaks, the memory leak stack is as
follow:

Indirect leak of 12360 byte(s) in 3 object(s) allocated from:
    #0 0x7f80f0b6d970 in __interceptor_calloc (/lib64/libasan.so.5+0xef97=
0)
    #1 0x7f80ee86049d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5249d)
    #2 0x55ea95b5bb67 in qdict_new /mnt/sdb/qemu-4.2.0-rc0/qobject/qdict.=
c:29
    #3 0x55ea956cd043 in bdrv_refresh_filename /mnt/sdb/qemu-4.2.0-rc0/bl=
ock.c:6427
    #4 0x55ea956cc950 in bdrv_refresh_filename /mnt/sdb/qemu-4.2.0-rc0/bl=
ock.c:6399
    #5 0x55ea956cc950 in bdrv_refresh_filename /mnt/sdb/qemu-4.2.0-rc0/bl=
ock.c:6399
    #6 0x55ea956cc950 in bdrv_refresh_filename /mnt/sdb/qemu-4.2.0-rc0/bl=
ock.c:6399
    #7 0x55ea958818ea in bdrv_block_device_info /mnt/sdb/qemu-4.2.0-rc0/b=
lock/qapi.c:56
    #8 0x55ea958879de in bdrv_query_info /mnt/sdb/qemu-4.2.0-rc0/block/qa=
pi.c:392
    #9 0x55ea9588b58f in qmp_query_block /mnt/sdb/qemu-4.2.0-rc0/block/qa=
pi.c:578
    #10 0x55ea95567392 in qmp_marshal_query_block qapi/qapi-commands-bloc=
k-core.c:95

Indirect leak of 4120 byte(s) in 1 object(s) allocated from:
    #0 0x7f80f0b6d970 in __interceptor_calloc (/lib64/libasan.so.5+0xef97=
0)
    #1 0x7f80ee86049d in g_malloc0 (/lib64/libglib-2.0.so.0+0x5249d)
    #2 0x55ea95b5bb67 in qdict_new /mnt/sdb/qemu-4.2.0-rc0/qobject/qdict.=
c:29
    #3 0x55ea956cd043 in bdrv_refresh_filename /mnt/sdb/qemu-4.2.0-rc0/bl=
ock.c:6427
    #4 0x55ea956cc950 in bdrv_refresh_filename /mnt/sdb/qemu-4.2.0-rc0/bl=
ock.c:6399
    #5 0x55ea956cc950 in bdrv_refresh_filename /mnt/sdb/qemu-4.2.0-rc0/bl=
ock.c:6399
    #6 0x55ea9569f301 in bdrv_backing_attach /mnt/sdb/qemu-4.2.0-rc0/bloc=
k.c:1064
    #7 0x55ea956a99dd in bdrv_replace_child_noperm /mnt/sdb/qemu-4.2.0-rc=
0/block.c:2283
    #8 0x55ea956b9b53 in bdrv_replace_node /mnt/sdb/qemu-4.2.0-rc0/block.=
c:4196
    #9 0x55ea956b9e49 in bdrv_append /mnt/sdb/qemu-4.2.0-rc0/block.c:4236
    #10 0x55ea958c3472 in commit_start /mnt/sdb/qemu-4.2.0-rc0/block/comm=
it.c:306
    #11 0x55ea94b68ab0 in qmp_block_commit /mnt/sdb/qemu-4.2.0-rc0/blockd=
ev.c:3459
    #12 0x55ea9556a7a7 in qmp_marshal_block_commit qapi/qapi-commands-blo=
ck-core.c:407

Fixes: bb808d5f5c0978828a974d547e6032402c339555
Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
---
 block.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block.c b/block.c
index ecd09dbbfd..177eb8ade0 100644
--- a/block.c
+++ b/block.c
@@ -6419,6 +6419,7 @@ void bdrv_refresh_filename(BlockDriverState *bs)
                 child->bs->exact_filename);
         pstrcpy(bs->filename, sizeof(bs->filename), child->bs->filename)=
;
=20
+        qobject_unref(bs->full_open_options);
         bs->full_open_options =3D qobject_ref(child->bs->full_open_optio=
ns);
=20
         return;
--=20
2.21.0.windows.1



