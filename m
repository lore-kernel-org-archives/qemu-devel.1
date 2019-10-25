Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0EC6CA9EAF
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 02:29:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B668021928
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 02:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cTwAiM5k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B668021928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNpMM-0000oK-R0
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 22:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39503)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iNpIj-00022c-EB
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 22:26:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iNpIi-0007Z6-9D
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 22:26:05 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23169
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iNpIi-0007Yu-5M
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 22:26:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571970363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=skzxznZMQb+hQ2LViMb7cCRGTVd6o+H0baPEAle9Hp0=;
 b=cTwAiM5kiBeINnwU5mnAouJR3YTFcQuLWLZtS78DtHHFaI8alQjqyzjieS4QSMMqTDC0t2
 pUNQlqd0xtJ+z7oWEnrfUtIwIKl5i2fWDkmAuvNSy0FkinjuoE81rDJ3yBZJUSTd82r8y3
 I6Xc/rxWRft6BoCNBdkyvlHOJT0+tXI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-2IYdbWHlN9aWnwFL-cGtDg-1; Thu, 24 Oct 2019 22:26:00 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 448C647B;
 Fri, 25 Oct 2019 02:25:59 +0000 (UTC)
Received: from localhost (ovpn-116-62.gru2.redhat.com [10.97.116.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D0C91600C6;
 Fri, 25 Oct 2019 02:25:58 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/7] i386: Add default_version parameter to CPU version
 functions
Date: Thu, 24 Oct 2019 23:25:48 -0300
Message-Id: <20191025022553.25298-3-ehabkost@redhat.com>
In-Reply-To: <20191025022553.25298-1-ehabkost@redhat.com>
References: <20191025022553.25298-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 2IYdbWHlN9aWnwFL-cGtDg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Not all CPU version lookup code will use default_cpu_version:
we'll change query-cpu-definitions to optionally get a machine
type argument.  Make CPU version resolving functions get an
explicit default_version argument.

All callers are being changed to use default_cpu_version as
argument, so no behavior is being changed yet.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 5b7c5b1177..843f8c4b68 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3187,11 +3187,12 @@ static X86CPUVersion x86_cpu_model_last_version(con=
st X86CPUModel *model)
 }
=20
 /* Return the actual version being used for a specific CPU model */
-static X86CPUVersion x86_cpu_model_resolve_version(const X86CPUModel *mode=
l)
+static X86CPUVersion x86_cpu_model_resolve_version(const X86CPUModel *mode=
l,
+                                                   X86CPUVersion default_v=
ersion)
 {
     X86CPUVersion v =3D model->version;
     if (v =3D=3D CPU_VERSION_AUTO) {
-        v =3D default_cpu_version;
+        v =3D default_version;
     }
     if (v =3D=3D CPU_VERSION_LATEST) {
         return x86_cpu_model_last_version(model);
@@ -3958,14 +3959,15 @@ static char *x86_cpu_class_get_model_id(X86CPUClass=
 *xc)
     return r;
 }
=20
-static char *x86_cpu_class_get_alias_of(X86CPUClass *cc)
+static char *x86_cpu_class_get_alias_of(X86CPUClass *cc,
+                                        X86CPUVersion default_version)
 {
     X86CPUVersion version;
=20
     if (!cc->model || !cc->model->is_alias) {
         return NULL;
     }
-    version =3D x86_cpu_model_resolve_version(cc->model);
+    version =3D x86_cpu_model_resolve_version(cc->model, default_version);
     if (version <=3D 0) {
         return NULL;
     }
@@ -3978,7 +3980,7 @@ static void x86_cpu_list_entry(gpointer data, gpointe=
r user_data)
     X86CPUClass *cc =3D X86_CPU_CLASS(oc);
     g_autofree char *name =3D x86_cpu_class_get_model_name(cc);
     g_autofree char *desc =3D g_strdup(cc->model_description);
-    g_autofree char *alias_of =3D x86_cpu_class_get_alias_of(cc);
+    g_autofree char *alias_of =3D x86_cpu_class_get_alias_of(cc, default_c=
pu_version);
=20
     if (!desc && alias_of) {
         if (cc->model && cc->model->version =3D=3D CPU_VERSION_AUTO) {
@@ -4045,7 +4047,7 @@ static void x86_cpu_definition_entry(gpointer data, g=
pointer user_data)
      * doesn't break compatibility with previous QEMU versions.
      */
     if (default_cpu_version !=3D CPU_VERSION_LEGACY) {
-        info->alias_of =3D x86_cpu_class_get_alias_of(cc);
+        info->alias_of =3D x86_cpu_class_get_alias_of(cc, default_cpu_vers=
ion);
         info->has_alias_of =3D !!info->alias_of;
     }
=20
@@ -4116,7 +4118,7 @@ static void x86_cpu_apply_props(X86CPU *cpu, PropValu=
e *props)
 static void x86_cpu_apply_version_props(X86CPU *cpu, X86CPUModel *model)
 {
     const X86CPUVersionDefinition *vdef;
-    X86CPUVersion version =3D x86_cpu_model_resolve_version(model);
+    X86CPUVersion version =3D x86_cpu_model_resolve_version(model, default=
_cpu_version);
=20
     if (version =3D=3D CPU_VERSION_LEGACY) {
         return;
--=20
2.21.0


