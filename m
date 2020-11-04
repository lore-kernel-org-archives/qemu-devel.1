Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978A9C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 17:27:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D71120759
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 17:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W3/bvtJt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D71120759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaMYz-0003Lv-08
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 12:27:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60964)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kaMXe-0001XU-FN
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 12:25:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59259)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kaMXc-0008Km-Od
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 12:25:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604510748;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kwACAshq5NS9uT54H9fF11qSNq1GFrFnRwSqIb1jpDQ=;
 b=W3/bvtJtb/WNWBN+WopsT6FfJJgpjFOHpsM58J/GqnOuQ3hSfMwY+Y+kCv5nM+UgbNkIBo
 8Gos7E/61y9Be9UIx0EguHNseSTbWIpf624ljqU8XtfgdfUjkCaP2NWtXxrvwZfBvm2+0/
 dutgqZKRfUmqqGHCZ/yHf7SWJYkuTqo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-425-FPCIqXdGNmuW79xPauGz0Q-1; Wed, 04 Nov 2020 12:25:46 -0500
X-MC-Unique: FPCIqXdGNmuW79xPauGz0Q-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4144911BD343;
 Wed,  4 Nov 2020 17:25:45 +0000 (UTC)
Received: from localhost (ovpn-114-68.rdu2.redhat.com [10.10.114.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D0B8E5DA33;
 Wed,  4 Nov 2020 17:25:44 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/7] sparc: Use FIELD_PTR at nwindows getter/setter
Date: Wed,  4 Nov 2020 12:25:12 -0500
Message-Id: <20201104172512.2381656-8-ehabkost@redhat.com>
In-Reply-To: <20201104172512.2381656-1-ehabkost@redhat.com>
References: <20201104172512.2381656-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This makes the nwindows getter and setter more consistent with
the other field getters and setters (which work with any struct
field).

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Artyom Tarasenko <atar4qemu@gmail.com>
Cc: qemu-devel@nongnu.org
---
 target/sparc/cpu.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
index 3acc99c29c..8bf02a4fe0 100644
--- a/target/sparc/cpu.c
+++ b/target/sparc/cpu.c
@@ -789,8 +789,8 @@ static void sparc_cpu_initfn(Object *obj)
 static void sparc_get_nwindows(Object *obj, Visitor *v, const char *name,
                                Property *prop, Error **errp)
 {
-    SPARCCPU *cpu = SPARC_CPU(obj);
-    int64_t value = cpu->env.def.nwindows;
+    uint32_t *ptr = FIELD_PTR(obj, prop, uint32_t);
+    int64_t value = *ptr;
 
     visit_type_int(v, name, &value, errp);
 }
@@ -798,9 +798,9 @@ static void sparc_get_nwindows(Object *obj, Visitor *v, const char *name,
 static void sparc_set_nwindows(Object *obj, Visitor *v, const char *name,
                                Property *prop, Error **errp)
 {
+    uint32_t *ptr = FIELD_PTR(obj, prop, uint32_t);
     const int64_t min = MIN_NWINDOWS;
     const int64_t max = MAX_NWINDOWS;
-    SPARCCPU *cpu = SPARC_CPU(obj);
     int64_t value;
 
     if (!visit_type_int(v, name, &value, errp)) {
@@ -814,7 +814,7 @@ static void sparc_set_nwindows(Object *obj, Visitor *v, const char *name,
                    value, min, max);
         return;
     }
-    cpu->env.def.nwindows = value;
+    *ptr = value;
 }
 
 static PropertyInfo qdev_prop_nwindows = {
-- 
2.28.0


