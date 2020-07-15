Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7588C433E4
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 15:42:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B648520672
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 15:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="fVSWSkw8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B648520672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58248 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvjYL-0004zd-Sr
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 11:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@163.com>) id 1jvjXQ-00042I-Kx
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 11:41:40 -0400
Received: from mail-m971.mail.163.com ([123.126.97.1]:41858)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@163.com>) id 1jvjXF-0007cP-C2
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 11:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id; bh=Jpc0ULaj7Q+AlknaAC
 1GDv72IgIlNte8P4Ei/Y5pgCk=; b=fVSWSkw8Ak2/pxiEB0oxZwHhBW23q/fxQi
 lE5OHxPQ2M7uwUWI0DHr+XOi0NdG6tgkVakNPnQDI2ErnLRtSh2plp+lDVb8OHNL
 O1a2lP9zx1vfd3z0r5kCFtHycp2Zx2mpFj2VYVGj4lTrbveElEesXO2E0X8UDA6e
 JUw89Sx5E=
Received: from localhost.localdomain (unknown [183.159.72.144])
 by smtp1 (Coremail) with SMTP id GdxpCgC3NpufIw9f0B_QAA--.54707S4;
 Wed, 15 Jul 2020 23:41:20 +0800 (CST)
From: Li Qiang <liq3ea@163.com>
To: armbru@redhat.com, thuth@redhat.com, lvivier@redhat.com,
 pbonzini@redhat.com, eric.auger@redhat.com
Subject: [PATCH v2] tests: qmp-cmd-test: fix memory leak
Date: Wed, 15 Jul 2020 08:41:17 -0700
Message-Id: <20200715154117.15456-1-liq3ea@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: GdxpCgC3NpufIw9f0B_QAA--.54707S4
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr1rWr18uFyUKFW3AFyDAwb_yoWrXrWxpr
 WI9wn3AFWkCFsaga18t3Z7WF1rXws3ZrWUGF4avw4jyayYyFyqyFyqvrnYq3WkXrZ7Z3Z5
 ZF1UtFn3Gr1DAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0ziq2MUUUUUU=
X-Originating-IP: [183.159.72.144]
X-CM-SenderInfo: 5oltjvrd6rljoofrz/1tbiTwFibVsGVJWW1gAAsd
Received-SPF: pass client-ip=123.126.97.1; envelope-from=liq3ea@163.com;
 helo=mail-m971.mail.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 11:12:07
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Li Qiang <liq3ea@163.com>, liq3ea@gmail.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Properly free each test response to avoid memory leak and separate
qtest_qmp() calls with spare lines, in a consistent manner.

Fixes: 5b88849e7b9("tests/qmp-cmd-test: Add
qmp/object-add-failure-modes"

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Li Qiang <liq3ea@163.com>
---
Change sincve v1: add detailed commit message
 
tests/qtest/qmp-cmd-test.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tests/qtest/qmp-cmd-test.c b/tests/qtest/qmp-cmd-test.c
index c68f99f659..f7b1aa7fdc 100644
--- a/tests/qtest/qmp-cmd-test.c
+++ b/tests/qtest/qmp-cmd-test.c
@@ -230,6 +230,8 @@ static void test_object_add_failure_modes(void)
                      " 'props': {'size': 1048576 } } }");
     g_assert_nonnull(resp);
     g_assert(qdict_haskey(resp, "return"));
+    qobject_unref(resp);
+
     resp = qtest_qmp(qts, "{'execute': 'object-add', 'arguments':"
                      " {'qom-type': 'memory-backend-ram', 'id': 'ram1',"
                      " 'props': {'size': 1048576 } } }");
@@ -241,6 +243,7 @@ static void test_object_add_failure_modes(void)
                      " {'id': 'ram1' } }");
     g_assert_nonnull(resp);
     g_assert(qdict_haskey(resp, "return"));
+    qobject_unref(resp);
 
     /* attempt to create an object with a property of a wrong type */
     resp = qtest_qmp(qts, "{'execute': 'object-add', 'arguments':"
@@ -249,17 +252,20 @@ static void test_object_add_failure_modes(void)
     g_assert_nonnull(resp);
     /* now do it right */
     qmp_assert_error_class(resp, "GenericError");
+
     resp = qtest_qmp(qts, "{'execute': 'object-add', 'arguments':"
                      " {'qom-type': 'memory-backend-ram', 'id': 'ram1',"
                      " 'props': {'size': 1048576 } } }");
     g_assert_nonnull(resp);
     g_assert(qdict_haskey(resp, "return"));
+    qobject_unref(resp);
 
     /* delete ram1 object */
     resp = qtest_qmp(qts, "{'execute': 'object-del', 'arguments':"
                      " {'id': 'ram1' } }");
     g_assert_nonnull(resp);
     g_assert(qdict_haskey(resp, "return"));
+    qobject_unref(resp);
 
     /* attempt to create an object without the id */
     resp = qtest_qmp(qts, "{'execute': 'object-add', 'arguments':"
@@ -267,18 +273,21 @@ static void test_object_add_failure_modes(void)
                      " 'props': {'size': 1048576 } } }");
     g_assert_nonnull(resp);
     qmp_assert_error_class(resp, "GenericError");
+
     /* now do it right */
     resp = qtest_qmp(qts, "{'execute': 'object-add', 'arguments':"
                      " {'qom-type': 'memory-backend-ram', 'id': 'ram1',"
                      " 'props': {'size': 1048576 } } }");
     g_assert_nonnull(resp);
     g_assert(qdict_haskey(resp, "return"));
+    qobject_unref(resp);
 
     /* delete ram1 object */
     resp = qtest_qmp(qts, "{'execute': 'object-del', 'arguments':"
                      " {'id': 'ram1' } }");
     g_assert_nonnull(resp);
     g_assert(qdict_haskey(resp, "return"));
+    qobject_unref(resp);
 
     /* attempt to set a non existing property */
     resp = qtest_qmp(qts, "{'execute': 'object-add', 'arguments':"
@@ -286,23 +295,27 @@ static void test_object_add_failure_modes(void)
                      " 'props': {'sized': 1048576 } } }");
     g_assert_nonnull(resp);
     qmp_assert_error_class(resp, "GenericError");
+
     /* now do it right */
     resp = qtest_qmp(qts, "{'execute': 'object-add', 'arguments':"
                      " {'qom-type': 'memory-backend-ram', 'id': 'ram1',"
                      " 'props': {'size': 1048576 } } }");
     g_assert_nonnull(resp);
     g_assert(qdict_haskey(resp, "return"));
+    qobject_unref(resp);
 
     /* delete ram1 object without id */
     resp = qtest_qmp(qts, "{'execute': 'object-del', 'arguments':"
                      " {'ida': 'ram1' } }");
     g_assert_nonnull(resp);
+    qobject_unref(resp);
 
     /* delete ram1 object */
     resp = qtest_qmp(qts, "{'execute': 'object-del', 'arguments':"
                      " {'id': 'ram1' } }");
     g_assert_nonnull(resp);
     g_assert(qdict_haskey(resp, "return"));
+    qobject_unref(resp);
 
     /* delete ram1 object that does not exist anymore*/
     resp = qtest_qmp(qts, "{'execute': 'object-del', 'arguments':"
-- 
2.17.1


