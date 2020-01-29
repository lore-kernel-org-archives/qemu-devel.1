Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C885C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 11:20:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 674132070E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 11:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VboAbvRM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 674132070E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44504 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwlOz-00013g-Ha
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 06:20:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60173)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1iwlKm-00028M-3d
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 06:16:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1iwlKk-0006ap-Of
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 06:16:35 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38857
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1iwlKk-0006ac-L1
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 06:16:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580296594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AQRwWfJqPtVLReOtRIx8yJtnPhUyNOAWNPFaWVmWw7c=;
 b=VboAbvRM1BQoB9IZoe10i3SRguUSmprEL7qCBQVETG+t7+c/GKrTm48VeKVE1wz5ZWeSQd
 zUDZb3g5om8PPnx6pzKwhG610ehB2oHaBKs4f2iLb62r4mkNtf1/+ynDLsZxN9X5l9Qj+p
 hvGUFHolqt9vIC9M78g6y1ynll2/P4E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-323-jHKvOSCmOV6uEbqLBYaukg-1; Wed, 29 Jan 2020 06:16:30 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9FE5E1800D41
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 11:16:29 +0000 (UTC)
Received: from secure.mitica (ovpn-116-64.ams2.redhat.com [10.36.116.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EDC728E9FE;
 Wed, 29 Jan 2020 11:16:25 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/18] multifd: Make multifd_load_setup() get an Error parameter
Date: Wed, 29 Jan 2020 12:15:33 +0100
Message-Id: <20200129111536.9497-16-quintela@redhat.com>
In-Reply-To: <20200129111536.9497-1-quintela@redhat.com>
References: <20200129111536.9497-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: jHKvOSCmOV6uEbqLBYaukg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We need to change the full chain to pass the Error parameter.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/migration.c | 35 +++++++++++++++++++++++++++++------
 migration/migration.h |  2 +-
 migration/ram.c       |  2 +-
 migration/ram.h       |  2 +-
 migration/rdma.c      |  2 +-
 5 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index d478f832ea..adc7d08e93 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -518,13 +518,23 @@ fail:
     exit(EXIT_FAILURE);
 }
=20
-static void migration_incoming_setup(QEMUFile *f)
+/**
+ * @migration_incoming_setup: Setup incoming migration
+ *
+ * Returns 0 for no error or 1 for error
+ *
+ * @f: file for main migration channel
+ * @errp: where to put errors
+ */
+static int migration_incoming_setup(QEMUFile *f, Error **errp)
 {
     MigrationIncomingState *mis =3D migration_incoming_get_current();
+    Error *local_err =3D NULL;
=20
-    if (multifd_load_setup() !=3D 0) {
+    if (multifd_load_setup(&local_err) !=3D 0) {
         /* We haven't been able to create multifd threads
            nothing better to do */
+        error_report_err(local_err);
         exit(EXIT_FAILURE);
     }
=20
@@ -532,6 +542,7 @@ static void migration_incoming_setup(QEMUFile *f)
         mis->from_src_file =3D f;
     }
     qemu_file_set_blocking(f, false);
+    return 0;
 }
=20
 void migration_incoming_process(void)
@@ -572,19 +583,27 @@ static bool postcopy_try_recover(QEMUFile *f)
     return false;
 }
=20
-void migration_fd_process_incoming(QEMUFile *f)
+void migration_fd_process_incoming(QEMUFile *f, Error **errp)
 {
+    Error *local_err =3D NULL;
+
     if (postcopy_try_recover(f)) {
         return;
     }
=20
-    migration_incoming_setup(f);
+    if (migration_incoming_setup(f, &local_err)) {
+        if (local_err) {
+            error_propagate(errp, local_err);
+        }
+        return;
+    }
     migration_incoming_process();
 }
=20
 void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp)
 {
     MigrationIncomingState *mis =3D migration_incoming_get_current();
+    Error *local_err =3D NULL;
     bool start_migration;
=20
     if (!mis->from_src_file) {
@@ -596,7 +615,12 @@ void migration_ioc_process_incoming(QIOChannel *ioc, E=
rror **errp)
             return;
         }
=20
-        migration_incoming_setup(f);
+        if (migration_incoming_setup(f, &local_err)) {
+            if (local_err) {
+                error_propagate(errp, local_err);
+            }
+            return;
+        }
=20
         /*
          * Common migration only needs one channel, so we can start
@@ -604,7 +628,6 @@ void migration_ioc_process_incoming(QIOChannel *ioc, Er=
ror **errp)
          */
         start_migration =3D !migrate_use_multifd();
     } else {
-        Error *local_err =3D NULL;
         /* Multiple connections */
         assert(migrate_use_multifd());
         start_migration =3D multifd_recv_new_channel(ioc, &local_err);
diff --git a/migration/migration.h b/migration/migration.h
index 44b1d56929..8473ddfc88 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -265,7 +265,7 @@ struct MigrationState
=20
 void migrate_set_state(int *state, int old_state, int new_state);
=20
-void migration_fd_process_incoming(QEMUFile *f);
+void migration_fd_process_incoming(QEMUFile *f, Error **errp);
 void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
 void migration_incoming_process(void);
=20
diff --git a/migration/ram.c b/migration/ram.c
index 78483247ad..3abd41ad33 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1474,7 +1474,7 @@ static void *multifd_recv_thread(void *opaque)
     return NULL;
 }
=20
-int multifd_load_setup(void)
+int multifd_load_setup(Error **errp)
 {
     int thread_count;
     uint32_t page_count =3D MULTIFD_PACKET_SIZE / qemu_target_page_size();
diff --git a/migration/ram.h b/migration/ram.h
index da22a417ea..42be471d52 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -43,7 +43,7 @@ uint64_t ram_bytes_total(void);
=20
 int multifd_save_setup(Error **errp);
 void multifd_save_cleanup(void);
-int multifd_load_setup(void);
+int multifd_load_setup(Error **errp);
 int multifd_load_cleanup(Error **errp);
 bool multifd_recv_all_channels_created(void);
 bool multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
diff --git a/migration/rdma.c b/migration/rdma.c
index e241dcb992..2379b8345b 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -4004,7 +4004,7 @@ static void rdma_accept_incoming_migration(void *opaq=
ue)
     }
=20
     rdma->migration_started_on_destination =3D 1;
-    migration_fd_process_incoming(f);
+    migration_fd_process_incoming(f, errp);
 }
=20
 void rdma_start_incoming_migration(const char *host_port, Error **errp)
--=20
2.24.1


