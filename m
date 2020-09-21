Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F8BFC4727F
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 22:18:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E190923A63
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 22:18:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YM7Pvrmg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E190923A63
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKU8I-0007uB-K2
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 18:18:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58728)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKU1R-0007vN-9H
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 18:10:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44412)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKU1P-0001Wn-JO
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 18:10:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600726254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Y1M+ptRXUElShVbGc8t7tTmSRMjAYObK3+M0oAoHaqc=;
 b=YM7PvrmgBf1JUhSFOYv9SmXmIwoGdRDs7y8LYADUW/Jfx/GLOCK9fk56TeH6WrFzMSW8S3
 fKnP+/cTIJC+ZbgslOepiqrfts5k/J/wMpcPixt+REIs8OelihfhhZ2BuCgHsu9g7x5mI8
 7BUxnaODTzq4Ao8wFcxmrwCsH9RYa4E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-ou9enofSNpmTayuY1tI_yg-1; Mon, 21 Sep 2020 18:10:52 -0400
X-MC-Unique: ou9enofSNpmTayuY1tI_yg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D373425D0;
 Mon, 21 Sep 2020 22:10:51 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D581C7366D;
 Mon, 21 Sep 2020 22:10:50 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/24] rng-egd: Register "chardev" as class property
Date: Mon, 21 Sep 2020 18:10:24 -0400
Message-Id: <20200921221045.699690-4-ehabkost@redhat.com>
In-Reply-To: <20200921221045.699690-1-ehabkost@redhat.com>
References: <20200921221045.699690-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:44:53
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
 "Daniel P. Berrange" <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Class properties make QOM introspection simpler and easier, as
they don't require an object to be instantiated.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Laurent Vivier <lvivier@redhat.com>
Cc: Amit Shah <amit@kernel.org>
Cc: qemu-devel@nongnu.org
---
 backends/rng-egd.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/backends/rng-egd.c b/backends/rng-egd.c
index d905fe657c5..d3a8b1ebe2a 100644
--- a/backends/rng-egd.c
+++ b/backends/rng-egd.c
@@ -137,12 +137,6 @@ static char *rng_egd_get_chardev(Object *obj, Error **errp)
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
@@ -157,6 +151,8 @@ static void rng_egd_class_init(ObjectClass *klass, void *data)
 
     rbc->request_entropy = rng_egd_request_entropy;
     rbc->opened = rng_egd_opened;
+    object_class_property_add_str(klass, "chardev",
+                                  rng_egd_get_chardev, rng_egd_set_chardev);
 }
 
 static const TypeInfo rng_egd_info = {
@@ -164,7 +160,6 @@ static const TypeInfo rng_egd_info = {
     .parent = TYPE_RNG_BACKEND,
     .instance_size = sizeof(RngEgd),
     .class_init = rng_egd_class_init,
-    .instance_init = rng_egd_init,
     .instance_finalize = rng_egd_finalize,
 };
 
-- 
2.26.2


