Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BFD5C33CA1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 10:04:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6D1C2072A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 10:04:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6D1C2072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipUgN-0003u7-Ra
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 05:04:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42491)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fengzhimin1@huawei.com>) id 1ipPvE-00010T-F8
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 23:59:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fengzhimin1@huawei.com>) id 1ipPvB-0001Mg-Sz
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 23:59:52 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:34922 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fengzhimin1@huawei.com>)
 id 1ipPvB-0001Gr-Dk
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 23:59:49 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id E5A532BA8A28ED572297;
 Thu,  9 Jan 2020 12:59:45 +0800 (CST)
Received: from huawei.com (10.173.220.198) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Thu, 9 Jan 2020
 12:59:37 +0800
From: Zhimin Feng <fengzhimin1@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>, <armbru@redhat.com>,
 <eblake@redhat.com>
Subject: [PATCH RFC 10/12] migration/rdma: use multiRDMA to send RAM block for
 rdma-pin-all mode
Date: Thu, 9 Jan 2020 12:59:20 +0800
Message-ID: <20200109045922.904-11-fengzhimin1@huawei.com>
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
X-Received-From: 45.249.212.32
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

Send the RAM block through MultiRDMA channels for using rdma-pin-all opti=
on,
and we choose the channel to send data through polling the MultiRDMA thre=
ad.

Signed-off-by: fengzhimin <fengzhimin1@huawei.com>
---
 migration/rdma.c | 66 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 63 insertions(+), 3 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 425dfa709d..36261f1fc8 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -427,6 +427,8 @@ typedef struct {
     QEMUFile *file;
     /* sem where to wait for more work */
     QemuSemaphore sem;
+    /* syncs main thread and channels */
+    QemuSemaphore sem_sync;
     /* this mutex protects the following parameters */
     QemuMutex mutex;
     /* is this channel thread running */
@@ -439,6 +441,8 @@ struct {
     MultiRDMASendParams *params;
     /* number of created threads */
     int count;
+    /* index of current RDMA channels */
+    int current_RDMA_index;
     /* this mutex protects the following parameters */
     QemuMutex mutex_sync;
     /* number of registered multiRDMA channels */
@@ -2043,6 +2047,18 @@ static int qemu_rdma_exchange_recv(RDMAContext *rd=
ma, RDMAControlHeader *head,
     return 0;
 }
=20
+/*
+ * Get the multiRDMA channel used to send data.
+ */
+static int get_multiRDMA_channel(void)
+{
+    int thread_count =3D migrate_multiRDMA_channels();
+    multiRDMA_send_state->current_RDMA_index++;
+    multiRDMA_send_state->current_RDMA_index %=3D thread_count;
+
+    return multiRDMA_send_state->current_RDMA_index;
+}
+
 /*
  * Write an actual chunk of memory using RDMA.
  *
@@ -2068,6 +2084,16 @@ static int qemu_rdma_write_one(QEMUFile *f, RDMACo=
ntext *rdma,
                                .repeat =3D 1,
                              };
=20
+    if (migrate_use_multiRDMA() &&
+        migrate_use_rdma_pin_all()) {
+        /* The multiRDMA threads only send ram block */
+        if (strcmp(block->block_name, "mach-virt.ram") =3D=3D 0) {
+            int channel =3D get_multiRDMA_channel();
+            rdma =3D multiRDMA_send_state->params[channel].rdma;
+            block =3D &(rdma->local_ram_blocks.block[current_index]);
+        }
+    }
+
 retry:
     sge.addr =3D (uintptr_t)(block->local_host_addr +
                             (current_addr - block->offset));
@@ -2285,8 +2311,22 @@ static int qemu_rdma_write_flush(QEMUFile *f, RDMA=
Context *rdma)
     }
=20
     if (ret =3D=3D 0) {
-        rdma->nb_sent++;
-        trace_qemu_rdma_write_flush(rdma->nb_sent);
+        if (migrate_use_multiRDMA() &&
+            migrate_use_rdma_pin_all()) {
+            /* The multiRDMA threads only send ram block */
+            RDMALocalBlock *block =3D NULL;
+            block =3D &(rdma->local_ram_blocks.block[rdma->current_index=
]);
+            if (strcmp(block->block_name, "mach-virt.ram") =3D=3D 0) {
+                int current_RDMA =3D multiRDMA_send_state->current_RDMA_=
index;
+                multiRDMA_send_state->params[current_RDMA].rdma->nb_sent=
++;
+            } else {
+                rdma->nb_sent++;
+                trace_qemu_rdma_write_flush(rdma->nb_sent);
+            }
+        } else {
+            rdma->nb_sent++;
+            trace_qemu_rdma_write_flush(rdma->nb_sent);
+        }
     }
=20
     rdma->current_length =3D 0;
@@ -4015,11 +4055,15 @@ static int qemu_rdma_registration_stop(QEMUFile *=
f, void *opaque,
     ret =3D qemu_rdma_exchange_send(rdma, &head, NULL, NULL, NULL, NULL)=
;
=20
     if (migrate_use_multiRDMA()) {
-        /* Inform src send_thread to send FINISHED signal */
+        /*
+         * Inform src send_thread to send FINISHED signal.
+         * Wait for multiRDMA send threads to poll the CQE.
+         */
         int i;
         int thread_count =3D migrate_multiRDMA_channels();
         for (i =3D 0; i < thread_count; i++) {
             qemu_sem_post(&multiRDMA_send_state->params[i].sem);
+            qemu_sem_wait(&multiRDMA_send_state->params[i].sem_sync);
         }
     }
=20
@@ -4592,12 +4636,25 @@ static void *multiRDMA_send_thread(void *opaque)
         }
         qemu_mutex_unlock(&p->mutex);
=20
+        /* To complete polling(CQE) */
+        while (rdma->nb_sent) {
+            ret =3D qemu_rdma_block_for_wrid(rdma, RDMA_WRID_RDMA_WRITE,=
 NULL);
+            if (ret < 0) {
+                error_report("multiRDMA migration: "
+                             "complete polling error!");
+                return NULL;
+            }
+        }
+
         /* Send FINISHED to the destination */
         head.type =3D RDMA_CONTROL_REGISTER_FINISHED;
         ret =3D qemu_rdma_exchange_send(rdma, &head, NULL, NULL, NULL, N=
ULL);
         if (ret < 0) {
             return NULL;
         }
+
+        /* sync main thread */
+        qemu_sem_post(&p->sem_sync);
     }
=20
     qemu_mutex_lock(&p->mutex);
@@ -4637,6 +4694,7 @@ static int multiRDMA_save_setup(const char *host_po=
rt, Error **errp)
                                           thread_count);
     atomic_set(&multiRDMA_send_state->count, 0);
     atomic_set(&multiRDMA_send_state->reg_mr_channels, 0);
+    atomic_set(&multiRDMA_send_state->current_RDMA_index, 0);
     qemu_mutex_init(&multiRDMA_send_state->mutex_sync);
     qemu_sem_init(&multiRDMA_send_state->sem_sync, 0);
=20
@@ -4665,6 +4723,7 @@ static int multiRDMA_save_setup(const char *host_po=
rt, Error **errp)
         f =3D qemu_fopen_rdma(multiRDMA_send_state->params[i].rdma, "wb"=
);
         qemu_mutex_init(&p->mutex);
         qemu_sem_init(&p->sem, 0);
+        qemu_sem_init(&p->sem_sync, 0);
         p->quit =3D false;
         p->id =3D i;
         p->running =3D true;
@@ -4730,6 +4789,7 @@ int multiRDMA_save_cleanup(void)
         MultiRDMASendParams *p =3D &multiRDMA_send_state->params[i];
         qemu_mutex_destroy(&p->mutex);
         qemu_sem_destroy(&p->sem);
+        qemu_sem_destroy(&p->sem_sync);
         g_free(p->name);
         p->name =3D NULL;
         qemu_rdma_cleanup(multiRDMA_send_state->params[i].rdma);
--=20
2.19.1



