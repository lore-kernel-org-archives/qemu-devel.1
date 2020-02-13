Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04087C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 09:43:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0903218AC
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 09:43:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0903218AC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2B1l-00078M-UE
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 04:43:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46031)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fengzhimin1@huawei.com>) id 1j2AxC-0006zl-2a
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:38:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fengzhimin1@huawei.com>) id 1j2AxA-0005DP-QN
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:38:38 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2778 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fengzhimin1@huawei.com>)
 id 1j2AxA-00051S-FU
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:38:36 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id D2A28455B78695011160;
 Thu, 13 Feb 2020 17:38:20 +0800 (CST)
Received: from huawei.com (10.173.220.198) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Thu, 13 Feb 2020
 17:38:13 +0800
From: Zhimin Feng <fengzhimin1@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>, <armbru@redhat.com>,
 <eblake@redhat.com>
Subject: [PATCH RFC 09/14] migration/rdma: register memory for multifd RDMA
 channels
Date: Thu, 13 Feb 2020 17:37:50 +0800
Message-ID: <20200213093755.370-10-fengzhimin1@huawei.com>
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

register memory for multifd RDMA channels and transmit the destination
the keys to source to use including the virtual addresses.

Signed-off-by: Zhimin Feng <fengzhimin1@huawei.com>
---
 migration/multifd.c | 34 +++++++++++++++++++++++++++++---
 migration/rdma.c    | 48 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 3 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index a57d7a2eab..4ae25fc88f 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -388,7 +388,11 @@ static void multifd_send_terminate_threads(Error *er=
r)
=20
         qemu_mutex_lock(&p->mutex);
         p->quit =3D true;
-        qemu_sem_post(&p->sem);
+        if (migrate_use_rdma()) {
+            qemu_sem_post(&p->sem_sync);
+        } else {
+            qemu_sem_post(&p->sem);
+        }
         qemu_mutex_unlock(&p->mutex);
     }
 }
@@ -484,6 +488,8 @@ static void *multifd_rdma_send_thread(void *opaque)
 {
     MultiFDSendParams *p =3D opaque;
     Error *local_err =3D NULL;
+    int ret =3D 0;
+    RDMAControlHeader head =3D { .len =3D 0, .repeat =3D 1 };
=20
     trace_multifd_send_thread_start(p->id);
=20
@@ -491,14 +497,28 @@ static void *multifd_rdma_send_thread(void *opaque)
         goto out;
     }
=20
+    /* wait for semaphore notification to register memory */
+    qemu_sem_wait(&p->sem_sync);
+    if (qemu_rdma_registration(p->rdma) < 0) {
+        goto out;
+    }
+
     while (true) {
+        qemu_sem_wait(&p->sem_sync);
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
+        ret =3D qemu_rdma_exchange_send(p->rdma, &head, NULL, NULL, NULL=
, NULL);
+        if (ret < 0) {
+            return NULL;
+        }
     }
=20
 out:
@@ -836,15 +856,23 @@ void multifd_recv_sync_main(void)
 static void *multifd_rdma_recv_thread(void *opaque)
 {
     MultiFDRecvParams *p =3D opaque;
+    int ret =3D 0;
=20
     while (true) {
+        qemu_sem_wait(&p->sem_sync);
+
         qemu_mutex_lock(&p->mutex);
         if (p->quit) {
             qemu_mutex_unlock(&p->mutex);
             break;
         }
         qemu_mutex_unlock(&p->mutex);
-        qemu_sem_wait(&p->sem_sync);
+
+        ret =3D qemu_rdma_registration_handle(p->file, p->c);
+        if (ret < 0) {
+            qemu_file_set_error(p->file, ret);
+            break;
+        }
     }
=20
     qemu_mutex_lock(&p->mutex);
diff --git a/migration/rdma.c b/migration/rdma.c
index 19a238be30..5de3a29712 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -3570,6 +3570,19 @@ static int rdma_load_hook(QEMUFile *f, void *opaqu=
e, uint64_t flags, void *data)
         return rdma_block_notification_handle(opaque, data);
=20
     case RAM_CONTROL_HOOK:
+        if (migrate_use_multifd()) {
+            int i;
+            MultiFDRecvParams *multifd_recv_param =3D NULL;
+            int thread_count =3D migrate_multifd_channels();
+            /* Inform dest recv_thread to poll */
+            for (i =3D 0; i < thread_count; i++) {
+                if (get_multifd_recv_param(i, &multifd_recv_param)) {
+                    return -1;
+                }
+                qemu_sem_post(&multifd_recv_param->sem_sync);
+            }
+        }
+
         return qemu_rdma_registration_handle(f, opaque);
=20
     default:
@@ -3643,6 +3656,25 @@ static int qemu_rdma_registration_stop(QEMUFile *f=
, void *opaque,
         head.type =3D RDMA_CONTROL_RAM_BLOCKS_REQUEST;
         trace_qemu_rdma_registration_stop_ram();
=20
+        if (migrate_use_multifd()) {
+            /*
+             * Inform the multifd channels to register memory
+             */
+            int i;
+            int thread_count =3D migrate_multifd_channels();
+            MultiFDSendParams *multifd_send_param =3D NULL;
+            for (i =3D 0; i < thread_count; i++) {
+                ret =3D get_multifd_send_param(i, &multifd_send_param);
+                if (ret) {
+                    ERROR(errp, "rdma: error getting"
+                                "multifd_send_param(%d)", i);
+                    return ret;
+                }
+
+                qemu_sem_post(&multifd_send_param->sem_sync);
+            }
+        }
+
         /*
          * Make sure that we parallelize the pinning on both sides.
          * For very large guests, doing this serially takes a really
@@ -3708,6 +3740,22 @@ static int qemu_rdma_registration_stop(QEMUFile *f=
, void *opaque,
     head.type =3D RDMA_CONTROL_REGISTER_FINISHED;
     ret =3D qemu_rdma_exchange_send(rdma, &head, NULL, NULL, NULL, NULL)=
;
=20
+    if (migrate_use_multifd()) {
+        /* Inform src send_thread to send FINISHED signal */
+        int i;
+        int thread_count =3D migrate_multifd_channels();
+        MultiFDSendParams *multifd_send_param =3D NULL;
+        for (i =3D 0; i < thread_count; i++) {
+            ret =3D get_multifd_send_param(i, &multifd_send_param);
+            if (ret) {
+                ERROR(errp, "rdma: error getting multifd_send_param(%d)"=
, i);
+                return ret;
+            }
+
+            qemu_sem_post(&multifd_send_param->sem_sync);
+        }
+    }
+
     if (ret < 0) {
         goto err;
     }
--=20
2.19.1



