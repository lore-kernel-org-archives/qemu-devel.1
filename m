Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABACFC43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 08:49:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5BE0221E8
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 08:49:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MT81ceP8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5BE0221E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHkAp-0008FR-Ns
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 04:49:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kHk9i-0006aZ-R2
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 04:48:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20082)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kHk9g-0005D6-TI
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 04:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600073287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5+0FEcmNlzWw4XpECqngOMwcHt/XS0yzjIW17fj7ZTk=;
 b=MT81ceP8xfsCDm0GPAfOrIMfslHsauwuJ+kt7Z2itzBHNO36s4MMxVEYGMZ+btRdNvkQEq
 vECKI3yfK3o0M7O9j3mi8a/Pt4jijg24Zt7nMiHdu30NLGmzOymdIGRp6kBTNVbuY/jyTz
 TSRBvChsKPKgQSCSKU1qbMAGosa/jnM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-590-oQEX3AvCMKWaxG08v1M3Mw-1; Mon, 14 Sep 2020 04:48:05 -0400
X-MC-Unique: oQEX3AvCMKWaxG08v1M3Mw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C98B8030A0;
 Mon, 14 Sep 2020 08:48:04 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-114-66.ams2.redhat.com
 [10.36.114.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 13E7A6FEE6;
 Mon, 14 Sep 2020 08:48:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8087611329BE; Mon, 14 Sep 2020 10:48:02 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 4/8] qapi: Implement deprecated-output=hide for QMP event
 data
Date: Mon, 14 Sep 2020 10:47:58 +0200
Message-Id: <20200914084802.4185028-5-armbru@redhat.com>
In-Reply-To: <20200914084802.4185028-1-armbru@redhat.com>
References: <20200914084802.4185028-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/14 02:55:39
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.695,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: marcandre.lureau@gmail.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This policy suppresses deprecated bits in output, and thus permits
"testing the future".  Implement it for QMP event data: suppress
deprecated members.

No QMP event data is deprecated right now.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/test-qmp-event.c                  | 21 +++++++++++++++++++++
 scripts/qapi/events.py                  |  8 ++++++--
 tests/qapi-schema/qapi-schema-test.json |  3 +++
 tests/qapi-schema/qapi-schema-test.out  |  2 ++
 4 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/tests/test-qmp-event.c b/tests/test-qmp-event.c
index ab059fb5c2..047f44ff9a 100644
--- a/tests/test-qmp-event.c
+++ b/tests/test-qmp-event.c
@@ -159,6 +159,26 @@ static void test_event_deprecated(TestEventData *data, const void *unused)
     qobject_unref(data->expect);
 }
 
+static void test_event_deprecated_data(TestEventData *data, const void *unused)
+{
+    memset(&compat_policy, 0, sizeof(compat_policy));
+
+    data->expect = qdict_from_jsonf_nofail("{ 'event': 'TEST-EVENT-FEATURES0',"
+                                           " 'data': { 'foo': 42 } }");
+    qapi_event_send_test_event_features0(42);
+    g_assert(data->emitted);
+
+    qobject_unref(data->expect);
+
+    compat_policy.has_deprecated_output = true;
+    compat_policy.deprecated_output = COMPAT_POLICY_OUTPUT_HIDE;
+    data->expect = qdict_from_jsonf_nofail("{ 'event': 'TEST-EVENT-FEATURES0' }");
+    qapi_event_send_test_event_features0(42);
+    g_assert(data->emitted);
+
+    qobject_unref(data->expect);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -168,6 +188,7 @@ int main(int argc, char **argv)
     event_test_add("/event/event_c", test_event_c);
     event_test_add("/event/event_d", test_event_d);
     event_test_add("/event/deprecated", test_event_deprecated);
+    event_test_add("/event/deprecated_data", test_event_deprecated_data);
     g_test_run();
 
     return 0;
diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index 95ca4b4753..f03c825cc1 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -104,7 +104,7 @@ def gen_event_send(name, arg_type, features, boxed,
 
     if have_args:
         ret += mcgen('''
-    v = qobject_output_visitor_new(&obj);
+    v = qobject_output_visitor_new_qmp(&obj);
 ''')
         if not arg_type.is_implicit():
             ret += mcgen('''
@@ -123,7 +123,11 @@ def gen_event_send(name, arg_type, features, boxed,
         ret += mcgen('''
 
     visit_complete(v, &obj);
-    qdict_put_obj(qmp, "data", obj);
+    if (qdict_size(qobject_to(QDict, obj))) {
+        qdict_put_obj(qmp, "data", obj);
+    } else {
+        qobject_unref(obj);
+    }
 ''')
 
     ret += mcgen('''
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qapi-schema-test.json
index 309e60566d..3f2943341e 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -323,5 +323,8 @@
   'features': [ { 'name': 'feature1', 'if': [ 'defined(TEST_IF_COND_1)',
                                               'defined(TEST_IF_COND_2)'] } ] }
 
+{ 'event': 'TEST-EVENT-FEATURES0',
+  'data': 'FeatureStruct1' }
+
 { 'event': 'TEST-EVENT-FEATURES1',
   'features': [ 'deprecated' ] }
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qapi-schema-test.out
index cd53323abd..1a63d3bca7 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -438,6 +438,8 @@ command test-command-cond-features3 None -> None
     gen=True success_response=True boxed=False oob=False preconfig=False
     feature feature1
         if ['defined(TEST_IF_COND_1)', 'defined(TEST_IF_COND_2)']
+event TEST-EVENT-FEATURES0 FeatureStruct1
+    boxed=False
 event TEST-EVENT-FEATURES1 None
     boxed=False
     feature deprecated
-- 
2.26.2


