Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6EEC4727D
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 22:15:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8175523A1B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 22:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dcZetXI7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8175523A1B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKU5X-0004JG-FL
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 18:15:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58698)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKU1P-0007tC-EZ
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 18:10:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60547)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKU1N-0001W3-S1
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 18:10:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600726253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jvXtzMDBmKU/rJx6CSPHzlbVRTQHljGXv5cU8mvsngI=;
 b=dcZetXI7ZCAIGXm1um/IHRR6XSJGD+R1HR0DM7Gp/HCh/UhWuue0UNQzY+kC7EHfycG6gZ
 NJOPER92rK3WVI2Y9tKVGz+EhMEfSxMRCI/NnbX3KI3cPMQfV1KX3wE+e2wdfRjFL9A7Hi
 oLFE1/gqiuJFnpN9mx7Cl8DTv3LLS6Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-75-pD2WeKkINNmOj_yyw5qf5A-1; Mon, 21 Sep 2020 18:10:51 -0400
X-MC-Unique: pD2WeKkINNmOj_yyw5qf5A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1F4EC1007464;
 Mon, 21 Sep 2020 22:10:50 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A34CB60BFA;
 Mon, 21 Sep 2020 22:10:49 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/24] cryptodev-backend: Register "chardev" as class property
Date: Mon, 21 Sep 2020 18:10:23 -0400
Message-Id: <20200921221045.699690-3-ehabkost@redhat.com>
In-Reply-To: <20200921221045.699690-1-ehabkost@redhat.com>
References: <20200921221045.699690-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:43:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Gonglei \(Arei\)" <arei.gonglei@huawei.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Class properties make QOM introspection simpler and easier, as
they don't require an object to be instantiated.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: qemu-devel@nongnu.org
---
 backends/cryptodev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/backends/cryptodev.c b/backends/cryptodev.c
index ada4ebe78b1..3f141f61ed6 100644
--- a/backends/cryptodev.c
+++ b/backends/cryptodev.c
@@ -206,10 +206,6 @@ cryptodev_backend_can_be_deleted(UserCreatable *uc)
 
 static void cryptodev_backend_instance_init(Object *obj)
 {
-    object_property_add(obj, "queues", "uint32",
-                          cryptodev_backend_get_queues,
-                          cryptodev_backend_set_queues,
-                          NULL, NULL);
     /* Initialize devices' queues property to 1 */
     object_property_set_int(obj, "queues", 1, NULL);
 }
@@ -230,6 +226,10 @@ cryptodev_backend_class_init(ObjectClass *oc, void *data)
     ucc->can_be_deleted = cryptodev_backend_can_be_deleted;
 
     QTAILQ_INIT(&crypto_clients);
+    object_class_property_add(oc, "queues", "uint32",
+                              cryptodev_backend_get_queues,
+                              cryptodev_backend_set_queues,
+                              NULL, NULL);
 }
 
 static const TypeInfo cryptodev_backend_info = {
-- 
2.26.2


