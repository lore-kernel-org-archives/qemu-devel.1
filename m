Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCF7C3F68F
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 09:58:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0EE32072E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 09:58:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0EE32072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipUaP-0003wU-Ga
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 04:58:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41996)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fengzhimin1@huawei.com>) id 1ipPvB-000100-Kd
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 23:59:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fengzhimin1@huawei.com>) id 1ipPv9-0001Iu-Vp
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 23:59:49 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2289 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fengzhimin1@huawei.com>)
 id 1ipPv9-000175-IM
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 23:59:47 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id CEC3FDBFB5913F201A51;
 Thu,  9 Jan 2020 12:59:40 +0800 (CST)
Received: from huawei.com (10.173.220.198) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Thu, 9 Jan 2020
 12:59:32 +0800
From: Zhimin Feng <fengzhimin1@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>, <armbru@redhat.com>,
 <eblake@redhat.com>
Subject: [PATCH RFC 02/12] migration: Export the 'migration_incoming_setup'
 function and add the 'migrate_use_rdma_pin_all' function
Date: Thu, 9 Jan 2020 12:59:12 +0800
Message-ID: <20200109045922.904-3-fengzhimin1@huawei.com>
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
X-Received-From: 45.249.212.191
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

We need to call the 'migration_incoming_setup' function in migration/rdma=
.c,
so it has to be changed to a global function.

Signed-off-by: fengzhimin <fengzhimin1@huawei.com>
---
 migration/migration.c | 11 ++++++++++-
 migration/migration.h |  2 ++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index e98e236ef9..d9d73a5eac 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -518,7 +518,7 @@ fail:
     exit(EXIT_FAILURE);
 }
=20
-static void migration_incoming_setup(QEMUFile *f)
+void migration_incoming_setup(QEMUFile *f)
 {
     MigrationIncomingState *mis =3D migration_incoming_get_current();
=20
@@ -2185,6 +2185,15 @@ bool migrate_use_multiRDMA(void)
     return s->enabled_capabilities[MIGRATION_CAPABILITY_MULTIRDMA];
 }
=20
+bool migrate_use_rdma_pin_all(void)
+{
+    MigrationState *s;
+
+    s =3D migrate_get_current();
+
+    return s->enabled_capabilities[MIGRATION_CAPABILITY_RDMA_PIN_ALL];
+}
+
 bool migrate_use_multifd(void)
 {
     MigrationState *s;
diff --git a/migration/migration.h b/migration/migration.h
index bb488028a6..0a23375b2f 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -265,6 +265,7 @@ struct MigrationState
=20
 void migrate_set_state(int *state, int old_state, int new_state);
=20
+void migration_incoming_setup(QEMUFile *f);
 void migration_fd_process_incoming(QEMUFile *f);
 void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
 void migration_incoming_process(void);
@@ -297,6 +298,7 @@ bool migrate_validate_uuid(void);
=20
 bool migrate_auto_converge(void);
 bool migrate_use_multiRDMA(void);
+bool migrate_use_rdma_pin_all(void);
 bool migrate_use_multifd(void);
 bool migrate_pause_before_switchover(void);
 int migrate_multifd_channels(void);
--=20
2.19.1



