Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1418DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:08:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8B5820702
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 09:08:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IF2nMmUC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8B5820702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnevE-0000uq-58
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 05:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46112)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnet3-0006Qd-6e
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 05:06:37 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53414
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jnet0-00033S-Ii
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 05:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592903193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NFodWqskMtC/5PQ2GwuPpH+2hReee1VihIY8eKIqRQU=;
 b=IF2nMmUCY/0Aj9Q4bBsRtp+nd/TNmZ1DsgCXMqNvRFLRoguIAUhwGe8Nmc1u6GfpWV2lPO
 Kp6hZpqh49omBNSrhyaJGwPP7oNEoAHnP3Ai8i5bMDzm3x0tlDl7KwJeSSE+PyMDHuC8D3
 Zz0HZcnhHs6JY78CPB0nFr7689DnH3g=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-C7o0gJhNNuSd_pLb8VZ4jg-1; Tue, 23 Jun 2020 05:06:32 -0400
X-MC-Unique: C7o0gJhNNuSd_pLb8VZ4jg-1
Received: by mail-wm1-f69.google.com with SMTP id a7so3215945wmf.1
 for <qemu-devel@nongnu.org>; Tue, 23 Jun 2020 02:06:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NFodWqskMtC/5PQ2GwuPpH+2hReee1VihIY8eKIqRQU=;
 b=UbNMtTpyGG4YRotfn711PzKJkjCAM5hc58HKveBlNWU4URE7uYVVIQU+Y2b3KP0jF2
 a94POOJDw7K3O3HPEMo9DToIDn564QCeuJJLtpH+912V9h0JUVOhpQcujI2P7DtD7sbx
 bx8+x+4FVzKhddgGvO8ScXDuV0LgyRvDiAoph594lei1JUAiHjQ7yN8lBd9i3v2gdTEX
 9deJG83bU5GmWej0GMuO0itwUkjtCrMQme++LK3kdyKj5r45xt8A0Kjgmq3349PrWSYd
 aIDNbF8RM2nv2IKkq9aQwrgGLwZewY9/tZXNxOAP3LOCz9jq4eAyX2AaFW5GWy92iV02
 1Tpw==
X-Gm-Message-State: AOAM532lLmh7SbslM1XA7Rl5ZBtWjxDlx+h9njADXqNnhp5yDk+xIC7d
 Wp8dpkqseUxTpcIwMF0fUd6Jum1KDJITnKjx3YE64IhEbvD90tAVQBdmIXdQiNN8uIwwJ43b9df
 4TlzmFHVoIkW4Nlk=
X-Received: by 2002:adf:fa81:: with SMTP id h1mr13967366wrr.266.1592903190739; 
 Tue, 23 Jun 2020 02:06:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYp7EOW24aIihuYBSTeyCt0a8qu7PFtl2vjpx6/D5IDweqkFR4nJCyT8X1HMCfow4T+lhWtA==
X-Received: by 2002:adf:fa81:: with SMTP id h1mr13967350wrr.266.1592903190490; 
 Tue, 23 Jun 2020 02:06:30 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id g195sm2896048wme.38.2020.06.23.02.06.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Jun 2020 02:06:30 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/2] tests/qtest/arm-cpu-features: Add feature setting tests
Date: Tue, 23 Jun 2020 11:06:21 +0200
Message-Id: <20200623090622.30365-2-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200623090622.30365-1-philmd@redhat.com>
References: <20200623090622.30365-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 01:53:54
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 kvm@vger.kernel.org, Andrew Jones <drjones@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrew Jones <drjones@redhat.com>

Some cpu features may be enabled and disabled for all configurations
that support the feature. Let's test that.

A recent regression[*] inspired adding these tests.

[*] '-cpu host,pmu=on' caused a segfault

Signed-off-by: Andrew Jones <drjones@redhat.com>
Message-Id: <20200623082310.17577-1-drjones@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/qtest/arm-cpu-features.c | 38 ++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/arm-cpu-features.c b/tests/qtest/arm-cpu-features.c
index 4692173676..f7e062c189 100644
--- a/tests/qtest/arm-cpu-features.c
+++ b/tests/qtest/arm-cpu-features.c
@@ -159,16 +159,35 @@ static bool resp_get_feature(QDict *resp, const char *feature)
     qobject_unref(_resp);                                              \
 })
 
-#define assert_feature(qts, cpu_type, feature, expected_value)         \
+#define resp_assert_feature(resp, feature, expected_value)             \
 ({                                                                     \
-    QDict *_resp, *_props;                                             \
+    QDict *_props;                                                     \
                                                                        \
-    _resp = do_query_no_props(qts, cpu_type);                          \
     g_assert(_resp);                                                   \
     g_assert(resp_has_props(_resp));                                   \
     _props = resp_get_props(_resp);                                    \
     g_assert(qdict_get(_props, feature));                              \
     g_assert(qdict_get_bool(_props, feature) == (expected_value));     \
+})
+
+#define assert_feature(qts, cpu_type, feature, expected_value)         \
+({                                                                     \
+    QDict *_resp;                                                      \
+                                                                       \
+    _resp = do_query_no_props(qts, cpu_type);                          \
+    g_assert(_resp);                                                   \
+    resp_assert_feature(_resp, feature, expected_value);               \
+    qobject_unref(_resp);                                              \
+})
+
+#define assert_set_feature(qts, cpu_type, feature, value)              \
+({                                                                     \
+    const char *_fmt = (value) ? "{ %s: true }" : "{ %s: false }";     \
+    QDict *_resp;                                                      \
+                                                                       \
+    _resp = do_query(qts, cpu_type, _fmt, feature);                    \
+    g_assert(_resp);                                                   \
+    resp_assert_feature(_resp, feature, value);                        \
     qobject_unref(_resp);                                              \
 })
 
@@ -424,10 +443,14 @@ static void test_query_cpu_model_expansion(const void *data)
     assert_error(qts, "host", "The CPU type 'host' requires KVM", NULL);
 
     /* Test expected feature presence/absence for some cpu types */
-    assert_has_feature_enabled(qts, "max", "pmu");
     assert_has_feature_enabled(qts, "cortex-a15", "pmu");
     assert_has_not_feature(qts, "cortex-a15", "aarch64");
 
+    /* Enabling and disabling pmu should always work. */
+    assert_has_feature_enabled(qts, "max", "pmu");
+    assert_set_feature(qts, "max", "pmu", false);
+    assert_set_feature(qts, "max", "pmu", true);
+
     assert_has_not_feature(qts, "max", "kvm-no-adjvtime");
 
     if (g_str_equal(qtest_get_arch(), "aarch64")) {
@@ -464,7 +487,10 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
         return;
     }
 
+    /* Enabling and disabling kvm-no-adjvtime should always work. */
     assert_has_feature_disabled(qts, "host", "kvm-no-adjvtime");
+    assert_set_feature(qts, "host", "kvm-no-adjvtime", true);
+    assert_set_feature(qts, "host", "kvm-no-adjvtime", false);
 
     if (g_str_equal(qtest_get_arch(), "aarch64")) {
         bool kvm_supports_sve;
@@ -475,7 +501,11 @@ static void test_query_cpu_model_expansion_kvm(const void *data)
         char *error;
 
         assert_has_feature_enabled(qts, "host", "aarch64");
+
+        /* Enabling and disabling pmu should always work. */
         assert_has_feature_enabled(qts, "host", "pmu");
+        assert_set_feature(qts, "host", "pmu", false);
+        assert_set_feature(qts, "host", "pmu", true);
 
         assert_error(qts, "cortex-a15",
             "We cannot guarantee the CPU type 'cortex-a15' works "
-- 
2.21.3


