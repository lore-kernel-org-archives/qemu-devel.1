Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DD8C3B189
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 09:39:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F39C217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 09:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F39C217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Ay5-0008Or-Ii
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 04:39:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45953)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fengzhimin1@huawei.com>) id 1j2Ax1-0006hU-7x
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:38:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fengzhimin1@huawei.com>) id 1j2Ax0-00052w-9B
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:38:27 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2772 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fengzhimin1@huawei.com>)
 id 1j2Awz-00050e-QQ
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:38:26 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id AB4DFBC2EA1D7D187D71;
 Thu, 13 Feb 2020 17:38:20 +0800 (CST)
Received: from huawei.com (10.173.220.198) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Thu, 13 Feb 2020
 17:38:13 +0800
From: Zhimin Feng <fengzhimin1@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>, <armbru@redhat.com>,
 <eblake@redhat.com>
Subject: [PATCH RFC 10/14] migration/rdma: Wait for all multifd to complete
 registration
Date: Thu, 13 Feb 2020 17:37:51 +0800
Message-ID: <20200213093755.370-11-fengzhimin1@huawei.com>
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
 migration/multifd.c |  6 ++++++
 migration/rdma.c    | 17 +++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/migration/multifd.c b/migration/multifd.c
index 4ae25fc88f..c986d4c247 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -389,6 +389,7 @@ static void multifd_send_terminate_threads(Error *err=
)
         qemu_mutex_lock(&p->mutex);
         p->quit =3D true;
         if (migrate_use_rdma()) {
+            qemu_sem_post(&p->sem);
             qemu_sem_post(&p->sem_sync);
         } else {
             qemu_sem_post(&p->sem);
@@ -502,6 +503,11 @@ static void *multifd_rdma_send_thread(void *opaque)
     if (qemu_rdma_registration(p->rdma) < 0) {
         goto out;
     }
+    /*
+     * Inform the main RDMA thread to run when multifd
+     * RDMA thread have completed registration.
+     */
+    qemu_sem_post(&p->sem);
=20
     while (true) {
         qemu_sem_wait(&p->sem_sync);
diff --git a/migration/rdma.c b/migration/rdma.c
index 5de3a29712..4c48e9832c 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3733,6 +3733,23 @@ static int qemu_rdma_registration_stop(QEMUFile *f=
, void *opaque,
                     rdma->dest_blocks[i].remote_host_addr;
             local->block[i].remote_rkey =3D rdma->dest_blocks[i].remote_=
rkey;
         }
+
+        /* Wait for all multifd channels to complete registration */
+        if (migrate_use_multifd()) {
+            int i;
+            int thread_count =3D migrate_multifd_channels();
+            MultiFDSendParams *multifd_send_param =3D NULL;
+            for (i =3D 0; i < thread_count; i++) {
+                ret =3D get_multifd_send_param(i, &multifd_send_param);
+                if (ret) {
+                    ERROR(errp, "rdma: error"
+                          "getting multifd_send_param(%d)", i);
+                    return ret;
+                }
+
+                qemu_sem_wait(&multifd_send_param->sem);
+            }
+        }
     }
=20
     trace_qemu_rdma_registration_stop(flags);
--=20
2.19.1



