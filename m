Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72087C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:28:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF556208A9
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 22:28:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Urye5tGK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF556208A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKqlb-0001d6-VG
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 18:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55528)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKqjb-0008IL-Gj
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:26:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54715)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kKqjZ-0006Ku-KU
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 18:26:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600813560;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qLySm8bIjgHhtZueEYh4yesmf1i/Wj497OLUEF9Hsyc=;
 b=Urye5tGKocMbb8mc8uiEOIXhqRy9fdSJvyRWIs8CyOyNi+O3eerZDwLIRnTniSXl+QI1eI
 HN4jlcUhIdq4ISSL9eiEU/TqbHvtSIibfEW0ufISJm57aHVxBdCO9pQe+/6dPxoe25VeKR
 Qw+A4+/jKUKjHd03uWiRPvz+tavAYr0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-iaPiE_nLO3mtWuTpsoZvuA-1; Tue, 22 Sep 2020 18:25:58 -0400
X-MC-Unique: iaPiE_nLO3mtWuTpsoZvuA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1D98B1084D6E;
 Tue, 22 Sep 2020 22:25:57 +0000 (UTC)
Received: from localhost (unknown [10.10.67.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 21B535577A;
 Tue, 22 Sep 2020 22:25:53 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 05/11] s390x: Register all CPU properties as class properties
Date: Tue, 22 Sep 2020 18:25:36 -0400
Message-Id: <20200922222542.2354748-6-ehabkost@redhat.com>
In-Reply-To: <20200922222542.2354748-1-ehabkost@redhat.com>
References: <20200922222542.2354748-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 02:07:04
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Class properties make QOM introspection simpler and easier, as
they don't require an object to be instantiated.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <20200921221045.699690-13-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/s390x/internal.h   |  1 -
 target/s390x/cpu.c        |  1 -
 target/s390x/cpu_models.c | 35 ++++++++++++++++-------------------
 3 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/target/s390x/internal.h b/target/s390x/internal.h
index b1e0ebf67f8..bac0d3c67b2 100644
--- a/target/s390x/internal.h
+++ b/target/s390x/internal.h
@@ -260,7 +260,6 @@ static inline void s390_cpu_unhalt(S390CPU *cpu)
 
 
 /* cpu_models.c */
-void s390_cpu_model_register_props(Object *obj);
 void s390_cpu_model_class_register_props(ObjectClass *oc);
 void s390_realize_cpu_model(CPUState *cs, Error **errp);
 ObjectClass *s390_cpu_class_by_name(const char *name);
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index e350edc9f53..9cbd937ba2c 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -302,7 +302,6 @@ static void s390_cpu_initfn(Object *obj)
         timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_cpu_timer, cpu);
     s390_cpu_set_state(S390_CPU_STATE_STOPPED, cpu);
 #endif
-    s390_cpu_model_register_props(obj);
 }
 
 static void s390_cpu_finalize(Object *obj)
diff --git a/target/s390x/cpu_models.c b/target/s390x/cpu_models.c
index c2af2261743..b97e9596ab0 100644
--- a/target/s390x/cpu_models.c
+++ b/target/s390x/cpu_models.c
@@ -1089,25 +1089,6 @@ static void set_feature_group(Object *obj, Visitor *v, const char *name,
     }
 }
 
-void s390_cpu_model_register_props(Object *obj)
-{
-    S390FeatGroup group;
-    S390Feat feat;
-
-    for (feat = 0; feat < S390_FEAT_MAX; feat++) {
-        const S390FeatDef *def = s390_feat_def(feat);
-        object_property_add(obj, def->name, "bool", get_feature,
-                            set_feature, NULL, (void *) feat);
-        object_property_set_description(obj, def->name, def->desc);
-    }
-    for (group = 0; group < S390_FEAT_GROUP_MAX; group++) {
-        const S390FeatGroupDef *def = s390_feat_group_def(group);
-        object_property_add(obj, def->name, "bool", get_feature_group,
-                            set_feature_group, NULL, (void *) group);
-        object_property_set_description(obj, def->name, def->desc);
-    }
-}
-
 static void s390_cpu_model_initfn(Object *obj)
 {
     S390CPU *cpu = S390_CPU(obj);
@@ -1215,11 +1196,27 @@ static char *get_description(Object *obj, Error **errp)
 
 void s390_cpu_model_class_register_props(ObjectClass *oc)
 {
+    S390FeatGroup group;
+    S390Feat feat;
+
     object_class_property_add_bool(oc, "migration-safe", get_is_migration_safe,
                                    NULL);
     object_class_property_add_bool(oc, "static", get_is_static,
                                    NULL);
     object_class_property_add_str(oc, "description", get_description, NULL);
+
+    for (feat = 0; feat < S390_FEAT_MAX; feat++) {
+        const S390FeatDef *def = s390_feat_def(feat);
+        object_class_property_add(oc, def->name, "bool", get_feature,
+                                  set_feature, NULL, (void *) feat);
+        object_class_property_set_description(oc, def->name, def->desc);
+    }
+    for (group = 0; group < S390_FEAT_GROUP_MAX; group++) {
+        const S390FeatGroupDef *def = s390_feat_group_def(group);
+        object_class_property_add(oc, def->name, "bool", get_feature_group,
+                                  set_feature_group, NULL, (void *) group);
+        object_class_property_set_description(oc, def->name, def->desc);
+    }
 }
 
 #ifdef CONFIG_KVM
-- 
2.26.2


