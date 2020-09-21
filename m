Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0C3C4727C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 22:19:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ABE2F23A60
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 22:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AwYxLKM1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ABE2F23A60
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57704 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKU9K-0000IJ-PE
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 18:19:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKU1x-0000OC-9D
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 18:11:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52106)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKU1t-0001ck-Ei
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 18:11:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600726284;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yI99G5RliSRDk0T3kuWGTzNZKNFmQSbNekxeuovQbRA=;
 b=AwYxLKM1E5nU+7wBNdquqOYLfvhamO7/SOT7XudTxnDR7/Xc9a2798b7z+rqPgMp2Kr6j5
 vMJD96zrwdP4tEa22fT8pHOZqwvIeQJN1GhWVmr0Bt5eX0NkjXC7qaq5X4pdJv9VTLYT/4
 zucBla+DtXxu6gw+qKrVeCYDD13u6m4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-YslSO1dlOnq2BGEsKiCFqA-1; Mon, 21 Sep 2020 18:11:22 -0400
X-MC-Unique: YslSO1dlOnq2BGEsKiCFqA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFB8A1DE0F;
 Mon, 21 Sep 2020 22:11:21 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 83BE010013BD;
 Mon, 21 Sep 2020 22:11:21 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 13/24] i386: Register most CPU properties as class properties
Date: Mon, 21 Sep 2020 18:10:34 -0400
Message-Id: <20200921221045.699690-14-ehabkost@redhat.com>
In-Reply-To: <20200921221045.699690-1-ehabkost@redhat.com>
References: <20200921221045.699690-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:43:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: John Snow <jsnow@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Class properties make QOM introspection simpler and easier, as
they don't require an object to be instantiated.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org
---
 target/i386/cpu.c | 66 ++++++++++++++++++++++++-----------------------
 1 file changed, 34 insertions(+), 32 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 1c58f764dcb..66792f28ba7 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -6922,44 +6922,12 @@ static void x86_cpu_initfn(Object *obj)
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
@@ -7308,6 +7276,40 @@ static void x86_cpu_common_class_init(ObjectClass *oc, void *data)
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
2.26.2


