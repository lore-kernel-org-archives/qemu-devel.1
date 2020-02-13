Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B046BC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 09:49:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64BC220848
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 09:49:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64BC220848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2B7U-0005N2-KD
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 04:49:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45989)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fengzhimin1@huawei.com>) id 1j2Ax2-0006iv-VY
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:38:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fengzhimin1@huawei.com>) id 1j2Ax0-00053p-Qh
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:38:28 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2776 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fengzhimin1@huawei.com>)
 id 1j2Ax0-000514-8J
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:38:26 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id C444E3313507A1336E19;
 Thu, 13 Feb 2020 17:38:20 +0800 (CST)
Received: from huawei.com (10.173.220.198) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Thu, 13 Feb 2020
 17:38:10 +0800
From: Zhimin Feng <fengzhimin1@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>, <armbru@redhat.com>,
 <eblake@redhat.com>
Subject: [PATCH RFC 05/14] migration/rdma: Create the multifd channels for RDMA
Date: Thu, 13 Feb 2020 17:37:46 +0800
Message-ID: <20200213093755.370-6-fengzhimin1@huawei.com>
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

In both sides. We still don't transmit anything through them,
and we only build the RDMA connections.

Signed-off-by: Zhimin Feng <fengzhimin1@huawei.com>
---
 migration/multifd.c | 103 ++++++++++++++++++++++++++++++++++++---
 migration/multifd.h |  10 ++++
 migration/rdma.c    | 115 ++++++++++++++++++++++++++++++++------------
 migration/rdma.h    |   4 +-
 4 files changed, 189 insertions(+), 43 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 63678d7fdd..acdfd3d5b3 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -248,6 +248,19 @@ struct {
     int exiting;
 } *multifd_send_state;
=20
+int get_multifd_send_param(int id, MultiFDSendParams **param)
+{
+    int ret =3D 0;
+
+    if (id < 0 || id >=3D migrate_multifd_channels()) {
+        ret =3D -1;
+    } else {
+        *param =3D &(multifd_send_state->params[id]);
+    }
+
+    return ret;
+}
+
 /*
  * How we use multifd_send_state->pages and channel->pages?
  *
@@ -410,6 +423,9 @@ void multifd_save_cleanup(void)
         p->packet_len =3D 0;
         g_free(p->packet);
         p->packet =3D NULL;
+        if (migrate_use_rdma()) {
+            g_free(p->rdma);
+        }
     }
     qemu_sem_destroy(&multifd_send_state->channels_ready);
     g_free(multifd_send_state->params);
@@ -464,6 +480,27 @@ void multifd_send_sync_main(QEMUFile *f)
     trace_multifd_send_sync_main(multifd_send_state->packet_num);
 }
=20
+static void *multifd_rdma_send_thread(void *opaque)
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
+
 static void *multifd_send_thread(void *opaque)
 {
     MultiFDSendParams *p =3D opaque;
@@ -566,6 +603,12 @@ static void rdma_send_channel_create(MultiFDSendPara=
ms *p)
 {
     Error *local_err =3D NULL;
=20
+    if (multifd_channel_rdma_connect(p)) {
+        error_setg(&local_err, "multifd: rdma channel %d not established=
",
+                   p->id);
+        return ;
+    }
+
     if (p->quit) {
         error_setg(&local_err, "multifd: send id %d already quit", p->id=
);
         return ;
@@ -654,6 +697,19 @@ struct {
     uint64_t packet_num;
 } *multifd_recv_state;
=20
+int get_multifd_recv_param(int id, MultiFDRecvParams **param)
+{
+    int ret =3D 0;
+
+    if (id < 0 || id >=3D migrate_multifd_channels()) {
+        ret =3D -1;
+    } else {
+        *param =3D &(multifd_recv_state->params[id]);
+    }
+
+    return ret;
+}
+
 static void multifd_recv_terminate_threads(Error *err)
 {
     int i;
@@ -724,6 +780,9 @@ int multifd_load_cleanup(Error **errp)
         p->packet_len =3D 0;
         g_free(p->packet);
         p->packet =3D NULL;
+        if (migrate_use_rdma()) {
+            g_free(p->rdma);
+        }
     }
     qemu_sem_destroy(&multifd_recv_state->sem_sync);
     g_free(multifd_recv_state->params);
@@ -761,6 +820,27 @@ void multifd_recv_sync_main(void)
     trace_multifd_recv_sync_main(multifd_recv_state->packet_num);
 }
=20
+static void *multifd_rdma_recv_thread(void *opaque)
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
 static void *multifd_recv_thread(void *opaque)
 {
     MultiFDRecvParams *p =3D opaque;
@@ -880,18 +960,24 @@ bool multifd_recv_all_channels_created(void)
 bool multifd_recv_new_channel(QIOChannel *ioc, Error **errp)
 {
     MultiFDRecvParams *p;
+    QIOChannelRDMA *rioc =3D QIO_CHANNEL_RDMA(ioc);
     Error *local_err =3D NULL;
     int id;
=20
-    id =3D multifd_recv_initial_packet(ioc, &local_err);
-    if (id < 0) {
-        multifd_recv_terminate_threads(local_err);
-        error_propagate_prepend(errp, local_err,
-                                "failed to receive packet"
-                                " via multifd channel %d: ",
-                                atomic_read(&multifd_recv_state->count))=
;
-        return false;
+    if (migrate_use_rdma()) {
+        id =3D multifd_recv_state->count;
+    } else {
+        id =3D multifd_recv_initial_packet(ioc, &local_err);
+        if (id < 0) {
+            multifd_recv_terminate_threads(local_err);
+            error_propagate_prepend(errp, local_err,
+                    "failed to receive packet"
+                    " via multifd channel %d: ",
+                    atomic_read(&multifd_recv_state->count));
+            return false;
+        }
     }
+
     trace_multifd_recv_new_channel(id);
=20
     p =3D &multifd_recv_state->params[id];
@@ -903,6 +989,7 @@ bool multifd_recv_new_channel(QIOChannel *ioc, Error =
**errp)
         return false;
     }
     p->c =3D ioc;
+    p->file =3D rioc->file;
     object_ref(OBJECT(ioc));
     /* initial packet */
     p->num_packets =3D 1;
diff --git a/migration/multifd.h b/migration/multifd.h
index c9c11ad140..1eae427f8c 100644
--- a/migration/multifd.h
+++ b/migration/multifd.h
@@ -67,6 +67,10 @@ typedef struct {
     char *name;
     /* channel thread id */
     QemuThread thread;
+    /* RDMAContext channel */
+    RDMAContext *rdma;
+    /* communication channel */
+    QEMUFile *file;
     /* communication channel */
     QIOChannel *c;
     /* sem where to wait for more work */
@@ -108,6 +112,10 @@ typedef struct {
     char *name;
     /* channel thread id */
     QemuThread thread;
+    /* RDMAContext channel */
+    RDMAContext *rdma;
+    /* communication channel */
+    QEMUFile *file;
     /* communication channel */
     QIOChannel *c;
     /* this mutex protects the following parameters */
@@ -137,5 +145,7 @@ typedef struct {
     QemuSemaphore sem_sync;
 } MultiFDRecvParams;
=20
+int get_multifd_send_param(int id, MultiFDSendParams **param);
+int get_multifd_recv_param(int id, MultiFDRecvParams **param);
 #endif
=20
diff --git a/migration/rdma.c b/migration/rdma.c
index a76823986e..48615fcaad 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -94,6 +94,8 @@ static const char *wrid_desc[] =3D {
     [RDMA_WRID_RECV_CONTROL] =3D "CONTROL RECV",
 };
=20
+static const char *rdma_host_port;
+
 /*
  * Negotiate RDMA capabilities during connection-setup time.
  */
@@ -3122,6 +3124,33 @@ static int qemu_rdma_accept(RDMAContext *rdma)
         qemu_set_fd_handler(rdma->channel->fd, rdma_accept_incoming_migr=
ation,
                             NULL,
                             (void *)(intptr_t)rdma->return_path);
+    } else if (migrate_use_multifd()) {
+        int thread_count;
+        int i;
+        MultiFDRecvParams *multifd_recv_param;
+        RDMAContext *multifd_rdma =3D NULL;
+        thread_count =3D migrate_multifd_channels();
+        /* create the multifd channels for RDMA */
+        for (i =3D 0; i < thread_count; i++) {
+            if (get_multifd_recv_param(i, &multifd_recv_param) < 0) {
+                error_report("rdma: error getting multifd_recv_param(%d)=
", i);
+                goto err_rdma_dest_wait;
+            }
+
+            if (multifd_recv_param->rdma->cm_id =3D=3D NULL) {
+                multifd_rdma =3D multifd_recv_param->rdma;
+                break;
+            }
+        }
+
+        if (multifd_rdma) {
+            qemu_set_fd_handler(rdma->channel->fd,
+                                rdma_accept_incoming_migration,
+                                NULL, (void *)(intptr_t)multifd_rdma);
+        } else {
+            qemu_set_fd_handler(rdma->channel->fd, rdma_cm_poll_handler,
+                                NULL, rdma);
+        }
     } else {
         qemu_set_fd_handler(rdma->channel->fd, rdma_cm_poll_handler,
                             NULL, rdma);
@@ -3744,7 +3773,7 @@ static void migration_rdma_process_incoming(QEMUFil=
e *f, Error **errp)
         mis->from_src_file =3D f;
         qemu_file_set_blocking(f, false);
=20
-        start_migration =3D migrate_use_multifd();
+        start_migration =3D !migrate_use_multifd();
     } else {
         ioc =3D QIO_CHANNEL(getQIOChannel(f));
         /* Multiple connections */
@@ -3847,6 +3876,30 @@ void rdma_start_incoming_migration(const char *hos=
t_port, Error **errp)
         goto err;
     }
=20
+    if (migrate_use_multifd()) {
+        int thread_count;
+        int i;
+        int idx;
+        MultiFDRecvParams *multifd_recv_param;
+        thread_count =3D migrate_multifd_channels();
+        for (i =3D 0; i < thread_count; i++) {
+            if (get_multifd_recv_param(i, &multifd_recv_param) < 0) {
+                error_report("rdma: error getting multifd_recv_param(%d)=
", i);
+                goto err;
+            }
+
+            multifd_recv_param->rdma =3D qemu_rdma_data_init(host_port,
+                                                           &local_err);
+            for (idx =3D 0; idx < RDMA_WRID_MAX; idx++) {
+                multifd_recv_param->rdma->wr_data[idx].control_len =3D 0=
;
+                multifd_recv_param->rdma->wr_data[idx].control_curr =3D =
NULL;
+            }
+            /* the CM channel and CM id is shared */
+            multifd_recv_param->rdma->channel =3D rdma->channel;
+            multifd_recv_param->rdma->listen_id =3D rdma->listen_id;
+        }
+    }
+
     qemu_set_fd_handler(rdma->channel->fd, rdma_accept_incoming_migratio=
n,
                         NULL, (void *)(intptr_t)rdma);
     return;
@@ -3868,6 +3921,10 @@ void rdma_start_outgoing_migration(void *opaque,
         goto err;
     }
=20
+    if (migrate_use_multifd()) {
+        rdma_host_port =3D g_strdup(host_port);
+    }
+
     ret =3D qemu_rdma_source_init(rdma,
         s->enabled_capabilities[MIGRATION_CAPABILITY_RDMA_PIN_ALL], errp=
);
=20
@@ -3918,44 +3975,38 @@ err:
     g_free(rdma_return_path);
 }
=20
-void *multifd_rdma_recv_thread(void *opaque)
+int multifd_channel_rdma_connect(void *opaque)
 {
-    MultiFDRecvParams *p =3D opaque;
+    MultiFDSendParams *p =3D opaque;
+    Error *local_err =3D NULL;
+    int ret =3D 0;
=20
-    while (true) {
-        qemu_mutex_lock(&p->mutex);
-        if (p->quit) {
-            qemu_mutex_unlock(&p->mutex);
-            break;
-        }
-        qemu_mutex_unlock(&p->mutex);
-        qemu_sem_wait(&p->sem_sync);
+    p->rdma =3D qemu_rdma_data_init(rdma_host_port, &local_err);
+    if (p->rdma =3D=3D NULL) {
+        goto out;
     }
=20
-    qemu_mutex_lock(&p->mutex);
-    p->running =3D false;
-    qemu_mutex_unlock(&p->mutex);
-
-    return NULL;
-}
+    ret =3D qemu_rdma_source_init(p->rdma,
+                                migrate_use_rdma_pin_all(),
+                                &local_err);
+    if (ret) {
+        goto out;
+    }
=20
-void *multifd_rdma_send_thread(void *opaque)
-{
-    MultiFDSendParams *p =3D opaque;
+    ret =3D qemu_rdma_connect(p->rdma, &local_err);
+    if (ret) {
+        goto out;
+    }
=20
-    while (true) {
-        qemu_mutex_lock(&p->mutex);
-        if (p->quit) {
-            qemu_mutex_unlock(&p->mutex);
-            break;
-        }
-        qemu_mutex_unlock(&p->mutex);
-        qemu_sem_wait(&p->sem);
+    p->file =3D qemu_fopen_rdma(p->rdma, "wb");
+    if (p->file =3D=3D NULL) {
+        goto out;
     }
=20
-    qemu_mutex_lock(&p->mutex);
-    p->running =3D false;
-    qemu_mutex_unlock(&p->mutex);
+out:
+    if (local_err) {
+        trace_multifd_send_error(p->id);
+    }
=20
-    return NULL;
+    return ret;
 }
diff --git a/migration/rdma.h b/migration/rdma.h
index cb206c7004..ace6e5be90 100644
--- a/migration/rdma.h
+++ b/migration/rdma.h
@@ -263,9 +263,7 @@ struct QIOChannelRDMA {
     bool blocking; /* XXX we don't actually honour this yet */
 };
=20
-
-void *multifd_rdma_recv_thread(void *opaque);
-void *multifd_rdma_send_thread(void *opaque);
+int multifd_channel_rdma_connect(void *opaque);
=20
 void rdma_start_outgoing_migration(void *opaque, const char *host_port,
                                    Error **errp);
--=20
2.19.1



