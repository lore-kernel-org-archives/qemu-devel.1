Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6922DC3B188
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 09:39:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4371B217F4
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 09:39:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4371B217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Ay8-0008RF-ES
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 04:39:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fengzhimin1@huawei.com>) id 1j2Awz-0006gs-G2
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:38:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fengzhimin1@huawei.com>) id 1j2Awy-00050B-3r
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:38:25 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2768 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fengzhimin1@huawei.com>)
 id 1j2Awx-0004q9-Gq
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:38:24 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id A80D067201E9F3108812;
 Thu, 13 Feb 2020 17:38:15 +0800 (CST)
Received: from huawei.com (10.173.220.198) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Thu, 13 Feb 2020
 17:38:09 +0800
From: Zhimin Feng <fengzhimin1@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>, <armbru@redhat.com>,
 <eblake@redhat.com>
Subject: [PATCH RFC 03/14] migration/rdma: Create multiFd migration threads
Date: Thu, 13 Feb 2020 17:37:44 +0800
Message-ID: <20200213093755.370-4-fengzhimin1@huawei.com>
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

Creation of the multifd send threads for RDMA migration,
nothing inside yet.

Signed-off-by: Zhimin Feng <fengzhimin1@huawei.com>
---
 migration/multifd.c   | 33 +++++++++++++---
 migration/multifd.h   |  2 +
 migration/qemu-file.c |  5 +++
 migration/qemu-file.h |  1 +
 migration/rdma.c      | 88 ++++++++++++++++++++++++++++++++++++++++++-
 migration/rdma.h      |  3 ++
 6 files changed, 125 insertions(+), 7 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index b3e8ae9bcc..63678d7fdd 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -424,7 +424,7 @@ void multifd_send_sync_main(QEMUFile *f)
 {
     int i;
=20
-    if (!migrate_use_multifd()) {
+    if (!migrate_use_multifd() || migrate_use_rdma()) {
         return;
     }
     if (multifd_send_state->pages->used) {
@@ -562,6 +562,20 @@ out:
     return NULL;
 }
=20
+static void rdma_send_channel_create(MultiFDSendParams *p)
+{
+    Error *local_err =3D NULL;
+
+    if (p->quit) {
+        error_setg(&local_err, "multifd: send id %d already quit", p->id=
);
+        return ;
+    }
+    p->running =3D true;
+
+    qemu_thread_create(&p->thread, p->name, multifd_rdma_send_thread, p,
+                       QEMU_THREAD_JOINABLE);
+}
+
 static void multifd_new_send_channel_async(QIOTask *task, gpointer opaqu=
e)
 {
     MultiFDSendParams *p =3D opaque;
@@ -621,7 +635,11 @@ int multifd_save_setup(Error **errp)
         p->packet->magic =3D cpu_to_be32(MULTIFD_MAGIC);
         p->packet->version =3D cpu_to_be32(MULTIFD_VERSION);
         p->name =3D g_strdup_printf("multifdsend_%d", i);
-        socket_send_channel_create(multifd_new_send_channel_async, p);
+        if (!migrate_use_rdma()) {
+            socket_send_channel_create(multifd_new_send_channel_async, p=
);
+        } else {
+            rdma_send_channel_create(p);
+        }
     }
     return 0;
 }
@@ -720,7 +738,7 @@ void multifd_recv_sync_main(void)
 {
     int i;
=20
-    if (!migrate_use_multifd()) {
+    if (!migrate_use_multifd() || migrate_use_rdma()) {
         return;
     }
     for (i =3D 0; i < migrate_multifd_channels(); i++) {
@@ -890,8 +908,13 @@ bool multifd_recv_new_channel(QIOChannel *ioc, Error=
 **errp)
     p->num_packets =3D 1;
=20
     p->running =3D true;
-    qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
-                       QEMU_THREAD_JOINABLE);
+    if (!migrate_use_rdma()) {
+        qemu_thread_create(&p->thread, p->name, multifd_recv_thread, p,
+                           QEMU_THREAD_JOINABLE);
+    } else {
+        qemu_thread_create(&p->thread, p->name, multifd_rdma_recv_thread=
, p,
+                           QEMU_THREAD_JOINABLE);
+    }
     atomic_inc(&multifd_recv_state->count);
     return atomic_read(&multifd_recv_state->count) =3D=3D
            migrate_multifd_channels();
diff --git a/migration/multifd.h b/migration/multifd.h
index d8b0205977..c9c11ad140 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -13,6 +13,8 @@
 #ifndef QEMU_MIGRATION_MULTIFD_H
 #define QEMU_MIGRATION_MULTIFD_H
=20
+#include "migration/rdma.h"
+
 int multifd_save_setup(Error **errp);
 void multifd_save_cleanup(void);
 int multifd_load_setup(Error **errp);
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 1c3a358a14..f0ed8f1381 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -248,6 +248,11 @@ void qemu_fflush(QEMUFile *f)
     f->iovcnt =3D 0;
 }
=20
+void *getQIOChannel(QEMUFile *f)
+{
+    return f->opaque;
+}
+
 void ram_control_before_iterate(QEMUFile *f, uint64_t flags)
 {
     int ret =3D 0;
diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index a9b6d6ccb7..fc656a3b72 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -161,6 +161,7 @@ int qemu_file_shutdown(QEMUFile *f);
 QEMUFile *qemu_file_get_return_path(QEMUFile *f);
 void qemu_fflush(QEMUFile *f);
 void qemu_file_set_blocking(QEMUFile *f, bool block);
+void *getQIOChannel(QEMUFile *f);
=20
 void ram_control_before_iterate(QEMUFile *f, uint64_t flags);
 void ram_control_after_iterate(QEMUFile *f, uint64_t flags);
diff --git a/migration/rdma.c b/migration/rdma.c
index 2379b8345b..f086ab5a82 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -34,6 +34,7 @@
 #include <arpa/inet.h>
 #include <rdma/rdma_cma.h>
 #include "trace.h"
+#include "multifd.h"
=20
 /*
  * Print and error on both the Monitor and the Log file.
@@ -3975,6 +3976,34 @@ static QEMUFile *qemu_fopen_rdma(RDMAContext *rdma=
, const char *mode)
     return rioc->file;
 }
=20
+static void migration_rdma_process_incoming(QEMUFile *f, Error **errp)
+{
+    MigrationIncomingState *mis =3D migration_incoming_get_current();
+    Error *local_err =3D NULL;
+    QIOChannel *ioc =3D NULL;
+    bool start_migration;
+
+    if (!mis->from_src_file) {
+        mis->from_src_file =3D f;
+        qemu_file_set_blocking(f, false);
+
+        start_migration =3D migrate_use_multifd();
+    } else {
+        ioc =3D QIO_CHANNEL(getQIOChannel(f));
+        /* Multiple connections */
+        assert(migrate_use_multifd());
+        start_migration =3D multifd_recv_new_channel(ioc, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
+        }
+    }
+
+    if (start_migration) {
+        migration_incoming_process();
+    }
+}
+
 static void rdma_accept_incoming_migration(void *opaque)
 {
     RDMAContext *rdma =3D opaque;
@@ -4003,8 +4032,12 @@ static void rdma_accept_incoming_migration(void *o=
paque)
         return;
     }
=20
-    rdma->migration_started_on_destination =3D 1;
-    migration_fd_process_incoming(f, errp);
+    if (migrate_use_multifd()) {
+        migration_rdma_process_incoming(f, errp);
+    } else {
+        rdma->migration_started_on_destination =3D 1;
+        migration_fd_process_incoming(f, errp);
+    }
 }
=20
 void rdma_start_incoming_migration(const char *host_port, Error **errp)
@@ -4048,6 +4081,15 @@ void rdma_start_incoming_migration(const char *hos=
t_port, Error **errp)
         qemu_rdma_return_path_dest_init(rdma_return_path, rdma);
     }
=20
+    if (multifd_load_setup(&local_err) !=3D 0) {
+        /*
+         * We haven't been able to create multifd threads
+         * nothing better to do
+         */
+        error_report_err(local_err);
+        goto err;
+    }
+
     qemu_set_fd_handler(rdma->channel->fd, rdma_accept_incoming_migratio=
n,
                         NULL, (void *)(intptr_t)rdma);
     return;
@@ -4118,3 +4160,45 @@ err:
     g_free(rdma);
     g_free(rdma_return_path);
 }
+
+void *multifd_rdma_recv_thread(void *opaque)
+{
+    MultiFDRecvParams *p =3D opaque;
+
+    while (true) {
+        qemu_mutex_lock(&p->mutex);
+        if (p->quit) {
+            qemu_mutex_unlock(&p->mutex);
+            break;
+        }
+        qemu_mutex_unlock(&p->mutex);
+        qemu_sem_wait(&p->sem_sync);
+    }
+
+    qemu_mutex_lock(&p->mutex);
+    p->running =3D false;
+    qemu_mutex_unlock(&p->mutex);
+
+    return NULL;
+}
+
+void *multifd_rdma_send_thread(void *opaque)
+{
+    MultiFDSendParams *p =3D opaque;
+
+    while (true) {
+        qemu_mutex_lock(&p->mutex);
+        if (p->quit) {
+            qemu_mutex_unlock(&p->mutex);
+            break;
+        }
+        qemu_mutex_unlock(&p->mutex);
+        qemu_sem_wait(&p->sem);
+    }
+
+    qemu_mutex_lock(&p->mutex);
+    p->running =3D false;
+    qemu_mutex_unlock(&p->mutex);
+
+    return NULL;
+}
diff --git a/migration/rdma.h b/migration/rdma.h
index de2ba09dc5..3a00573083 100644
--- a/migration/rdma.h
+++ b/migration/rdma.h
@@ -17,6 +17,9 @@
 #ifndef QEMU_MIGRATION_RDMA_H
 #define QEMU_MIGRATION_RDMA_H
=20
+void *multifd_rdma_recv_thread(void *opaque);
+void *multifd_rdma_send_thread(void *opaque);
+
 void rdma_start_outgoing_migration(void *opaque, const char *host_port,
                                    Error **errp);
=20
--=20
2.19.1



