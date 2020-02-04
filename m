Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16342C3524A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 05:11:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D949420674
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 05:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D949420674
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyqUm-0003WP-3S
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 00:11:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48481)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhukeqian1@huawei.com>) id 1iyqU4-00030A-Kp
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 00:10:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhukeqian1@huawei.com>) id 1iyqU3-00046l-Dz
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 00:10:48 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:41470 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhukeqian1@huawei.com>)
 id 1iyqU0-0002n0-Mu; Tue, 04 Feb 2020 00:10:44 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 68DF8C6E135F0EF27316;
 Tue,  4 Feb 2020 13:10:36 +0800 (CST)
Received: from linux-TFkxOR.huawei.com (10.175.104.212) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.439.0; Tue, 4 Feb 2020 13:10:29 +0800
From: Keqian Zhu <zhukeqian1@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH] migration: Optimization about wait-unplug migration state
Date: Tue, 4 Feb 2020 13:08:41 +0800
Message-ID: <20200204050841.44453-1-zhukeqian1@huawei.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.212]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 45.249.212.35
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
Cc: Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 wanghaibin.wang@huawei.com, jfreimann@redhat.com,
 Keqian Zhu <zhukeqian1@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

qemu_savevm_nr_failover_devices() is originally designed to
get the number of failover devices, but it actually returns
the number of "unplug-pending" failover devices now. Moreover,
what drives migration state to wait-unplug should be the number
of "unplug-pending" failover devices, not all failover devices.

We can also notice that qemu_savevm_state_guest_unplug_pending()
and qemu_savevm_nr_failover_devices() is equivalent almost (from
the code view). So the latter is incorrect semantically and
useless, just delete it.

In the qemu_savevm_state_guest_unplug_pending(), once hit a
unplug-pending failover device, then it can return true right
now to save cpu time.

Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
---
Cc: jfreimann@redhat.com
Cc: Juan Quintela <quintela@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
---
 migration/migration.c |  2 +-
 migration/savevm.c    | 24 +++---------------------
 migration/savevm.h    |  1 -
 3 files changed, 4 insertions(+), 23 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 3a21a4686c..deedc968cf 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -3333,7 +3333,7 @@ static void *migration_thread(void *opaque)
=20
     qemu_savevm_state_setup(s->to_dst_file);
=20
-    if (qemu_savevm_nr_failover_devices()) {
+    if (qemu_savevm_state_guest_unplug_pending()) {
         migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
                           MIGRATION_STATUS_WAIT_UNPLUG);
=20
diff --git a/migration/savevm.c b/migration/savevm.c
index f19cb9ec7a..1d4220ece8 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1140,36 +1140,18 @@ void qemu_savevm_state_header(QEMUFile *f)
     }
 }
=20
-int qemu_savevm_nr_failover_devices(void)
+bool qemu_savevm_state_guest_unplug_pending(void)
 {
     SaveStateEntry *se;
-    int n =3D 0;
=20
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
         if (se->vmsd && se->vmsd->dev_unplug_pending &&
             se->vmsd->dev_unplug_pending(se->opaque)) {
-            n++;
-        }
-    }
-
-    return n;
-}
-
-bool qemu_savevm_state_guest_unplug_pending(void)
-{
-    SaveStateEntry *se;
-    int n =3D 0;
-
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
-        if (!se->vmsd || !se->vmsd->dev_unplug_pending) {
-            continue;
-        }
-        if (se->vmsd->dev_unplug_pending(se->opaque)) {
-            n++;
+            return true;
         }
     }
=20
-    return n > 0;
+    return false;
 }
=20
 void qemu_savevm_state_setup(QEMUFile *f)
diff --git a/migration/savevm.h b/migration/savevm.h
index c42b9c80ee..ba64a7e271 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -31,7 +31,6 @@
=20
 bool qemu_savevm_state_blocked(Error **errp);
 void qemu_savevm_state_setup(QEMUFile *f);
-int qemu_savevm_nr_failover_devices(void);
 bool qemu_savevm_state_guest_unplug_pending(void);
 int qemu_savevm_state_resume_prepare(MigrationState *s);
 void qemu_savevm_state_header(QEMUFile *f);
--=20
2.19.1


