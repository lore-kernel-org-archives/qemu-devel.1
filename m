Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F832C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 10:16:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF91220684
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 10:16:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tk/EfL/0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF91220684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itU6E-0003sN-Uw
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 05:16:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34048)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <drjones@redhat.com>) id 1itU16-0005XU-Kr
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:10:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <drjones@redhat.com>) id 1itU12-00036b-VC
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:10:44 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49019
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <drjones@redhat.com>) id 1itU12-00036O-R0
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 05:10:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579515040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=InD8eLFdEd7P2dOOJgZ5WOfz83jfIZ31XEZBRwEDSHw=;
 b=Tk/EfL/0lD0A87EfKSFUlgKmaaAm0Egf+bvGiWd37WA2JiDmbh3MbhWjnDSReh7vdk6ViD
 6BR5Zb9ntbBnuCHtE9x+tdUqlFSbg9eA4dwJZuCw9+NCZK28UyPOk/QJuydUf2WWKpDNsF
 iPu1hk/nMzFM2upsEh7n98zzCQfgEYs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-76-I3PRj7aCPx67PR4fHhsE_w-1; Mon, 20 Jan 2020 05:10:36 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29449107ACCA;
 Mon, 20 Jan 2020 10:10:35 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 602B98BE01;
 Mon, 20 Jan 2020 10:10:33 +0000 (UTC)
From: Andrew Jones <drjones@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org
Subject: [RFC PATCH v3 4/6] tests/arm-cpu-features: Check feature default
 values
Date: Mon, 20 Jan 2020 11:10:21 +0100
Message-Id: <20200120101023.16030-5-drjones@redhat.com>
In-Reply-To: <20200120101023.16030-1-drjones@redhat.com>
References: <20200120101023.16030-1-drjones@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: I3PRj7aCPx67PR4fHhsE_w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: peter.maydell@linaro.org, bijan.mottahedeh@oracle.com, maz@kernel.org,
 richard.henderson@linaro.org, guoheyi@huawei.com, msys.mizuma@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If we know what the default value should be then we can test for
that as well as the feature existence.

Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 tests/qtest/arm-cpu-features.c | 37 +++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/tests/qtest/arm-cpu-features.c b/tests/qtest/arm-cpu-features.=
c
index bef3ed24b604..a039e3c8d724 100644
--- a/tests/qtest/arm-cpu-features.c
+++ b/tests/qtest/arm-cpu-features.c
@@ -159,6 +159,25 @@ static bool resp_get_feature(QDict *resp, const char *=
feature)
     qobject_unref(_resp);                                              \
 })
=20
+#define assert_feature(qts, cpu_type, feature, expected_value)         \
+({                                                                     \
+    QDict *_resp, *_props;                                             \
+                                                                       \
+    _resp =3D do_query_no_props(qts, cpu_type);                          \
+    g_assert(_resp);                                                   \
+    g_assert(resp_has_props(_resp));                                   \
+    _props =3D resp_get_props(_resp);                                    \
+    g_assert(qdict_get(_props, feature));                              \
+    g_assert(qdict_get_bool(_props, feature) =3D=3D (expected_value));    =
 \
+    qobject_unref(_resp);                                              \
+})
+
+#define assert_has_feature_enabled(qts, cpu_type, feature)             \
+    assert_feature(qts, cpu_type, feature, true)
+
+#define assert_has_feature_disabled(qts, cpu_type, feature)            \
+    assert_feature(qts, cpu_type, feature, false)
+
 static void assert_type_full(QTestState *qts)
 {
     const char *error;
@@ -405,16 +424,16 @@ static void test_query_cpu_model_expansion(const void=
 *data)
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
@@ -451,8 +470,8 @@ static void test_query_cpu_model_expansion_kvm(const vo=
id *data)
         QDict *resp;
         char *error;
=20
-        assert_has_feature(qts, "host", "aarch64");
-        assert_has_feature(qts, "host", "pmu");
+        assert_has_feature_enabled(qts, "host", "aarch64");
+        assert_has_feature_enabled(qts, "host", "pmu");
=20
         assert_error(qts, "cortex-a15",
             "We cannot guarantee the CPU type 'cortex-a15' works "
--=20
2.21.1


