Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EDD5C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 17:23:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18BA120748
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 17:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IRrV9FFX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18BA120748
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46920 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZI5D-0003PK-8v
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 12:23:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57312)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iZI2c-0002N3-9E
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 12:20:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iZI2a-00074W-ES
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 12:20:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52321
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>) id 1iZI2a-00074F-9q
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 12:20:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574702447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GLPP2N5MWrkl6vjc+aSFm5QJyB6kxStlVWQOmcRjfzU=;
 b=IRrV9FFX9+Mdf+wx/23onDA1n5IN7q7LLsgq8OBUIodyg+N9d0EBZFDK1ao47nHRT8prj4
 RbuBomSZ6sMwR7Ui7QmSilBEP/rcFF482GLQ/nnTgfFEDYMbbRO5p+w9WJma0xMQgi60MH
 mAyXv7D6ZM+P4eQK/SLxRJpBQ36arCE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-k7MOVp4YMGCRD3T7ZKZ8PA-1; Mon, 25 Nov 2019 12:20:44 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 487FD63CD7;
 Mon, 25 Nov 2019 17:20:42 +0000 (UTC)
Received: from t460s.redhat.com (unknown [10.36.118.6])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 614C019C7F;
 Mon, 25 Nov 2019 17:20:40 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/2] s390x/cpumodel: Introduce dynamic feature groups
Date: Mon, 25 Nov 2019 18:20:31 +0100
Message-Id: <20191125172031.16282-3-david@redhat.com>
In-Reply-To: <20191125172031.16282-1-david@redhat.com>
References: <20191125172031.16282-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: k7MOVp4YMGCRD3T7ZKZ8PA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
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

This is where dynamic CPU feature groups come into play. They allow to
first disable all features that would be enabled as default for a QEMU
machine, to then enable a dynamic set of features (depending on the
CPU definition, the accelerator, and the host).

Get the best possible feature set (e.g., excluding deprecated features) for
a CPU definition in the configuration
    -cpu z14,all-features=3Doff,recommended-features=3Don

Get the maximum possible feature set (e.g., including deprecated
features) for a CPU definition in the configuration ("everything that
could be enabled"):
    -cpu z14,all-features=3Doff,available-features=3Don

Get all valid features for a CPU definition:
    -cpu z14,all-features=3Don

The idea of using feature flags for this use case instead of introducing
new models was brought up by Eduardo Habkost.

The best possible features will then, for example, include nested
virtualization ("SIE" feature) when KVM+HW support is enabled, or fixes via
microcode updates (e.g., spectre) - something we cannot have in the
default models of older QEMU machines.

As soon as dynamic feature groups are used, the CPU model becomes
migration-unsafe. Upper layers can expand these models to migration-safe
and static variants, allowing them to be migrated.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu_features.c |  29 ++++++++
 target/s390x/cpu_features.h |  14 ++++
 target/s390x/cpu_models.c   | 127 ++++++++++++++++++++++++++++++++++++
 3 files changed, 170 insertions(+)

diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 9f817e3cfa..77deabf375 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -166,6 +166,35 @@ void s390_feat_bitmap_to_ascii(const S390FeatBitmap fe=
atures, void *opaque,
     };
 }
=20
+#define DYN_FEAT_GROUP_INIT(_name, _group, _desc)    \
+    [S390_DYN_FEAT_GROUP_ ## _group] =3D {             \
+        .name =3D _name,                               \
+        .desc =3D _desc,                               \
+    }
+
+/*
+ * Dynamic feature groups can change between QEMU versions (or even for th=
e
+ * same version on backports) and depend on the selected CPU definition. M=
ost of
+ * them also depend on the selected accelerator and the host ("max" model)=
. When
+ * used, they turn every model into a migration-unsafe model. Thus, they w=
ill
+ * never appear in expaneded CPU models.
+ *
+ * Indexed by dynamic feature group number.
+ */
+static S390DynFeatGroupDef s390_dyn_feature_groups[] =3D {
+    /* "all" corresponds to our "full" definitions */
+    DYN_FEAT_GROUP_INIT("all-features", ALL, "Features valid for a CPU def=
inition"),
+    /* "recommended" does not include deprecated features. */
+    DYN_FEAT_GROUP_INIT("recommended-features", RECOMMENDED, "Available, r=
ecommended features supported by the accelerator in the current host for a =
CPU definition"),
+    /* "available" includes deprecated features. */
+    DYN_FEAT_GROUP_INIT("available-features", AVAILABLE, "Available featur=
es supported by the accelerator in the current host for a CPU definition"),
+};
+
+const S390DynFeatGroupDef *s390_dyn_feat_group_def(S390DynFeatGroup group)
+{
+    return &s390_dyn_feature_groups[group];
+}
+
 #define FEAT_GROUP_INIT(_name, _group, _desc)        \
     {                                                \
         .name =3D _name,                               \
diff --git a/target/s390x/cpu_features.h b/target/s390x/cpu_features.h
index da695a8346..4a2f418cd3 100644
--- a/target/s390x/cpu_features.h
+++ b/target/s390x/cpu_features.h
@@ -76,7 +76,21 @@ typedef struct {
     S390FeatInit init;      /* used to init feat from generated data */
 } S390FeatGroupDef;
=20
+/* Definition of a dynamic CPU feature group */
+typedef struct {
+    const char *name;       /* name exposed to the user */
+    const char *desc;       /* description exposed to the user */
+} S390DynFeatGroupDef;
+
+typedef enum {
+    S390_DYN_FEAT_GROUP_ALL,
+    S390_DYN_FEAT_GROUP_RECOMMENDED,
+    S390_DYN_FEAT_GROUP_AVAILABLE,
+    S390_DYN_FEAT_GROUP_MAX,
+} S390DynFeatGroup;
+
 const S390FeatGroupDef *s390_feat_group_def(S390FeatGroup group);
+const S390DynFeatGroupDef *s390_dyn_feat_group_def(S390DynFeatGroup group)=
;
=20
 #define BE_BIT_NR(BIT) (BIT ^ (BITS_PER_LONG - 1))
=20
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index e6072fab43..e76a70b177 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -417,6 +417,7 @@ static gint s390_cpu_list_compare(gconstpointer a, gcon=
stpointer b)
=20
 void s390_cpu_list(void)
 {
+    S390DynFeatGroup dyn_group;
     S390FeatGroup group;
     S390Feat feat;
     GSList *list;
@@ -439,6 +440,14 @@ void s390_cpu_list(void)
=20
         qemu_printf("%-20s %-50s\n", def->name, def->desc);
     }
+
+    qemu_printf("\nRecognized dyanmic feature groups:\n");
+    for (dyn_group =3D 0; dyn_group < S390_DYN_FEAT_GROUP_MAX; dyn_group++=
) {
+        const S390DynFeatGroupDef *def =3D s390_dyn_feat_group_def(dyn_gro=
up);
+
+        qemu_printf("%-20s %-50s\n", def->name, def->desc);
+    }
+
 }
=20
 static S390CPUModel *get_max_cpu_model(Error **errp);
@@ -1081,8 +1090,118 @@ static void set_feature_group(Object *obj, Visitor =
*v, const char *name,
     }
 }
=20
+static bool get_dyn_features(S390DynFeatGroup group, const S390CPUDef *def=
,
+                             S390FeatBitmap features)
+{
+    const S390CPUModel *max_model;
+    Error *local_err =3D NULL;
+    int i;
+
+    switch (group) {
+    case S390_DYN_FEAT_GROUP_ALL:
+        bitmap_copy(features, def->full_feat, S390_FEAT_MAX);
+        break;
+    case S390_DYN_FEAT_GROUP_RECOMMENDED:
+    case S390_DYN_FEAT_GROUP_AVAILABLE:
+        if (kvm_enabled() && kvm_s390_cpu_models_supported()) {
+            return false;
+        }
+        max_model =3D get_max_cpu_model(&local_err);
+        if (local_err) {
+            error_report_err(local_err);
+            return false;
+        }
+
+        /*
+         * Start with "full" feature set and mask off features that are no=
t
+         * available in the "max" model.
+         */
+        bitmap_and(features, def->full_feat, max_model->features,
+                   S390_FEAT_MAX);
+
+        if (group =3D=3D S390_DYN_FEAT_GROUP_RECOMMENDED) {
+            /* Mask off deprecated (and experimental) features. */
+            clear_bit(S390_FEAT_CONDITIONAL_SSKE, features);
+            /*
+             * Make sure we pass consistency checks (relevant mostly
+             * for TCG where the "max" model will result in warnings).
+             */
+            for (i =3D 0; i < ARRAY_SIZE(cpu_feature_dependencies); i++) {
+                if (!test_bit(cpu_feature_dependencies[i][1], features)) {
+                    clear_bit(cpu_feature_dependencies[i][0], features);
+                }
+            }
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+    return true;
+}
+
+static void get_dyn_feature_group(Object *obj, Visitor *v, const char *nam=
e,
+                                  void *opaque, Error **errp)
+{
+    S390DynFeatGroup group =3D (S390DynFeatGroup) opaque;
+    S390FeatBitmap tmp, features =3D {};
+    S390CPU *cpu =3D S390_CPU(obj);
+    bool value;
+
+    if (!cpu->model) {
+        error_setg(errp, "Details about the host CPU model are not availab=
le, "
+                   "features cannot be queried.");
+        return;
+    } else if (!get_dyn_features(group, cpu->model->def, features)) {
+        error_setg(errp, "Details about the dynamic feature group '%s' "
+                   "are not available.", name);
+        return;
+    }
+
+    /* a group is enabled if all features are enabled */
+    bitmap_and(tmp, cpu->model->features, features, S390_FEAT_MAX);
+    value =3D bitmap_equal(tmp, features, S390_FEAT_MAX);
+    visit_type_bool(v, name, &value, errp);
+}
+
+static void set_dyn_feature_group(Object *obj, Visitor *v, const char *nam=
e,
+                                  void *opaque, Error **errp)
+{
+    S390DynFeatGroup group =3D (S390DynFeatGroup) opaque;
+    S390FeatBitmap features =3D {};
+    DeviceState *dev =3D DEVICE(obj);
+    S390CPU *cpu =3D S390_CPU(obj);
+    bool value;
+
+    if (dev->realized) {
+        error_setg(errp, "Attempt to set property '%s' on '%s' after "
+                   "it was realized", name, object_get_typename(obj));
+        return;
+    } else if (!cpu->model) {
+        error_setg(errp, "Details about the host CPU model are not availab=
le, "
+                   "features cannot be changed.");
+        return;
+    } else if (!get_dyn_features(group, cpu->model->def, features)) {
+        error_setg(errp, "Details about the dynamic feature group '%s' "
+                   "are not available.", name);
+        return;
+    }
+
+    visit_type_bool(v, name, &value, errp);
+    if (*errp) {
+        return;
+    }
+    if (value) {
+        bitmap_or(cpu->model->features, cpu->model->features, features,
+                  S390_FEAT_MAX);
+    } else {
+        bitmap_andnot(cpu->model->features, cpu->model->features, features=
,
+                      S390_FEAT_MAX);
+    }
+}
+
 void s390_cpu_model_register_props(Object *obj)
 {
+    S390DynFeatGroup dyn_group;
     S390FeatGroup group;
     S390Feat feat;
=20
@@ -1098,6 +1217,14 @@ void s390_cpu_model_register_props(Object *obj)
                             set_feature_group, NULL, (void *) group, NULL)=
;
         object_property_set_description(obj, def->name, def->desc , NULL);
     }
+    for (dyn_group =3D 0; dyn_group < S390_DYN_FEAT_GROUP_MAX; dyn_group++=
) {
+        const S390DynFeatGroupDef *def =3D s390_dyn_feat_group_def(dyn_gro=
up);
+
+        object_property_add(obj, def->name, "bool", get_dyn_feature_group,
+                            set_dyn_feature_group, NULL, (void *) dyn_grou=
p,
+                            NULL);
+        object_property_set_description(obj, def->name, def->desc , NULL);
+    }
 }
=20
 static void s390_cpu_model_initfn(Object *obj)
--=20
2.21.0


