Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D14BC4727C
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:24:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F065921D7A
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 12:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K7KqjJP6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F065921D7A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLmm0-0005fi-Ng
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 08:24:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38556)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kLmWe-0003zX-Mw
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:08:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25551)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <dgilbert@redhat.com>)
 id 1kLmWb-0004K0-I6
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 08:08:32 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601035708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YFFWgewJEUCwYiM/+Aevl1Ftix7NLyf9/nEk16IBEow=;
 b=K7KqjJP6vp7LnE/jgDeRmjsHnS5ZJUwy9eyd4pRmH0+e5lZI5FhbTgvDxGGQzU6BfJlP+0
 BbbnCHTUa5SpX041c74lygLvMj98k+/Hp0/0GiYasSnpS/1kwchDHI2YtfCJe6z6BsmNlN
 KIPyTn+WmjSKzSUsrSbTOa+AyU5YrMs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-y-Pi9oUrP6aOm4HqIsU-_w-1; Fri, 25 Sep 2020 08:08:24 -0400
X-MC-Unique: y-Pi9oUrP6aOm4HqIsU-_w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C7AE57088;
 Fri, 25 Sep 2020 12:08:23 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-114-177.ams2.redhat.com
 [10.36.114.177])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 011D273695;
 Fri, 25 Sep 2020 12:08:17 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org, zhengchuan@huawei.com, dovmurik@linux.vnet.ibm.com,
 hgcoin@gmail.com, zhangjiachen.jaycee@bytedance.com, lvivier@redhat.com,
 peterx@redhat.com, stefanha@redhat.com, vgoyal@redhat.com,
 jinyan12@huawei.com, ann.zhuangyanying@huawei.com
Subject: [PULL 21/26] migration/tls: add support for multifd tls-handshake
Date: Fri, 25 Sep 2020 13:06:50 +0100
Message-Id: <20200925120655.295142-22-dgilbert@redhat.com>
In-Reply-To: <20200925120655.295142-1-dgilbert@redhat.com>
References: <20200925120655.295142-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=dgilbert@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=dgilbert@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/25 01:07:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chuan Zheng <zhengchuan@huawei.com>

Similar like migration main thread, we need to do handshake
for each multifd thread.

Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
Signed-off-by: Yan Jin <jinyan12@huawei.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <1600139042-104593-6-git-send-email-zhengchuan@huawei.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/multifd.c | 77 +++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 75 insertions(+), 2 deletions(-)

diff --git a/migration/multifd.c b/migration/multifd.c
index 36d4a403a5..67e39593a7 100644
--- a/migration/multifd.c
+++ b/migration/multifd.c
@@ -20,6 +20,7 @@
 #include "ram.h"
 #include "migration.h"
 #include "socket.h"
+#include "tls.h"
 #include "qemu-file.h"
 #include "trace.h"
 #include "multifd.h"
@@ -719,6 +720,77 @@ out:
     return NULL;
 }
 
+static bool multifd_channel_connect(MultiFDSendParams *p,
+                                    QIOChannel *ioc,
+                                    Error *error);
+
+static void multifd_tls_outgoing_handshake(QIOTask *task,
+                                           gpointer opaque)
+{
+    MultiFDSendParams *p = opaque;
+    QIOChannel *ioc = QIO_CHANNEL(qio_task_get_source(task));
+    Error *err = NULL;
+
+    qio_task_propagate_error(task, &err);
+    multifd_channel_connect(p, ioc, err);
+}
+
+static void multifd_tls_channel_connect(MultiFDSendParams *p,
+                                        QIOChannel *ioc,
+                                        Error **errp)
+{
+    MigrationState *s = migrate_get_current();
+    const char *hostname = p->tls_hostname;
+    QIOChannelTLS *tioc;
+
+    tioc = migration_tls_client_create(s, ioc, hostname, errp);
+    if (!tioc) {
+        return;
+    }
+
+    qio_channel_set_name(QIO_CHANNEL(tioc), "multifd-tls-outgoing");
+    qio_channel_tls_handshake(tioc,
+                              multifd_tls_outgoing_handshake,
+                              p,
+                              NULL,
+                              NULL);
+
+}
+
+static bool multifd_channel_connect(MultiFDSendParams *p,
+                                    QIOChannel *ioc,
+                                    Error *error)
+{
+    MigrationState *s = migrate_get_current();
+
+    if (!error) {
+        if (s->parameters.tls_creds &&
+            *s->parameters.tls_creds &&
+            !object_dynamic_cast(OBJECT(ioc),
+                                 TYPE_QIO_CHANNEL_TLS)) {
+            multifd_tls_channel_connect(p, ioc, &error);
+            if (!error) {
+                /*
+                 * tls_channel_connect will call back to this
+                 * function after the TLS handshake,
+                 * so we mustn't call multifd_send_thread until then
+                 */
+                return false;
+            } else {
+                return true;
+            }
+        } else {
+            /* update for tls qio channel */
+            p->c = ioc;
+            qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
+                                   QEMU_THREAD_JOINABLE);
+       }
+       return false;
+    }
+
+    return true;
+}
+
 static void multifd_new_send_channel_cleanup(MultiFDSendParams *p,
                                              QIOChannel *ioc, Error *err)
 {
@@ -749,8 +821,9 @@ static void multifd_new_send_channel_async(QIOTask *task, gpointer opaque)
         p->c = QIO_CHANNEL(sioc);
         qio_channel_set_delay(p->c, false);
         p->running = true;
-        qemu_thread_create(&p->thread, p->name, multifd_send_thread, p,
-                           QEMU_THREAD_JOINABLE);
+        if (multifd_channel_connect(p, sioc, local_err)) {
+            goto cleanup;
+        }
         return;
     }
 
-- 
2.26.2


