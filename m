Return-Path: <SRS0=J7/p=6I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBB0C54FD0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 19:22:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 644DB20857
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2020 19:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P/7nO099"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 644DB20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jS3tl-00066R-BX
	for qemu-devel@archiver.kernel.org; Fri, 24 Apr 2020 15:22:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53020)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jS3sV-0003jv-9X
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 15:20:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jS3sQ-00047P-T4
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 15:20:47 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:37774
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jS3sQ-00045q-Et
 for qemu-devel@nongnu.org; Fri, 24 Apr 2020 15:20:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587756040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zGcQGQv7zwGHGWcukN+1+avvdcKa5eSElFpuJg26zW8=;
 b=P/7nO099HFEXPbABQFI/M5guWmeEQnKbDe5ed+oIcNccj8pUNAxzXlXv4pIC/QBUqtFJ0w
 i8QzyyZVjQzO3CpYvmtax9y8diyhnx736uscgJcnTijkFSEFOL2NUJhhWKEcOJAzew73Sx
 4yvagofrqYvE1I4NUTypHZMYzOR0xuQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-IOZPIz37MWaWNTbYOZcO3A-1; Fri, 24 Apr 2020 15:20:35 -0400
X-MC-Unique: IOZPIz37MWaWNTbYOZcO3A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 443E684B8A3;
 Fri, 24 Apr 2020 19:20:34 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F14BA5D715;
 Fri, 24 Apr 2020 19:20:33 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4C2CF11358C7; Fri, 24 Apr 2020 21:20:27 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 11/11] i386: Fix x86_cpu_load_model() error API violation
Date: Fri, 24 Apr 2020 21:20:27 +0200
Message-Id: <20200424192027.11404-12-armbru@redhat.com>
In-Reply-To: <20200424192027.11404-1-armbru@redhat.com>
References: <20200424192027.11404-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/24 15:11:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
index 90ffc5f3b1..3f09fd2321 100644
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


