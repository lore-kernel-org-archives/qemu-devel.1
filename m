Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4D78CA9EAF
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 02:57:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9622C21929
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 02:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bBoQ3qJi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9622C21929
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNpnL-00045I-No
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 22:57:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43420)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1iNpmN-0002t5-Ff
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 22:56:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1iNpmK-00029G-3L
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 22:56:42 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:23074
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1iNpmJ-000293-VU
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 22:56:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571972198;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=73BawrUYc6aNHsvAvATVMrBAuwEni3+WEcPmsgQDF4M=;
 b=bBoQ3qJiG8pcTKzV15CCvr37ZMQSnSNQul4wbuNk71agAsLev5fH7O+jx1DciNWGQ5qZVM
 SK5mCvhMQfv8ONIYvoaXt7+0flPAtJ90QCRgKFc0pGobPfcgJz9AHSgOecmy9Y5uKxKJxh
 lwibf4ITqp+shNrhwxvXkqDXIAkCqM0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-SXRKXMEqPWe4VfN3Mor4Uw-1; Thu, 24 Oct 2019 22:56:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DB3E80183D;
 Fri, 25 Oct 2019 02:56:34 +0000 (UTC)
Received: from localhost (ovpn-116-62.gru2.redhat.com [10.97.116.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A2FB6608C1;
 Fri, 25 Oct 2019 02:56:33 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] i386: Use g_autofree in a few places
Date: Thu, 24 Oct 2019 23:56:32 -0300
Message-Id: <20191025025632.5928-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: SXRKXMEqPWe4VfN3Mor4Uw-1
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Get rid of 12 explicit g_free() calls.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 41 +++++++++++++----------------------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 0de8a22e1e..59b7aaf580 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1671,11 +1671,8 @@ static char *x86_cpu_type_name(const char *model_nam=
e)
=20
 static ObjectClass *x86_cpu_class_by_name(const char *cpu_model)
 {
-    ObjectClass *oc;
-    char *typename =3D x86_cpu_type_name(cpu_model);
-    oc =3D object_class_by_name(typename);
-    g_free(typename);
-    return oc;
+    g_autofree char *typename =3D x86_cpu_type_name(cpu_model);
+    return object_class_by_name(typename);
 }
=20
 static char *x86_cpu_class_get_model_name(X86CPUClass *cc)
@@ -3407,7 +3404,6 @@ static void mark_unavailable_features(X86CPU *cpu, Fe=
atureWord w, uint64_t mask,
     CPUX86State *env =3D &cpu->env;
     FeatureWordInfo *f =3D &feature_word_info[w];
     int i;
-    char *feat_word_str;
=20
     if (!cpu->force_features) {
         env->features[w] &=3D ~mask;
@@ -3420,13 +3416,12 @@ static void mark_unavailable_features(X86CPU *cpu, =
FeatureWord w, uint64_t mask,
=20
     for (i =3D 0; i < 64; ++i) {
         if ((1ULL << i) & mask) {
-            feat_word_str =3D feature_word_description(f, i);
+            g_autofree char *feat_word_str =3D feature_word_description(f,=
 i);
             warn_report("%s: %s%s%s [bit %d]",
                         verbose_prefix,
                         feat_word_str,
                         f->feat_names[i] ? "." : "",
                         f->feat_names[i] ? f->feat_names[i] : "", i);
-            g_free(feat_word_str);
         }
     }
 }
@@ -3928,17 +3923,14 @@ static gint x86_cpu_list_compare(gconstpointer a, g=
constpointer b)
     ObjectClass *class_b =3D (ObjectClass *)b;
     X86CPUClass *cc_a =3D X86_CPU_CLASS(class_a);
     X86CPUClass *cc_b =3D X86_CPU_CLASS(class_b);
-    char *name_a, *name_b;
     int ret;
=20
     if (cc_a->ordering !=3D cc_b->ordering) {
         ret =3D cc_a->ordering - cc_b->ordering;
     } else {
-        name_a =3D x86_cpu_class_get_model_name(cc_a);
-        name_b =3D x86_cpu_class_get_model_name(cc_b);
+        g_autofree char *name_a =3D x86_cpu_class_get_model_name(cc_a);
+        g_autofree char *name_b =3D x86_cpu_class_get_model_name(cc_b);
         ret =3D strcmp(name_a, name_b);
-        g_free(name_a);
-        g_free(name_b);
     }
     return ret;
 }
@@ -3976,9 +3968,9 @@ static void x86_cpu_list_entry(gpointer data, gpointe=
r user_data)
 {
     ObjectClass *oc =3D data;
     X86CPUClass *cc =3D X86_CPU_CLASS(oc);
-    char *name =3D x86_cpu_class_get_model_name(cc);
-    char *desc =3D g_strdup(cc->model_description);
-    char *alias_of =3D x86_cpu_class_get_alias_of(cc);
+    g_autofree char *name =3D x86_cpu_class_get_model_name(cc);
+    g_autofree char *desc =3D g_strdup(cc->model_description);
+    g_autofree char *alias_of =3D x86_cpu_class_get_alias_of(cc);
=20
     if (!desc && alias_of) {
         if (cc->model && cc->model->version =3D=3D CPU_VERSION_AUTO) {
@@ -3992,9 +3984,6 @@ static void x86_cpu_list_entry(gpointer data, gpointe=
r user_data)
     }
=20
     qemu_printf("x86 %-20s  %-48s\n", name, desc);
-    g_free(name);
-    g_free(desc);
-    g_free(alias_of);
 }
=20
 /* list available CPU models and flags */
@@ -4433,7 +4422,7 @@ static void x86_cpu_cpudef_class_init(ObjectClass *oc=
, void *data)
=20
 static void x86_register_cpu_model_type(const char *name, X86CPUModel *mod=
el)
 {
-    char *typename =3D x86_cpu_type_name(name);
+    g_autofree char *typename =3D x86_cpu_type_name(name);
     TypeInfo ti =3D {
         .name =3D typename,
         .parent =3D TYPE_X86_CPU,
@@ -4442,14 +4431,12 @@ static void x86_register_cpu_model_type(const char =
*name, X86CPUModel *model)
     };
=20
     type_register(&ti);
-    g_free(typename);
 }
=20
 static void x86_register_cpudef_types(X86CPUDefinition *def)
 {
     X86CPUModel *m;
     const X86CPUVersionDefinition *vdef;
-    char *name;
=20
     /* AMD aliases are handled at runtime based on CPUID vendor, so
      * they shouldn't be set on the CPU model table.
@@ -4469,11 +4456,11 @@ static void x86_register_cpudef_types(X86CPUDefinit=
ion *def)
=20
     for (vdef =3D x86_cpu_def_get_versions(def); vdef->version; vdef++) {
         X86CPUModel *m =3D g_new0(X86CPUModel, 1);
+        g_autofree char *name =3D
+            x86_cpu_versioned_model_name(def, vdef->version);
         m->cpudef =3D def;
         m->version =3D vdef->version;
-        name =3D x86_cpu_versioned_model_name(def, vdef->version);
         x86_register_cpu_model_type(name, m);
-        g_free(name);
=20
         if (vdef->alias) {
             X86CPUModel *am =3D g_new0(X86CPUModel, 1);
@@ -5545,9 +5532,8 @@ static void x86_cpu_realizefn(DeviceState *dev, Error=
 **errp)
=20
     if (xcc->host_cpuid_required) {
         if (!accel_uses_host_cpuid()) {
-            char *name =3D x86_cpu_class_get_model_name(xcc);
+            g_autofree char *name =3D x86_cpu_class_get_model_name(xcc);
             error_setg(&local_err, "CPU model '%s' requires KVM", name);
-            g_free(name);
             goto out;
         }
=20
@@ -5663,10 +5649,9 @@ static void x86_cpu_realizefn(DeviceState *dev, Erro=
r **errp)
     /* Cache information initialization */
     if (!cpu->legacy_cache) {
         if (!xcc->model || !xcc->model->cpudef->cache_info) {
-            char *name =3D x86_cpu_class_get_model_name(xcc);
+            g_autofree char *name =3D x86_cpu_class_get_model_name(xcc);
             error_setg(errp,
                        "CPU model '%s' doesn't support legacy-cache=3Doff"=
, name);
-            g_free(name);
             return;
         }
         env->cache_info_cpuid2 =3D env->cache_info_cpuid4 =3D env->cache_i=
nfo_amd =3D
--=20
2.21.0


