Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E31C2BA83
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 09:48:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A5F420848
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 09:48:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A5F420848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2B6Y-0003zk-Iy
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 04:48:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45957)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fengzhimin1@huawei.com>) id 1j2Ax1-0006hY-9m
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:38:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fengzhimin1@huawei.com>) id 1j2Ax0-000533-AY
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:38:27 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2774 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <fengzhimin1@huawei.com>)
 id 1j2Awz-00050h-RT
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 04:38:26 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id BABCCDE1D4F06A777EA2;
 Thu, 13 Feb 2020 17:38:20 +0800 (CST)
Received: from huawei.com (10.173.220.198) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Thu, 13 Feb 2020
 17:38:11 +0800
From: Zhimin Feng <fengzhimin1@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>, <armbru@redhat.com>,
 <eblake@redhat.com>
Subject: [PATCH RFC 06/14] migration/rdma: Transmit initial packet
Date: Thu, 13 Feb 2020 17:37:47 +0800
Message-ID: <20200213093755.370-7-fengzhimin1@huawei.com>
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

Transmit initial packet through the multifd RDMA channels,
so that we can identify the multifd channels.

Signed-off-by: Zhimin Feng <fengzhimin1@huawei.com>
---
 migration/multifd.c | 33 +++++++++++++++++++++------------
 migration/rdma.c    |  2 ++
 2 files changed, 23 insertions(+), 12 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index acdfd3d5b3..a57d7a2eab 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -483,6 +483,13 @@ void multifd_send_sync_main(QEMUFile *f)
 static void *multifd_rdma_send_thread(void *opaque)
 {
     MultiFDSendParams *p =3D opaque;
+    Error *local_err =3D NULL;
+
+    trace_multifd_send_thread_start(p->id);
+
+    if (multifd_send_initial_packet(p, &local_err) < 0) {
+        goto out;
+    }
=20
     while (true) {
         qemu_mutex_lock(&p->mutex);
@@ -494,6 +501,12 @@ static void *multifd_rdma_send_thread(void *opaque)
         qemu_sem_wait(&p->sem);
     }
=20
+out:
+    if (local_err) {
+        trace_multifd_send_error(p->id);
+        multifd_send_terminate_threads(local_err);
+    }
+
     qemu_mutex_lock(&p->mutex);
     p->running =3D false;
     qemu_mutex_unlock(&p->mutex);
@@ -964,18 +977,14 @@ bool multifd_recv_new_channel(QIOChannel *ioc, Erro=
r **errp)
     Error *local_err =3D NULL;
     int id;
=20
-    if (migrate_use_rdma()) {
-        id =3D multifd_recv_state->count;
-    } else {
-        id =3D multifd_recv_initial_packet(ioc, &local_err);
-        if (id < 0) {
-            multifd_recv_terminate_threads(local_err);
-            error_propagate_prepend(errp, local_err,
-                    "failed to receive packet"
-                    " via multifd channel %d: ",
-                    atomic_read(&multifd_recv_state->count));
-            return false;
-        }
+    id =3D multifd_recv_initial_packet(ioc, &local_err);
+    if (id < 0) {
+        multifd_recv_terminate_threads(local_err);
+        error_propagate_prepend(errp, local_err,
+                "failed to receive packet"
+                " via multifd channel %d: ",
+                atomic_read(&multifd_recv_state->count));
+        return false;
     }
=20
     trace_multifd_recv_new_channel(id);
diff --git a/migration/rdma.c b/migration/rdma.c
index 48615fcaad..2f1e69197f 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -4003,6 +4003,8 @@ int multifd_channel_rdma_connect(void *opaque)
         goto out;
     }
=20
+    p->c =3D QIO_CHANNEL(getQIOChannel(p->file));
+
 out:
     if (local_err) {
         trace_multifd_send_error(p->id);
--=20
2.19.1



