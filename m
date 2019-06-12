Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0777C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 10:55:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 974AF2080A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 10:55:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 974AF2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58745 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hb0v8-0001do-S5
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 06:55:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60137)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <quintela@redhat.com>) id 1hb0t5-0008JO-8n
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 06:53:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1hb0t3-0004mo-W1
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 06:53:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40454)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hb0t0-0004jy-U3
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 06:53:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 42DEE37E8E
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 10:53:40 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-241.ams2.redhat.com
 [10.36.116.241])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D795153786;
 Wed, 12 Jun 2019 10:53:34 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed, 12 Jun 2019 12:53:20 +0200
Message-Id: <20190612105323.7051-4-quintela@redhat.com>
In-Reply-To: <20190612105323.7051-1-quintela@redhat.com>
References: <20190612105323.7051-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Wed, 12 Jun 2019 10:53:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v4 3/6] migration: Make multifd_load_setup()
 get an Error parameter
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We need to change the full chain to pass the Error parameter.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 10 +++++-----
 migration/migration.h |  2 +-
 migration/ram.c       |  2 +-
 migration/ram.h       |  2 +-
 migration/rdma.c      |  2 +-
 5 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 0ac504be3c..4246bdd661 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -513,11 +513,11 @@ fail:
     exit(EXIT_FAILURE);
 }
=20
-static void migration_incoming_setup(QEMUFile *f)
+static void migration_incoming_setup(QEMUFile *f, Error **errp)
 {
     MigrationIncomingState *mis =3D migration_incoming_get_current();
=20
-    if (multifd_load_setup() !=3D 0) {
+    if (multifd_load_setup(errp) !=3D 0) {
         /* We haven't been able to create multifd threads
            nothing better to do */
         exit(EXIT_FAILURE);
@@ -567,13 +567,13 @@ static bool postcopy_try_recover(QEMUFile *f)
     return false;
 }
=20
-void migration_fd_process_incoming(QEMUFile *f)
+void migration_fd_process_incoming(QEMUFile *f, Error **errp)
 {
     if (postcopy_try_recover(f)) {
         return;
     }
=20
-    migration_incoming_setup(f);
+    migration_incoming_setup(f, errp);
     migration_incoming_process();
 }
=20
@@ -591,7 +591,7 @@ void migration_ioc_process_incoming(QIOChannel *ioc, =
Error **errp)
             return;
         }
=20
-        migration_incoming_setup(f);
+        migration_incoming_setup(f, errp);
=20
         /*
          * Common migration only needs one channel, so we can start
diff --git a/migration/migration.h b/migration/migration.h
index 780a096857..71c03353c3 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -237,7 +237,7 @@ struct MigrationState
=20
 void migrate_set_state(int *state, int old_state, int new_state);
=20
-void migration_fd_process_incoming(QEMUFile *f);
+void migration_fd_process_incoming(QEMUFile *f, Error **errp);
 void migration_ioc_process_incoming(QIOChannel *ioc, Error **errp);
 void migration_incoming_process(void);
=20
diff --git a/migration/ram.c b/migration/ram.c
index 4b65d22cb1..b0ca989160 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1370,7 +1370,7 @@ static void *multifd_recv_thread(void *opaque)
     return NULL;
 }
=20
-int multifd_load_setup(void)
+int multifd_load_setup(Error **errp)
 {
     int thread_count;
     uint32_t page_count =3D MULTIFD_PACKET_SIZE / qemu_target_page_size(=
);
diff --git a/migration/ram.h b/migration/ram.h
index 09feaad55b..dd1a736417 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -44,7 +44,7 @@ uint64_t ram_bytes_total(void);
=20
 int multifd_save_setup(Error **errp);
 void multifd_save_cleanup(void);
-int multifd_load_setup(void);
+int multifd_load_setup(Error **errp);
 int multifd_load_cleanup(Error **errp);
 bool multifd_recv_all_channels_created(void);
 bool multifd_recv_new_channel(QIOChannel *ioc, Error **errp);
diff --git a/migration/rdma.c b/migration/rdma.c
index c1bcece53b..69389a8662 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -4019,7 +4019,7 @@ static void rdma_accept_incoming_migration(void *op=
aque)
     }
=20
     rdma->migration_started_on_destination =3D 1;
-    migration_fd_process_incoming(f);
+    migration_fd_process_incoming(f, errp);
 }
=20
 void rdma_start_incoming_migration(const char *host_port, Error **errp)
--=20
2.21.0


