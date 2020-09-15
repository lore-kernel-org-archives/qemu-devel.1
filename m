Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9174C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 03:16:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A3A2208DB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 03:16:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RHf8GeW8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A3A2208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33552 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI1SY-0007Ka-DH
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 23:16:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48294)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kI1OK-0000lr-Cl
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 23:12:24 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:54641)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <haibo.xu@linaro.org>)
 id 1kI1OH-0001mG-6c
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 23:12:23 -0400
Received: by mail-pj1-x1041.google.com with SMTP id mm21so1025400pjb.4
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 20:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=lp4BszfnJ+gdPupxEQ8UJGzcoaSEVDtxDHyalqIp0D8=;
 b=RHf8GeW8AEcF92GFgKkUWgx5WG3YJ2UpWvclfMwROGJbx17e+BzUqG3qEM7wckkhEt
 F1MEDsYjynMHnEEQJSOhUx1miUDypfSQbXEJaOZ7xrwcePJ4O4cuMKaRaKOGq5WKzOIs
 6y/wbF83g9cbpumm7OPRfniYgNdkiuyPJD9CXcZ5UCHfNdf2LhEPD9uWiCEEBLsyePkM
 wEO5vYqPdAyO2e6U1N1VJdSkV4KF/bg2wz6d77WiW40q+wTaqphxosr6jbViJMb/9LmP
 11btLz78Et1s2MjI3B/T9TOoyvSbRKHSqjs2YCP6z5vMxImfdyMuK3CDwCB4HlP8LKnA
 uF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=lp4BszfnJ+gdPupxEQ8UJGzcoaSEVDtxDHyalqIp0D8=;
 b=F6t4RZ41o+FIaiftFzT06w9m1ecx73gqjkvqr21cTYcvCmz9zzjNLfnVEKs7+lfaRt
 2kOb0SxiAF+4fSVgdELlwUlE5pUonyVCphKtg/lrfRMrtX3Wmi3qz087lFp8hseWRPCB
 JNkdRgBDGk/xx1CAl+b7Urol0CCzIXG9tNkk6m7ktj+3alI26XzruXCeGKlPB47g0JDW
 6wHVV5M7hB1VoDcHp8BWhPdQUT6jigFFyE6OqmUDX4TaulJgnGlPaAJPWPfL3djclRxR
 lEGS1o31L+25xAz2wvSTgH6NH06bYcIk6ClBcgDZZe4wwD/nBeidrDG6XzzFPMlMgCVA
 lV7A==
X-Gm-Message-State: AOAM532gJQVVB8O0AMDKcnEy/NCP87IfphcgMB79WJHqOslhTBUPwnrP
 54uFgX2jckcBpS8w7gpPxXRZ
X-Google-Smtp-Source: ABdhPJyD7Hnd+o0WdBhdPGftjYArmea1o5YPWFDqXsjLxZsFfMjuBLsbaBZLnsqbBOLPt8rq5UVgYg==
X-Received: by 2002:a17:902:c407:: with SMTP id
 k7mr17105381plk.95.1600139539771; 
 Mon, 14 Sep 2020 20:12:19 -0700 (PDT)
Received: from localhost.localdomain ([147.75.106.138])
 by smtp.gmail.com with ESMTPSA id g23sm11551776pfh.133.2020.09.14.20.12.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 20:12:19 -0700 (PDT)
From: Haibo Xu <haibo.xu@linaro.org>
To: drjones@redhat.com,
	richard.henderson@linaro.org
Subject: [PATCH v3 12/12] target/arm: spe: Add corresponding test.
Date: Tue, 15 Sep 2020 03:11:48 +0000
Message-Id: <53adf9e25750962eca7dd09f924c97bb17c1214a.1600135462.git.haibo.xu@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1600135462.git.haibo.xu@linaro.org>
References: <cover.1600135462.git.haibo.xu@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=haibo.xu@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, philmd@redhat.com,
 qemu-devel@nongnu.org, Haibo Xu <haibo.xu@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Haibo Xu <haibo.xu@linaro.org>
---
 target/arm/monitor.c           | 2 +-
 tests/qtest/arm-cpu-features.c | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/arm/monitor.c b/target/arm/monitor.c
index ba6e01abd0..1b8f08988a 100644
--- a/target/arm/monitor.c
+++ b/target/arm/monitor.c
@@ -99,7 +99,7 @@ QEMU_BUILD_BUG_ON(ARM_MAX_VQ > 16);
  * then the order that considers those dependencies must be used.
  */
 static const char *cpu_model_advertised_features[] = {
-    "aarch64", "pmu", "sve",
+    "aarch64", "pmu", "spe", "sve",
     "sve128", "sve256", "sve384", "sve512",
     "sve640", "sve768", "sve896", "sve1024", "sve1152", "sve1280",
     "sve1408", "sve1536", "sve1664", "sve1792", "sve1920", "sve2048",
diff --git a/tests/qtest/arm-cpu-features.c b/tests/qtest/arm-cpu-features.c
index 77b5e30a9c..4d393fb2e2 100644
--- a/tests/qtest/arm-cpu-features.c
+++ b/tests/qtest/arm-cpu-features.c
@@ -494,6 +494,7 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
 
     if (g_str_equal(qtest_get_arch(), "aarch64")) {
         bool kvm_supports_sve;
+        bool kvm_supports_spe;
         char max_name[8], name[8];
         uint32_t max_vq, vq;
         uint64_t vls;
@@ -512,8 +513,10 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
             "with KVM on this host", NULL);
 
         assert_has_feature(qts, "host", "sve");
+        assert_has_feature(qts, "host", "spe");
         resp = do_query_no_props(qts, "host");
         kvm_supports_sve = resp_get_feature(resp, "sve");
+        kvm_supports_spe = resp_get_feature(resp, "spe");
         vls = resp_get_sve_vls(resp);
         qobject_unref(resp);
 
@@ -573,10 +576,16 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
         } else {
             g_assert(vls == 0);
         }
+
+        if (kvm_supports_spe) {
+                assert_set_feature(qts, "host", "spe", false);
+                assert_set_feature(qts, "host", "spe", true);
+        }
     } else {
         assert_has_not_feature(qts, "host", "aarch64");
         assert_has_not_feature(qts, "host", "pmu");
         assert_has_not_feature(qts, "host", "sve");
+        assert_has_not_feature(qts, "host", "spe");
     }
 
     qtest_quit(qts);
-- 
2.17.1


