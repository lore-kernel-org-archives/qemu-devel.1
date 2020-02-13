Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9EDC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 09:45:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0ED5220848
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 09:45:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0ED5220848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2B4B-00026G-6B
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 04:45:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45954)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fengzhimin1@huawei.com>) id 1j2Ax1-0006hV-7x
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:38:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fengzhimin1@huawei.com>) id 1j2Ax0-00052T-3m
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:38:27 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2773 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fengzhimin1@huawei.com>)
 id 1j2Awz-00050b-PG
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:38:26 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id B64E8B6B29421BA12035;
 Thu, 13 Feb 2020 17:38:20 +0800 (CST)
Received: from huawei.com (10.173.220.198) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Thu, 13 Feb 2020
 17:38:14 +0800
From: Zhimin Feng <fengzhimin1@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>, <armbru@redhat.com>,
 <eblake@redhat.com>
Subject: [PATCH RFC 12/14] migration/rdma: use multifd to migrate VM for NOT
 rdma-pin-all mode
Date: Thu, 13 Feb 2020 17:37:53 +0800
Message-ID: <20200213093755.370-13-fengzhimin1@huawei.com>
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

Signed-off-by: Zhimin Feng <fengzhimin1@huawei.com>
---
 migration/rdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 873c17dc03..eb7c2edbe7 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -1749,7 +1749,7 @@ static int qemu_rdma_write_one(QEMUFile *f, RDMACon=
text *rdma,
                              };
=20
     /* use multifd to send data */
-    if (migrate_use_multifd() && migrate_use_rdma_pin_all()) {
+    if (migrate_use_multifd()) {
         int channel =3D get_multifd_RDMA_channel();
         int ret =3D 0;
         MultiFDSendParams *multifd_send_param =3D NULL;
@@ -1979,7 +1979,7 @@ static int qemu_rdma_write_flush(QEMUFile *f, RDMAC=
ontext *rdma)
     }
=20
     if (ret =3D=3D 0) {
-        if (migrate_use_multifd() && migrate_use_rdma_pin_all()) {
+        if (migrate_use_multifd()) {
             /* The multifd RDMA threads send data */
             MultiFDSendParams *multifd_send_param =3D NULL;
             ret =3D get_multifd_send_param(current_RDMA_index,
--=20
2.19.1



