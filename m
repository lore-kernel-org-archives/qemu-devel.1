Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E14AC2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 09:44:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73D3620848
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 09:44:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73D3620848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2B2h-00005k-M1
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 04:44:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45917)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fengzhimin1@huawei.com>) id 1j2Awz-0006gt-N6
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:38:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fengzhimin1@huawei.com>) id 1j2Awy-00050l-BH
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:38:25 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2770 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fengzhimin1@huawei.com>)
 id 1j2Awy-0004tq-09
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:38:24 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id A5B0AE7CE3F2B8C58865;
 Thu, 13 Feb 2020 17:38:20 +0800 (CST)
Received: from huawei.com (10.173.220.198) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Thu, 13 Feb 2020
 17:38:14 +0800
From: Zhimin Feng <fengzhimin1@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>, <armbru@redhat.com>,
 <eblake@redhat.com>
Subject: [PATCH RFC 11/14] migration/rdma: use multifd to migrate VM for
 rdma-pin-all mode
Date: Thu, 13 Feb 2020 17:37:52 +0800
Message-ID: <20200213093755.370-12-fengzhimin1@huawei.com>
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

Signed-off-by: Zhimin Feng <fengzhimin1@huawei.com>
---
 migration/multifd.c | 15 ++++++++++++
 migration/rdma.c    | 58 +++++++++++++++++++++++++++++++++++++++++----
 migration/rdma.h    |  2 ++
 3 files changed, 70 insertions(+), 5 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index c986d4c247..ba5e0b11d0 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -519,12 +519,27 @@ static void *multifd_rdma_send_thread(void *opaque)
         }
         qemu_mutex_unlock(&p->mutex);
=20
+        /* To complete polling(CQE) */
+        while (p->rdma->nb_sent) {
+            ret =3D qemu_rdma_block_for_wrid(p->rdma, RDMA_WRID_RDMA_WRI=
TE, NULL);
+            if (ret < 0) {
+                error_report("multifd RDMA migration: "
+                             "complete polling error!");
+                return NULL;
+            }
+        }
+
         /* Send FINISHED to the destination */
         head.type =3D RDMA_CONTROL_REGISTER_FINISHED;
         ret =3D qemu_rdma_exchange_send(p->rdma, &head, NULL, NULL, NULL=
, NULL);
         if (ret < 0) {
+            error_report("multifd RDMA migration: "
+                         "receiving remote info!");
             return NULL;
         }
+
+        /* sync main thread */
+        qemu_sem_post(&p->sem);
     }
=20
 out:
diff --git a/migration/rdma.c b/migration/rdma.c
index 4c48e9832c..873c17dc03 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -96,6 +96,23 @@ static const char *wrid_desc[] =3D {
=20
 static const char *rdma_host_port;
=20
+/*
+ * index of current RDMA channel for multifd
+ */
+static int current_RDMA_index;
+
+/*
+ * Get the multifd RDMA channel used to send data.
+ */
+static int get_multifd_RDMA_channel(void)
+{
+    int thread_count =3D migrate_multifd_channels();
+    current_RDMA_index++;
+    current_RDMA_index %=3D thread_count;
+
+    return current_RDMA_index;
+}
+
 /*
  * Negotiate RDMA capabilities during connection-setup time.
  */
@@ -1328,8 +1345,8 @@ static int qemu_rdma_wait_comp_channel(RDMAContext =
*rdma)
  * completions only need to be recorded, but do not actually
  * need further processing.
  */
-static int qemu_rdma_block_for_wrid(RDMAContext *rdma, int wrid_requeste=
d,
-                                    uint32_t *byte_len)
+int qemu_rdma_block_for_wrid(RDMAContext *rdma, int wrid_requested,
+                             uint32_t *byte_len)
 {
     int num_cq_events =3D 0, ret =3D 0;
     struct ibv_cq *cq;
@@ -1731,6 +1748,20 @@ static int qemu_rdma_write_one(QEMUFile *f, RDMACo=
ntext *rdma,
                                .repeat =3D 1,
                              };
=20
+    /* use multifd to send data */
+    if (migrate_use_multifd() && migrate_use_rdma_pin_all()) {
+        int channel =3D get_multifd_RDMA_channel();
+        int ret =3D 0;
+        MultiFDSendParams *multifd_send_param =3D NULL;
+        ret =3D get_multifd_send_param(channel, &multifd_send_param);
+        if (ret) {
+            error_report("rdma: error getting multifd_send_param(%d)", c=
hannel);
+            return -EINVAL;
+        }
+        rdma =3D multifd_send_param->rdma;
+        block =3D &(rdma->local_ram_blocks.block[current_index]);
+    }
+
 retry:
     sge.addr =3D (uintptr_t)(block->local_host_addr +
                             (current_addr - block->offset));
@@ -1948,8 +1979,21 @@ static int qemu_rdma_write_flush(QEMUFile *f, RDMA=
Context *rdma)
     }
=20
     if (ret =3D=3D 0) {
-        rdma->nb_sent++;
-        trace_qemu_rdma_write_flush(rdma->nb_sent);
+        if (migrate_use_multifd() && migrate_use_rdma_pin_all()) {
+            /* The multifd RDMA threads send data */
+            MultiFDSendParams *multifd_send_param =3D NULL;
+            ret =3D get_multifd_send_param(current_RDMA_index,
+                                         &multifd_send_param);
+            if (ret) {
+                error_report("rdma: error getting multifd_send_param(%d)=
",
+                             current_RDMA_index);
+                return ret;
+            }
+            multifd_send_param->rdma->nb_sent++;
+        } else {
+            rdma->nb_sent++;
+            trace_qemu_rdma_write_flush(rdma->nb_sent);
+        }
     }
=20
     rdma->current_length =3D 0;
@@ -3758,7 +3802,10 @@ static int qemu_rdma_registration_stop(QEMUFile *f=
, void *opaque,
     ret =3D qemu_rdma_exchange_send(rdma, &head, NULL, NULL, NULL, NULL)=
;
=20
     if (migrate_use_multifd()) {
-        /* Inform src send_thread to send FINISHED signal */
+        /*
+         * Inform src send_thread to send FINISHED signal.
+         * Wait for multifd RDMA send threads to poll the CQE.
+         */
         int i;
         int thread_count =3D migrate_multifd_channels();
         MultiFDSendParams *multifd_send_param =3D NULL;
@@ -3770,6 +3817,7 @@ static int qemu_rdma_registration_stop(QEMUFile *f,=
 void *opaque,
             }
=20
             qemu_sem_post(&multifd_send_param->sem_sync);
+            qemu_sem_wait(&multifd_send_param->sem);
         }
     }
=20
diff --git a/migration/rdma.h b/migration/rdma.h
index 86c89bdd1f..7dc3895698 100644
--- a/migration/rdma.h
+++ b/migration/rdma.h
@@ -281,6 +281,8 @@ int qemu_rdma_exchange_send(RDMAContext *rdma, RDMACo=
ntrolHeader *head,
                             int *resp_idx,
                             int (*callback)(RDMAContext *rdma));
 int qemu_rdma_registration(void *opaque);
+int qemu_rdma_block_for_wrid(RDMAContext *rdma, int wrid_requested,
+                             uint32_t *byte_len);
=20
 void rdma_start_outgoing_migration(void *opaque, const char *host_port,
                                    Error **errp);
--=20
2.19.1



