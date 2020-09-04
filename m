Return-Path: <SRS0=8bV5=CN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,
	DATE_IN_FUTURE_06_12,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E913AC43461
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 07:20:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7DDD206D4
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2020 07:20:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7DDD206D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kE61B-00047H-Iq
	for qemu-devel@archiver.kernel.org; Fri, 04 Sep 2020 03:20:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33560)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pannengyuan@huawei.com>)
 id 1kE60a-0003a9-Nj
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 03:19:40 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55854 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pannengyuan@huawei.com>)
 id 1kE60Y-00046M-4v
 for qemu-devel@nongnu.org; Fri, 04 Sep 2020 03:19:40 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 4357D56638D3A8ECE35B;
 Fri,  4 Sep 2020 15:19:23 +0800 (CST)
Received: from opensource.huawei.com (10.175.100.152) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Fri, 4 Sep 2020 15:19:14 +0800
From: Pan Nengyuan <pannengyuan@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH] target/i386/cpu: add return value verification and ignore
 Error objects
Date: Fri, 4 Sep 2020 09:45:29 -0400
Message-ID: <20200904134529.1317-1-pannengyuan@huawei.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.100.152]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.35;
 envelope-from=pannengyuan@huawei.com; helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/04 03:19:24
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DATE_IN_FUTURE_06_12=1.947,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: zhang.zhanghailiang@huawei.com, Pan Nengyuan <pannengyuan@huawei.com>,
 kuhn.chenqun@huawei.com, pbonzini@redhat.com, rth@twiddle.net,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

'err' is unnecessary in x86_cpu_class_check_missing_features(), we can change x86_cpu_expand_features()
to return true on success, false on failure, then pass NULL here to remove it.

Signed-off-by: Pan Nengyuan <pannengyuan@huawei.com>
Suggested-by: Markus Armbruster <armbru@redhat.com>
---
 target/i386/cpu.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 49d8958528..c3d3766133 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4883,7 +4883,7 @@ static void x86_cpu_parse_featurestr(const char *typename, char *features,
     }
 }
 
-static void x86_cpu_expand_features(X86CPU *cpu, Error **errp);
+static bool x86_cpu_expand_features(X86CPU *cpu, Error **errp);
 static void x86_cpu_filter_features(X86CPU *cpu, bool verbose);
 
 /* Build a list with the name of all features on a feature word array */
@@ -4925,7 +4925,6 @@ static void x86_cpu_class_check_missing_features(X86CPUClass *xcc,
                                                  strList **missing_feats)
 {
     X86CPU *xc;
-    Error *err = NULL;
     strList **next = missing_feats;
 
     if (xcc->host_cpuid_required && !accel_uses_host_cpuid()) {
@@ -4937,8 +4936,7 @@ static void x86_cpu_class_check_missing_features(X86CPUClass *xcc,
 
     xc = X86_CPU(object_new_with_class(OBJECT_CLASS(xcc)));
 
-    x86_cpu_expand_features(xc, &err);
-    if (err) {
+    if (!x86_cpu_expand_features(xc, NULL)) {
         /* Errors at x86_cpu_expand_features should never happen,
          * but in case it does, just report the model as not
          * runnable at all using the "type" property.
@@ -4947,7 +4945,6 @@ static void x86_cpu_class_check_missing_features(X86CPUClass *xcc,
         new->value = g_strdup("type");
         *next = new;
         next = &new->next;
-        error_free(err);
     }
 
     x86_cpu_filter_features(xc, false);
@@ -6426,7 +6423,7 @@ static void x86_cpu_enable_xsave_components(X86CPU *cpu)
 /* Expand CPU configuration data, based on configured features
  * and host/accelerator capabilities when appropriate.
  */
-static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
+static bool x86_cpu_expand_features(X86CPU *cpu, Error **errp)
 {
     CPUX86State *env = &cpu->env;
     FeatureWord w;
@@ -6436,14 +6433,14 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
     for (l = plus_features; l; l = l->next) {
         const char *prop = l->data;
         if (!object_property_set_bool(OBJECT(cpu), prop, true, errp)) {
-            return;
+            return false;
         }
     }
 
     for (l = minus_features; l; l = l->next) {
         const char *prop = l->data;
         if (!object_property_set_bool(OBJECT(cpu), prop, false, errp)) {
-            return;
+            return false;
         }
     }
 
@@ -6540,6 +6537,8 @@ static void x86_cpu_expand_features(X86CPU *cpu, Error **errp)
     if (env->cpuid_xlevel2 == UINT32_MAX) {
         env->cpuid_xlevel2 = env->cpuid_min_xlevel2;
     }
+
+    return true;
 }
 
 /*
-- 
2.18.2


