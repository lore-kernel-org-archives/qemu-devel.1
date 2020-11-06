Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE32C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 06:10:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37A2E20867
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 06:10:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37A2E20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaux2-00029w-1Q
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 01:10:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51596)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kauwR-0001kL-Vd
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 01:09:43 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2507)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhengchuan@huawei.com>)
 id 1kauwO-00060k-LG
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 01:09:43 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CS92T5Ghgzhd7y;
 Fri,  6 Nov 2020 14:09:21 +0800 (CST)
Received: from huawei.com (10.175.101.6) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.487.0; Fri, 6 Nov 2020
 14:09:15 +0800
From: Chuan Zheng <zhengchuan@huawei.com>
To: <quintela@redhat.com>, <dgilbert@redhat.com>, <berrange@redhat.com>
Subject: [PATCH] migration/multifd: fix hangup with TLS-Multifd due to
 blocking handshake
Date: Fri, 6 Nov 2020 14:24:53 +0800
Message-ID: <1604643893-8223-1-git-send-email-zhengchuan@huawei.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.191;
 envelope-from=zhengchuan@huawei.com; helo=szxga05-in.huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 01:09:28
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: yubihong@huawei.com, zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org,
 xiexiangyou@huawei.com, alex.chen@huawei.com, wanghao232@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The qemu main loop could hang up forever when we enable TLS+Multifd.
The Src multifd_send_0 invokes tls handshake, it sends hello to sever
and wait response.
However, the Dst main qemu loop has been waiting recvmsg() for multifd_recv_1.
Both of Src and Dst main qemu loop are blocking and waiting for reponse which
results in hanging up forever.

Src: (multifd_send_0)                                              Dst: (multifd_recv_1)
multifd_channel_connect                                            migration_channel_process_incoming
  multifd_tls_channel_connect                                        migration_tls_channel_process_incoming
    multifd_tls_channel_connect                                        qio_channel_tls_handshake_task
       qio_channel_tls_handshake                                         gnutls_handshake
          qio_channel_tls_handshake_task                                       ...
            qcrypto_tls_session_handshake                                      ...
              gnutls_handshake                                                 ...
                   ...                                                         ...
                recvmsg (Blocking I/O waiting for response)                recvmsg (Blocking I/O waiting for response)

Fix this by offloadinig handshake work to a background thread.

Reported-by: Yan Jin <jinyan12@huawei.com>
Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
---
 migration/multifd.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 68b171f..88486b9 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -739,6 +739,19 @@ static void multifd_tls_outgoing_handshake(QIOTask *task,
     multifd_channel_connect(p, ioc, err);
 }
 
+static void *multifd_tls_handshake_thread(void *opaque)
+{
+    MultiFDSendParams *p = opaque;
+    QIOChannelTLS *tioc = QIO_CHANNEL_TLS(p->c);
+
+    qio_channel_tls_handshake(tioc,
+                              multifd_tls_outgoing_handshake,
+                              p,
+                              NULL,
+                              NULL);
+    return NULL;
+}
+
 static void multifd_tls_channel_connect(MultiFDSendParams *p,
                                         QIOChannel *ioc,
                                         Error **errp)
@@ -754,12 +767,10 @@ static void multifd_tls_channel_connect(MultiFDSendParams *p,
 
     trace_multifd_tls_outgoing_handshake_start(ioc, tioc, hostname);
     qio_channel_set_name(QIO_CHANNEL(tioc), "multifd-tls-outgoing");
-    qio_channel_tls_handshake(tioc,
-                              multifd_tls_outgoing_handshake,
-                              p,
-                              NULL,
-                              NULL);
-
+    p->c = QIO_CHANNEL(tioc);
+    qemu_thread_create(&p->thread, "multifd-tls-handshake-worker",
+                       multifd_tls_handshake_thread, p,
+                       QEMU_THREAD_JOINABLE);
 }
 
 static bool multifd_channel_connect(MultiFDSendParams *p,
-- 
1.8.3.1


