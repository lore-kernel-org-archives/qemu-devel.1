Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E06C3F2CD
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 13:08:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81F0D20838
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 13:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="InvlNaS+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F0D20838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9TlL-0004U4-En
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 08:08:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37180)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lekiravi@yandex-team.ru>) id 1j9TkH-0002mn-SZ
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 08:07:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lekiravi@yandex-team.ru>) id 1j9TkG-0001CP-K8
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 08:07:29 -0500
Received: from forwardcorp1j.mail.yandex.net ([2a02:6b8:0:1619::183]:40464)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lekiravi@yandex-team.ru>)
 id 1j9TkD-00012X-Oh; Wed, 04 Mar 2020 08:07:26 -0500
Received: from mxbackcorp2j.mail.yandex.net (mxbackcorp2j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::119])
 by forwardcorp1j.mail.yandex.net (Yandex) with ESMTP id E6B6B2E1695;
 Wed,  4 Mar 2020 16:07:22 +0300 (MSK)
Received: from sas1-9998cec34266.qloud-c.yandex.net
 (sas1-9998cec34266.qloud-c.yandex.net [2a02:6b8:c14:3a0e:0:640:9998:cec3])
 by mxbackcorp2j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 fDcZyQkbLf-7JJKZglc; Wed, 04 Mar 2020 16:07:22 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1583327242; bh=RzA7COy6OjGENVG5q5PdG3mDLFc4iPpo75ImpI9/idQ=;
 h=In-Reply-To:Message-Id:References:Date:Subject:To:From:Cc;
 b=InvlNaS+6VR8q2ihOkE87gsAyKN7LhYTRQObXdwhw7Zc39oH3dBVLg1PkzoD/5Iox
 vh7w995083AolKuaLn3q1GpsyysEnHLG2OLsBtnFS8alONLPesN/dQ7rIZA+K2jHsb
 JemjMrst8VWPU1Y0q5zVcEzSdnyOG+Osf3rwfgbE=
Authentication-Results: mxbackcorp2j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-red.dhcp.yndx.net (dynamic-red.dhcp.yndx.net
 [2a02:6b8:0:40c:b4f7:3f29:4fea:8822])
 by sas1-9998cec34266.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 ujb0Gsh6CR-7IWOaIsp; Wed, 04 Mar 2020 16:07:19 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Alexey Kirillov <lekiravi@yandex-team.ru>
To: Eric Blake <eblake@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH v2 2/4] tests: Add tests for query-netdevs command
Date: Wed,  4 Mar 2020 16:06:54 +0300
Message-Id: <20200304130656.16859-3-lekiravi@yandex-team.ru>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200304130656.16859-1-lekiravi@yandex-team.ru>
References: <20200304130656.16859-1-lekiravi@yandex-team.ru>
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 qemu-devel@nongnu.org, Vincenzo Maffione <v.maffione@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Sven Schnelle <svens@stackframe.org>, Rob Herring <robh@kernel.org>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Joel Stanley <joel@jms.id.au>, Anthony Perard <anthony.perard@citrix.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Laurent Vivier <lvivier@redhat.com>, Jiri Pirko <jiri@resnulli.us>,
 yc-core@yandex-team.ru, Stefan Weil <sw@weilnetz.de>,
 Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 xen-devel@lists.xenproject.org, Giuseppe Lettieri <g.lettieri@iet.unipi.it>,
 Luigi Rizzo <rizzo@iet.unipi.it>, Richard Henderson <rth@twiddle.net>,
 Andrew Jeffery <andrew@aj.id.au>, Michael Walle <michael@walle.cc>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Alexey Kirillov <lekiravi@yandex-team.ru>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Alexey Kirillov <lekiravi@yandex-team.ru>
---
 tests/qtest/Makefile.include     |   2 +
 tests/qtest/test-query-netdevs.c | 120 +++++++++++++++++++++++++++++++
 2 files changed, 122 insertions(+)
 create mode 100644 tests/qtest/test-query-netdevs.c

diff --git a/tests/qtest/Makefile.include b/tests/qtest/Makefile.include
index e769c1ad70..6924843ef9 100644
--- a/tests/qtest/Makefile.include
+++ b/tests/qtest/Makefile.include
@@ -9,6 +9,7 @@ check-qtest-generic-y += qmp-cmd-test
 check-qtest-generic-y += qom-test
 check-qtest-generic-$(CONFIG_MODULES) += modules-test
 check-qtest-generic-y += test-hmp
+check-qtest-generic-$(CONFIG_SLIRP) += test-query-netdevs
 
 check-qtest-pci-$(CONFIG_RTL8139_PCI) += rtl8139-test
 check-qtest-pci-$(CONFIG_VGA) += display-vga-test
@@ -303,6 +304,7 @@ tests/qtest/tpm-crb-test$(EXESUF): tests/qtest/tpm-crb-test.o tests/qtest/tpm-em
 tests/qtest/tpm-tis-swtpm-test$(EXESUF): tests/qtest/tpm-tis-swtpm-test.o tests/qtest/tpm-emu.o \
 	tests/qtest/tpm-util.o tests/qtest/tpm-tests.o $(test-io-obj-y)
 tests/qtest/tpm-tis-test$(EXESUF): tests/qtest/tpm-tis-test.o tests/qtest/tpm-emu.o $(test-io-obj-y)
+tests/qtest/test-query-netdevs$(EXESUF): tests/qtest/test-query-netdevs.o
 
 # QTest rules
 
diff --git a/tests/qtest/test-query-netdevs.c b/tests/qtest/test-query-netdevs.c
new file mode 100644
index 0000000000..e077358a50
--- /dev/null
+++ b/tests/qtest/test-query-netdevs.c
@@ -0,0 +1,120 @@
+/*
+ * QTest testcase for the query-netdevs
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
+    resp = wait_command(qts, "{'execute': 'query-netdevs'}");
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
+    /* Archs which still have a netdev despite of -nodefaults */
+    if (g_str_equal(arch, "cris") ||
+        g_str_equal(arch, "microblaze") ||
+        g_str_equal(arch, "microblazeel") ||
+        g_str_equal(arch, "sparc")) {
+        correction = 1;
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


