Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E1E2C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 02:26:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72F29206A2
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 02:26:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72F29206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hggb5-0008KE-Mu
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 22:26:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50160)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hgg8n-0000xC-U0
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 21:57:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hgg8l-0001i3-Sy
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 21:57:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49666)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hgg8l-00010x-Gh
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 21:57:27 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id CA568308212A;
 Fri, 28 Jun 2019 01:57:09 +0000 (UTC)
Received: from localhost (ovpn-116-7.gru2.redhat.com [10.97.116.7])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 223261001B06;
 Fri, 28 Jun 2019 01:57:08 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Thu, 27 Jun 2019 22:56:01 -0300
Message-Id: <20190628015606.32107-25-ehabkost@redhat.com>
In-Reply-To: <20190628015606.32107-1-ehabkost@redhat.com>
References: <20190628015606.32107-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 28 Jun 2019 01:57:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 24/29] i386: make 'hv-spinlocks' a regular
 uint32 property
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Roman Kagan <rkagan@virtuozzo.com>

X86CPU.hv-spinlocks is a uint32 property that has a special setter
validating the value to be no less than 0xFFF and no bigger than
UINT_MAX.  The latter check is redundant; as for the former, there
appears to be no reason to prohibit the user from setting it to a lower
value.

So nuke the dedicated getter/setter pair and convert 'hv-spinlocks' to a
regular uint32 property.

Signed-off-by: Roman Kagan <rkagan@virtuozzo.com>
Message-Id: <20190618110659.14744-1-rkagan@virtuozzo.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 45 ++-------------------------------------------
 1 file changed, 2 insertions(+), 43 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 390f47adc5..8d5d34849c 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3518,46 +3518,6 @@ static void x86_cpu_get_feature_words(Object *obj, Visitor *v,
     visit_type_X86CPUFeatureWordInfoList(v, "feature-words", &list, errp);
 }
 
-static void x86_get_hv_spinlocks(Object *obj, Visitor *v, const char *name,
-                                 void *opaque, Error **errp)
-{
-    X86CPU *cpu = X86_CPU(obj);
-    int64_t value = cpu->hyperv_spinlock_attempts;
-
-    visit_type_int(v, name, &value, errp);
-}
-
-static void x86_set_hv_spinlocks(Object *obj, Visitor *v, const char *name,
-                                 void *opaque, Error **errp)
-{
-    const int64_t min = 0xFFF;
-    const int64_t max = UINT_MAX;
-    X86CPU *cpu = X86_CPU(obj);
-    Error *err = NULL;
-    int64_t value;
-
-    visit_type_int(v, name, &value, &err);
-    if (err) {
-        error_propagate(errp, err);
-        return;
-    }
-
-    if (value < min || value > max) {
-        error_setg(errp, "Property %s.%s doesn't take value %" PRId64
-                   " (minimum: %" PRId64 ", maximum: %" PRId64 ")",
-                   object_get_typename(obj), name ? name : "null",
-                   value, min, max);
-        return;
-    }
-    cpu->hyperv_spinlock_attempts = value;
-}
-
-static const PropertyInfo qdev_prop_spinlocks = {
-    .name  = "int",
-    .get   = x86_get_hv_spinlocks,
-    .set   = x86_set_hv_spinlocks,
-};
-
 /* Convert all '_' in a feature string option name to '-', to make feature
  * name conform to QOM property naming rule, which uses '-' instead of '_'.
  */
@@ -5682,8 +5642,6 @@ static void x86_cpu_initfn(Object *obj)
     object_property_add(obj, "crash-information", "GuestPanicInformation",
                         x86_cpu_get_crash_info_qom, NULL, NULL, NULL, NULL);
 
-    cpu->hyperv_spinlock_attempts = HYPERV_SPINLOCK_NEVER_RETRY;
-
     for (w = 0; w < FEATURE_WORDS; w++) {
         int bitnr;
 
@@ -5880,7 +5838,8 @@ static Property x86_cpu_properties[] = {
     DEFINE_PROP_INT32("node-id", X86CPU, node_id, CPU_UNSET_NUMA_NODE_ID),
     DEFINE_PROP_BOOL("pmu", X86CPU, enable_pmu, false),
 
-    { .name  = "hv-spinlocks", .info  = &qdev_prop_spinlocks },
+    DEFINE_PROP_UINT32("hv-spinlocks", X86CPU, hyperv_spinlock_attempts,
+                       HYPERV_SPINLOCK_NEVER_RETRY),
     DEFINE_PROP_BIT64("hv-relaxed", X86CPU, hyperv_features,
                       HYPERV_FEAT_RELAXED, 0),
     DEFINE_PROP_BIT64("hv-vapic", X86CPU, hyperv_features,
-- 
2.18.0.rc1.1.g3f1ff2140


