Return-Path: <SRS0=5Zkg=SY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C4DC10F11
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 23:57:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE56420665
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2019 23:57:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE56420665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45765 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIioj-0006sa-4H
	for qemu-devel@archiver.kernel.org; Mon, 22 Apr 2019 19:57:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hIimm-00058J-0I
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 19:55:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hIif5-0005hx-LU
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 19:47:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49898)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hIif5-0005hg-Fg
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 19:47:47 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A8ED130842AC;
	Mon, 22 Apr 2019 23:47:46 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3B0CA5D9CA;
	Mon, 22 Apr 2019 23:47:46 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 22 Apr 2019 20:47:41 -0300
Message-Id: <20190422234742.15780-2-ehabkost@redhat.com>
In-Reply-To: <20190422234742.15780-1-ehabkost@redhat.com>
References: <20190422234742.15780-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.40]);
	Mon, 22 Apr 2019 23:47:46 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 1/2] i386: x86_cpu_list_feature_names() function
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jiri Denemark <jdenemar@redhat.com>,
	Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190422234741.NySZ1Th49L3V22yfs4WmTsCKIpWt2tjNAkQ0P7Mcg_A@z>

Extract feature name listing code from
x86_cpu_class_check_missing_features().  It will be reused to
return information about CPU filtered features at runtime.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 35 ++++++++++++++++++++++-------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index d6bb57d210..23e55a9ef2 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -3619,6 +3619,27 @@ static void x86_cpu_parse_featurestr(const char *typename, char *features,
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
@@ -3626,7 +3647,6 @@ static void x86_cpu_class_check_missing_features(X86CPUClass *xcc,
                                                  strList **missing_feats)
 {
     X86CPU *xc;
-    FeatureWord w;
     Error *err = NULL;
     strList **next = missing_feats;
 
@@ -3653,18 +3673,7 @@ static void x86_cpu_class_check_missing_features(X86CPUClass *xcc,
 
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


