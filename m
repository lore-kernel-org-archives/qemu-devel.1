Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51498C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 09:41:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B0C7206CC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 09:41:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B0C7206CC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Azg-0003RD-Bg
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 04:41:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45893)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fengzhimin1@huawei.com>) id 1j2Awy-0006gi-W4
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:38:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fengzhimin1@huawei.com>) id 1j2Awx-0004zF-Sh
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:38:24 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2766 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fengzhimin1@huawei.com>)
 id 1j2Awx-0004qA-Gp
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:38:23 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id A33F81D81F85C3A487B6;
 Thu, 13 Feb 2020 17:38:15 +0800 (CST)
Received: from huawei.com (10.173.220.198) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Thu, 13 Feb 2020
 17:38:08 +0800
From: Zhimin Feng <fengzhimin1@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>, <armbru@redhat.com>,
 <eblake@redhat.com>
Subject: [PATCH RFC 02/14] migration: judge whether or not the RDMA is used
 for migration
Date: Thu, 13 Feb 2020 17:37:43 +0800
Message-ID: <20200213093755.370-3-fengzhimin1@huawei.com>
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
 migration/migration.c | 10 ++++++++++
 migration/migration.h |  1 +
 2 files changed, 11 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 10a13e0c79..819089a7ea 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -107,6 +107,7 @@ static NotifierList migration_state_notifiers =3D
     NOTIFIER_LIST_INITIALIZER(migration_state_notifiers);
=20
 static bool deferred_incoming;
+static bool enabled_rdma_migration;
=20
 /* Messages sent on the return path from destination to source */
 enum mig_rp_message_type {
@@ -354,6 +355,7 @@ void migrate_add_address(SocketAddress *address)
 void qemu_start_incoming_migration(const char *uri, Error **errp)
 {
     const char *p;
+    enabled_rdma_migration =3D false;
=20
     qapi_event_send_migration(MIGRATION_STATUS_SETUP);
     if (!strcmp(uri, "defer")) {
@@ -362,6 +364,7 @@ void qemu_start_incoming_migration(const char *uri, E=
rror **errp)
         tcp_start_incoming_migration(p, errp);
 #ifdef CONFIG_RDMA
     } else if (strstart(uri, "rdma:", &p)) {
+        enabled_rdma_migration =3D true;
         rdma_start_incoming_migration(p, errp);
 #endif
     } else if (strstart(uri, "exec:", &p)) {
@@ -1982,6 +1985,7 @@ void qmp_migrate(const char *uri, bool has_blk, boo=
l blk,
     Error *local_err =3D NULL;
     MigrationState *s =3D migrate_get_current();
     const char *p;
+    enabled_rdma_migration =3D false;
=20
     if (!migrate_prepare(s, has_blk && blk, has_inc && inc,
                          has_resume && resume, errp)) {
@@ -1993,6 +1997,7 @@ void qmp_migrate(const char *uri, bool has_blk, boo=
l blk,
         tcp_start_outgoing_migration(s, p, &local_err);
 #ifdef CONFIG_RDMA
     } else if (strstart(uri, "rdma:", &p)) {
+        enabled_rdma_migration =3D true;
         rdma_start_outgoing_migration(s, p, &local_err);
 #endif
     } else if (strstart(uri, "exec:", &p)) {
@@ -2208,6 +2213,11 @@ bool migrate_use_events(void)
     return s->enabled_capabilities[MIGRATION_CAPABILITY_EVENTS];
 }
=20
+bool migrate_use_rdma(void)
+{
+    return enabled_rdma_migration;
+}
+
 bool migrate_use_rdma_pin_all(void)
 {
     MigrationState *s;
diff --git a/migration/migration.h b/migration/migration.h
index 50fc2693c7..9b37320d50 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -297,6 +297,7 @@ bool migrate_ignore_shared(void);
 bool migrate_validate_uuid(void);
=20
 bool migrate_auto_converge(void);
+bool migrate_use_rdma(void);
 bool migrate_use_rdma_pin_all(void);
 bool migrate_use_multifd(void);
 bool migrate_pause_before_switchover(void);
--=20
2.19.1



