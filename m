Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3349FC4727D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:29:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4B4C20B1F
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I/t0F/KX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4B4C20B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKqnK-0004hS-SK
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 18:29:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55490)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKqjV-00085D-Ny
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:25:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:38726)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKqjR-0006GJ-PH
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:25:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600813550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zdEAwkWXGaIslq9BgQ9voSgKZZw+SQC6QvEj70bS2Xw=;
 b=I/t0F/KXTfiCfnCLhfdx/kwsqTKyge7KtsA+Xx2yCVOIDuXCIB7N6n+0cpCbf+sw5d1V4p
 ctQS4s8gFD0jacz1d4qZfoUp7CU8fK1LLDdGiaZEWChHz4wwPxV4qWZE1E7cSGnoa8r/0a
 B+v8BucgfvQGP/xNdwOukrasB6tBG7g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-431-un9vauJ4OXawpmEjA0_RmA-1; Tue, 22 Sep 2020 18:25:48 -0400
X-MC-Unique: un9vauJ4OXawpmEjA0_RmA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 331691084D6F;
 Tue, 22 Sep 2020 22:25:47 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C437E10013DB;
 Tue, 22 Sep 2020 22:25:46 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 03/11] cryptodev-vhost-user: Register "chardev" as class
 property
Date: Tue, 22 Sep 2020 18:25:34 -0400
Message-Id: <20200922222542.2354748-4-ehabkost@redhat.com>
In-Reply-To: <20200922222542.2354748-1-ehabkost@redhat.com>
References: <20200922222542.2354748-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 15:47:47
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gonglei <arei.gonglei@huawei.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Class properties make QOM introspection simpler and easier, as
they don't require an object to be instantiated.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Gonglei <arei.gonglei@huawei.com>
Message-Id: <20200921221045.699690-2-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 backends/cryptodev-vhost-user.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-user.c
index 60ec4908aa1..e1df073de2d 100644
--- a/backends/cryptodev-vhost-user.c
+++ b/backends/cryptodev-vhost-user.c
@@ -334,13 +334,6 @@ cryptodev_vhost_user_get_chardev(Object *obj, Error **errp)
     return NULL;
 }
 
-static void cryptodev_vhost_user_instance_int(Object *obj)
-{
-    object_property_add_str(obj, "chardev",
-                            cryptodev_vhost_user_get_chardev,
-                            cryptodev_vhost_user_set_chardev);
-}
-
 static void cryptodev_vhost_user_finalize(Object *obj)
 {
     CryptoDevBackendVhostUser *s =
@@ -361,13 +354,17 @@ cryptodev_vhost_user_class_init(ObjectClass *oc, void *data)
     bc->create_session = cryptodev_vhost_user_sym_create_session;
     bc->close_session = cryptodev_vhost_user_sym_close_session;
     bc->do_sym_op = NULL;
+
+    object_class_property_add_str(oc, "chardev",
+                                  cryptodev_vhost_user_get_chardev,
+                                  cryptodev_vhost_user_set_chardev);
+
 }
 
 static const TypeInfo cryptodev_vhost_user_info = {
     .name = TYPE_CRYPTODEV_BACKEND_VHOST_USER,
     .parent = TYPE_CRYPTODEV_BACKEND,
     .class_init = cryptodev_vhost_user_class_init,
-    .instance_init = cryptodev_vhost_user_instance_int,
     .instance_finalize = cryptodev_vhost_user_finalize,
     .instance_size = sizeof(CryptoDevBackendVhostUser),
 };
-- 
2.26.2


