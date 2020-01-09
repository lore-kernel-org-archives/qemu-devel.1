Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03788C33CA1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 09:58:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB19C2072A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 09:58:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB19C2072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipUaP-0003y7-FJ
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 04:58:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42141)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fengzhimin1@huawei.com>) id 1ipPvC-000106-EJ
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 23:59:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fengzhimin1@huawei.com>) id 1ipPv9-0001Im-Vm
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 23:59:50 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2288 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fengzhimin1@huawei.com>)
 id 1ipPv9-000172-Hz
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 23:59:47 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id D95024124071CE2929B8;
 Thu,  9 Jan 2020 12:59:40 +0800 (CST)
Received: from huawei.com (10.173.220.198) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Thu, 9 Jan 2020
 12:59:31 +0800
From: Zhimin Feng <fengzhimin1@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>, <armbru@redhat.com>,
 <eblake@redhat.com>
Subject: [PATCH RFC 01/12] migration: Add multiRDMA capability support
Date: Thu, 9 Jan 2020 12:59:11 +0800
Message-ID: <20200109045922.904-2-fengzhimin1@huawei.com>
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

Signed-off-by: fengzhimin <fengzhimin1@huawei.com>
---
 migration/migration.c | 11 +++++++++++
 migration/migration.h |  1 +
 qapi/migration.json   |  4 +++-
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 354ad072fa..e98e236ef9 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2176,6 +2176,15 @@ bool migrate_use_events(void)
     return s->enabled_capabilities[MIGRATION_CAPABILITY_EVENTS];
 }
=20
+bool migrate_use_multiRDMA(void)
+{
+    MigrationState *s;
+
+    s =3D migrate_get_current();
+
+    return s->enabled_capabilities[MIGRATION_CAPABILITY_MULTIRDMA];
+}
+
 bool migrate_use_multifd(void)
 {
     MigrationState *s;
@@ -3509,6 +3518,8 @@ static Property migration_properties[] =3D {
     DEFINE_PROP_MIG_CAP("x-block", MIGRATION_CAPABILITY_BLOCK),
     DEFINE_PROP_MIG_CAP("x-return-path", MIGRATION_CAPABILITY_RETURN_PAT=
H),
     DEFINE_PROP_MIG_CAP("x-multifd", MIGRATION_CAPABILITY_MULTIFD),
+    DEFINE_PROP_MIG_CAP("x-multirdma",
+                        MIGRATION_CAPABILITY_MULTIRDMA),
=20
     DEFINE_PROP_END_OF_LIST(),
 };
diff --git a/migration/migration.h b/migration/migration.h
index 79b3dda146..bb488028a6 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -296,6 +296,7 @@ bool migrate_ignore_shared(void);
 bool migrate_validate_uuid(void);
=20
 bool migrate_auto_converge(void);
+bool migrate_use_multiRDMA(void);
 bool migrate_use_multifd(void);
 bool migrate_pause_before_switchover(void);
 int migrate_multifd_channels(void);
diff --git a/qapi/migration.json b/qapi/migration.json
index b7348d0c8b..c995ffdc4c 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -421,6 +421,8 @@
 # @validate-uuid: Send the UUID of the source to allow the destination
 #                 to ensure it is the same. (since 4.2)
 #
+# @multirdma: Use more than one channels for rdma migration. (since 4.2)
+#
 # Since: 1.2
 ##
 { 'enum': 'MigrationCapability',
@@ -428,7 +430,7 @@
            'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram'=
,
            'block', 'return-path', 'pause-before-switchover', 'multifd',
            'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate',
-           'x-ignore-shared', 'validate-uuid' ] }
+           'x-ignore-shared', 'validate-uuid', 'multirdma' ] }
=20
 ##
 # @MigrationCapabilityStatus:
--=20
2.19.1



