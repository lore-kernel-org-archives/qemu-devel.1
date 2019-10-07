Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E25C47404
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 17:13:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7741E206C0
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 17:13:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7741E206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47970 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHWZO-0004jw-6N
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 13:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36927)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1iHWT2-0006LT-22
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 13:06:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1iHWT0-0004rL-Sq
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 13:06:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47802)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>)
 id 1iHWSx-0004pu-KH; Mon, 07 Oct 2019 13:06:36 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C0BC710C050B;
 Mon,  7 Oct 2019 17:06:34 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 77FF65D9C9;
 Mon,  7 Oct 2019 17:06:33 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Subject: [RFC PATCH 4/5] tests/arm-cpu-features: Check feature default values
Date: Mon,  7 Oct 2019 19:06:21 +0200
Message-Id: <20191007170622.1814-5-drjones@redhat.com>
In-Reply-To: <20191007170622.1814-1-drjones@redhat.com>
References: <20191007170622.1814-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Mon, 07 Oct 2019 17:06:34 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: peter.maydell@linaro.org, bijan.mottahedeh@oracle.com, maz@kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If we know what the default value should be then we can test for
that as well as the feature existence.

Signed-off-by: Andrew Jones <drjones@redhat.com>
---
 tests/arm-cpu-features.c | 44 ++++++++++++++++++++++++++++++++--------
 1 file changed, 35 insertions(+), 9 deletions(-)

diff --git a/tests/arm-cpu-features.c b/tests/arm-cpu-features.c
index 92668efb8f56..ee444b04010f 100644
--- a/tests/arm-cpu-features.c
+++ b/tests/arm-cpu-features.c
@@ -141,6 +141,32 @@ static bool resp_get_feature(QDict *resp, const char=
 *feature)
     qobject_unref(_resp);                                              \
 })
=20
+#define assert_has_feature_enabled(qts, cpu_type, feature)             \
+({                                                                     \
+    QDict *_resp, *_props;                                             \
+                                                                       \
+    _resp =3D do_query_no_props(qts, cpu_type);                         =
 \
+    g_assert(_resp);                                                   \
+    g_assert(resp_has_props(_resp));                                   \
+    _props =3D resp_get_props(_resp);                                   =
 \
+    g_assert(qdict_get(_props, feature));                              \
+    g_assert(qdict_get_bool(_props, feature));                         \
+    qobject_unref(_resp);                                              \
+})
+
+#define assert_has_feature_disabled(qts, cpu_type, feature)            \
+({                                                                     \
+    QDict *_resp, *_props;                                             \
+                                                                       \
+    _resp =3D do_query_no_props(qts, cpu_type);                         =
 \
+    g_assert(_resp);                                                   \
+    g_assert(resp_has_props(_resp));                                   \
+    _props =3D resp_get_props(_resp);                                   =
 \
+    g_assert(qdict_get(_props, feature));                              \
+    g_assert(!qdict_get_bool(_props, feature));                        \
+    qobject_unref(_resp);                                              \
+})
+
 static void assert_type_full(QTestState *qts)
 {
     const char *error;
@@ -387,16 +413,16 @@ static void test_query_cpu_model_expansion(const vo=
id *data)
     assert_error(qts, "host", "The CPU type 'host' requires KVM", NULL);
=20
     /* Test expected feature presence/absence for some cpu types */
-    assert_has_feature(qts, "max", "pmu");
-    assert_has_feature(qts, "cortex-a15", "pmu");
+    assert_has_feature_enabled(qts, "max", "pmu");
+    assert_has_feature_enabled(qts, "cortex-a15", "pmu");
     assert_has_not_feature(qts, "cortex-a15", "aarch64");
=20
     if (g_str_equal(qtest_get_arch(), "aarch64")) {
-        assert_has_feature(qts, "max", "aarch64");
-        assert_has_feature(qts, "max", "sve");
-        assert_has_feature(qts, "max", "sve128");
-        assert_has_feature(qts, "cortex-a57", "pmu");
-        assert_has_feature(qts, "cortex-a57", "aarch64");
+        assert_has_feature_enabled(qts, "max", "aarch64");
+        assert_has_feature_enabled(qts, "max", "sve");
+        assert_has_feature_enabled(qts, "max", "sve128");
+        assert_has_feature_enabled(qts, "cortex-a57", "pmu");
+        assert_has_feature_enabled(qts, "cortex-a57", "aarch64");
=20
         sve_tests_default(qts, "max");
=20
@@ -417,7 +443,7 @@ static void test_query_cpu_model_expansion_kvm(const =
void *data)
=20
     qts =3D qtest_init(MACHINE "-accel kvm -cpu host");
=20
-    assert_has_feature(qts, "host", "pmu");
+    assert_has_feature_enabled(qts, "host", "pmu");
=20
     if (g_str_equal(qtest_get_arch(), "aarch64")) {
         bool kvm_supports_sve;
@@ -427,7 +453,7 @@ static void test_query_cpu_model_expansion_kvm(const =
void *data)
         QDict *resp;
         char *error;
=20
-        assert_has_feature(qts, "host", "aarch64");
+        assert_has_feature_enabled(qts, "host", "aarch64");
=20
         assert_error(qts, "cortex-a15",
             "We cannot guarantee the CPU type 'cortex-a15' works "
--=20
2.20.1


