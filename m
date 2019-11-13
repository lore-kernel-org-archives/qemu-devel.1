Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 176C9C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 21:29:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4CC9206E3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 21:29:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="EiT0PY9s"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4CC9206E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iV0Ci-00045I-0c
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 16:29:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58954)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lekiravi@yandex-team.ru>) id 1iV097-0001JG-3Y
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 16:25:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lekiravi@yandex-team.ru>) id 1iV095-0004QK-RF
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 16:25:49 -0500
Received: from forwardcorp1j.mail.yandex.net ([2a02:6b8:0:1619::183]:38840)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lekiravi@yandex-team.ru>)
 id 1iV093-0004NT-Qa
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 16:25:46 -0500
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::119])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id 826E42E0951;
 Thu, 14 Nov 2019 00:25:41 +0300 (MSK)
Received: from vla1-5826f599457c.qloud-c.yandex.net
 (vla1-5826f599457c.qloud-c.yandex.net [2a02:6b8:c0d:35a1:0:640:5826:f599])
 by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 G84mh3mGGb-PcteMKMm; Thu, 14 Nov 2019 00:25:41 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1573680341; bh=LPUz0oDhexTDd3tx3l9GgCnARWld3cPZd5fQI7FZEvk=;
 h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
 b=EiT0PY9shD+O9XzhjsJV2538aOshA+u7q8vNxc+uhnmkCmVgVWW8QP3Bq8iWVhwxf
 kqhLMVzrkf5gyw8G0gOzuJjYqcpzlWKkple4cl/IqP8cYYz0rH3jDxZ0/+c72o3a7Z
 208zkQyfv2HnFMu8QkUjbD6fMVvDU8xv8V0JmrS4=
Authentication-Results: mxbackcorp2j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from unknown (unknown [2a02:6b8:b080:7204::1:11])
 by vla1-5826f599457c.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 dbNdL4rsWi-PcV8tkM4; Thu, 14 Nov 2019 00:25:38 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Alexey Kirillov <lekiravi@yandex-team.ru>
To: Jason Wang <jasowang@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 2/2] tests: Add tests for query-netdevs command
Date: Thu, 14 Nov 2019 00:25:16 +0300
Message-Id: <20191113212516.13606-3-lekiravi@yandex-team.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191113212516.13606-1-lekiravi@yandex-team.ru>
References: <20191113212516.13606-1-lekiravi@yandex-team.ru>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a02:6b8:0:1619::183
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>,
 qemu-devel@nongnu.org, Vincenzo Maffione <v.maffione@gmail.com>,
 yc-core@yandex-team.ru, Alexey Kirillov <lekiravi@yandex-team.ru>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, Luigi Rizzo <rizzo@iet.unipi.it>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexey Kirillov <lekiravi@yandex-team.ru>
---
 tests/Makefile.include     |   2 +
 tests/test-query-netdevs.c | 114 +++++++++++++++++++++++++++++++++++++
 2 files changed, 116 insertions(+)
 create mode 100644 tests/test-query-netdevs.c

diff --git a/tests/Makefile.include b/tests/Makefile.include
index 534ee48743..4d199e463b 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -297,6 +297,7 @@ check-qtest-s390x-y += tests/migration-test$(EXESUF)
 check-qtest-generic-y += tests/machine-none-test$(EXESUF)
 check-qtest-generic-y += tests/qom-test$(EXESUF)
 check-qtest-generic-y += tests/test-hmp$(EXESUF)
+check-qtest-generic-y += tests/test-query-netdevs$(EXESUF)
 
 qapi-schema += alternate-any.json
 qapi-schema += alternate-array.json
@@ -844,6 +845,7 @@ tests/numa-test$(EXESUF): tests/numa-test.o
 tests/vmgenid-test$(EXESUF): tests/vmgenid-test.o tests/boot-sector.o tests/acpi-utils.o
 tests/cdrom-test$(EXESUF): tests/cdrom-test.o tests/boot-sector.o $(libqos-obj-y)
 tests/arm-cpu-features$(EXESUF): tests/arm-cpu-features.o
+tests/test-query-netdevs$(EXESUF): tests/test-query-netdevs.o
 
 tests/migration/stress$(EXESUF): tests/migration/stress.o
 	$(call quiet-command, $(LINKPROG) -static -O3 $(PTHREAD_LIB) -o $@ $< ,"LINK","$(TARGET_DIR)$@")
diff --git a/tests/test-query-netdevs.c b/tests/test-query-netdevs.c
new file mode 100644
index 0000000000..2afde36114
--- /dev/null
+++ b/tests/test-query-netdevs.c
@@ -0,0 +1,114 @@
+/*
+ * QTest testcase for the query-netdevs
+ *
+ * Copyright Yandex N.V., 2019
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.  See
+ * the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+
+#include "libqtest.h"
+#include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qlist.h"
+
+/*
+ * Events can get in the way of responses we are actually waiting for.
+ */
+GCC_FMT_ATTR(2, 3)
+static QObject *wait_command(QTestState *who, const char *command, ...)
+{
+    va_list ap;
+    QDict *response;
+    QObject *result;
+
+    va_start(ap, command);
+    qtest_qmp_vsend(who, command, ap);
+    va_end(ap);
+
+    response = qtest_qmp_receive(who);
+
+    result = qdict_get(response, "return");
+    g_assert(result);
+    qobject_ref(result);
+    qobject_unref(response);
+
+    return result;
+}
+
+static void qmp_query_netdevs_no_error(QTestState *qts,
+                                       size_t netdevs_count)
+{
+    QObject *resp;
+    QList *netdevs;
+
+    resp = wait_command(qts, "{'execute': 'x-query-netdevs'}");
+
+    netdevs = qobject_to(QList, resp);
+    g_assert(netdevs);
+    g_assert(qlist_size(netdevs) == netdevs_count);
+
+    qobject_unref(resp);
+}
+
+static void test_query_netdevs(void)
+{
+    const char *arch = qtest_get_arch();
+    size_t correction = 0;
+    QObject *resp;
+    QTestState *state;
+
+    if (strcmp(arch, "arm") == 0 ||
+        strcmp(arch, "aarch64") == 0 ||
+        strcmp(arch, "tricore") == 0) {
+        g_test_skip("Not supported without machine type");
+        return;
+    }
+
+    /* Archs with default not unpluggable netdev */
+    if (strcmp(arch, "cris") == 0 ||
+        strcmp(arch, "microblaze") == 0 ||
+        strcmp(arch, "microblazeel") == 0 ||
+        strcmp(arch, "sparc") == 0) {
+        correction = 1;
+    }
+
+    state = qtest_init(
+        "-nodefaults "
+        "-netdev user,id=slirp0");
+    g_assert(state);
+
+    qmp_query_netdevs_no_error(state, 1 + correction);
+
+    resp = wait_command(state,
+        "{'execute': 'netdev_add', 'arguments': {"
+        " 'id': 'slirp1',"
+        " 'type': 'user'}}");
+    qobject_unref(resp);
+
+    qmp_query_netdevs_no_error(state, 2 + correction);
+
+    resp = wait_command(state,
+        "{'execute': 'netdev_del', 'arguments': {"
+        " 'id': 'slirp1'}}");
+    qobject_unref(resp);
+
+    qmp_query_netdevs_no_error(state, 1 + correction);
+
+    qtest_quit(state);
+}
+
+int main(int argc, char **argv)
+{
+    int ret = 0;
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/net/qapi/query_netdevs",
+        test_query_netdevs);
+
+    ret = g_test_run();
+
+    return ret;
+}
-- 
2.17.1


