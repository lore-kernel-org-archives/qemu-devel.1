Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11CC0C4727F
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:45:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DC112158C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 14:45:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BAJC5M41"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC112158C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51136 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNzpO-0002Ia-7c
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 10:45:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41138)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNzmg-0007MM-Bd
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:42:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56326)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kNzmb-0002E0-0j
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 10:42:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601563328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=13dFYoU6KvfqYyBOP1RLSUELKZQPOuaHJ8QYH3lau34=;
 b=BAJC5M41zf1AAgYqMOW9lah3fXDlsFm9sD/DABlOe7kameH4X/WJ8BYe1SNzAitiCzPkzv
 nxuilhB60xvMtJ1EJHvACeodXb+3sVZXAOb2+J84aXWRUhJpxmupGLPycT8ZkSUARFeruL
 XuVvrh+RQUVlEmabWfKpvGlNSxK1ej8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436--a3oxEwWOeqR_MWeyVB16Q-1; Thu, 01 Oct 2020 10:42:06 -0400
X-MC-Unique: -a3oxEwWOeqR_MWeyVB16Q-1
Received: by mail-wm1-f72.google.com with SMTP id f2so384010wml.6
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 07:42:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=13dFYoU6KvfqYyBOP1RLSUELKZQPOuaHJ8QYH3lau34=;
 b=cEF8QW3i6ESYzYk9Oj0lZLmQllxJnVN8d6oKf4Jx2Zn6M+3kKshOPvVEzZiiowhnGG
 Jo18w/j3Zbr+WY+D9lPFpiqt5RhPMA7An8Cb8dxWE3ovUEyxAf3O1dcrWA2MF1prtDl1
 wBKwUXM/Q32j+PHYUNVUbk9W4Mz7FPFb/F4UM4UyXw3XpJapiY0jncbmxSBC2neeHJpJ
 NU+f/3AHsKfRynujPSpPTU2Jij/I78TCj8gYJi03M/JYEFz1047T6U8L25GdwAx1lESg
 KAnwe2UhMHKU9a2HvcWwVQi4jQUL/5qChVhydlc9h94ja2ZXHhuOrDwQ5DWKe8Dmytoy
 +YxQ==
X-Gm-Message-State: AOAM532urSi8ELHxeros2ClhdqkYby9WZeveF5WUIxS+EJzp0gL2PE4Y
 9+upnZel861Zw6OCMEGPPTIvmx74JAVhOY67yWS9ivxXGZ0+LXH3sLJEq9BnBtHBFeUaUd7IGB6
 qwco/fqx7baU4K/w=
X-Received: by 2002:a05:6000:151:: with SMTP id
 r17mr9251136wrx.311.1601563325333; 
 Thu, 01 Oct 2020 07:42:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxrzt9S3V7X1vy2AEYQIyqcVrhP7bOQbPWynLiIbO1fC4A1y5IZ7wB2zXD9goNUo4cVKkvc5w==
X-Received: by 2002:a05:6000:151:: with SMTP id
 r17mr9251103wrx.311.1601563325121; 
 Thu, 01 Oct 2020 07:42:05 -0700 (PDT)
Received: from x1w.redhat.com (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id o194sm301374wme.24.2020.10.01.07.42.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 07:42:04 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Laurent Vivier <laurent@vivier.eu>,
	qemu-devel@nongnu.org
Subject: [PATCH v4 2/3] target/i386/cpu: Restrict some of feature-words uses
 to system-mode
Date: Thu,  1 Oct 2020 16:41:51 +0200
Message-Id: <20201001144152.1555659-3-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201001144152.1555659-1-philmd@redhat.com>
References: <20201001144152.1555659-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 02:15:30
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The feature-words properties are not used in user-mode emulation,
restrict it to system-mode.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 target/i386/cpu.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 2eec53ca22..9f72342506 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -4607,6 +4607,7 @@ static void x86_cpuid_set_tsc_freq(Object *obj, Visitor *v, const char *name,
     cpu->env.tsc_khz = cpu->env.user_tsc_khz = value / 1000;
 }
 
+#if !defined(CONFIG_USER_ONLY)
 /* Generic getter for "feature-words" and "filtered-features" properties */
 static void x86_cpu_get_feature_words(Object *obj, Visitor *v,
                                       const char *name, void *opaque,
@@ -4666,6 +4667,7 @@ static const char *x86_cpu_feature_name(FeatureWord w, int bitnr)
     assert(bitnr < 32 || !(name && feature_word_info[w].type == CPUID_FEATURE_WORD));
     return name;
 }
+#endif /* CONFIG_USER_ONLY */
 
 /*
  * Convert all '_' in a feature string option name to '-', to make feature
@@ -4783,6 +4785,7 @@ static void x86_cpu_parse_featurestr(const char *typename, char *features,
 static void x86_cpu_expand_features(X86CPU *cpu, Error **errp);
 static void x86_cpu_filter_features(X86CPU *cpu, bool verbose);
 
+#if !defined(CONFIG_USER_ONLY)
 /* Build a list with the name of all features on a feature word array */
 static void x86_cpu_list_feature_names(FeatureWordArray features,
                                        strList **feat_names)
@@ -4853,6 +4856,7 @@ static void x86_cpu_class_check_missing_features(X86CPUClass *xcc,
 
     object_unref(OBJECT(xc));
 }
+#endif /* CONFIG_USER_ONLY */
 
 /* Print all cpuid feature names in featureset
  */
@@ -4987,7 +4991,9 @@ static void x86_cpu_definition_entry(gpointer data, gpointer user_data)
 
     info = g_malloc0(sizeof(*info));
     info->name = x86_cpu_class_get_model_name(cc);
+#if !defined(CONFIG_USER_ONLY)
     x86_cpu_class_check_missing_features(cc, &info->unavailable_features);
+#endif
     info->has_unavailable_features = true;
     info->q_typename = g_strdup(object_class_get_name(oc));
     info->migration_safe = cc->migration_safe;
@@ -6941,6 +6947,7 @@ static void x86_cpu_initfn(Object *obj)
     object_property_add(obj, "tsc-frequency", "int",
                         x86_cpuid_get_tsc_freq,
                         x86_cpuid_set_tsc_freq, NULL, NULL);
+#if !defined(CONFIG_USER_ONLY)
     object_property_add(obj, "feature-words", "X86CPUFeatureWordInfo",
                         x86_cpu_get_feature_words,
                         NULL, NULL, (void *)env->features);
@@ -6957,7 +6964,6 @@ static void x86_cpu_initfn(Object *obj)
                         x86_cpu_get_unavailable_features,
                         NULL, NULL, NULL);
 
-#if !defined(CONFIG_USER_ONLY)
     object_property_add(obj, "crash-information", "GuestPanicInformation",
                         x86_cpu_get_crash_info_qom, NULL, NULL, NULL);
 #endif
-- 
2.26.2


