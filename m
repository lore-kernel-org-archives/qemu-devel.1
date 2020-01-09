Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADA55C32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 10:07:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EA3E206ED
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 10:07:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EA3E206ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipUj3-0007iW-LW
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 05:07:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43186)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fengzhimin1@huawei.com>) id 1ipPvI-00011w-Dn
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 23:59:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fengzhimin1@huawei.com>) id 1ipPvE-0001Sq-IZ
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 23:59:56 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:34978 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fengzhimin1@huawei.com>)
 id 1ipPvD-0001Ns-Qs
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 23:59:52 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id EFA7C28F611D0299523C;
 Thu,  9 Jan 2020 12:59:45 +0800 (CST)
Received: from huawei.com (10.173.220.198) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Thu, 9 Jan 2020
 12:59:38 +0800
From: Zhimin Feng <fengzhimin1@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>, <armbru@redhat.com>,
 <eblake@redhat.com>
Subject: [PATCH RFC 12/12] migration/rdma: only register the virt-ram block
 for MultiRDMA
Date: Thu, 9 Jan 2020 12:59:22 +0800
Message-ID: <20200109045922.904-13-fengzhimin1@huawei.com>
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

The virt-ram block is sent by MultiRDMA, so we only register it for
MultiRDMA channels and main channel don't register the virt-ram block.

Signed-off-by: fengzhimin <fengzhimin1@huawei.com>
---
 migration/rdma.c | 140 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 112 insertions(+), 28 deletions(-)

diff --git a/migration/rdma.c b/migration/rdma.c
index 0a150099e2..1477fd509b 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -618,7 +618,9 @@ const char *print_wrid(int wrid);
 static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader =
*head,
                                    uint8_t *data, RDMAControlHeader *res=
p,
                                    int *resp_idx,
-                                   int (*callback)(RDMAContext *rdma));
+                                   int (*callback)(RDMAContext *rdma,
+                                   uint8_t id),
+                                   uint8_t id);
=20
 static inline uint64_t ram_chunk_index(const uint8_t *start,
                                        const uint8_t *host)
@@ -1198,24 +1200,81 @@ static int qemu_rdma_alloc_qp(RDMAContext *rdma)
     return 0;
 }
=20
-static int qemu_rdma_reg_whole_ram_blocks(RDMAContext *rdma)
+/*
+ * Parameters:
+ *    @id =3D=3D UNUSED_ID :
+ *    This means that we register memory for the main RDMA channel,
+ *    the main RDMA channel don't register the mach-virt.ram block
+ *    when we use multiRDMA method to migrate.
+ *
+ *    @id =3D=3D 0 or id =3D=3D 1 or ... :
+ *    This means that we register memory for the multiRDMA channels,
+ *    the multiRDMA channels only register memory for the mach-virt.ram
+ *    block when we use multiRDAM method to migrate.
+ */
+static int qemu_rdma_reg_whole_ram_blocks(RDMAContext *rdma, uint8_t id)
 {
     int i;
     RDMALocalBlocks *local =3D &rdma->local_ram_blocks;
=20
-    for (i =3D 0; i < local->nb_blocks; i++) {
-        local->block[i].mr =3D
-            ibv_reg_mr(rdma->pd,
-                    local->block[i].local_host_addr,
-                    local->block[i].length,
-                    IBV_ACCESS_LOCAL_WRITE |
-                    IBV_ACCESS_REMOTE_WRITE
-                    );
-        if (!local->block[i].mr) {
-            perror("Failed to register local dest ram block!\n");
-            break;
+    if (migrate_use_multiRDMA()) {
+        if (id =3D=3D UNUSED_ID) {
+            for (i =3D 0; i < local->nb_blocks; i++) {
+                /* main RDMA channel don't register the mach-virt.ram bl=
ock */
+                if (strcmp(local->block[i].block_name, "mach-virt.ram") =
=3D=3D 0) {
+                    continue;
+                }
+
+                local->block[i].mr =3D
+                    ibv_reg_mr(rdma->pd,
+                            local->block[i].local_host_addr,
+                            local->block[i].length,
+                            IBV_ACCESS_LOCAL_WRITE |
+                            IBV_ACCESS_REMOTE_WRITE
+                            );
+                if (!local->block[i].mr) {
+                    perror("Failed to register local dest ram block!\n")=
;
+                    break;
+                }
+                rdma->total_registrations++;
+            }
+        } else {
+            for (i =3D 0; i < local->nb_blocks; i++) {
+                /*
+                 * The multiRDAM channels only register
+                 * the mach-virt.ram block
+                 */
+                if (strcmp(local->block[i].block_name, "mach-virt.ram") =
=3D=3D 0) {
+                    local->block[i].mr =3D
+                        ibv_reg_mr(rdma->pd,
+                                local->block[i].local_host_addr,
+                                local->block[i].length,
+                                IBV_ACCESS_LOCAL_WRITE |
+                                IBV_ACCESS_REMOTE_WRITE
+                                );
+                    if (!local->block[i].mr) {
+                        perror("Failed to register local dest ram block!=
\n");
+                        break;
+                    }
+                    rdma->total_registrations++;
+                }
+            }
+        }
+    } else {
+        for (i =3D 0; i < local->nb_blocks; i++) {
+            local->block[i].mr =3D
+                ibv_reg_mr(rdma->pd,
+                        local->block[i].local_host_addr,
+                        local->block[i].length,
+                        IBV_ACCESS_LOCAL_WRITE |
+                        IBV_ACCESS_REMOTE_WRITE
+                        );
+            if (!local->block[i].mr) {
+                perror("Failed to register local dest ram block!\n");
+                break;
+            }
+            rdma->total_registrations++;
         }
-        rdma->total_registrations++;
     }
=20
     if (i >=3D local->nb_blocks) {
@@ -1223,8 +1282,10 @@ static int qemu_rdma_reg_whole_ram_blocks(RDMACont=
ext *rdma)
     }
=20
     for (i--; i >=3D 0; i--) {
-        ibv_dereg_mr(local->block[i].mr);
-        rdma->total_registrations--;
+        if (local->block[i].mr) {
+            ibv_dereg_mr(local->block[i].mr);
+            rdma->total_registrations--;
+        }
     }
=20
     return -1;
@@ -1446,7 +1507,7 @@ static int qemu_rdma_unregister_waiting(RDMAContext=
 *rdma)
         reg.key.chunk =3D chunk;
         register_to_network(rdma, &reg);
         ret =3D qemu_rdma_exchange_send(rdma, &head, (uint8_t *) &reg,
-                                &resp, NULL, NULL);
+                                      &resp, NULL, NULL, UNUSED_ID);
         if (ret < 0) {
             return ret;
         }
@@ -1915,11 +1976,17 @@ static void qemu_rdma_move_header(RDMAContext *rd=
ma, int idx,
  * The extra (optional) response is used during registration to us from =
having
  * to perform an *additional* exchange of message just to provide a resp=
onse by
  * instead piggy-backing on the acknowledgement.
+ *
+ * Parameters:
+ *    @id : callback function need two parameters, id is the second para=
meter.
+ *
  */
 static int qemu_rdma_exchange_send(RDMAContext *rdma, RDMAControlHeader =
*head,
                                    uint8_t *data, RDMAControlHeader *res=
p,
                                    int *resp_idx,
-                                   int (*callback)(RDMAContext *rdma))
+                                   int (*callback)(RDMAContext *rdma,
+                                   uint8_t id),
+                                   uint8_t id)
 {
     int ret =3D 0;
=20
@@ -1973,7 +2040,7 @@ static int qemu_rdma_exchange_send(RDMAContext *rdm=
a, RDMAControlHeader *head,
     if (resp) {
         if (callback) {
             trace_qemu_rdma_exchange_send_issue_callback();
-            ret =3D callback(rdma);
+            ret =3D callback(rdma, id);
             if (ret < 0) {
                 return ret;
             }
@@ -2168,7 +2235,7 @@ retry:
=20
                 compress_to_network(rdma, &comp);
                 ret =3D qemu_rdma_exchange_send(rdma, &head,
-                                (uint8_t *) &comp, NULL, NULL, NULL);
+                                (uint8_t *) &comp, NULL, NULL, NULL, UNU=
SED_ID);
=20
                 if (ret < 0) {
                     return -EIO;
@@ -2195,7 +2262,7 @@ retry:
=20
             register_to_network(rdma, &reg);
             ret =3D qemu_rdma_exchange_send(rdma, &head, (uint8_t *) &re=
g,
-                                    &resp, &reg_result_idx, NULL);
+                                    &resp, &reg_result_idx, NULL, UNUSED=
_ID);
             if (ret < 0) {
                 return ret;
             }
@@ -2828,7 +2895,8 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *=
ioc,
             head.len =3D len;
             head.type =3D RDMA_CONTROL_QEMU_FILE;
=20
-            ret =3D qemu_rdma_exchange_send(rdma, &head, data, NULL, NUL=
L, NULL);
+            ret =3D qemu_rdma_exchange_send(rdma, &head, data, NULL,
+                                          NULL, NULL, UNUSED_ID);
=20
             if (ret < 0) {
                 rdma->error_state =3D ret;
@@ -3660,7 +3728,7 @@ static int qemu_rdma_registration_handle(QEMUFile *=
f, void *opaque)
             }
=20
             if (rdma->pin_all) {
-                ret =3D qemu_rdma_reg_whole_ram_blocks(rdma);
+                ret =3D qemu_rdma_reg_whole_ram_blocks(rdma, UNUSED_ID);
                 if (ret) {
                     error_report("rdma migration: error dest "
                                     "registering ram blocks");
@@ -3675,6 +3743,15 @@ static int qemu_rdma_registration_handle(QEMUFile =
*f, void *opaque)
              * their "local" descriptions with what was sent.
              */
             for (i =3D 0; i < local->nb_blocks; i++) {
+                /*
+                 * use the main RDMA channel to deliver the block of dev=
ice
+                 * use the multiRDMA channels to deliver the RAMBlock
+                 */
+                if (migrate_use_multiRDMA() &&
+                    strcmp(local->block[i].block_name, "mach-virt.ram") =
=3D=3D 0) {
+                        continue;
+                }
+
                 rdma->dest_blocks[i].remote_host_addr =3D
                     (uintptr_t)(local->block[i].local_host_addr);
=20
@@ -3992,7 +4069,7 @@ static int qemu_rdma_registration_stop(QEMUFile *f,=
 void *opaque,
          */
         ret =3D qemu_rdma_exchange_send(rdma, &head, NULL, &resp,
                     &reg_result_idx, rdma->pin_all ?
-                    qemu_rdma_reg_whole_ram_blocks : NULL);
+                    qemu_rdma_reg_whole_ram_blocks : NULL, UNUSED_ID);
         if (ret < 0) {
             ERROR(errp, "receiving remote info!");
             return ret;
@@ -4025,6 +4102,11 @@ static int qemu_rdma_registration_stop(QEMUFile *f=
, void *opaque,
         memcpy(rdma->dest_blocks,
             rdma->wr_data[reg_result_idx].control_curr, resp.len);
         for (i =3D 0; i < nb_dest_blocks; i++) {
+            if (migrate_use_multiRDMA() &&
+                strcmp(local->block[i].block_name, "mach-virt.ram") =3D=3D=
 0) {
+                continue;
+            }
+
             network_to_dest_block(&rdma->dest_blocks[i]);
=20
             /* We require that the blocks are in the same order */
@@ -4050,7 +4132,8 @@ static int qemu_rdma_registration_stop(QEMUFile *f,=
 void *opaque,
     trace_qemu_rdma_registration_stop(flags);
=20
     head.type =3D RDMA_CONTROL_REGISTER_FINISHED;
-    ret =3D qemu_rdma_exchange_send(rdma, &head, NULL, NULL, NULL, NULL)=
;
+    ret =3D qemu_rdma_exchange_send(rdma, &head, NULL, NULL,
+                                  NULL, NULL, UNUSED_ID);
=20
     if (migrate_use_multiRDMA()) {
         /*
@@ -4298,7 +4381,7 @@ static int qemu_multiRDMA_registration_handle(void =
*opaque)
                   sizeof(RDMALocalBlock), dest_ram_sort_func);
=20
             if (rdma->pin_all) {
-                ret =3D qemu_rdma_reg_whole_ram_blocks(rdma);
+                ret =3D qemu_rdma_reg_whole_ram_blocks(rdma, p->id);
                 if (ret) {
                     error_report("rdma migration: error dest "
                                  "registering ram blocks");
@@ -4680,7 +4763,7 @@ static void *multiRDMA_send_thread(void *opaque)
=20
     ret =3D qemu_rdma_exchange_send(rdma, &head, NULL, &resp,
             &reg_result_idx, rdma->pin_all ?
-            qemu_rdma_reg_whole_ram_blocks : NULL);
+            qemu_rdma_reg_whole_ram_blocks : NULL, p->id);
     if (ret < 0) {
         return NULL;
     }
@@ -4749,7 +4832,8 @@ static void *multiRDMA_send_thread(void *opaque)
=20
         /* Send FINISHED to the destination */
         head.type =3D RDMA_CONTROL_REGISTER_FINISHED;
-        ret =3D qemu_rdma_exchange_send(rdma, &head, NULL, NULL, NULL, N=
ULL);
+        ret =3D qemu_rdma_exchange_send(rdma, &head, NULL, NULL,
+                                      NULL, NULL, p->id);
         if (ret < 0) {
             return NULL;
         }
--=20
2.19.1



