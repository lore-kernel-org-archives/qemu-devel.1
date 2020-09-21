Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A36CFC4727D
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 22:20:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A63A23A1D
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 22:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LecBx23u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A63A23A1D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKUAt-0002vQ-7r
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 18:20:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58730)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKU1R-0007ve-GK
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 18:10:57 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:22274
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKU1P-0001Wj-VL
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 18:10:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600726254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=23B5K5m+Q8GWGZkZrurk62Tue8RrQxz9GY5WVWnQk5c=;
 b=LecBx23uUWQqhDtj561KJRj1oLJozlIx1SqKXrmcpEA3EgYjoB3yZ960PmLmYoivAsXMZ5
 hA8O4BUvPpGR0foXd5rAN4Yu8lIvaANmBT0jYNKW+EGEQZ1wuUELSD+iwmdtIEX8Po2mHv
 y/pcjs+xgS4NMLINZAiStlA0QgNRP4w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-582-vDD9ewllPVGxrmOHWWTSvw-1; Mon, 21 Sep 2020 18:10:53 -0400
X-MC-Unique: vDD9ewllPVGxrmOHWWTSvw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 325B1909CA6;
 Mon, 21 Sep 2020 22:10:52 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EF6E760BFA;
 Mon, 21 Sep 2020 22:10:51 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 04/24] rng-random: register "filename" as class property
Date: Mon, 21 Sep 2020 18:10:25 -0400
Message-Id: <20200921221045.699690-5-ehabkost@redhat.com>
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
Received-SPF: pass client-ip=205.139.110.61; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 16:17:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
 backends/rng-random.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/backends/rng-random.c b/backends/rng-random.c
index 245b12ab245..7add272eddd 100644
--- a/backends/rng-random.c
+++ b/backends/rng-random.c
@@ -108,10 +108,6 @@ static void rng_random_init(Object *obj)
 {
     RngRandom *s = RNG_RANDOM(obj);
 
-    object_property_add_str(obj, "filename",
-                            rng_random_get_filename,
-                            rng_random_set_filename);
-
     s->filename = g_strdup("/dev/urandom");
     s->fd = -1;
 }
@@ -134,6 +130,10 @@ static void rng_random_class_init(ObjectClass *klass, void *data)
 
     rbc->request_entropy = rng_random_request_entropy;
     rbc->opened = rng_random_opened;
+    object_class_property_add_str(klass, "filename",
+                                  rng_random_get_filename,
+                                  rng_random_set_filename);
+
 }
 
 static const TypeInfo rng_random_info = {
-- 
2.26.2


