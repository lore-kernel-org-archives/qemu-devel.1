Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB2B6C33CA2
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 09:58:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ED2320673
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 09:58:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ED2320673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57624 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipUaP-0003vB-7y
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 04:58:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42619)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fengzhimin1@huawei.com>) id 1ipPvF-00010e-7H
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 23:59:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fengzhimin1@huawei.com>) id 1ipPvC-0001Nm-5F
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 23:59:53 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:34920 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fengzhimin1@huawei.com>)
 id 1ipPvB-0001Gq-B5
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 23:59:50 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id DA2E65FB4C5DD70D1BED;
 Thu,  9 Jan 2020 12:59:45 +0800 (CST)
Received: from huawei.com (10.173.220.198) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Thu, 9 Jan 2020
 12:59:35 +0800
From: Zhimin Feng <fengzhimin1@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>, <armbru@redhat.com>,
 <eblake@redhat.com>
Subject: [PATCH RFC 08/12] migration/rdma: register memory for multiRDMA
 channels
Date: Thu, 9 Jan 2020 12:59:18 +0800
Message-ID: <20200109045922.904-9-fengzhimin1@huawei.com>
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

register memory for multiRDMA channels and transmit the destination
the keys to source to use including the virtual addresses.

Signed-off-by: fengzhimin <fengzhimin1@huawei.com>
---
 migration/rdma.c | 192 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 190 insertions(+), 2 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 518a21b0fe..6ecc870844 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3847,6 +3847,15 @@ static int rdma_load_hook(QEMUFile *f, void *opaqu=
e, uint64_t flags, void *data)
         return rdma_block_notification_handle(opaque, data);
=20
     case RAM_CONTROL_HOOK:
+        if (migrate_use_multiRDMA()) {
+            int i;
+            int thread_count =3D migrate_multiRDMA_channels();
+            /* Inform dest recv_thread to poll */
+            for (i =3D 0; i < thread_count; i++) {
+                qemu_sem_post(&multiRDMA_recv_state->params[i].sem);
+            }
+        }
+
         return qemu_rdma_registration_handle(f, opaque);
=20
     default:
@@ -3920,6 +3929,17 @@ static int qemu_rdma_registration_stop(QEMUFile *f=
, void *opaque,
         head.type =3D RDMA_CONTROL_RAM_BLOCKS_REQUEST;
         trace_qemu_rdma_registration_stop_ram();
=20
+        if (migrate_use_multiRDMA()) {
+            /*
+             * Inform the multiRDMA channels to register memory
+             */
+            int i;
+            int thread_count =3D migrate_multiRDMA_channels();
+            for (i =3D 0; i < thread_count; i++) {
+                qemu_sem_post(&multiRDMA_send_state->params[i].sem);
+            }
+        }
+
         /*
          * Make sure that we parallelize the pinning on both sides.
          * For very large guests, doing this serially takes a really
@@ -3985,6 +4005,15 @@ static int qemu_rdma_registration_stop(QEMUFile *f=
, void *opaque,
     head.type =3D RDMA_CONTROL_REGISTER_FINISHED;
     ret =3D qemu_rdma_exchange_send(rdma, &head, NULL, NULL, NULL, NULL)=
;
=20
+    if (migrate_use_multiRDMA()) {
+        /* Inform src send_thread to send FINISHED signal */
+        int i;
+        int thread_count =3D migrate_multiRDMA_channels();
+        for (i =3D 0; i < thread_count; i++) {
+            qemu_sem_post(&multiRDMA_send_state->params[i].sem);
+        }
+    }
+
     if (ret < 0) {
         goto err;
     }
@@ -4150,18 +4179,119 @@ err:
     return msg;
 }
=20
+static int qemu_multiRDMA_registration_handle(void *opaque)
+{
+    RDMAControlHeader blocks =3D { .type =3D RDMA_CONTROL_RAM_BLOCKS_RES=
ULT,
+                                 .repeat =3D 1 };
+    MultiRDMARecvParams *p =3D opaque;
+    RDMAContext *rdma =3D p->rdma;
+    RDMALocalBlocks *local =3D &rdma->local_ram_blocks;
+    RDMAControlHeader head;
+    int ret =3D 0;
+    int i =3D 0;
+
+    CHECK_ERROR_STATE();
+
+    do {
+        ret =3D qemu_rdma_exchange_recv(rdma, &head, RDMA_CONTROL_NONE);
+
+        if (ret < 0) {
+            break;
+        }
+
+        if (head.repeat > RDMA_CONTROL_MAX_COMMANDS_PER_MESSAGE) {
+            error_report("rdma: Too many requests in this message (%d)."
+                         "Bailing.", head.repeat);
+            ret =3D -EIO;
+            break;
+        }
+
+        switch (head.type) {
+        case RDMA_CONTROL_REGISTER_FINISHED:
+            goto out;
+        case RDMA_CONTROL_RAM_BLOCKS_REQUEST:
+            qsort(rdma->local_ram_blocks.block,
+                  rdma->local_ram_blocks.nb_blocks,
+                  sizeof(RDMALocalBlock), dest_ram_sort_func);
+
+            if (rdma->pin_all) {
+                ret =3D qemu_rdma_reg_whole_ram_blocks(rdma);
+                if (ret) {
+                    error_report("rdma migration: error dest "
+                                 "registering ram blocks");
+                    goto out;
+                }
+            }
+
+            for (i =3D 0; i < local->nb_blocks; i++) {
+                /*
+                 * The multiRDMA threads only register ram block
+                 * to send data, other blocks are sent by main RDMA thre=
ad.
+                 */
+                if (strcmp(local->block[i].block_name, "mach-virt.ram") =
=3D=3D 0) {
+                    rdma->dest_blocks[i].remote_host_addr =3D
+                        (uintptr_t)(local->block[i].local_host_addr);
+
+                    if (rdma->pin_all) {
+                        rdma->dest_blocks[i].remote_rkey =3D
+                            local->block[i].mr->rkey;
+                    }
+
+                    rdma->dest_blocks[i].offset =3D local->block[i].offs=
et;
+                    rdma->dest_blocks[i].length =3D local->block[i].leng=
th;
+
+                    dest_block_to_network(&rdma->dest_blocks[i]);
+
+                    break;
+                }
+            }
+
+            blocks.len =3D rdma->local_ram_blocks.nb_blocks
+                                                * sizeof(RDMADestBlock);
+
+            ret =3D qemu_rdma_post_send_control(rdma,
+                                              (uint8_t *) rdma->dest_blo=
cks,
+                                              &blocks);
+
+            if (ret < 0) {
+                error_report("rdma migration: error sending remote info"=
);
+                goto out;
+            }
+
+            break;
+        default:
+            error_report("Unknown control message %s", control_desc(head=
.type));
+            ret =3D -EIO;
+            goto out;
+        }
+    } while (1);
+out:
+    if (ret < 0) {
+        rdma->error_state =3D ret;
+    }
+    return ret;
+}
+
 static void *multiRDMA_recv_thread(void *opaque)
 {
     MultiRDMARecvParams *p =3D opaque;
+    int ret;
=20
     while (true) {
+        qemu_sem_wait(&p->sem);
+
         qemu_mutex_lock(&p->mutex);
         if (p->quit) {
             qemu_mutex_unlock(&p->mutex);
             break;
         }
         qemu_mutex_unlock(&p->mutex);
-        qemu_sem_wait(&p->sem);
+
+        ret =3D qemu_multiRDMA_registration_handle(opaque);
+        if (ret < 0) {
+            qemu_file_set_error(p->file, ret);
+            break;
+        }
     }
=20
     qemu_mutex_lock(&p->mutex);
@@ -4378,18 +4508,76 @@ static void migration_rdma_send_initial_packet(QE=
MUFile *f, uint8_t id)
 static void *multiRDMA_send_thread(void *opaque)
 {
     MultiRDMASendParams *p =3D opaque;
+    RDMAContext *rdma =3D p->rdma;
+    int ret;
=20
     /* send the multiRDMA channels magic */
     migration_rdma_send_initial_packet(p->file, p->id);
=20
+    /* wait for semaphore notification to register memory */
+    qemu_sem_wait(&p->sem);
+
+    RDMAControlHeader resp =3D {.type =3D RDMA_CONTROL_RAM_BLOCKS_RESULT=
 };
+    RDMALocalBlocks *local =3D &rdma->local_ram_blocks;
+    int reg_result_idx, i, nb_dest_blocks;
+    RDMAControlHeader head =3D { .len =3D 0, .repeat =3D 1 };
+
+    head.type =3D RDMA_CONTROL_RAM_BLOCKS_REQUEST;
+
+    ret =3D qemu_rdma_exchange_send(rdma, &head, NULL, &resp,
+            &reg_result_idx, rdma->pin_all ?
+            qemu_rdma_reg_whole_ram_blocks : NULL);
+    if (ret < 0) {
+        return NULL;
+    }
+
+    nb_dest_blocks =3D resp.len / sizeof(RDMADestBlock);
+
+    if (local->nb_blocks !=3D nb_dest_blocks) {
+        rdma->error_state =3D -EINVAL;
+        return NULL;
+    }
+
+    qemu_rdma_move_header(rdma, reg_result_idx, &resp);
+    memcpy(rdma->dest_blocks,
+           rdma->wr_data[reg_result_idx].control_curr, resp.len);
+
+    for (i =3D 0; i < nb_dest_blocks; i++) {
+        /*
+         * The multiRDMA threads only register ram block
+         * to send data, other blocks are sent by main RDMA thread.
+         */
+        if (strcmp(local->block[i].block_name, "mach-virt.ram") =3D=3D 0=
) {
+            network_to_dest_block(&rdma->dest_blocks[i]);
+
+            /* We require that the blocks are in the same order */
+            if (rdma->dest_blocks[i].length !=3D local->block[i].length)=
 {
+                rdma->error_state =3D -EINVAL;
+                return NULL;
+            }
+            local->block[i].remote_host_addr =3D
+                rdma->dest_blocks[i].remote_host_addr;
+            local->block[i].remote_rkey =3D rdma->dest_blocks[i].remote_=
rkey;
+            break;
+        }
+    }
+
     while (true) {
+        qemu_sem_wait(&p->sem);
+
         qemu_mutex_lock(&p->mutex);
         if (p->quit) {
             qemu_mutex_unlock(&p->mutex);
             break;
         }
         qemu_mutex_unlock(&p->mutex);
-        qemu_sem_wait(&p->sem);
+
+        /* Send FINISHED to the destination */
+        head.type =3D RDMA_CONTROL_REGISTER_FINISHED;
+        ret =3D qemu_rdma_exchange_send(rdma, &head, NULL, NULL, NULL, N=
ULL);
+        if (ret < 0) {
+            return NULL;
+        }
     }
=20
     qemu_mutex_lock(&p->mutex);
--=20
2.19.1



