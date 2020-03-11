Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A48C10F25
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 03:30:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CC7A20674
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 03:30:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CC7A20674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBs4u-0002HG-Pi
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 23:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54313)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jBs4D-0001el-JY
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 23:29:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kuhn.chenqun@huawei.com>) id 1jBs4C-0001Nx-Dv
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 23:29:57 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3196 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kuhn.chenqun@huawei.com>)
 id 1jBs4C-0001Bh-20; Tue, 10 Mar 2020 23:29:56 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 5643B4A7CBD4F5EEDE15;
 Wed, 11 Mar 2020 11:29:49 +0800 (CST)
Received: from huawei.com (10.133.205.93) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Wed, 11 Mar 2020
 11:29:38 +0800
From: Chen Qun <kuhn.chenqun@huawei.com>
To: <qemu-devel@nongnu.org>, <qemu-trivial@nongnu.org>
Subject: [PATCH v3] block/iscsi:use the flags in iscsi_open() prevent Clang
 warning
Date: Wed, 11 Mar 2020 11:29:27 +0800
Message-ID: <20200311032927.35092-1-kuhn.chenqun@huawei.com>
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
 Euler Robot <euler.robot@huawei.com>, Peter Lieven <pl@kamp.de>,
 Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>, Ronnie
 Sahlberg <ronniesahlberg@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Chen Qun <kuhn.chenqun@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Clang static code analyzer show warning:
  block/iscsi.c:1920:9: warning: Value stored to 'flags' is never read
        flags &=3D ~BDRV_O_RDWR;
        ^        ~~~~~~~~~~~~

In iscsi_allocmap_init() only checks BDRV_O_NOCACHE, which
is the same in both of flags and bs->open_flags.
We can use the flags instead bs->open_flags to prevent Clang warning.

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Chen Qun <kuhn.chenqun@huawei.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Lieven <pl@kamp.de>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: Laurent Vivier <laurent@vivier.eu>

v1->v2:
 Keep the 'flags' then use it(Base on Kevin's comments).

v2->v3:
 Modify subject and commit messages(Base on Kevin's and Laurent's comment=
s).
---
 block/iscsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 682abd8e09..50bae51700 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -2002,7 +2002,7 @@ static int iscsi_open(BlockDriverState *bs, QDict *=
options, int flags,
         iscsilun->cluster_size =3D iscsilun->bl.opt_unmap_gran *
             iscsilun->block_size;
         if (iscsilun->lbprz) {
-            ret =3D iscsi_allocmap_init(iscsilun, bs->open_flags);
+            ret =3D iscsi_allocmap_init(iscsilun, flags);
         }
     }
=20
--=20
2.23.0



