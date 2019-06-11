Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD21C43218
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 14:10:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1756F20652
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 14:10:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1756F20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59330 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hahTM-0005LA-4w
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 10:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56709)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hah3H-0007Nt-6U
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 09:43:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hah3G-00020q-21
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 09:43:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52046)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hah3F-0001dF-Sj
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 09:43:01 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BCCD2223883;
 Tue, 11 Jun 2019 13:42:30 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A094019C59;
 Tue, 11 Jun 2019 13:42:28 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Tue, 11 Jun 2019 10:42:22 -0300
Message-Id: <20190611134224.6683-2-ehabkost@redhat.com>
In-Reply-To: <20190611134224.6683-1-ehabkost@redhat.com>
References: <20190611134224.6683-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Tue, 11 Jun 2019 13:42:33 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 1/3] i386: x86_cpu_list_feature_names() function
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Extract feature name listing code from
x86_cpu_class_check_missing_features().  It will be reused to
return information about CPU filtered features at runtime.

Message-Id: <20190422234742.15780-2-ehabkost@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b21ecaac17..36589adb1f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3671,6 +3671,27 @@ static void x86_cpu_parse_featurestr(const char *typename, char *features,
 static void x86_cpu_expand_features(X86CPU *cpu, Error **errp);
 static int x86_cpu_filter_features(X86CPU *cpu);
 
+/* Build a list with the name of all features on a feature word array */
+static void x86_cpu_list_feature_names(FeatureWordArray features,
+                                       strList **feat_names)
+{
+    FeatureWord w;
+    strList **next = feat_names;
+
+    for (w = 0; w < FEATURE_WORDS; w++) {
+        uint32_t filtered = features[w];
+        int i;
+        for (i = 0; i < 32; i++) {
+            if (filtered & (1UL << i)) {
+                strList *new = g_new0(strList, 1);
+                new->value = g_strdup(x86_cpu_feature_name(w, i));
+                *next = new;
+                next = &new->next;
+            }
+        }
+    }
+}
+
 /* Check for missing features that may prevent the CPU class from
  * running using the current machine and accelerator.
  */
@@ -3678,7 +3699,6 @@ static void x86_cpu_class_check_missing_features(X86CPUClass *xcc,
                                                  strList **missing_feats)
 {
     X86CPU *xc;
-    FeatureWord w;
     Error *err = NULL;
     strList **next = missing_feats;
 
@@ -3705,18 +3725,7 @@ static void x86_cpu_class_check_missing_features(X86CPUClass *xcc,
 
     x86_cpu_filter_features(xc);
 
-    for (w = 0; w < FEATURE_WORDS; w++) {
-        uint32_t filtered = xc->filtered_features[w];
-        int i;
-        for (i = 0; i < 32; i++) {
-            if (filtered & (1UL << i)) {
-                strList *new = g_new0(strList, 1);
-                new->value = g_strdup(x86_cpu_feature_name(w, i));
-                *next = new;
-                next = &new->next;
-            }
-        }
-    }
+    x86_cpu_list_feature_names(xc->filtered_features, next);
 
     object_unref(OBJECT(xc));
 }
-- 
2.18.0.rc1.1.g3f1ff2140


