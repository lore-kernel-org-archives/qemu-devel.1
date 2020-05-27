Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944C0C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 06:01:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C8B520787
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 06:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H61GpkQB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C8B520787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdp8W-0004e7-Hy
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 02:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jdp6Y-0002aF-NQ
 for qemu-devel@nongnu.org; Wed, 27 May 2020 01:59:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28327
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jdp6X-0004Eb-OL
 for qemu-devel@nongnu.org; Wed, 27 May 2020 01:59:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590559192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zFFO/S/9pY3J4o3RTDNJU5p3lZ1X88+VrmeEvaoB8Ko=;
 b=H61GpkQBbRv4/F9VPwjAZdyot7WQamiQmAwghGhsGJaASQCZW0DxC9JtX07XE1sw5p9Q0b
 iXpPmsazQ3/+Q9zXncYYT+X80Fy1ZN4d2BkRf4JyZfLo6ebYqklbmxwY9zKbLhE4wKkfkX
 HWjcRAFeJrdafLoiBDJVFagGtTXienQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-HrUoReIqOwOxSQu-d5kPgQ-1; Wed, 27 May 2020 01:59:50 -0400
X-MC-Unique: HrUoReIqOwOxSQu-d5kPgQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A5F21855A01;
 Wed, 27 May 2020 05:59:49 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A7675D9EF;
 Wed, 27 May 2020 05:59:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0BAFB11358C2; Wed, 27 May 2020 07:59:46 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/10] i386: Fix x86_cpu_load_model() error API violation
Date: Wed, 27 May 2020 07:59:45 +0200
Message-Id: <20200527055945.6774-11-armbru@redhat.com>
In-Reply-To: <20200527055945.6774-1-armbru@redhat.com>
References: <20200527055945.6774-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 00:49:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Error ** argument must be NULL, &error_abort, &error_fatal, or a
pointer to a variable containing NULL.  Passing an argument of the
latter kind twice without clearing it in between is wrong: if the
first call sets an error, it no longer points to NULL for the second
call.

x86_cpu_load_model() is wrong that way.  Harmless, because its @errp
is always &error_abort.  To fix, cut out the @errp middleman.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200505101908.6207-11-armbru@redhat.com>
---
 target/i386/cpu.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 7a4a8e3847..3733d9a279 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5078,7 +5078,7 @@ static void x86_cpu_apply_version_props(X86CPU *cpu, X86CPUModel *model)
 
 /* Load data from X86CPUDefinition into a X86CPU object
  */
-static void x86_cpu_load_model(X86CPU *cpu, X86CPUModel *model, Error **errp)
+static void x86_cpu_load_model(X86CPU *cpu, X86CPUModel *model)
 {
     X86CPUDefinition *def = model->cpudef;
     CPUX86State *env = &cpu->env;
@@ -5092,13 +5092,19 @@ static void x86_cpu_load_model(X86CPU *cpu, X86CPUModel *model, Error **errp)
      */
 
     /* CPU models only set _minimum_ values for level/xlevel: */
-    object_property_set_uint(OBJECT(cpu), def->level, "min-level", errp);
-    object_property_set_uint(OBJECT(cpu), def->xlevel, "min-xlevel", errp);
+    object_property_set_uint(OBJECT(cpu), def->level, "min-level",
+                             &error_abort);
+    object_property_set_uint(OBJECT(cpu), def->xlevel, "min-xlevel",
+                             &error_abort);
 
-    object_property_set_int(OBJECT(cpu), def->family, "family", errp);
-    object_property_set_int(OBJECT(cpu), def->model, "model", errp);
-    object_property_set_int(OBJECT(cpu), def->stepping, "stepping", errp);
-    object_property_set_str(OBJECT(cpu), def->model_id, "model-id", errp);
+    object_property_set_int(OBJECT(cpu), def->family, "family",
+                            &error_abort);
+    object_property_set_int(OBJECT(cpu), def->model, "model",
+                            &error_abort);
+    object_property_set_int(OBJECT(cpu), def->stepping, "stepping",
+                            &error_abort);
+    object_property_set_str(OBJECT(cpu), def->model_id, "model-id",
+                            &error_abort);
     for (w = 0; w < FEATURE_WORDS; w++) {
         env->features[w] = def->features[w];
     }
@@ -5135,7 +5141,8 @@ static void x86_cpu_load_model(X86CPU *cpu, X86CPUModel *model, Error **errp)
         vendor = host_vendor;
     }
 
-    object_property_set_str(OBJECT(cpu), vendor, "vendor", errp);
+    object_property_set_str(OBJECT(cpu), vendor, "vendor",
+                            &error_abort);
 
     x86_cpu_apply_version_props(cpu, model);
 }
@@ -6975,7 +6982,7 @@ static void x86_cpu_initfn(Object *obj)
     object_property_add_alias(obj, "sse4_2", obj, "sse4.2");
 
     if (xcc->model) {
-        x86_cpu_load_model(cpu, xcc->model, &error_abort);
+        x86_cpu_load_model(cpu, xcc->model);
     }
 }
 
-- 
2.21.3


