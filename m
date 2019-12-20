Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E24A5C43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:13:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7DD8206EC
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 14:13:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7DD8206EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56590 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiJ1q-0001BM-J8
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 09:13:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53979)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chenjiajun8@huawei.com>) id 1iiEv3-00080w-MI
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 04:50:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chenjiajun8@huawei.com>) id 1iiEv2-0006lT-Bt
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 04:50:01 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2281 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chenjiajun8@huawei.com>)
 id 1iiEv1-0006ID-UY
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 04:50:00 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 655753285479021D78DB;
 Fri, 20 Dec 2019 17:49:52 +0800 (CST)
Received: from DESKTOP-RHHE7UD.china.huawei.com (10.173.221.217) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Fri, 20 Dec 2019 17:49:43 +0800
From: Jiajun Chen <chenjiajun8@huawei.com>
To: <groug@kaod.org>
Subject: [PATCH] 9pfs: local: Fix possible memory leak in local_link()
Date: Fri, 20 Dec 2019 17:49:34 +0800
Message-ID: <20191220094934.21232-1-chenjiajun8@huawei.com>
X-Mailer: git-send-email 2.21.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.221.217]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.191
X-Mailman-Approved-At: Fri, 20 Dec 2019 09:01:13 -0500
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
Cc: qemu-devel@nongnu.org, xiexiangyou@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is a possible memory leak while local_link return -1 without free
odirpath and oname.

Reported-by: Euler Robot <euler.robot@huawei.com>
Signed-off-by: Jaijun Chen <chenjiajun8@huawei.com>
Signed-off-by: Xiang Zheng <zhengxiang9@huawei.com>
---
 hw/9pfs/9p-local.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/9pfs/9p-local.c b/hw/9pfs/9p-local.c
index 4708c0bd89..491b08aee8 100644
--- a/hw/9pfs/9p-local.c
+++ b/hw/9pfs/9p-local.c
@@ -947,7 +947,7 @@ static int local_link(FsContext *ctx, V9fsPath *oldpa=
th,
     if (ctx->export_flags & V9FS_SM_MAPPED_FILE &&
         local_is_mapped_file_metadata(ctx, name)) {
         errno =3D EINVAL;
-        return -1;
+        goto out;
     }
=20
     odirfd =3D local_opendir_nofollow(ctx, odirpath);
--=20
2.21.0.windows.1



