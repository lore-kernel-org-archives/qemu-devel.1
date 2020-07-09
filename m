Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB5CDC433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 11:29:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0F9920772
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 11:29:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hdnr8RL8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0F9920772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtUkN-0006pJ-Vo
	for qemu-devel@archiver.kernel.org; Thu, 09 Jul 2020 07:29:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jtUjl-0006MW-3c
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 07:29:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35142
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jtUjh-0001q1-L7
 for qemu-devel@nongnu.org; Thu, 09 Jul 2020 07:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594294144;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=w9CTFcztZXOHRtwLxvUc3BnkRbdncxBnD8z9W3Pyc7M=;
 b=hdnr8RL81UP5o+0Fxywp5xWLNgcpx0ifqdajzDNJpm0QYEKTbU10ISuHBYqS3cJNa4T0M6
 BUrVigmXtmPog0PU6COqe9uXhKLRG1cmo2MfLrITx4gbHJecSNxva+BKRtuF0rR3Rb9Ahq
 abGERJzVDFDX82ljC5yxyjrpxdKcDtw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-NsvKGYX5PiyaYMsLtdwFgw-1; Thu, 09 Jul 2020 07:29:02 -0400
X-MC-Unique: NsvKGYX5PiyaYMsLtdwFgw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C0A8A87952C
 for <qemu-devel@nongnu.org>; Thu,  9 Jul 2020 11:29:01 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.45])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8CA1A2DE60;
 Thu,  9 Jul 2020 11:28:59 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] tests: improve performance of device-introspect-test
Date: Thu,  9 Jul 2020 12:28:57 +0100
Message-Id: <20200709112857.3760116-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/07 17:25:10
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Total execution time with "-m slow" and x86_64 QEMU, drops from 3
minutes 15 seconds, down to 54 seconds.

Individual tests drop from 17-20 seconds, down to 3-4 seconds.

The cost of this change is that any QOM bugs resulting in the test
failure will not be directly associated with the device that caused
the failure. The test case is not frequently identifying such bugs
though, and the cause is likely easily visible in the patch series
that causes the failure. So overall the shorter running time is
considered the more important factor.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 tests/qtest/device-introspect-test.c | 38 +++++++++++++---------------
 1 file changed, 18 insertions(+), 20 deletions(-)

diff --git a/tests/qtest/device-introspect-test.c b/tests/qtest/device-introspect-test.c
index 9abb5ec889..b4af1e19f6 100644
--- a/tests/qtest/device-introspect-test.c
+++ b/tests/qtest/device-introspect-test.c
@@ -105,14 +105,9 @@ static void test_one_device(QTestState *qts, const char *type)
 {
     QDict *resp;
     char *help;
-    char *qom_tree_start, *qom_tree_end;
-    char *qtree_start, *qtree_end;
 
     g_test_message("Testing device '%s'", type);
 
-    qom_tree_start = qtest_hmp(qts, "info qom-tree");
-    qtree_start = qtest_hmp(qts, "info qtree");
-
     resp = qtest_qmp(qts, "{'execute': 'device-list-properties',"
                           " 'arguments': {'typename': %s}}",
                type);
@@ -120,21 +115,6 @@ static void test_one_device(QTestState *qts, const char *type)
 
     help = qtest_hmp(qts, "device_add \"%s,help\"", type);
     g_free(help);
-
-    /*
-     * Some devices leave dangling pointers in QOM behind.
-     * "info qom-tree" or "info qtree" have a good chance at crashing then.
-     * Also make sure that the tree did not change.
-     */
-    qom_tree_end = qtest_hmp(qts, "info qom-tree");
-    g_assert_cmpstr(qom_tree_start, ==, qom_tree_end);
-    g_free(qom_tree_start);
-    g_free(qom_tree_end);
-
-    qtree_end = qtest_hmp(qts, "info qtree");
-    g_assert_cmpstr(qtree_start, ==, qtree_end);
-    g_free(qtree_start);
-    g_free(qtree_end);
 }
 
 static void test_device_intro_list(void)
@@ -232,10 +212,17 @@ static void test_device_intro_concrete(const void *args)
     QListEntry *entry;
     const char *type;
     QTestState *qts;
+    g_autofree char *qom_tree_start = NULL;
+    g_autofree char *qom_tree_end = NULL;
+    g_autofree char *qtree_start = NULL;
+    g_autofree char *qtree_end = NULL;
 
     qts = qtest_init(args);
     types = device_type_list(qts, false);
 
+    qom_tree_start = qtest_hmp(qts, "info qom-tree");
+    qtree_start = qtest_hmp(qts, "info qtree");
+
     QLIST_FOREACH_ENTRY(types, entry) {
         type = qdict_get_try_str(qobject_to(QDict, qlist_entry_obj(entry)),
                                  "name");
@@ -243,6 +230,17 @@ static void test_device_intro_concrete(const void *args)
         test_one_device(qts, type);
     }
 
+    /*
+     * Some devices leave dangling pointers in QOM behind.
+     * "info qom-tree" or "info qtree" have a good chance at crashing then.
+     * Also make sure that the tree did not change.
+     */
+    qom_tree_end = qtest_hmp(qts, "info qom-tree");
+    g_assert_cmpstr(qom_tree_start, ==, qom_tree_end);
+
+    qtree_end = qtest_hmp(qts, "info qtree");
+    g_assert_cmpstr(qtree_start, ==, qtree_end);
+
     qobject_unref(types);
     qtest_quit(qts);
     g_free((void *)args);
-- 
2.26.2


