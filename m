Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0173C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 09:50:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C544020848
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 09:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C544020848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2B8T-0006G4-1e
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 04:50:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46055)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fengzhimin1@huawei.com>) id 1j2AxE-00072l-09
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:38:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fengzhimin1@huawei.com>) id 1j2AxC-0005Ee-08
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:38:39 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2779 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fengzhimin1@huawei.com>)
 id 1j2AxB-00052Z-Kt
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:38:37 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id B09D99A0BA9C9E556120;
 Thu, 13 Feb 2020 17:38:25 +0800 (CST)
Received: from huawei.com (10.173.220.198) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Thu, 13 Feb 2020
 17:38:15 +0800
From: Zhimin Feng <fengzhimin1@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>, <armbru@redhat.com>,
 <eblake@redhat.com>
Subject: [PATCH RFC 13/14] migration/rdma: only register the memory for
 multifd channels
Date: Thu, 13 Feb 2020 17:37:54 +0800
Message-ID: <20200213093755.370-14-fengzhimin1@huawei.com>
X-Mailer: git-send-email 2.24.0.windows.2
In-Reply-To: <20200213093755.370-1-fengzhimin1@huawei.com>
References: <20200213093755.370-1-fengzhimin1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.220.198]
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
Cc: jemmy858585@gmail.com, Zhimin Feng <fengzhimin1@huawei.com>,
 qemu-devel@nongnu.org, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

All data is sent by multifd Channels, so we only register its for
multifd channels and main channel don't register its.

Signed-off-by: Zhimin Feng <fengzhimin1@huawei.com>
---
 migration/rdma.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/migration/rdma.c b/migration/rdma.c
index eb7c2edbe7..b7b56c0493 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3717,6 +3717,12 @@ static int qemu_rdma_registration_stop(QEMUFile *f=
, void *opaque,
=20
                 qemu_sem_post(&multifd_send_param->sem_sync);
             }
+
+            /*
+             * Use multifd to migrate, we only register memory for
+             * multifd RDMA channel and main channel don't register it.
+             */
+            goto wait_reg_complete;
         }
=20
         /*
@@ -3778,6 +3784,7 @@ static int qemu_rdma_registration_stop(QEMUFile *f,=
 void *opaque,
             local->block[i].remote_rkey =3D rdma->dest_blocks[i].remote_=
rkey;
         }
=20
+wait_reg_complete:
         /* Wait for all multifd channels to complete registration */
         if (migrate_use_multifd()) {
             int i;
--=20
2.19.1



