Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B00C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 10:02:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB43F20673
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 10:02:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB43F20673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipUde-00084B-S4
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 05:02:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42713)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fengzhimin1@huawei.com>) id 1ipPvF-00010n-Nm
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 23:59:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fengzhimin1@huawei.com>) id 1ipPvC-0001Ou-LG
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 23:59:53 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2293 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fengzhimin1@huawei.com>)
 id 1ipPvC-0001K3-1i
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 23:59:50 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id DDE967ABED5B9696DBA0;
 Thu,  9 Jan 2020 12:59:40 +0800 (CST)
Received: from huawei.com (10.173.220.198) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Thu, 9 Jan 2020
 12:59:34 +0800
From: Zhimin Feng <fengzhimin1@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>, <armbru@redhat.com>,
 <eblake@redhat.com>
Subject: [PATCH RFC 06/12] migration/rdma: Transmit initial package
Date: Thu, 9 Jan 2020 12:59:16 +0800
Message-ID: <20200109045922.904-7-fengzhimin1@huawei.com>
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

Transmit initial package through the multiRDMA channels,
so that we can identify the main channel and multiRDMA channels.

Signed-off-by: fengzhimin <fengzhimin1@huawei.com>
---
 migration/rdma.c | 114 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 107 insertions(+), 7 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 5b780bef36..db75a4372a 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -116,6 +116,16 @@ static uint32_t known_capabilities =3D RDMA_CAPABILI=
TY_PIN_ALL;
=20
 #define RDMA_WRID_CHUNK_MASK (~RDMA_WRID_BLOCK_MASK & ~RDMA_WRID_TYPE_MA=
SK)
=20
+/* Define magic to distinguish multiRDMA and main RDMA */
+#define MULTIRDMA_MAGIC 0x11223344U
+#define MAINRDMA_MAGIC 0x55667788U
+#define ERROR_MAGIC 0xFFFFFFFFU
+
+#define MULTIRDMA_VERSION 1
+#define MAINRDMA_VERSION 1
+
+#define UNUSED_ID 0xFFU
+
 /*
  * RDMA migration protocol:
  * 1. RDMA Writes (data messages, i.e. RAM)
@@ -167,6 +177,14 @@ enum {
     RDMA_CONTROL_UNREGISTER_FINISHED, /* unpinning finished */
 };
=20
+/*
+ * Identify the MultiRDAM channel info
+ */
+typedef struct {
+    uint32_t magic;
+    uint32_t version;
+    uint8_t id;
+} __attribute__((packed)) RDMAChannelInit_t;
=20
 /*
  * Memory and MR structures used to represent an IB Send/Recv work reque=
st.
@@ -3430,7 +3448,7 @@ static int qemu_rdma_accept(RDMAContext *rdma)
         int i;
         RDMAContext *multi_rdma =3D NULL;
         thread_count =3D migrate_multiRDMA_channels();
-        /* create the multi Thread RDMA channels */
+        /* create the multiRDMA channels */
         for (i =3D 0; i < thread_count; i++) {
             if (multiRDMA_recv_state->params[i].rdma->cm_id =3D=3D NULL)=
 {
                 multi_rdma =3D multiRDMA_recv_state->params[i].rdma;
@@ -4058,6 +4076,48 @@ static QEMUFile *qemu_fopen_rdma(RDMAContext *rdma=
, const char *mode)
     return rioc->file;
 }
=20
+static RDMAChannelInit_t migration_rdma_recv_initial_packet(QEMUFile *f,
+                                                            Error **errp=
)
+{
+    RDMAChannelInit_t msg;
+    int thread_count =3D migrate_multiRDMA_channels();
+    qemu_get_buffer(f, (uint8_t *)&msg, sizeof(msg));
+    be32_to_cpus(&msg.magic);
+    be32_to_cpus(&msg.version);
+
+    if (msg.magic !=3D MULTIRDMA_MAGIC &&
+        msg.magic !=3D MAINRDMA_MAGIC) {
+        error_setg(errp, "multiRDMA: received unrecognized "
+                   "packet magic %x", msg.magic);
+        goto err;
+    }
+
+    if (msg.magic =3D=3D MULTIRDMA_MAGIC
+        && msg.version !=3D MULTIRDMA_VERSION) {
+        error_setg(errp, "multiRDMA: received packet version "
+                   "%d expected %d", msg.version, MULTIRDMA_VERSION);
+        goto err;
+    }
+
+    if (msg.magic =3D=3D MAINRDMA_MAGIC && msg.version !=3D MAINRDMA_VER=
SION) {
+        error_setg(errp, "multiRDMA: received packet version "
+                   "%d expected %d", msg.version, MAINRDMA_VERSION);
+        goto err;
+    }
+
+    if (msg.magic =3D=3D MULTIRDMA_MAGIC && msg.id > thread_count) {
+        error_setg(errp, "multiRDMA: received channel version %d "
+                   "expected %d", msg.version, MULTIRDMA_VERSION);
+        goto err;
+    }
+
+    return msg;
+err:
+    msg.magic =3D ERROR_MAGIC;
+    msg.id =3D UNUSED_ID;
+    return msg;
+}
+
 static void *multiRDMA_recv_thread(void *opaque)
 {
     MultiRDMARecvParams *p =3D opaque;
@@ -4100,13 +4160,34 @@ static void multiRDMA_recv_new_channel(QEMUFile *=
f, int id)
 static void migration_multiRDMA_process_incoming(QEMUFile *f, RDMAContex=
t *rdma)
 {
     MigrationIncomingState *mis =3D migration_incoming_get_current();
+    Error *local_err =3D NULL;
+    RDMAChannelInit_t msg =3D migration_rdma_recv_initial_packet(f, &loc=
al_err);
+
+    switch (msg.magic) {
+    case MAINRDMA_MAGIC:
+        if (!mis->from_src_file) {
+            rdma->migration_started_on_destination =3D 1;
+            migration_incoming_setup(f);
+            migration_incoming_process();
+        }
+        break;
=20
-    if (!mis->from_src_file) {
-        rdma->migration_started_on_destination =3D 1;
-        migration_incoming_setup(f);
-        migration_incoming_process();
-    } else {
-        multiRDMA_recv_new_channel(f, multiRDMA_recv_state->count);
+    case MULTIRDMA_MAGIC:
+        multiRDMA_recv_new_channel(f, msg.id);
+        break;
+
+    case ERROR_MAGIC:
+    default:
+        if (local_err) {
+            MigrationState *s =3D migrate_get_current();
+            migrate_set_error(s, local_err);
+            if (s->state =3D=3D MIGRATION_STATUS_SETUP ||
+                    s->state =3D=3D MIGRATION_STATUS_ACTIVE) {
+                migrate_set_state(&s->state, s->state,
+                        MIGRATION_STATUS_FAILED);
+            }
+        }
+        break;
     }
 }
=20
@@ -4245,10 +4326,26 @@ err:
     multiRDMA_load_cleanup();
 }
=20
+static void migration_rdma_send_initial_packet(QEMUFile *f, uint8_t id)
+{
+    RDMAChannelInit_t msg;
+
+    msg.magic =3D cpu_to_be32(id =3D=3D UNUSED_ID ?
+                            MAINRDMA_MAGIC : MULTIRDMA_MAGIC);
+    msg.version =3D cpu_to_be32(id =3D=3D UNUSED_ID ?
+                              MAINRDMA_VERSION : MULTIRDMA_VERSION);
+    msg.id =3D id;
+    qemu_put_buffer(f, (uint8_t *)&msg, sizeof(msg));
+    qemu_fflush(f);
+}
+
 static void *multiRDMA_send_thread(void *opaque)
 {
     MultiRDMASendParams *p =3D opaque;
=20
+    /* send the multiRDMA channels magic */
+    migration_rdma_send_initial_packet(p->file, p->id);
+
     while (true) {
         qemu_mutex_lock(&p->mutex);
         if (p->quit) {
@@ -4579,6 +4676,9 @@ void rdma_start_outgoing_migration(void *opaque,
     s->to_dst_file =3D qemu_fopen_rdma(rdma, "wb");
     /* create multiRDMA channel */
     if (migrate_use_multiRDMA()) {
+        /* send the main RDMA channel magic */
+        migration_rdma_send_initial_packet(s->to_dst_file, UNUSED_ID);
+
         if (multiRDMA_save_setup(host_port, errp) !=3D 0) {
             ERROR(errp, "init multiRDMA channels failure!");
             goto err;
--=20
2.19.1



