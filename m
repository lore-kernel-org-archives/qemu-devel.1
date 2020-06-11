Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBA9C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:41:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8696D2073E
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 20:41:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ipGBGsmv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8696D2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjU0p-0007Q4-Nh
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 16:41:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAX-00026x-55
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:21 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51913
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jjTAP-0001Qm-Tg
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:47:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591904833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zYBTb0M0ZA3DWZb/MQ7k4GbYqnZpIJsslP+QwLOSIHU=;
 b=ipGBGsmvcklcMn56ay1qUKvZQXMoZUwLYMLPnS804DUtzJwITSnv2GTAeeGI0txel3oQST
 qx0b0yzmQo0E0/dUszthJLarm+8yhzy+qb67iO2SCpH6ESXFIxgKipL9r7NShq1dXFXEY1
 AXuI7UfrLxX/DcBYmh1AvfvslQYAf8Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-HMnhUwunPMKZjlxQ9QCHJA-1; Thu, 11 Jun 2020 15:46:53 -0400
X-MC-Unique: HMnhUwunPMKZjlxQ9QCHJA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BC0E7107AD9A;
 Thu, 11 Jun 2020 19:46:46 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 43DA060CC0;
 Thu, 11 Jun 2020 19:46:46 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 073/115] replay: implement fair mutex
Date: Thu, 11 Jun 2020 15:44:07 -0400
Message-Id: <20200611194449.31468-74-pbonzini@redhat.com>
In-Reply-To: <20200611194449.31468-1-pbonzini@redhat.com>
References: <20200611194449.31468-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 03:29:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>

In record/replay icount mode main loop thread and vCPU thread
do not perform simultaneously. They take replay mutex to synchronize
the actions. Sometimes vCPU thread waits for locking the mutex for
very long time, because main loop releases the mutex and takes it
back again. Standard qemu mutex do not provide the ordering
capabilities.

This patch adds a "queue" for replay mutex. Therefore thread ordering
becomes more "fair". Threads are executed in the same order as
they are trying to take the mutex.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Message-Id: <158823802979.28101.9340462887738957616.stgit@pasha-ThinkPad-X280>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 replay/replay-internal.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/replay/replay-internal.c b/replay/replay-internal.c
index eba8246aae..2e8a3e947a 100644
--- a/replay/replay-internal.c
+++ b/replay/replay-internal.c
@@ -22,6 +22,9 @@
    It also protects replay events queue which stores events to be
    written or read to the log. */
 static QemuMutex lock;
+/* Condition and queue for fair ordering of mutex lock requests. */
+static QemuCond mutex_cond;
+static unsigned long mutex_head, mutex_tail;
 
 /* File for replay writing */
 static bool write_error;
@@ -197,9 +200,10 @@ static __thread bool replay_locked;
 void replay_mutex_init(void)
 {
     qemu_mutex_init(&lock);
+    qemu_cond_init(&mutex_cond);
     /* Hold the mutex while we start-up */
-    qemu_mutex_lock(&lock);
     replay_locked = true;
+    ++mutex_tail;
 }
 
 bool replay_mutex_locked(void)
@@ -211,10 +215,16 @@ bool replay_mutex_locked(void)
 void replay_mutex_lock(void)
 {
     if (replay_mode != REPLAY_MODE_NONE) {
+        unsigned long id;
         g_assert(!qemu_mutex_iothread_locked());
         g_assert(!replay_mutex_locked());
         qemu_mutex_lock(&lock);
+        id = mutex_tail++;
+        while (id != mutex_head) {
+            qemu_cond_wait(&mutex_cond, &lock);
+        }
         replay_locked = true;
+        qemu_mutex_unlock(&lock);
     }
 }
 
@@ -222,7 +232,10 @@ void replay_mutex_unlock(void)
 {
     if (replay_mode != REPLAY_MODE_NONE) {
         g_assert(replay_mutex_locked());
+        qemu_mutex_lock(&lock);
+        ++mutex_head;
         replay_locked = false;
+        qemu_cond_broadcast(&mutex_cond);
         qemu_mutex_unlock(&lock);
     }
 }
-- 
2.26.2



