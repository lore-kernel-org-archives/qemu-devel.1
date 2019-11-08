Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0C0C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 11:08:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A0B5206BA
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 11:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L3VIdnE7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A0B5206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52446 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT27t-0002Pw-7V
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 06:08:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58026)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iT275-0001OF-JH
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:07:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iT273-0007X5-Rv
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:07:35 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:36727
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iT273-0007Wq-Ho
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 06:07:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573211253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Qs0wfT67g8m1YAIfOzW7By2Klybg7xnOHdIWRU8Z9g=;
 b=L3VIdnE7JSKy7/cuPA3l68qF7ucMnEpXb7YZZGORta6Oa979Fdt8W8Q9R3u1ZMpRfBFHBN
 o97eKkLky6NPugZBu1JfGI6mgnaLcQAshEu+c+B2rD89X8yU8HOoN4XuFAlF1g2SPjqBj4
 tN3Elrko9QDJMpNUHBohNSgEbAceFYQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-297-4Ez46kfFNgu4nJvGRyQn7g-1; Fri, 08 Nov 2019 06:07:29 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8559A107ACC3;
 Fri,  8 Nov 2019 11:07:28 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.2])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CEA095DA70;
 Fri,  8 Nov 2019 11:07:25 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 2/2] s390x/cpumodel: Introduce "best" model variants
Date: Fri,  8 Nov 2019 12:07:14 +0100
Message-Id: <20191108110714.7475-3-david@redhat.com>
In-Reply-To: <20191108110714.7475-1-david@redhat.com>
References: <20191108110714.7475-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 4Ez46kfFNgu4nJvGRyQn7g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>, David Hildenbrand <david@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Michael Mueller <mimu@linux.ibm.com>, Jiri Denemark <jdenemar@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

For a specific CPU model, we have a lot of feature variability depending on
- The microcode version of the HW
- The hypervisor we're running on (LPAR vs. KVM vs. z/VM)
- The hypervisor version we're running on
- The KVM version
- KVM module parameters (especially, "nested=3D1")
- The accelerator

Our default models are migration safe, however can only be changed
between QEMU releases (glued to QEMU machine). This somewhat collides
with the feature variability we have. E.g., the z13 model will not run
under TCG. There is the demand from higher levels in the stack to "have the
best CPU model possible on a given accelerator, firmware and HW", which
should especially include all features that fix security issues.
Especially, if we have a new feature due to a security flaw, we want to
have a way to backport this feature to older QEMU versions and a way to
automatically enable it when asked.

This is where "best" CPU models come into play. If upper layers specify
"z14-best" on a z14, they will get the best possible feature set in that
configuration. "best" usually means "maximum features", besides deprecated
features. This will then, for example, include nested virtualization
("SIE" feature) when KVM+HW support is enabled, or fixes via
microcode updates (e.g., spectre)

"best" models are not migration safe. Upper layers can expand these
models to migration-safe and static variants, allowing them to be
migrated.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu-qom.h    |  1 +
 target/s390x/cpu_models.c | 96 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 95 insertions(+), 2 deletions(-)

diff --git a/target/s390x/cpu-qom.h b/target/s390x/cpu-qom.h
index b809ec8418..73901d1410 100644
--- a/target/s390x/cpu-qom.h
+++ b/target/s390x/cpu-qom.h
@@ -52,6 +52,7 @@ typedef struct S390CPUClass {
     bool kvm_required;
     bool is_static;
     bool is_migration_safe;
+    bool is_best;
     const char *desc;
=20
     DeviceRealize parent_realize;
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index 57c06e5ea1..a379b4c15d 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -557,11 +557,16 @@ static void cpu_model_from_info(S390CPUModel *model, =
const CpuModelInfo *info,
     obj =3D object_new(object_class_get_name(oc));
     cpu =3D S390_CPU(obj);
=20
-    if (!cpu->model) {
+    if (!cpu->model && !S390_CPU_CLASS(oc)->is_best) {
         error_setg(errp, "Details about the host CPU model are not availab=
le, "
                          "it cannot be used.");
         object_unref(obj);
         return;
+    } else if (!cpu->model) {
+        error_setg(errp, "There is not best CPU model that is runnable,"
+                         "therefore, it cannot be used.");
+        object_unref(obj);
+        return;
     }
=20
     if (qdict) {
@@ -932,7 +937,7 @@ void s390_realize_cpu_model(CPUState *cs, Error **errp)
         return;
     }
=20
-    if (!cpu->model) {
+    if (!cpu->model && !xcc->is_best) {
         /* no host model support -> perform compatibility stuff */
         apply_cpu_model(NULL, errp);
         return;
@@ -944,6 +949,11 @@ void s390_realize_cpu_model(CPUState *cs, Error **errp=
)
         return;
     }
=20
+    if (xcc->is_best && !cpu->model) {
+        error_setg(errp, "Selected CPU model is too new.");
+        return;
+    }
+
     /* copy over properties that can vary */
     cpu->model->lowest_ibc =3D max_model->lowest_ibc;
     cpu->model->cpu_id =3D max_model->cpu_id;
@@ -1156,6 +1166,58 @@ static void s390_qemu_cpu_model_initfn(Object *obj)
     memcpy(cpu->model, &s390_qemu_cpu_model, sizeof(*cpu->model));
 }
=20
+static void s390_best_cpu_model_initfn(Object *obj)
+{
+    const S390CPUModel *max_model;
+    S390CPU *cpu =3D S390_CPU(obj);
+    S390CPUClass *xcc =3D S390_CPU_GET_CLASS(cpu);
+    Error *local_err =3D NULL;
+    int i;
+
+    if (kvm_enabled() && !kvm_s390_cpu_models_supported()) {
+        return;
+    }
+
+    max_model =3D get_max_cpu_model(&local_err);
+    if (local_err) {
+        /* we expect errors only under KVM, when actually querying the ker=
nel */
+        g_assert(kvm_enabled());
+        error_report_err(local_err);
+        return;
+    }
+
+    /*
+     * Similar to baselining against the "max" model. However, features
+     * are handled differently and are not used for the search for a defin=
ition.
+     */
+    if (xcc->cpu_def->gen =3D=3D max_model->def->gen) {
+        if (xcc->cpu_def->ec_ga > max_model->def->ec_ga) {
+            return;
+        }
+    } else if (xcc->cpu_def->gen > max_model->def->gen) {
+        return;
+    }
+
+    /* The model is theoretically runnable, construct the features. */
+    cpu->model =3D g_new(S390CPUModel, 1);
+    cpu->model->def =3D xcc->cpu_def;
+    bitmap_copy(cpu->model->features, xcc->cpu_def->full_feat, S390_FEAT_M=
AX);
+
+    /* Mask of features that are not available in the "max" model */
+    bitmap_and(cpu->model->features, cpu->model->features, max_model->feat=
ures,
+               S390_FEAT_MAX);
+
+    /* Mask off deprecated features */
+    clear_bit(S390_FEAT_CONDITIONAL_SSKE, cpu->model->features);
+
+    /* Make sure every model passes consistency checks */
+    for (i =3D 0; i < ARRAY_SIZE(cpu_feature_dependencies); i++) {
+        if (!test_bit(cpu_feature_dependencies[i][1], cpu->model->features=
)) {
+            clear_bit(cpu_feature_dependencies[i][0], cpu->model->features=
);
+        }
+    }
+}
+
 static void s390_max_cpu_model_initfn(Object *obj)
 {
     const S390CPUModel *max_model;
@@ -1235,6 +1297,20 @@ static void s390_base_cpu_model_class_init(ObjectCla=
ss *oc, void *data)
     xcc->desc =3D xcc->cpu_def->desc;
 }
=20
+static void s390_best_cpu_model_class_init(ObjectClass *oc, void *data)
+{
+    S390CPUClass *xcc =3D S390_CPU_CLASS(oc);
+
+    /*
+     * The "best" models are neither static nor migration safe, similar to
+     * the "max" model.
+     */
+    xcc->is_best =3D true;
+    xcc->cpu_def =3D (const S390CPUDef *) data;
+    xcc->desc =3D g_strdup_printf("%s with best features supported by the =
accelerator in the current host",
+                                xcc->cpu_def->desc);
+}
+
 static void s390_cpu_model_class_init(ObjectClass *oc, void *data)
 {
     S390CPUClass *xcc =3D S390_CPU_CLASS(oc);
@@ -1280,6 +1356,12 @@ static char *s390_base_cpu_type_name(const char *mod=
el_name)
     return g_strdup_printf(S390_CPU_TYPE_NAME("%s-base"), model_name);
 }
=20
+/* Generate type name for a best cpu model. Caller has to free the string.=
 */
+static char *s390_best_cpu_type_name(const char *model_name)
+{
+    return g_strdup_printf(S390_CPU_TYPE_NAME("%s-best"), model_name);
+}
+
 ObjectClass *s390_cpu_class_by_name(const char *name)
 {
     char *typename =3D s390_cpu_type_name(name);
@@ -1380,9 +1462,19 @@ static void register_types(void)
             .class_init =3D s390_cpu_model_class_init,
             .class_data =3D (void *) &s390_cpu_defs[i],
         };
+        char *best_name =3D s390_best_cpu_type_name(s390_cpu_defs[i].name)=
;
+        TypeInfo ti_best =3D {
+            .name =3D best_name,
+            .parent =3D TYPE_S390_CPU,
+            .instance_init =3D s390_best_cpu_model_initfn,
+            .instance_finalize =3D s390_cpu_model_finalize,
+            .class_init =3D s390_best_cpu_model_class_init,
+            .class_data =3D (void *) &s390_cpu_defs[i],
+        };
=20
         type_register_static(&ti_base);
         type_register_static(&ti);
+        type_register_static(&ti_best);
         g_free(base_name);
         g_free(name);
     }
--=20
2.21.0


