Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20FCC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 08:24:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD5732072E
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 08:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VgH3Ei7Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD5732072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jneE2-0006O8-W8
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 04:24:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1jneD9-0005XY-3s
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 04:23:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38793
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <drjones@redhat.com>)
 id 1jneD7-0002cS-Ai
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 04:23:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592900596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=yVXF9LcaZskJ0tGfBcpzB27fYjUyPcnJagV17aQzJH8=;
 b=VgH3Ei7YLfqpxEgfTm6Zcb3tj3U3Ob0lI6uXtRNJxCoTEOhrw1rKiT0DsaHaoLkNBY6Vy1
 zF5y0HS5xLALpwNQ7IA83BYNF97joB8FtxkpY9FxKkgoJBhuzVM50DAyHIokyC3eylmr3p
 NwfyVrGdaLLLA5k1k7VOHgljmPXUKPc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414--Uf7Py9UNvq2JXEoR2LXIQ-1; Tue, 23 Jun 2020 04:23:14 -0400
X-MC-Unique: -Uf7Py9UNvq2JXEoR2LXIQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEA36100CCC0;
 Tue, 23 Jun 2020 08:23:13 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.40.193.84])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4E69910013D7;
 Tue, 23 Jun 2020 08:23:12 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Subject: [PATCH v2] tests/qtest/arm-cpu-features: Add feature setting tests
Date: Tue, 23 Jun 2020 10:23:10 +0200
Message-Id: <20200623082310.17577-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=drjones@redhat.com;
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
Cc: peter.maydell@linaro.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Some cpu features may be enabled and disabled for all configurations
that support the feature. Let's test that.

A recent regression[*] inspired adding these tests.

[*] '-cpu host,pmu=on' caused a segfault

Based-on: "target/arm: Check supported KVM features globally (not per vCPU)"
Signed-off-by: Andrew Jones <drjones@redhat.com>
---
Note: We need to apply this test change after the Based-on patch is
      applied in order to avoid breaking CI with segfaults.

v2:
  - When a feature is enabled by default set false first [Peter]
  - Add Based-on tag [Peter]
  - Also do the PMU setting test with TCG [drew]
  - Improve commit message [drew]
---
 tests/qtest/arm-cpu-features.c | 38 ++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/tests/qtest/arm-cpu-features.c b/tests/qtest/arm-cpu-features.c
index 469217367661..f7e062c1891e 100644
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
2.25.4


