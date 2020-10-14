Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD0FEC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 14:52:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B3AA212CC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 14:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JKiGvbia"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B3AA212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSi99-0004ni-06
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 10:52:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kShrE-0001BM-Kd
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 10:34:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57316)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kShrB-00062Z-E9
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 10:34:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602686060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3tMEFGxyFYtBVTNUpmi0qNYLG6xfsDcVqxV2LYJGW48=;
 b=JKiGvbiatEd3mkxyQPUN3SQJj+Grk/6b30QoF4Tg9E7c0+solGhy41iQwKNxBUK5xKrFmu
 +PK8eOIuWb9UPa5l8i8FvFSvYfsJyKnBlA52Ua4BhW5u+ZmHPJUVEeHb758pcurcuwMhqF
 BdHsmGQr8/bBohX2aUnD+AzdcP2KeX4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-LO7Jy7b-MSqIiehE6WbZJg-1; Wed, 14 Oct 2020 10:34:17 -0400
X-MC-Unique: LO7Jy7b-MSqIiehE6WbZJg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C632FD688E;
 Wed, 14 Oct 2020 14:34:16 +0000 (UTC)
Received: from localhost (ovpn-66-44.rdu2.redhat.com [10.10.66.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9402360C0F;
 Wed, 14 Oct 2020 14:34:16 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 01/10] rng-egd: Register "chardev" as class property
Date: Wed, 14 Oct 2020 10:34:06 -0400
Message-Id: <20201014143415.240472-2-ehabkost@redhat.com>
In-Reply-To: <20201014143415.240472-1-ehabkost@redhat.com>
References: <20201014143415.240472-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:37:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Class properties make QOM introspection simpler and easier, as
they don't require an object to be instantiated.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Message-Id: <20200921221045.699690-4-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 backends/rng-egd.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/backends/rng-egd.c b/backends/rng-egd.c
index 20198ff26e..4de142b9dc 100644
--- a/backends/rng-egd.c
+++ b/backends/rng-egd.c
@@ -135,12 +135,6 @@ static char *rng_egd_get_chardev(Object *obj, Error **errp)
     return NULL;
 }
 
-static void rng_egd_init(Object *obj)
-{
-    object_property_add_str(obj, "chardev",
-                            rng_egd_get_chardev, rng_egd_set_chardev);
-}
-
 static void rng_egd_finalize(Object *obj)
 {
     RngEgd *s = RNG_EGD(obj);
@@ -155,6 +149,8 @@ static void rng_egd_class_init(ObjectClass *klass, void *data)
 
     rbc->request_entropy = rng_egd_request_entropy;
     rbc->opened = rng_egd_opened;
+    object_class_property_add_str(klass, "chardev",
+                                  rng_egd_get_chardev, rng_egd_set_chardev);
 }
 
 static const TypeInfo rng_egd_info = {
@@ -162,7 +158,6 @@ static const TypeInfo rng_egd_info = {
     .parent = TYPE_RNG_BACKEND,
     .instance_size = sizeof(RngEgd),
     .class_init = rng_egd_class_init,
-    .instance_init = rng_egd_init,
     .instance_finalize = rng_egd_finalize,
 };
 
-- 
2.28.0


