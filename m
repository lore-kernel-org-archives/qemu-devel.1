Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B89CBC3F68F
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 10:02:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 900052072A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 10:02:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 900052072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipUdb-0007sR-Uk
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 05:01:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42362)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fengzhimin1@huawei.com>) id 1ipPvD-00010L-NA
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 23:59:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fengzhimin1@huawei.com>) id 1ipPvB-0001N1-VJ
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 23:59:51 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:34928 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fengzhimin1@huawei.com>)
 id 1ipPvB-0001Gp-FD
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 23:59:49 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id EAFEF725F85CFF8656CE;
 Thu,  9 Jan 2020 12:59:45 +0800 (CST)
Received: from huawei.com (10.173.220.198) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Thu, 9 Jan 2020
 12:59:35 +0800
From: Zhimin Feng <fengzhimin1@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>, <armbru@redhat.com>,
 <eblake@redhat.com>
Subject: [PATCH RFC 07/12] migration/rdma: Be sure all channels are created
Date: Thu, 9 Jan 2020 12:59:17 +0800
Message-ID: <20200109045922.904-8-fengzhimin1@huawei.com>
X-Mailer: git-send-email 2.24.0.windows.2
In-Reply-To: <20200109045922.904-1-fengzhimin1@huawei.com>
References: <20200109045922.904-1-fengzhimin1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.173.220.198]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.32
X-Mailman-Approved-At: Thu, 09 Jan 2020 04:56:54 -0500
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
Cc: jemmy858585@gmail.com, fengzhimin <fengzhimin1@huawei.com>,
 qemu-devel@nongnu.org, zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: fengzhimin <fengzhimin1@huawei.com>

We need to build all multiRDMA channels before we start migration.

Signed-off-by: fengzhimin <fengzhimin1@huawei.com>
---
 migration/rdma.c | 44 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index db75a4372a..518a21b0fe 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -4076,6 +4076,38 @@ static QEMUFile *qemu_fopen_rdma(RDMAContext *rdma=
, const char *mode)
     return rioc->file;
 }
=20
+static bool multiRDMA_send_all_channels_created(void)
+{
+    int thread_count =3D migrate_multiRDMA_channels();
+
+    return thread_count =3D=3D atomic_read(&multiRDMA_send_state->count)=
;
+}
+
+static bool multiRDMA_recv_all_channels_created(void)
+{
+    int thread_count =3D migrate_multiRDMA_channels();
+
+    return thread_count =3D=3D atomic_read(&multiRDMA_recv_state->count)=
;
+}
+
+static bool migration_has_all_rdma_channels(void)
+{
+    bool all_channels;
+    if (multiRDMA_send_state) {
+        MigrationState *ms =3D migrate_get_current();
+        all_channels =3D multiRDMA_send_all_channels_created();
+
+        return all_channels && ms->to_dst_file !=3D NULL;
+    } else {
+        MigrationIncomingState *mis =3D migration_incoming_get_current()=
;
+        all_channels =3D multiRDMA_recv_all_channels_created();
+
+        return all_channels && mis->from_src_file !=3D NULL;
+    }
+
+    return false;
+}
+
 static RDMAChannelInit_t migration_rdma_recv_initial_packet(QEMUFile *f,
                                                             Error **errp=
)
 {
@@ -4168,7 +4200,6 @@ static void migration_multiRDMA_process_incoming(QE=
MUFile *f, RDMAContext *rdma)
         if (!mis->from_src_file) {
             rdma->migration_started_on_destination =3D 1;
             migration_incoming_setup(f);
-            migration_incoming_process();
         }
         break;
=20
@@ -4189,6 +4220,11 @@ static void migration_multiRDMA_process_incoming(Q=
EMUFile *f, RDMAContext *rdma)
         }
         break;
     }
+
+    /* wait for all channels to be established */
+    if (migration_has_all_rdma_channels()) {
+        migration_incoming_process();
+    }
 }
=20
 static void rdma_accept_incoming_migration(void *opaque)
@@ -4683,7 +4719,11 @@ void rdma_start_outgoing_migration(void *opaque,
             ERROR(errp, "init multiRDMA channels failure!");
             goto err;
         }
-        migrate_fd_connect(s, NULL);
+
+        /* wait for all channels to be established */
+        if (migration_has_all_rdma_channels()) {
+            migrate_fd_connect(s, NULL);
+        }
     } else {
         migrate_fd_connect(s, NULL);
     }
--=20
2.19.1



