Return-Path: <SRS0=4Hnu=AF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B08AC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 17:00:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE8B720738
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2020 17:00:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cWJuTV+E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE8B720738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jo8lO-00076B-Qw
	for qemu-devel@archiver.kernel.org; Wed, 24 Jun 2020 13:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jo8VU-0003rN-5E
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 12:44:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46909
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jo8VB-00056x-Qt
 for qemu-devel@nongnu.org; Wed, 24 Jun 2020 12:44:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593017035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iv5jsw8Qu10tKDuXJWYnW772497s6X8/d3y77EvOOD4=;
 b=cWJuTV+EKLbvlDjrOtpOASjhAN7JxdSBxuUsCvvv9NZDyPu/ltA4i6tzmYgsM4v9D/kGHp
 tujvUyEunN+zRiiUrXUWmX8nV2/wFxZB3XQNLyZTlJ7TwmZ/7PmJZ21M2OWub4MN0vMzUv
 q68vKU4qzlDWRr1yV+cBXRL7pm78RNs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-rR_Zk2FwPjmwnb6OpwONYw-1; Wed, 24 Jun 2020 12:43:53 -0400
X-MC-Unique: rR_Zk2FwPjmwnb6OpwONYw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 671428015FA;
 Wed, 24 Jun 2020 16:43:52 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D05D60F8A;
 Wed, 24 Jun 2020 16:43:52 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 76A8B1138494; Wed, 24 Jun 2020 18:43:45 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 39/46] qom: Smooth error checking manually
Date: Wed, 24 Jun 2020 18:43:37 +0200
Message-Id: <20200624164344.3778251-40-armbru@redhat.com>
In-Reply-To: <20200624164344.3778251-1-armbru@redhat.com>
References: <20200624164344.3778251-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/24 02:33:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, vsementsov@virtuozzo.com, berrange@redhat.com,
 ehabkost@redhat.com, qemu-block@nongnu.org, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When foo(..., &err) is followed by error_propagate(errp, err), we can
often just as well do foo(..., errp).  The previous commit did that
for simple cases with Coccinelle.  Do it for a few more manually.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/core/bus.c              |  6 +-----
 hw/s390x/s390-virtio-ccw.c | 15 +++++++--------
 qom/object.c               |  9 ++-------
 qom/qom-qobject.c          |  5 +----
 target/i386/cpu.c          | 19 +++++--------------
 5 files changed, 16 insertions(+), 38 deletions(-)

diff --git a/hw/core/bus.c b/hw/core/bus.c
index 00d1d31762..6b987b6946 100644
--- a/hw/core/bus.c
+++ b/hw/core/bus.c
@@ -166,11 +166,7 @@ BusState *qbus_create(const char *typename, DeviceState *parent, const char *nam
 
 bool qbus_realize(BusState *bus, Error **errp)
 {
-    Error *err = NULL;
-
-    object_property_set_bool(OBJECT(bus), "realized", true, &err);
-    error_propagate(errp, err);
-    return !err;
+    return object_property_set_bool(OBJECT(bus), "realized", true, errp);
 }
 
 void qbus_unrealize(BusState *bus)
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 62af349c31..877ea2af9d 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -69,20 +69,19 @@ static S390CPU *s390x_new_cpu(const char *typename, uint32_t core_id,
                               Error **errp)
 {
     S390CPU *cpu = S390_CPU(object_new(typename));
-    Error *err = NULL;
+    S390CPU *ret = NULL;
 
-    if (!object_property_set_int(OBJECT(cpu), "core-id", core_id, &err)) {
+    if (!object_property_set_int(OBJECT(cpu), "core-id", core_id, errp)) {
         goto out;
     }
-    qdev_realize(DEVICE(cpu), NULL, &err);
+    if (!qdev_realize(DEVICE(cpu), NULL, errp)) {
+        goto out;
+    }
+    ret = cpu;
 
 out:
     object_unref(OBJECT(cpu));
-    if (err) {
-        error_propagate(errp, err);
-        cpu = NULL;
-    }
-    return cpu;
+    return ret;
 }
 
 static void s390_init_cpus(MachineState *machine)
diff --git a/qom/object.c b/qom/object.c
index eb814e41be..684540a09f 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -547,7 +547,6 @@ bool object_initialize_child_with_propsv(Object *parentobj,
                               void *childobj, size_t size, const char *type,
                               Error **errp, va_list vargs)
 {
-    Error *local_err = NULL;
     bool ok = false;
     Object *obj;
     UserCreatable *uc;
@@ -563,7 +562,7 @@ bool object_initialize_child_with_propsv(Object *parentobj,
 
     uc = (UserCreatable *)object_dynamic_cast(obj, TYPE_USER_CREATABLE);
     if (uc) {
-        if (!user_creatable_complete(uc, &local_err)) {
+        if (!user_creatable_complete(uc, errp)) {
             object_unparent(obj);
             goto out;
         }
@@ -581,8 +580,6 @@ out:
      * the reference taken by object_property_add_child().
      */
     object_unref(obj);
-
-    error_propagate(errp, local_err);
     return ok;
 }
 
@@ -735,7 +732,6 @@ Object *object_new_with_propv(const char *typename,
 {
     Object *obj;
     ObjectClass *klass;
-    Error *local_err = NULL;
     UserCreatable *uc;
 
     klass = object_class_by_name(typename);
@@ -760,7 +756,7 @@ Object *object_new_with_propv(const char *typename,
 
     uc = (UserCreatable *)object_dynamic_cast(obj, TYPE_USER_CREATABLE);
     if (uc) {
-        if (!user_creatable_complete(uc, &local_err)) {
+        if (!user_creatable_complete(uc, errp)) {
             if (id != NULL) {
                 object_unparent(obj);
             }
@@ -772,7 +768,6 @@ Object *object_new_with_propv(const char *typename,
     return obj;
 
  error:
-    error_propagate(errp, local_err);
     object_unref(obj);
     return NULL;
 }
diff --git a/qom/qom-qobject.c b/qom/qom-qobject.c
index 62ac5e07ac..21ce22de94 100644
--- a/qom/qom-qobject.c
+++ b/qom/qom-qobject.c
@@ -34,15 +34,12 @@ QObject *object_property_get_qobject(Object *obj, const char *name,
                                      Error **errp)
 {
     QObject *ret = NULL;
-    Error *local_err = NULL;
     Visitor *v;
 
     v = qobject_output_visitor_new(&ret);
-    object_property_get(obj, name, v, &local_err);
-    if (!local_err) {
+    if (object_property_get(obj, name, v, errp)) {
         visit_complete(v, &ret);
     }
-    error_propagate(errp, local_err);
     visit_free(v);
     return ret;
 }
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 26ba40656d..b7c9f0fa72 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -5251,16 +5251,13 @@ static void x86_cpu_to_dict_full(X86CPU *cpu, QDict *props)
 static void object_apply_props(Object *obj, QDict *props, Error **errp)
 {
     const QDictEntry *prop;
-    Error *err = NULL;
 
     for (prop = qdict_first(props); prop; prop = qdict_next(props, prop)) {
         if (!object_property_set_qobject(obj, qdict_entry_key(prop),
-                                         qdict_entry_value(prop), &err)) {
+                                         qdict_entry_value(prop), errp)) {
             break;
         }
     }
-
-    error_propagate(errp, err);
 }
 
 /* Create X86CPU object according to model+props specification */
@@ -6318,19 +6315,18 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
     FeatureWord w;
     int i;
     GList *l;
-    Error *local_err = NULL;
 
     for (l = plus_features; l; l = l->next) {
         const char *prop = l->data;
-        if (!object_property_set_bool(OBJECT(cpu), prop, true, &local_err)) {
-            goto out;
+        if (!object_property_set_bool(OBJECT(cpu), prop, true, errp)) {
+            return;
         }
     }
 
     for (l = minus_features; l; l = l->next) {
         const char *prop = l->data;
-        if (!object_property_set_bool(OBJECT(cpu), prop, false, &local_err)) {
-            goto out;
+        if (!object_property_set_bool(OBJECT(cpu), prop, false, errp)) {
+            return;
         }
     }
 
@@ -6428,11 +6424,6 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
     if (env->cpuid_xlevel2 == UINT32_MAX) {
         env->cpuid_xlevel2 = env->cpuid_min_xlevel2;
     }
-
-out:
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
-    }
 }
 
 /*
-- 
2.26.2


