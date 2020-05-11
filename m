Return-Path: <SRS0=xv4c=6Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC1EC47255
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 16:14:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB004206DB
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2020 16:14:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G+FoyOMI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB004206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39478 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYB4a-0000kV-0I
	for qemu-devel@archiver.kernel.org; Mon, 11 May 2020 12:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48226)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jYB0J-0002C1-5h
 for qemu-devel@nongnu.org; Mon, 11 May 2020 12:10:07 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32358
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mlevitsk@redhat.com>)
 id 1jYB0I-00014k-6W
 for qemu-devel@nongnu.org; Mon, 11 May 2020 12:10:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589213405;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=MtXFuOOm3cWbAtx6CbAfAbc97uTwRwSIWWwQ7gjw+kU=;
 b=G+FoyOMIvIggkSwjdmfLspszVM+aN1ozboYQuAIjIOaxKj5NJJwpYfkKoekZPJ9lsRfagJ
 rGmc5nEutCuKd+oIoNg4TdzsBzgqKxw32tfNBYifejlGSJsCUjUI1gDWac9uBNlhFaw5HO
 gtwTunyOm4EaknQnNS8KqNV152/DM68=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-0OkGEouIOCKBksrRXnpGaA-1; Mon, 11 May 2020 12:10:03 -0400
X-MC-Unique: 0OkGEouIOCKBksrRXnpGaA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 178E5107ACCA;
 Mon, 11 May 2020 16:10:02 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 309185C1B5;
 Mon, 11 May 2020 16:09:59 +0000 (UTC)
From: Maxim Levitsky <mlevitsk@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/7] Implement drain_call_rcu and use it in hmp_device_del
Date: Mon, 11 May 2020 19:09:46 +0300
Message-Id: <20200511160951.8733-3-mlevitsk@redhat.com>
In-Reply-To: <20200511160951.8733-1-mlevitsk@redhat.com>
References: <20200511160951.8733-1-mlevitsk@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mlevitsk@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/11 01:43:51
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This allows to preserve the semantics of hmp_device_del,
that the device is deleted immediatly which was changed by previos
patch that delayed this to RCU callback

Suggested-by: Stefan Hajnoczi <stefanha@gmail.com>
Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
---
 include/qemu/rcu.h |  1 +
 qdev-monitor.c     |  3 +++
 util/rcu.c         | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/include/qemu/rcu.h b/include/qemu/rcu.h
index 570aa603eb..0e375ebe13 100644
--- a/include/qemu/rcu.h
+++ b/include/qemu/rcu.h
@@ -133,6 +133,7 @@ struct rcu_head {
 };
 
 extern void call_rcu1(struct rcu_head *head, RCUCBFunc *func);
+extern void drain_call_rcu(void);
 
 /* The operands of the minus operator must have the same type,
  * which must be the one that we specify in the cast.
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 56cee1483f..70877840a2 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -812,6 +812,8 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
         return;
     }
     dev = qdev_device_add(opts, &local_err);
+    drain_call_rcu();
+
     if (!dev) {
         error_propagate(errp, local_err);
         qemu_opts_del(opts);
@@ -904,6 +906,7 @@ void qmp_device_del(const char *id, Error **errp)
         }
 
         qdev_unplug(dev, errp);
+        drain_call_rcu();
     }
 }
 
diff --git a/util/rcu.c b/util/rcu.c
index 60a37f72c3..e8b1c4d6c5 100644
--- a/util/rcu.c
+++ b/util/rcu.c
@@ -293,6 +293,39 @@ void call_rcu1(struct rcu_head *node, void (*func)(struct rcu_head *node))
     qemu_event_set(&rcu_call_ready_event);
 }
 
+
+struct rcu_drain {
+    struct rcu_head rcu;
+    QemuEvent drain_complete_event;
+};
+
+static void drain_rcu_callback(struct rcu_head *node)
+{
+    struct rcu_drain *event = (struct rcu_drain *)node;
+    qemu_event_set(&event->drain_complete_event);
+}
+
+void drain_call_rcu(void)
+{
+    struct rcu_drain rcu_drain;
+    bool locked = qemu_mutex_iothread_locked();
+
+    memset(&rcu_drain, 0, sizeof(struct rcu_drain));
+
+    if (locked) {
+        qemu_mutex_unlock_iothread();
+    }
+
+    qemu_event_init(&rcu_drain.drain_complete_event, false);
+    call_rcu1(&rcu_drain.rcu, drain_rcu_callback);
+    qemu_event_wait(&rcu_drain.drain_complete_event);
+
+    if (locked) {
+        qemu_mutex_lock_iothread();
+    }
+
+}
+
 void rcu_register_thread(void)
 {
     assert(rcu_reader.ctr == 0);
-- 
2.17.2


