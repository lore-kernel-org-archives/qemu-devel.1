Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8EF3C4346E
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 19:26:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 813CA20757
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 19:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="RL5uZVKP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 813CA20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKRSP-0008FD-J5
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 15:26:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lekiravi@yandex-team.ru>)
 id 1kKRLc-0000xE-6E
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 15:19:36 -0400
Received: from forwardcorp1p.mail.yandex.net
 ([2a02:6b8:0:1472:2741:0:8b6:217]:42938)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lekiravi@yandex-team.ru>)
 id 1kKRLZ-0004IN-Ta
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 15:19:35 -0400
Received: from myt5-23f0be3aa648.qloud-c.yandex.net
 (myt5-23f0be3aa648.qloud-c.yandex.net
 [IPv6:2a02:6b8:c12:3e29:0:640:23f0:be3a])
 by forwardcorp1p.mail.yandex.net (Yandex) with ESMTP id 196CA2E1292;
 Mon, 21 Sep 2020 22:19:32 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net
 (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
 by myt5-23f0be3aa648.qloud-c.yandex.net (mxbackcorp/Yandex) with ESMTP id
 l2BxRr0TMk-JVvSoiHl; Mon, 21 Sep 2020 22:19:32 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1600715972; bh=7Ei0QCfTnZuNSxS6GY9e7Cb2wuR6mqS8vDmfwcyT8CE=;
 h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
 b=RL5uZVKPgsPz2y3FbXjqfhy/JpwOp4GVATN/b1fDEySPnoazvsc/BYi+fL89H232Y
 TGy8LEzlG1qodkl/wB58+O5WavmTZySZoZs7WQOd71JVIn8BcgdC3Roxilj3aS8eO6
 L3aDEdds1qiydACoHGb/yYRCbZMzk9uVc/lfj6Hc=
Authentication-Results: myt5-23f0be3aa648.qloud-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b080:6416::1:4])
 by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 3Nc4XKVFl3-JVl41BEl; Mon, 21 Sep 2020 22:19:31 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Alexey Kirillov <lekiravi@yandex-team.ru>
To: Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: [PATCH v4 2/4] tests: Add tests for query-netdev command
Date: Mon, 21 Sep 2020 22:19:10 +0300
Message-Id: <20200921191912.105305-3-lekiravi@yandex-team.ru>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200921191912.105305-1-lekiravi@yandex-team.ru>
References: <20200921191912.105305-1-lekiravi@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:0:1472:2741:0:8b6:217;
 envelope-from=lekiravi@yandex-team.ru; helo=forwardcorp1p.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 15:19:21
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, qemu-devel@nongnu.org,
 Vincenzo Maffione <v.maffione@gmail.com>, yc-core@yandex-team.ru,
 Paolo Bonzini <pbonzini@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, Luigi Rizzo <rizzo@iet.unipi.it>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexey Kirillov <lekiravi@yandex-team.ru>
---
 tests/qtest/meson.build         |   3 +
 tests/qtest/test-query-netdev.c | 115 ++++++++++++++++++++++++++++++++
 2 files changed, 118 insertions(+)
 create mode 100644 tests/qtest/test-query-netdev.c

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 874b5be62b..826eef49e0 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -17,6 +17,9 @@ qtests_generic = [
 if config_host.has_key('CONFIG_MODULES')
   qtests_generic += [ 'modules-test' ]
 endif
+if config_host.has_key('CONFIG_SLIRP')
+  qtests_generic += [ 'test-query-netdev' ]
+endif
 
 qtests_pci = \
   (config_all_devices.has_key('CONFIG_VGA') ? ['display-vga-test'] : []) +                  \
diff --git a/tests/qtest/test-query-netdev.c b/tests/qtest/test-query-netdev.c
new file mode 100644
index 0000000000..9526316983
--- /dev/null
+++ b/tests/qtest/test-query-netdev.c
@@ -0,0 +1,115 @@
+/*
+ * QTest testcase for the query-netdev
+ *
+ * Copyright Yandex N.V., 2019
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or later.
+ * See the COPYING file in the top-level directory.
+ *
+ */
+
+#include "qemu/osdep.h"
+
+#include "libqos/libqtest.h"
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
+static void qmp_query_netdev_no_error(QTestState *qts, size_t netdevs_count)
+{
+    QObject *resp;
+    QList *netdevs;
+
+    resp = wait_command(qts, "{'execute': 'query-netdev'}");
+
+    netdevs = qobject_to(QList, resp);
+    g_assert(netdevs);
+    g_assert(qlist_size(netdevs) == netdevs_count);
+
+    qobject_unref(resp);
+}
+
+static void test_query_netdev(void)
+{
+    const char *arch = qtest_get_arch();
+    QObject *resp;
+    QTestState *state;
+
+    /* Skip test for some MCU */
+    if (g_str_equal(arch, "avr") ||
+        g_str_equal(arch, "rx")) {
+        return;
+    }
+
+    if (g_str_equal(arch, "arm") ||
+        g_str_equal(arch, "aarch64")) {
+        state = qtest_init(
+            "-nodefaults "
+            "-M virt "
+            "-netdev user,id=slirp0");
+    } else if (g_str_equal(arch, "tricore")) {
+        state = qtest_init(
+            "-nodefaults "
+            "-M tricore_testboard "
+            "-netdev user,id=slirp0");
+    } else {
+        state = qtest_init(
+            "-nodefaults "
+            "-netdev user,id=slirp0");
+    }
+    g_assert(state);
+
+    qmp_query_netdev_no_error(state, 1);
+
+    resp = wait_command(state,
+        "{'execute': 'netdev_add', 'arguments': {"
+        " 'id': 'slirp1',"
+        " 'type': 'user'}}");
+    qobject_unref(resp);
+
+    qmp_query_netdev_no_error(state, 2);
+
+    resp = wait_command(state,
+        "{'execute': 'netdev_del', 'arguments': {"
+        " 'id': 'slirp1'}}");
+    qobject_unref(resp);
+
+    qmp_query_netdev_no_error(state, 1);
+
+    qtest_quit(state);
+}
+
+int main(int argc, char **argv)
+{
+    int ret = 0;
+    g_test_init(&argc, &argv, NULL);
+
+    qtest_add_func("/net/qapi/query_netdev", test_query_netdev);
+
+    ret = g_test_run();
+
+    return ret;
+}
-- 
2.25.1


