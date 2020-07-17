Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0ACC433E2
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 09:58:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 269B120684
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 09:58:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I8cimg9f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 269B120684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwN8J-0005B3-Cs
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 05:58:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jwN6J-0002GL-5i
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 05:56:19 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23967
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1jwN6H-0001BT-EO
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 05:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594979776;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=qDZBWVxjlP1RzIGLNAd+Hv7lGAWp0Y8xuODpMSmQXgg=;
 b=I8cimg9frhtpRvNcKpzg4JopSfzNsf9PFqgnfOFdyHACwi5qJpcXS6RPdtIJgZbXmQp0jR
 dhr+3VAvmUFIgukNhiBvT5+XCWGQdECDTPaEgYfFQ4psbuSEUMtSzSYMwuJ/8Zn+XVRsnb
 o9dHAysJLk7hkifUlAmcRJlMwdLou6s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-y5FpCEHdOkaUpF5P3DV2uA-1; Fri, 17 Jul 2020 05:56:12 -0400
X-MC-Unique: y5FpCEHdOkaUpF5P3DV2uA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32CFC100960F;
 Fri, 17 Jul 2020 09:56:11 +0000 (UTC)
Received: from thuth.com (ovpn-112-62.ams2.redhat.com [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 286135C1D3;
 Fri, 17 Jul 2020 09:56:09 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 2/6] tests: qmp-cmd-test: fix memory leak
Date: Fri, 17 Jul 2020 11:56:01 +0200
Message-Id: <20200717095605.27589-3-thuth@redhat.com>
In-Reply-To: <20200717095605.27589-1-thuth@redhat.com>
References: <20200717095605.27589-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=thuth@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 23:13:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Li Qiang <liq3ea@163.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Li Qiang <liq3ea@163.com>

Properly free each test response to avoid memory leak and separate
qtest_qmp() calls with spare lines, in a consistent manner.

Fixes: 5b88849e7b9("tests/qmp-cmd-test: Add qmp/object-add-failure-modes")
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Li Qiang <liq3ea@163.com>
Message-Id: <20200715154117.15456-1-liq3ea@163.com>
Fixes: 9fc719b869 ("tests/qmp-cmd-test: Add qmp/object-add-duplicate-id")
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
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
2.18.1


