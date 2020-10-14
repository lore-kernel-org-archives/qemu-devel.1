Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A26C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 14:57:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B88F212CC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 14:57:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gazkMOlv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B88F212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37060 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSiDF-0001aR-6c
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 10:57:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kShrK-0001O0-Fd
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 10:34:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36415)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kShrI-00063j-DY
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 10:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602686067;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V57Ij139uBLKn0xILPsn2gLRsESAqakDIgsBu2SuvIo=;
 b=gazkMOlvMWnCK23FYLByiuaiUBovFJAT+pOftQQ8lQfnKFVZA6aDx5tfGqEDakzec4EdMx
 XkeQsu/Hyy5ielBb0VhuVp2g8K16oLognJiPGlE4NFj0wVRCrkYXxalB5rIb/auoGJHO0i
 v1D2i6wiiYKLqp37TTPV22LdeiGq9nk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-YrbHby1eOPK48Jv0fiTufQ-1; Wed, 14 Oct 2020 10:34:23 -0400
X-MC-Unique: YrbHby1eOPK48Jv0fiTufQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D51BE801FDB;
 Wed, 14 Oct 2020 14:34:22 +0000 (UTC)
Received: from localhost (ovpn-66-44.rdu2.redhat.com [10.10.66.44])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6BDD65D9CD;
 Wed, 14 Oct 2020 14:34:22 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 06/10] i386: Register most CPU properties as class properties
Date: Wed, 14 Oct 2020 10:34:11 -0400
Message-Id: <20201014143415.240472-7-ehabkost@redhat.com>
In-Reply-To: <20201014143415.240472-1-ehabkost@redhat.com>
References: <20201014143415.240472-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:37:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Class properties make QOM introspection simpler and easier, as
they don't require an object to be instantiated.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20200921221045.699690-14-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 66 ++++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 32 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 9eafbe3690..5d713c8528 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6925,44 +6925,12 @@ static void x86_cpu_initfn(Object *obj)
     env->nr_dies = 1;
     cpu_set_cpustate_pointers(cpu);
 
-    object_property_add(obj, "family", "int",
-                        x86_cpuid_version_get_family,
-                        x86_cpuid_version_set_family, NULL, NULL);
-    object_property_add(obj, "model", "int",
-                        x86_cpuid_version_get_model,
-                        x86_cpuid_version_set_model, NULL, NULL);
-    object_property_add(obj, "stepping", "int",
-                        x86_cpuid_version_get_stepping,
-                        x86_cpuid_version_set_stepping, NULL, NULL);
-    object_property_add_str(obj, "vendor",
-                            x86_cpuid_get_vendor,
-                            x86_cpuid_set_vendor);
-    object_property_add_str(obj, "model-id",
-                            x86_cpuid_get_model_id,
-                            x86_cpuid_set_model_id);
-    object_property_add(obj, "tsc-frequency", "int",
-                        x86_cpuid_get_tsc_freq,
-                        x86_cpuid_set_tsc_freq, NULL, NULL);
     object_property_add(obj, "feature-words", "X86CPUFeatureWordInfo",
                         x86_cpu_get_feature_words,
                         NULL, NULL, (void *)env->features);
     object_property_add(obj, "filtered-features", "X86CPUFeatureWordInfo",
                         x86_cpu_get_feature_words,
                         NULL, NULL, (void *)cpu->filtered_features);
-    /*
-     * The "unavailable-features" property has the same semantics as
-     * CpuDefinitionInfo.unavailable-features on the "query-cpu-definitions"
-     * QMP command: they list the features that would have prevented the
-     * CPU from running if the "enforce" flag was set.
-     */
-    object_property_add(obj, "unavailable-features", "strList",
-                        x86_cpu_get_unavailable_features,
-                        NULL, NULL, NULL);
-
-#if !defined(CONFIG_USER_ONLY)
-    object_property_add(obj, "crash-information", "GuestPanicInformation",
-                        x86_cpu_get_crash_info_qom, NULL, NULL, NULL);
-#endif
 
     for (w = 0; w < FEATURE_WORDS; w++) {
         int bitnr;
@@ -7312,6 +7280,40 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
     cc->disas_set_info = x86_disas_set_info;
 
     dc->user_creatable = true;
+
+    object_class_property_add(oc, "family", "int",
+                              x86_cpuid_version_get_family,
+                              x86_cpuid_version_set_family, NULL, NULL);
+    object_class_property_add(oc, "model", "int",
+                              x86_cpuid_version_get_model,
+                              x86_cpuid_version_set_model, NULL, NULL);
+    object_class_property_add(oc, "stepping", "int",
+                              x86_cpuid_version_get_stepping,
+                              x86_cpuid_version_set_stepping, NULL, NULL);
+    object_class_property_add_str(oc, "vendor",
+                                  x86_cpuid_get_vendor,
+                                  x86_cpuid_set_vendor);
+    object_class_property_add_str(oc, "model-id",
+                                  x86_cpuid_get_model_id,
+                                  x86_cpuid_set_model_id);
+    object_class_property_add(oc, "tsc-frequency", "int",
+                              x86_cpuid_get_tsc_freq,
+                              x86_cpuid_set_tsc_freq, NULL, NULL);
+    /*
+     * The "unavailable-features" property has the same semantics as
+     * CpuDefinitionInfo.unavailable-features on the "query-cpu-definitions"
+     * QMP command: they list the features that would have prevented the
+     * CPU from running if the "enforce" flag was set.
+     */
+    object_class_property_add(oc, "unavailable-features", "strList",
+                              x86_cpu_get_unavailable_features,
+                              NULL, NULL, NULL);
+
+#if !defined(CONFIG_USER_ONLY)
+    object_class_property_add(oc, "crash-information", "GuestPanicInformation",
+                              x86_cpu_get_crash_info_qom, NULL, NULL, NULL);
+#endif
+
 }
 
 static const TypeInfo x86_cpu_type_info = {
-- 
2.28.0


