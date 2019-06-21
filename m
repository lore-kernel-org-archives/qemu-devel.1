Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FA0C43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 16:43:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1CC2D20665
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 16:43:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CC2D20665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36762 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heMdU-00088J-9i
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 12:43:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44522)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <drjones@redhat.com>) id 1heMVJ-0001ZF-Gl
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 12:35:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1heMVF-0001G2-Kt
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 12:35:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40366)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>)
 id 1heMV3-0000GC-MB; Fri, 21 Jun 2019 12:34:55 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B7530C1EB219;
 Fri, 21 Jun 2019 16:34:40 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 78F561001DD9;
 Fri, 21 Jun 2019 16:34:38 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Date: Fri, 21 Jun 2019 18:34:11 +0200
Message-Id: <20190621163422.6127-4-drjones@redhat.com>
In-Reply-To: <20190621163422.6127-1-drjones@redhat.com>
References: <20190621163422.6127-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Fri, 21 Jun 2019 16:34:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 03/14] target/arm/monitor: Introduce
 qmp_query_cpu_model_expansion
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
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, armbru@redhat.com,
 eric.auger@redhat.com, imammedo@redhat.com, alex.bennee@linaro.org,
 Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add support for the query-cpu-model-expansion QMP command to Arm. We
do this selectively, only exposing CPU properties which represent
optional CPU features which the user may want to enable/disable. Also,
for simplicity, we restrict the list of queryable cpu models to 'max',
'host', or the current type when KVM is in use, even though there
may exist KVM hosts where other types would also work. For example on a
seattle you could use 'host' for the current type, but then attempt to
query 'cortex-a57', which is also a valid CPU type to use with KVM on
seattle hosts, but that query will fail with our simplifications. This
shouldn't be an issue though as management layers and users have been
preferring the 'host' CPU type for use with KVM for quite some time.
Additionally, if the KVM-enabled QEMU instance running on a seattle
host is using the cortex-a57 CPU type, then querying 'cortex-a57' will
work. Finally, we only implement expansion type 'full', as Arm does not
yet have a "base" CPU type. Below are some example calls and results
(to save character clutter they're not in json, but are still json-ish
to give the idea)

 # expand the 'max' CPU model
 query-cpu-model-expansion: type:full, model:{ name:max }

 return: model:{ name:max, props:{ 'aarch64': true, 'pmu': true }}

 # attempt to expand the 'max' CPU model with pmu=3Doff
 query-cpu-model-expansion:
   type:full, model:{ name:max, props:{ 'pmu': false }}

 return: model:{ name:max, props:{ 'aarch64': true, 'pmu': false }}

 # attempt to expand the 'max' CPU model with aarch64=3Doff
 query-cpu-model-expansion:
   type:full, model:{ name:max, props:{ 'aarch64': false }}

 error: "'aarch64' feature cannot be disabled unless KVM is enabled
         and 32-bit EL1 is supported"

In the last example KVM was not in use so an error was returned.

Note1: It's possible for features to have dependencies on other
features. I.e. it may be possible to change one feature at a time
without error, but when attempting to change all features at once
an error could occur depending on the order they are processed. It's
also possible changing all at once doesn't generate an error, because
a feature's dependencies are satisfied with other features, but the
same feature cannot be changed independently without error. For these
reasons callers should always attempt to make their desired changes
all at once in order to ensure the collection is valid.

Note2: Certainly more features may be added to the list of
advertised features, e.g. 'vfp' and 'neon'. The only requirement
is that their property set accessors fail when invalid
configurations are detected. For vfp we would need something like

 set_vfp()
 {
   if (arm_feature(env, ARM_FEATURE_AARCH64) &&
       cpu->has_vfp !=3D cpu->has_neon)
       error("AArch64 CPUs must have both VFP and Neon or neither")

in its set accessor, and the same for neon, rather than doing that
check at realize time, which isn't executed at qmp query time.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 qapi/target.json     |   6 +-
 target/arm/monitor.c | 132 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 135 insertions(+), 3 deletions(-)

diff --git a/qapi/target.json b/qapi/target.json
index 1d4d54b6002e..edfa2f82b916 100644
--- a/qapi/target.json
+++ b/qapi/target.json
@@ -408,7 +408,7 @@
 ##
 { 'struct': 'CpuModelExpansionInfo',
   'data': { 'model': 'CpuModelInfo' },
-  'if': 'defined(TARGET_S390X) || defined(TARGET_I386)' }
+  'if': 'defined(TARGET_S390X) || defined(TARGET_I386) || defined(TARGET=
_ARM)' }
=20
 ##
 # @query-cpu-model-expansion:
@@ -433,7 +433,7 @@
 #   query-cpu-model-expansion while using these is not advised.
 #
 # Some architectures may not support all expansion types. s390x supports
-# "full" and "static".
+# "full" and "static". Arm only supports "full".
 #
 # Returns: a CpuModelExpansionInfo. Returns an error if expanding CPU mo=
dels is
 #          not supported, if the model cannot be expanded, if the model =
contains
@@ -447,7 +447,7 @@
   'data': { 'type': 'CpuModelExpansionType',
             'model': 'CpuModelInfo' },
   'returns': 'CpuModelExpansionInfo',
-  'if': 'defined(TARGET_S390X) || defined(TARGET_I386)' }
+  'if': 'defined(TARGET_S390X) || defined(TARGET_I386) || defined(TARGET=
_ARM)' }
=20
 ##
 # @CpuDefinitionInfo:
diff --git a/target/arm/monitor.c b/target/arm/monitor.c
index 41b32b94b258..19e3120eef95 100644
--- a/target/arm/monitor.c
+++ b/target/arm/monitor.c
@@ -23,7 +23,13 @@
 #include "qemu/osdep.h"
 #include "hw/boards.h"
 #include "kvm_arm.h"
+#include "qapi/error.h"
+#include "qapi/visitor.h"
+#include "qapi/qobject-input-visitor.h"
 #include "qapi/qapi-commands-target.h"
+#include "qapi/qmp/qerror.h"
+#include "qapi/qmp/qdict.h"
+#include "qom/qom-qobject.h"
=20
 static GICCapability *gic_cap_new(int version)
 {
@@ -82,3 +88,129 @@ GICCapabilityList *qmp_query_gic_capabilities(Error *=
*errp)
=20
     return head;
 }
+
+static const char *cpu_model_advertised_features[] =3D {
+    "aarch64", "pmu",
+    NULL
+};
+
+CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionTy=
pe type,
+                                                     CpuModelInfo *model=
,
+                                                     Error **errp)
+{
+    CpuModelExpansionInfo *expansion_info;
+    const QDict *qdict_in =3D NULL;
+    QDict *qdict_out;
+    ObjectClass *oc;
+    Object *obj;
+    const char *name;
+    int i;
+
+    if (type !=3D CPU_MODEL_EXPANSION_TYPE_FULL) {
+        error_setg(errp, "The requested expansion type is not supported.=
");
+        return NULL;
+    }
+
+    if (!kvm_enabled() && !strcmp(model->name, "host")) {
+        error_setg(errp, "The CPU definition '%s' requires KVM", model->=
name);
+        return NULL;
+    }
+
+    oc =3D cpu_class_by_name(TYPE_ARM_CPU, model->name);
+    if (!oc) {
+        error_setg(errp, "The CPU definition '%s' is unknown.", model->n=
ame);
+        return NULL;
+    }
+
+    if (kvm_enabled()) {
+        const char *cpu_type =3D current_machine->cpu_type;
+        int len =3D strlen(cpu_type) - strlen(ARM_CPU_TYPE_SUFFIX);
+        bool supported =3D false;
+
+        if (!strcmp(model->name, "host") || !strcmp(model->name, "max"))=
 {
+            /* These are kvmarm's recommended cpu types */
+            supported =3D true;
+        } else if (strlen(model->name) =3D=3D len &&
+                   !strncmp(model->name, cpu_type, len)) {
+            /* KVM is enabled and we're using this type, so it works. */
+            supported =3D true;
+        }
+        if (!supported) {
+            error_setg(errp, "The CPU definition '%s' cannot "
+                             "be used with KVM on this host", model->nam=
e);
+            return NULL;
+        }
+    }
+
+    if (model->props) {
+        qdict_in =3D qobject_to(QDict, model->props);
+        if (!qdict_in) {
+            error_setg(errp, QERR_INVALID_PARAMETER_TYPE, "props", "dict=
");
+            return NULL;
+        }
+    }
+
+    obj =3D object_new(object_class_get_name(oc));
+
+    if (qdict_in) {
+        Visitor *visitor;
+
+        visitor =3D qobject_input_visitor_new(model->props);
+        visit_start_struct(visitor, NULL, NULL, 0, errp);
+        if (*errp) {
+            object_unref(obj);
+            return NULL;
+        }
+
+        i =3D 0;
+        while ((name =3D cpu_model_advertised_features[i++]) !=3D NULL) =
{
+            if (qdict_get(qdict_in, name)) {
+                object_property_set(obj, visitor, name, errp);
+                if (*errp) {
+                    break;
+                }
+            }
+        }
+
+        if (!*errp) {
+            visit_check_struct(visitor, errp);
+        }
+        visit_end_struct(visitor, NULL);
+        visit_free(visitor);
+        if (*errp) {
+            object_unref(obj);
+            return NULL;
+        }
+    }
+
+    expansion_info =3D g_new0(CpuModelExpansionInfo, 1);
+    expansion_info->model =3D g_malloc0(sizeof(*expansion_info->model));
+    expansion_info->model->name =3D g_strdup(model->name);
+
+    qdict_out =3D qdict_new();
+
+    i =3D 0;
+    while ((name =3D cpu_model_advertised_features[i++]) !=3D NULL) {
+        ObjectProperty *prop =3D object_property_find(obj, name, NULL);
+        if (prop) {
+            QObject *value;
+
+            assert(prop->get);
+            value =3D object_property_get_qobject(obj, name, errp);
+            assert(!*errp);
+
+            qdict_put_obj(qdict_out, name, value);
+        }
+    }
+
+    if (!qdict_size(qdict_out)) {
+        qobject_unref(qdict_out);
+    } else {
+        expansion_info->model->props =3D QOBJECT(qdict_out);
+        expansion_info->model->has_props =3D true;
+    }
+
+    object_unref(obj);
+
+    return expansion_info;
+}
--=20
2.20.1


