Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28686C47247
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:22:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0C5D20675
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 10:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cGSEp5We"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0C5D20675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVuiS-0000eL-1s
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 06:22:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jVufY-0003oR-H5
 for qemu-devel@nongnu.org; Tue, 05 May 2020 06:19:20 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32517
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jVufV-00081w-2D
 for qemu-devel@nongnu.org; Tue, 05 May 2020 06:19:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588673956;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/VuGCwxJ3g4opaKqs7sv6lCxXcUwA/OOYtx/5XTHJeA=;
 b=cGSEp5We7WypB0f2ypMCkiiryLmjGt0NkiBQIcFFq7P0oEs8vqQYD0rvPjDDUsKmPnVJjG
 I9S+l6d5YZmWYJt+wakD13LhDEc0LzjPCjaChYbQ/MDDb7ukhRsIcAEBcIzxnBJl6i38Xa
 WngMKtJNcZiG0J3QUIOvxx/4WoMWxuM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-160-VZtceZIwM2ukyuyKV2PsnQ-1; Tue, 05 May 2020 06:19:14 -0400
X-MC-Unique: VZtceZIwM2ukyuyKV2PsnQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89BED835B40;
 Tue,  5 May 2020 10:19:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4E68B63F9B;
 Tue,  5 May 2020 10:19:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E43CC11358C6; Tue,  5 May 2020 12:19:08 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 10/10] i386: Fix x86_cpu_load_model() error API violation
Date: Tue,  5 May 2020 12:19:08 +0200
Message-Id: <20200505101908.6207-11-armbru@redhat.com>
In-Reply-To: <20200505101908.6207-1-armbru@redhat.com>
References: <20200505101908.6207-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
---
 target/i386/cpu.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9c256ab159..16ed95e8da 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5078,7 +5078,7 @@ static void x86_cpu_apply_version_props(X86CPU *cpu, =
X86CPUModel *model)
=20
 /* Load data from X86CPUDefinition into a X86CPU object
  */
-static void x86_cpu_load_model(X86CPU *cpu, X86CPUModel *model, Error **er=
rp)
+static void x86_cpu_load_model(X86CPU *cpu, X86CPUModel *model)
 {
     X86CPUDefinition *def =3D model->cpudef;
     CPUX86State *env =3D &cpu->env;
@@ -5092,13 +5092,19 @@ static void x86_cpu_load_model(X86CPU *cpu, X86CPUM=
odel *model, Error **errp)
      */
=20
     /* CPU models only set _minimum_ values for level/xlevel: */
-    object_property_set_uint(OBJECT(cpu), def->level, "min-level", errp);
-    object_property_set_uint(OBJECT(cpu), def->xlevel, "min-xlevel", errp)=
;
+    object_property_set_uint(OBJECT(cpu), def->level, "min-level",
+                             &error_abort);
+    object_property_set_uint(OBJECT(cpu), def->xlevel, "min-xlevel",
+                             &error_abort);
=20
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
     for (w =3D 0; w < FEATURE_WORDS; w++) {
         env->features[w] =3D def->features[w];
     }
@@ -5135,7 +5141,8 @@ static void x86_cpu_load_model(X86CPU *cpu, X86CPUMod=
el *model, Error **errp)
         vendor =3D host_vendor;
     }
=20
-    object_property_set_str(OBJECT(cpu), vendor, "vendor", errp);
+    object_property_set_str(OBJECT(cpu), vendor, "vendor",
+                            &error_abort);
=20
     x86_cpu_apply_version_props(cpu, model);
 }
@@ -6981,7 +6988,7 @@ static void x86_cpu_initfn(Object *obj)
     object_property_add_alias(obj, "sse4_2", obj, "sse4.2", &error_abort);
=20
     if (xcc->model) {
-        x86_cpu_load_model(cpu, xcc->model, &error_abort);
+        x86_cpu_load_model(cpu, xcc->model);
     }
 }
=20
--=20
2.21.1


