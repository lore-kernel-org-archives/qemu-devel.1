Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30355ECE58D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 19:19:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0048E206CD
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 19:19:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0048E206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJ0Ro-0002Ki-M6
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 15:19:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37393)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iJ0PL-00006p-13
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 15:17:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iJ0PJ-0003hK-Up
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 15:16:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50580)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iJ0PJ-0003gm-Or
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 15:16:57 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 03E2D309843A;
 Fri, 11 Oct 2019 19:16:57 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-210.ams2.redhat.com
 [10.36.117.210])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CE5F75D6C8;
 Fri, 11 Oct 2019 19:16:55 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, quintela@redhat.com, eric.auger@redhat.com,
 richardw.yang@linux.intel.com
Subject: [PULL 01/21] migration: use migration_is_active to represent active
 state
Date: Fri, 11 Oct 2019 20:16:26 +0100
Message-Id: <20191011191646.226814-2-dgilbert@redhat.com>
In-Reply-To: <20191011191646.226814-1-dgilbert@redhat.com>
References: <20191011191646.226814-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 11 Oct 2019 19:16:57 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: peterx@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Wei Yang <richardw.yang@linux.intel.com>

Wrap the check into a function to make it easy to read.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
Message-Id: <20190717005341.14140-1-richardw.yang@linux.intel.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/migration/misc.h |  1 +
 migration/migration.c    | 12 ++++++++----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index b9d8e787af..d2762257aa 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -60,6 +60,7 @@ void migration_object_init(void);
 void migration_shutdown(void);
 void qemu_start_incoming_migration(const char *uri, Error **errp);
 bool migration_is_idle(void);
+bool migration_is_active(MigrationState *);
 void add_migration_state_change_notifier(Notifier *notify);
 void remove_migration_state_change_notifier(Notifier *notify);
 bool migration_in_setup(MigrationState *);
diff --git a/migration/migration.c b/migration/migration.c
index 5f7e4d15e9..0c51aa6ac7 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1533,8 +1533,7 @@ static void migrate_fd_cleanup(MigrationState *s)
         qemu_fclose(tmp);
     }
=20
-    assert((s->state !=3D MIGRATION_STATUS_ACTIVE) &&
-           (s->state !=3D MIGRATION_STATUS_POSTCOPY_ACTIVE));
+    assert(!migration_is_active(s));
=20
     if (s->state =3D=3D MIGRATION_STATUS_CANCELLING) {
         migrate_set_state(&s->state, MIGRATION_STATUS_CANCELLING,
@@ -1703,6 +1702,12 @@ bool migration_is_idle(void)
     return false;
 }
=20
+bool migration_is_active(MigrationState *s)
+{
+    return (s->state =3D=3D MIGRATION_STATUS_ACTIVE ||
+            s->state =3D=3D MIGRATION_STATUS_POSTCOPY_ACTIVE);
+}
+
 void migrate_init(MigrationState *s)
 {
     /*
@@ -3266,8 +3271,7 @@ static void *migration_thread(void *opaque)
=20
     trace_migration_thread_setup_complete();
=20
-    while (s->state =3D=3D MIGRATION_STATUS_ACTIVE ||
-           s->state =3D=3D MIGRATION_STATUS_POSTCOPY_ACTIVE) {
+    while (migration_is_active(s)) {
         int64_t current_time;
=20
         if (urgent || !qemu_file_rate_limit(s->to_dst_file)) {
--=20
2.23.0


