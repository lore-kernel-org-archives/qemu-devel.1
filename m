Return-Path: <SRS0=V8KP=YZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85FDECA9ECF
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 08:59:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C817204FD
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2019 08:59:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DaQ9rMQ4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C817204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQSmh-0001K1-8j
	for qemu-devel@archiver.kernel.org; Fri, 01 Nov 2019 04:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56459)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iQSes-00011Y-40
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 04:51:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iQSep-0008JT-3u
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 04:51:49 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:32881)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iQSeo-0008Eu-SQ
 for qemu-devel@nongnu.org; Fri, 01 Nov 2019 04:51:47 -0400
Received: by mail-wr1-x436.google.com with SMTP id s1so8974612wro.0
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2019 01:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=cpklon7lgXWv3V0ZHDlYJqd8G/58j7vD/Z0D6CafQ/4=;
 b=DaQ9rMQ4fXPcKskmwk3wJL323XFfODyVR40TiPLuMIYH/eClsJx1LQ5sLz1YdUqTX9
 zQpsBweKoK8E508eK/vkDQatr07CP0N/q7NOeNdqSoMnXMv2QhVXvcb4h9my6DRgf/nh
 +jpFMqMzoPbMeJMZGv7o3gvKrZhYdxi6fG/dt41cyEqa0zVWvHygbaWVpfqi9JeAC/HL
 p1X3HSKicpQ+k4Ms7aCvwlNCRspuYFjTIUTR9/Yh9sC8NFofnVFraEOe1H6fn+zF9LWR
 ve4m3xzcDXBIatp2xXyXWf3FD6cIj4vwFihL0o8fpOZZo1x+P5ravsWhO4Vb4hBJj3SI
 WxOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=cpklon7lgXWv3V0ZHDlYJqd8G/58j7vD/Z0D6CafQ/4=;
 b=ovAz9VQ6z5X51vHJwflrnubKRJe0BgpVsnNCmCmYQIgMitj6OEuBjd8EPIM/nF795L
 D/e8T6BLxCkUdRnxefSKLW8mzyuKVqp+t+6lc2Si0n6CFJKiaYTz2PBd4DXd4oXor8/g
 QojXXxVALNssLemmVCBQlr6PlDN2MiGzodp+KPQai4mWm8JbLsgSaTrwp1g6Hb9MRYrK
 jWJebh7DeCx+ejjrY3Yauw4ai1lPGfknwVwrv7PSFfG+4CZ37HNAH3dTAQdOQSNkfY0V
 rnAFNUHmxOqFJ3k4DAY7ZqFnFPbUsT/VU3hDD+RnLz8NaXqY5sXL1BcaDdI3bbRqUAR4
 O2eQ==
X-Gm-Message-State: APjAAAXUf/nfgB1RbIbOd6v0FLqy35WE61mEcf1XG/EjlC7u8iGb/zwG
 wFKM+RgAYy++TCh9/RAxQSY6E80XU2s/Q6iA
X-Google-Smtp-Source: APXvYqy/IA+qO2ewHyXvCKfZINhBgZqefEGWc1fNnlHtKiyternybSqFDClsfibrfH4lJhlXvZjBzA==
X-Received: by 2002:adf:ff81:: with SMTP id j1mr607503wrr.98.1572598305514;
 Fri, 01 Nov 2019 01:51:45 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id d20sm8818922wra.4.2019.11.01.01.51.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Nov 2019 01:51:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 02/11] tests: arm: Introduce cpu feature tests
Date: Fri,  1 Nov 2019 08:51:31 +0000
Message-Id: <20191101085140.5205-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191101085140.5205-1-peter.maydell@linaro.org>
References: <20191101085140.5205-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrew Jones <drjones@redhat.com>

Now that Arm CPUs have advertised features lets add tests to ensure
we maintain their expected availability with and without KVM.

Signed-off-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Message-id: 20191031142734.8590-3-drjones@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/Makefile.include   |   5 +-
 tests/arm-cpu-features.c | 253 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 257 insertions(+), 1 deletion(-)
 create mode 100644 tests/arm-cpu-features.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 56f73b46e2a..534ee487436 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -262,6 +262,7 @@ check-qtest-sparc64-$(CONFIG_ISA_TESTDEV) = tests/endianness-test$(EXESUF)
 check-qtest-sparc64-y += tests/prom-env-test$(EXESUF)
 check-qtest-sparc64-y += tests/boot-serial-test$(EXESUF)
 
+check-qtest-arm-y += tests/arm-cpu-features$(EXESUF)
 check-qtest-arm-y += tests/microbit-test$(EXESUF)
 check-qtest-arm-y += tests/m25p80-test$(EXESUF)
 check-qtest-arm-y += tests/test-arm-mptimer$(EXESUF)
@@ -269,7 +270,8 @@ check-qtest-arm-y += tests/boot-serial-test$(EXESUF)
 check-qtest-arm-y += tests/hexloader-test$(EXESUF)
 check-qtest-arm-$(CONFIG_PFLASH_CFI02) += tests/pflash-cfi02-test$(EXESUF)
 
-check-qtest-aarch64-y = tests/numa-test$(EXESUF)
+check-qtest-aarch64-y += tests/arm-cpu-features$(EXESUF)
+check-qtest-aarch64-y += tests/numa-test$(EXESUF)
 check-qtest-aarch64-y += tests/boot-serial-test$(EXESUF)
 check-qtest-aarch64-y += tests/migration-test$(EXESUF)
 # TODO: once aarch64 TCG is fixed on ARM 32 bit host, make test unconditional
@@ -841,6 +843,7 @@ tests/test-qapi-util$(EXESUF): tests/test-qapi-util.o $(test-util-obj-y)
 tests/numa-test$(EXESUF): tests/numa-test.o
 tests/vmgenid-test$(EXESUF): tests/vmgenid-test.o tests/boot-sector.o tests/acpi-utils.o
 tests/cdrom-test$(EXESUF): tests/cdrom-test.o tests/boot-sector.o $(libqos-obj-y)
+tests/arm-cpu-features$(EXESUF): tests/arm-cpu-features.o
 
 tests/migration/stress$(EXESUF): tests/migration/stress.o
 	$(call quiet-command, $(LINKPROG) -static -O3 $(PTHREAD_LIB) -o $@ $< ,"LINK","$(TARGET_DIR)$@")
diff --git a/tests/arm-cpu-features.c b/tests/arm-cpu-features.c
new file mode 100644
index 00000000000..6ebb03d7ad6
--- /dev/null
+++ b/tests/arm-cpu-features.c
@@ -0,0 +1,253 @@
+/*
+ * Arm CPU feature test cases
+ *
+ * Copyright (c) 2019 Red Hat Inc.
+ * Authors:
+ *  Andrew Jones <drjones@redhat.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ */
+#include "qemu/osdep.h"
+#include "libqtest.h"
+#include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qjson.h"
+
+#define MACHINE     "-machine virt,gic-version=max,accel=tcg "
+#define MACHINE_KVM "-machine virt,gic-version=max,accel=kvm:tcg "
+#define QUERY_HEAD  "{ 'execute': 'query-cpu-model-expansion', " \
+                    "  'arguments': { 'type': 'full', "
+#define QUERY_TAIL  "}}"
+
+static bool kvm_enabled(QTestState *qts)
+{
+    QDict *resp, *qdict;
+    bool enabled;
+
+    resp = qtest_qmp(qts, "{ 'execute': 'query-kvm' }");
+    g_assert(qdict_haskey(resp, "return"));
+    qdict = qdict_get_qdict(resp, "return");
+    g_assert(qdict_haskey(qdict, "enabled"));
+    enabled = qdict_get_bool(qdict, "enabled");
+    qobject_unref(resp);
+
+    return enabled;
+}
+
+static QDict *do_query_no_props(QTestState *qts, const char *cpu_type)
+{
+    return qtest_qmp(qts, QUERY_HEAD "'model': { 'name': %s }"
+                          QUERY_TAIL, cpu_type);
+}
+
+static QDict *do_query(QTestState *qts, const char *cpu_type,
+                       const char *fmt, ...)
+{
+    QDict *resp;
+
+    if (fmt) {
+        QDict *args;
+        va_list ap;
+
+        va_start(ap, fmt);
+        args = qdict_from_vjsonf_nofail(fmt, ap);
+        va_end(ap);
+
+        resp = qtest_qmp(qts, QUERY_HEAD "'model': { 'name': %s, "
+                                                    "'props': %p }"
+                              QUERY_TAIL, cpu_type, args);
+    } else {
+        resp = do_query_no_props(qts, cpu_type);
+    }
+
+    return resp;
+}
+
+static const char *resp_get_error(QDict *resp)
+{
+    QDict *qdict;
+
+    g_assert(resp);
+
+    qdict = qdict_get_qdict(resp, "error");
+    if (qdict) {
+        return qdict_get_str(qdict, "desc");
+    }
+
+    return NULL;
+}
+
+#define assert_error(qts, cpu_type, expected_error, fmt, ...)          \
+({                                                                     \
+    QDict *_resp;                                                      \
+    const char *_error;                                                \
+                                                                       \
+    _resp = do_query(qts, cpu_type, fmt, ##__VA_ARGS__);               \
+    g_assert(_resp);                                                   \
+    _error = resp_get_error(_resp);                                    \
+    g_assert(_error);                                                  \
+    g_assert(g_str_equal(_error, expected_error));                     \
+    qobject_unref(_resp);                                              \
+})
+
+static bool resp_has_props(QDict *resp)
+{
+    QDict *qdict;
+
+    g_assert(resp);
+
+    if (!qdict_haskey(resp, "return")) {
+        return false;
+    }
+    qdict = qdict_get_qdict(resp, "return");
+
+    if (!qdict_haskey(qdict, "model")) {
+        return false;
+    }
+    qdict = qdict_get_qdict(qdict, "model");
+
+    return qdict_haskey(qdict, "props");
+}
+
+static QDict *resp_get_props(QDict *resp)
+{
+    QDict *qdict;
+
+    g_assert(resp);
+    g_assert(resp_has_props(resp));
+
+    qdict = qdict_get_qdict(resp, "return");
+    qdict = qdict_get_qdict(qdict, "model");
+    qdict = qdict_get_qdict(qdict, "props");
+
+    return qdict;
+}
+
+#define assert_has_feature(qts, cpu_type, feature)                     \
+({                                                                     \
+    QDict *_resp = do_query_no_props(qts, cpu_type);                   \
+    g_assert(_resp);                                                   \
+    g_assert(resp_has_props(_resp));                                   \
+    g_assert(qdict_get(resp_get_props(_resp), feature));               \
+    qobject_unref(_resp);                                              \
+})
+
+#define assert_has_not_feature(qts, cpu_type, feature)                 \
+({                                                                     \
+    QDict *_resp = do_query_no_props(qts, cpu_type);                   \
+    g_assert(_resp);                                                   \
+    g_assert(!resp_has_props(_resp) ||                                 \
+             !qdict_get(resp_get_props(_resp), feature));              \
+    qobject_unref(_resp);                                              \
+})
+
+static void assert_type_full(QTestState *qts)
+{
+    const char *error;
+    QDict *resp;
+
+    resp = qtest_qmp(qts, "{ 'execute': 'query-cpu-model-expansion', "
+                            "'arguments': { 'type': 'static', "
+                                           "'model': { 'name': 'foo' }}}");
+    g_assert(resp);
+    error = resp_get_error(resp);
+    g_assert(error);
+    g_assert(g_str_equal(error,
+                         "The requested expansion type is not supported"));
+    qobject_unref(resp);
+}
+
+static void assert_bad_props(QTestState *qts, const char *cpu_type)
+{
+    const char *error;
+    QDict *resp;
+
+    resp = qtest_qmp(qts, "{ 'execute': 'query-cpu-model-expansion', "
+                            "'arguments': { 'type': 'full', "
+                                           "'model': { 'name': %s, "
+                                                      "'props': false }}}",
+                     cpu_type);
+    g_assert(resp);
+    error = resp_get_error(resp);
+    g_assert(error);
+    g_assert(g_str_equal(error,
+                         "Invalid parameter type for 'props', expected: dict"));
+    qobject_unref(resp);
+}
+
+static void test_query_cpu_model_expansion(const void *data)
+{
+    QTestState *qts;
+
+    qts = qtest_init(MACHINE "-cpu max");
+
+    /* Test common query-cpu-model-expansion input validation */
+    assert_type_full(qts);
+    assert_bad_props(qts, "max");
+    assert_error(qts, "foo", "The CPU type 'foo' is not a recognized "
+                 "ARM CPU type", NULL);
+    assert_error(qts, "max", "Parameter 'not-a-prop' is unexpected",
+                 "{ 'not-a-prop': false }");
+    assert_error(qts, "host", "The CPU type 'host' requires KVM", NULL);
+
+    /* Test expected feature presence/absence for some cpu types */
+    assert_has_feature(qts, "max", "pmu");
+    assert_has_feature(qts, "cortex-a15", "pmu");
+    assert_has_not_feature(qts, "cortex-a15", "aarch64");
+
+    if (g_str_equal(qtest_get_arch(), "aarch64")) {
+        assert_has_feature(qts, "max", "aarch64");
+        assert_has_feature(qts, "cortex-a57", "pmu");
+        assert_has_feature(qts, "cortex-a57", "aarch64");
+
+        /* Test that features that depend on KVM generate errors without. */
+        assert_error(qts, "max",
+                     "'aarch64' feature cannot be disabled "
+                     "unless KVM is enabled and 32-bit EL1 "
+                     "is supported",
+                     "{ 'aarch64': false }");
+    }
+
+    qtest_quit(qts);
+}
+
+static void test_query_cpu_model_expansion_kvm(const void *data)
+{
+    QTestState *qts;
+
+    qts = qtest_init(MACHINE_KVM "-cpu max");
+
+    /*
+     * These tests target the 'host' CPU type, so KVM must be enabled.
+     */
+    if (!kvm_enabled(qts)) {
+        qtest_quit(qts);
+        return;
+    }
+
+    if (g_str_equal(qtest_get_arch(), "aarch64")) {
+        assert_has_feature(qts, "host", "aarch64");
+        assert_has_feature(qts, "host", "pmu");
+
+        assert_error(qts, "cortex-a15",
+            "We cannot guarantee the CPU type 'cortex-a15' works "
+            "with KVM on this host", NULL);
+    } else {
+        assert_has_not_feature(qts, "host", "aarch64");
+        assert_has_not_feature(qts, "host", "pmu");
+    }
+
+    qtest_quit(qts);
+}
+
+int main(int argc, char **argv)
+{
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_data_func("/arm/query-cpu-model-expansion",
+                        NULL, test_query_cpu_model_expansion);
+    qtest_add_data_func("/arm/kvm/query-cpu-model-expansion",
+                        NULL, test_query_cpu_model_expansion_kvm);
+
+    return g_test_run();
+}
-- 
2.20.1


