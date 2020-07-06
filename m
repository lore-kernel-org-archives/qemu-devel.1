Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8CEFC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:51:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82206206E9
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 16:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AOfN5OjP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82206206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34576 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsUKZ-0004FZ-Mx
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 12:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56776)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsUC4-0003Bz-90
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:42:12 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:43411
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1jsUC2-00034F-7f
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 12:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594053729;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q9PBOOXjH927YWdtrJRWujodic8piYwE9PRAbQZuPF4=;
 b=AOfN5OjPJQh9eSMcYLZNOA2i0sRq6/D9vS1DiZyOZDTvqtgBCLc51jou7BrJ7ErHWXXrPx
 bepZbVvb4Ur1px6ZgBTIPvMj9lUCBSO2ec+iBtbS0j5ODlRpQCydrAul++CKn2MLTee0S8
 MfrsIDmnJvNZO8jmf0Dt5hu9iIPOo3Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-SvPzauWZMeS1XQg-yXbRKQ-1; Mon, 06 Jul 2020 12:42:04 -0400
X-MC-Unique: SvPzauWZMeS1XQg-yXbRKQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 34532461
 for <qemu-devel@nongnu.org>; Mon,  6 Jul 2020 16:42:03 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CB6ED1002380;
 Mon,  6 Jul 2020 16:42:02 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 06/53] tests/qmp-cmd-test: Add qmp/object-add-failure-modes
Date: Mon,  6 Jul 2020 12:41:08 -0400
Message-Id: <20200706164155.24696-7-pbonzini@redhat.com>
In-Reply-To: <20200706164155.24696-1-pbonzini@redhat.com>
References: <20200706164155.24696-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/06 01:39:15
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
Cc: Eric Auger <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Auger <eric.auger@redhat.com>

Merge the existing object-add test cases into a single test
functions and cover more failure cases.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

Message-Id: <20200629193424.30280-4-eric.auger@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 tests/qtest/qmp-cmd-test.c | 112 +++++++++++++++++++++++++++++++------
 1 file changed, 96 insertions(+), 16 deletions(-)

diff --git a/tests/qtest/qmp-cmd-test.c b/tests/qtest/qmp-cmd-test.c
index fc65fa3726..c68f99f659 100644
--- a/tests/qtest/qmp-cmd-test.c
+++ b/tests/qtest/qmp-cmd-test.c
@@ -200,33 +200,116 @@ static void add_query_tests(QmpSchema *schema)
     }
 }
 
-static void test_object_add_without_props(void)
+static void test_object_add_failure_modes(void)
 {
     QTestState *qts;
     QDict *resp;
 
+    /* attempt to create an object without props */
     qts = qtest_init(common_args);
     resp = qtest_qmp(qts, "{'execute': 'object-add', 'arguments':"
-                    " {'qom-type': 'memory-backend-ram', 'id': 'ram1' } }");
+                     " {'qom-type': 'memory-backend-ram', 'id': 'ram1' } }");
     g_assert_nonnull(resp);
     qmp_assert_error_class(resp, "GenericError");
-    qtest_quit(qts);
-}
 
-static void test_object_add_with_duplicate_id(void)
-{
-    QTestState *qts;
-    QDict *resp;
+    /* attempt to create an object without qom-type */
+    resp = qtest_qmp(qts, "{'execute': 'object-add', 'arguments':"
+                     " {'id': 'ram1' } }");
+    g_assert_nonnull(resp);
+    qmp_assert_error_class(resp, "GenericError");
 
-    qts = qtest_init(common_args);
+    /* attempt to delete an object that does not exist */
+    resp = qtest_qmp(qts, "{'execute': 'object-del', 'arguments':"
+                     " {'id': 'ram1' } }");
+    g_assert_nonnull(resp);
+    qmp_assert_error_class(resp, "GenericError");
+
+    /* attempt to create 2 objects with duplicate id */
+    resp = qtest_qmp(qts, "{'execute': 'object-add', 'arguments':"
+                     " {'qom-type': 'memory-backend-ram', 'id': 'ram1',"
+                     " 'props': {'size': 1048576 } } }");
+    g_assert_nonnull(resp);
+    g_assert(qdict_haskey(resp, "return"));
     resp = qtest_qmp(qts, "{'execute': 'object-add', 'arguments':"
-                    " {'qom-type': 'memory-backend-ram', 'id': 'ram1', 'props': {'size': 1048576 } } }");
+                     " {'qom-type': 'memory-backend-ram', 'id': 'ram1',"
+                     " 'props': {'size': 1048576 } } }");
+    g_assert_nonnull(resp);
+    qmp_assert_error_class(resp, "GenericError");
+
+    /* delete ram1 object */
+    resp = qtest_qmp(qts, "{'execute': 'object-del', 'arguments':"
+                     " {'id': 'ram1' } }");
     g_assert_nonnull(resp);
     g_assert(qdict_haskey(resp, "return"));
+
+    /* attempt to create an object with a property of a wrong type */
     resp = qtest_qmp(qts, "{'execute': 'object-add', 'arguments':"
-                    " {'qom-type': 'memory-backend-ram', 'id': 'ram1', 'props': {'size': 1048576 } } }");
+                     " {'qom-type': 'memory-backend-ram', 'id': 'ram1',"
+                     " 'props': {'size': '1048576' } } }");
     g_assert_nonnull(resp);
+    /* now do it right */
     qmp_assert_error_class(resp, "GenericError");
+    resp = qtest_qmp(qts, "{'execute': 'object-add', 'arguments':"
+                     " {'qom-type': 'memory-backend-ram', 'id': 'ram1',"
+                     " 'props': {'size': 1048576 } } }");
+    g_assert_nonnull(resp);
+    g_assert(qdict_haskey(resp, "return"));
+
+    /* delete ram1 object */
+    resp = qtest_qmp(qts, "{'execute': 'object-del', 'arguments':"
+                     " {'id': 'ram1' } }");
+    g_assert_nonnull(resp);
+    g_assert(qdict_haskey(resp, "return"));
+
+    /* attempt to create an object without the id */
+    resp = qtest_qmp(qts, "{'execute': 'object-add', 'arguments':"
+                     " {'qom-type': 'memory-backend-ram',"
+                     " 'props': {'size': 1048576 } } }");
+    g_assert_nonnull(resp);
+    qmp_assert_error_class(resp, "GenericError");
+    /* now do it right */
+    resp = qtest_qmp(qts, "{'execute': 'object-add', 'arguments':"
+                     " {'qom-type': 'memory-backend-ram', 'id': 'ram1',"
+                     " 'props': {'size': 1048576 } } }");
+    g_assert_nonnull(resp);
+    g_assert(qdict_haskey(resp, "return"));
+
+    /* delete ram1 object */
+    resp = qtest_qmp(qts, "{'execute': 'object-del', 'arguments':"
+                     " {'id': 'ram1' } }");
+    g_assert_nonnull(resp);
+    g_assert(qdict_haskey(resp, "return"));
+
+    /* attempt to set a non existing property */
+    resp = qtest_qmp(qts, "{'execute': 'object-add', 'arguments':"
+                     " {'qom-type': 'memory-backend-ram', 'id': 'ram1',"
+                     " 'props': {'sized': 1048576 } } }");
+    g_assert_nonnull(resp);
+    qmp_assert_error_class(resp, "GenericError");
+    /* now do it right */
+    resp = qtest_qmp(qts, "{'execute': 'object-add', 'arguments':"
+                     " {'qom-type': 'memory-backend-ram', 'id': 'ram1',"
+                     " 'props': {'size': 1048576 } } }");
+    g_assert_nonnull(resp);
+    g_assert(qdict_haskey(resp, "return"));
+
+    /* delete ram1 object without id */
+    resp = qtest_qmp(qts, "{'execute': 'object-del', 'arguments':"
+                     " {'ida': 'ram1' } }");
+    g_assert_nonnull(resp);
+
+    /* delete ram1 object */
+    resp = qtest_qmp(qts, "{'execute': 'object-del', 'arguments':"
+                     " {'id': 'ram1' } }");
+    g_assert_nonnull(resp);
+    g_assert(qdict_haskey(resp, "return"));
+
+    /* delete ram1 object that does not exist anymore*/
+    resp = qtest_qmp(qts, "{'execute': 'object-del', 'arguments':"
+                     " {'id': 'ram1' } }");
+    g_assert_nonnull(resp);
+    qmp_assert_error_class(resp, "GenericError");
+
     qtest_quit(qts);
 }
 
@@ -240,11 +323,8 @@ int main(int argc, char *argv[])
     qmp_schema_init(&schema);
     add_query_tests(&schema);
 
-    qtest_add_func("qmp/object-add-without-props",
-                   test_object_add_without_props);
-    qtest_add_func("qmp/object-add-duplicate-id",
-                   test_object_add_with_duplicate_id);
-    /* TODO: add coverage of generic object-add failure modes */
+    qtest_add_func("qmp/object-add-failure-modes",
+                   test_object_add_failure_modes);
 
     ret = g_test_run();
 
-- 
2.26.2



