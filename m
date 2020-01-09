Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07000C33CA2
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 10:04:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C286620673
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 10:04:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C286620673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipUgN-0003ut-La
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 05:04:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42224)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fengzhimin1@huawei.com>) id 1ipPvC-00010A-UV
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 23:59:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fengzhimin1@huawei.com>) id 1ipPvA-0001Ja-BT
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 23:59:50 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2290 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fengzhimin1@huawei.com>)
 id 1ipPv9-000171-Hi
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 23:59:48 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id C8A22C74532043537580;
 Thu,  9 Jan 2020 12:59:40 +0800 (CST)
Received: from huawei.com (10.173.220.198) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Thu, 9 Jan 2020
 12:59:33 +0800
From: Zhimin Feng <fengzhimin1@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>, <armbru@redhat.com>,
 <eblake@redhat.com>
Subject: [PATCH RFC 04/12] migration/rdma: Create multiRDMA migration threads
Date: Thu, 9 Jan 2020 12:59:14 +0800
Message-ID: <20200109045922.904-5-fengzhimin1@huawei.com>
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

Creation of the RDMA threads, nothing inside yet.

Signed-off-by: fengzhimin <fengzhimin1@huawei.com>
---
 migration/migration.c |   1 +
 migration/migration.h |   2 +
 migration/rdma.c      | 283 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 286 insertions(+)

diff --git a/migration/migration.c b/migration/migration.c
index 5756a4806e..f8d4eb657e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1546,6 +1546,7 @@ static void migrate_fd_cleanup(MigrationState *s)
         qemu_mutex_lock_iothread();
=20
         multifd_save_cleanup();
+        multiRDMA_save_cleanup();
         qemu_mutex_lock(&s->qemu_file_lock);
         tmp =3D s->to_dst_file;
         s->to_dst_file =3D NULL;
diff --git a/migration/migration.h b/migration/migration.h
index 4192c22d8c..d69a3fe4e9 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -272,6 +272,8 @@ void migration_incoming_process(void);
=20
 bool  migration_has_all_channels(void);
 int migrate_multiRDMA_channels(void);
+int multiRDMA_save_cleanup(void);
+int multiRDMA_load_cleanup(void);
=20
 uint64_t migrate_max_downtime(void);
=20
diff --git a/migration/rdma.c b/migration/rdma.c
index e241dcb992..992e5abfed 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -395,6 +395,58 @@ typedef struct RDMAContext {
     bool is_return_path;
 } RDMAContext;
=20
+typedef struct {
+    /* this fields are not changed once the thread is created */
+    /* channel number */
+    uint8_t id;
+    /* channel thread name */
+    char *name;
+    /* channel thread id */
+    QemuThread thread;
+    /* sem where to wait for more work */
+    QemuSemaphore sem;
+    /* this mutex protects the following parameters */
+    QemuMutex mutex;
+    /* is this channel thread running */
+    bool running;
+    /* should this thread finish */
+    bool quit;
+}  MultiRDMASendParams;
+
+struct {
+    MultiRDMASendParams *params;
+    /* number of created threads */
+    int count;
+    /* syncs main thread and channels */
+    QemuSemaphore sem_sync;
+} *multiRDMA_send_state;
+
+typedef struct {
+    /* this fields are not changed once the thread is created */
+    /* channel number */
+    uint8_t id;
+    /* channel thread name */
+    char *name;
+    /* channel thread id */
+    QemuThread thread;
+    /* sem where to wait for more work */
+    QemuSemaphore sem;
+    /* this mutex protects the following parameters */
+    QemuMutex mutex;
+    /* is this channel thread running */
+    bool running;
+    /* should this thread finish */
+    bool quit;
+} MultiRDMARecvParams;
+
+struct {
+    MultiRDMARecvParams *params;
+    /* number of created threads */
+    int count;
+    /* syncs main thread and channels */
+    QemuSemaphore sem_sync;
+} *multiRDMA_recv_state;
+
 #define TYPE_QIO_CHANNEL_RDMA "qio-channel-rdma"
 #define QIO_CHANNEL_RDMA(obj)                                     \
     OBJECT_CHECK(QIOChannelRDMA, (obj), TYPE_QIO_CHANNEL_RDMA)
@@ -3018,6 +3070,7 @@ static void qio_channel_rdma_close_rcu(struct rdma_=
close_rcu *rcu)
     if (rcu->rdmaout) {
         qemu_rdma_cleanup(rcu->rdmaout);
     }
+    multiRDMA_load_cleanup();
=20
     g_free(rcu->rdmain);
     g_free(rcu->rdmaout);
@@ -3919,6 +3972,7 @@ static void qio_channel_rdma_finalize(Object *obj)
         g_free(rioc->rdmaout);
         rioc->rdmaout =3D NULL;
     }
+    multiRDMA_load_cleanup();
 }
=20
 static void qio_channel_rdma_class_init(ObjectClass *klass,
@@ -4007,6 +4061,59 @@ static void rdma_accept_incoming_migration(void *o=
paque)
     migration_fd_process_incoming(f);
 }
=20
+static void *multiRDMA_recv_thread(void *opaque)
+{
+    MultiRDMARecvParams *p =3D opaque;
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
+
+static int multiRDMA_load_setup(const char *host_port, RDMAContext *rdma=
,
+                                      Error **errp)
+{
+    uint8_t i;
+    int thread_count;
+
+    thread_count =3D migrate_multiRDMA_channels();
+    if (multiRDMA_recv_state =3D=3D NULL) {
+        multiRDMA_recv_state =3D g_malloc0(sizeof(*multiRDMA_recv_state)=
);
+        multiRDMA_recv_state->params =3D g_new0(MultiRDMARecvParams,
+                                              thread_count);
+        atomic_set(&multiRDMA_recv_state->count, 0);
+        qemu_sem_init(&multiRDMA_recv_state->sem_sync, 0);
+
+        for (i =3D 0; i < thread_count; i++) {
+            MultiRDMARecvParams *p =3D &multiRDMA_recv_state->params[i];
+
+            qemu_mutex_init(&p->mutex);
+            qemu_sem_init(&p->sem, 0);
+            p->quit =3D false;
+            p->id =3D i;
+            p->running =3D true;
+            p->name =3D g_strdup_printf("multiRDMARecv_%d", i);
+            qemu_thread_create(&p->thread, p->name, multiRDMA_recv_threa=
d,
+                               p, QEMU_THREAD_JOINABLE);
+            atomic_inc(&multiRDMA_recv_state->count);
+        }
+    }
+
+    return 0;
+}
+
 void rdma_start_incoming_migration(const char *host_port, Error **errp)
 {
     int ret;
@@ -4048,6 +4155,13 @@ void rdma_start_incoming_migration(const char *hos=
t_port, Error **errp)
         qemu_rdma_return_path_dest_init(rdma_return_path, rdma);
     }
=20
+    if (migrate_use_multiRDMA()) {
+        if (multiRDMA_load_setup(host_port, rdma, &local_err) !=3D 0) {
+            ERROR(errp, "init multiRDMA failure!");
+            goto err;
+        }
+    }
+
     qemu_set_fd_handler(rdma->channel->fd, rdma_accept_incoming_migratio=
n,
                         NULL, (void *)(intptr_t)rdma);
     return;
@@ -4055,6 +4169,167 @@ err:
     error_propagate(errp, local_err);
     g_free(rdma);
     g_free(rdma_return_path);
+    multiRDMA_load_cleanup();
+}
+
+static void *multiRDMA_send_thread(void *opaque)
+{
+    MultiRDMASendParams *p =3D opaque;
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
+
+static int multiRDMA_save_setup(const char *host_port, Error **errp)
+{
+    int thread_count;
+    uint8_t i;
+
+    thread_count =3D migrate_multiRDMA_channels();
+    multiRDMA_send_state =3D g_malloc0(sizeof(*multiRDMA_send_state));
+    multiRDMA_send_state->params =3D g_new0(MultiRDMASendParams,
+                                          thread_count);
+    atomic_set(&multiRDMA_send_state->count, 0);
+    qemu_sem_init(&multiRDMA_send_state->sem_sync, 0);
+
+    for (i =3D 0; i < thread_count; i++) {
+        MultiRDMASendParams *p =3D &multiRDMA_send_state->params[i];
+        qemu_mutex_init(&p->mutex);
+        qemu_sem_init(&p->sem, 0);
+        p->quit =3D false;
+        p->id =3D i;
+        p->running =3D true;
+        p->name =3D g_strdup_printf("multiRDMASend_%d", i);
+
+        qemu_thread_create(&p->thread, p->name, multiRDMA_send_thread, p=
,
+                           QEMU_THREAD_JOINABLE);
+        atomic_inc(&multiRDMA_send_state->count);
+    }
+
+    return 0;
+}
+
+static void multiRDMA_send_terminate_threads(void)
+{
+    int i;
+    int thread_count =3D migrate_multiRDMA_channels();
+
+    for (i =3D 0; i < thread_count; i++) {
+        MultiRDMASendParams *p =3D &multiRDMA_send_state->params[i];
+
+        qemu_mutex_lock(&p->mutex);
+        p->quit =3D true;
+        qemu_mutex_unlock(&p->mutex);
+        qemu_sem_post(&p->sem);
+    }
+}
+
+int multiRDMA_save_cleanup(void)
+{
+    int i;
+    int ret =3D 0;
+    int thread_count =3D migrate_multiRDMA_channels();
+
+    if (!migrate_use_multiRDMA()) {
+        return 0;
+    }
+
+    /* prevent double free */
+    if (multiRDMA_send_state =3D=3D NULL) {
+        return 0;
+    }
+
+    /* notify multi RDMA threads to exit */
+    multiRDMA_send_terminate_threads();
+
+    /* wait for multi RDMA send threads to be exit */
+    for (i =3D 0; i < thread_count; i++) {
+        MultiRDMASendParams *p =3D &multiRDMA_send_state->params[i];
+
+        qemu_thread_join(&p->thread);
+    }
+
+    for (i =3D 0; i < thread_count; i++) {
+        MultiRDMASendParams *p =3D &multiRDMA_send_state->params[i];
+        qemu_mutex_destroy(&p->mutex);
+        qemu_sem_destroy(&p->sem);
+        g_free(p->name);
+        p->name =3D NULL;
+    }
+
+    qemu_sem_destroy(&multiRDMA_send_state->sem_sync);
+    g_free(multiRDMA_send_state);
+    multiRDMA_send_state =3D NULL;
+
+    return ret;
+}
+
+static void multiRDMA_recv_terminate_threads(void)
+{
+    int i;
+    int thread_count =3D migrate_multiRDMA_channels();
+
+    for (i =3D 0; i < thread_count; i++) {
+        MultiRDMARecvParams *p =3D &multiRDMA_recv_state->params[i];
+
+        qemu_mutex_lock(&p->mutex);
+        p->quit =3D true;
+        qemu_mutex_unlock(&p->mutex);
+        qemu_sem_post(&p->sem);
+    }
+}
+
+int multiRDMA_load_cleanup(void)
+{
+    int i;
+    int ret =3D 0;
+    int thread_count =3D migrate_multiRDMA_channels();
+
+    if (!migrate_use_multiRDMA()) {
+        return 0;
+    }
+
+    /* prevent double free */
+    if (multiRDMA_recv_state =3D=3D NULL) {
+        return 0;
+    }
+
+    /* notify multi RDMA recv threads to exit */
+    multiRDMA_recv_terminate_threads();
+
+    /* wait for multi RDMA threads to be exit */
+    for (i =3D 0; i < thread_count; i++) {
+        MultiRDMARecvParams *p =3D &multiRDMA_recv_state->params[i];
+
+        qemu_thread_join(&p->thread);
+    }
+
+    for (i =3D 0; i < thread_count; i++) {
+        MultiRDMARecvParams *p =3D &multiRDMA_recv_state->params[i];
+        qemu_mutex_destroy(&p->mutex);
+        qemu_sem_destroy(&p->sem);
+        g_free(p->name);
+        p->name =3D NULL;
+    }
+
+    qemu_sem_destroy(&multiRDMA_recv_state->sem_sync);
+    g_free(multiRDMA_recv_state);
+    multiRDMA_recv_state =3D NULL;
+
+    return ret;
 }
=20
 void rdma_start_outgoing_migration(void *opaque,
@@ -4111,10 +4386,18 @@ void rdma_start_outgoing_migration(void *opaque,
=20
     trace_rdma_start_outgoing_migration_after_rdma_connect();
=20
+    if (migrate_use_multiRDMA()) {
+        if (multiRDMA_save_setup(host_port, errp) !=3D 0) {
+            ERROR(errp, "init multiRDMA channels failure!");
+            goto err;
+        }
+    }
+
     s->to_dst_file =3D qemu_fopen_rdma(rdma, "wb");
     migrate_fd_connect(s, NULL);
     return;
 err:
     g_free(rdma);
     g_free(rdma_return_path);
+    multiRDMA_save_cleanup();
 }
--=20
2.19.1



