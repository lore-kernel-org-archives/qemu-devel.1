Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F16C2BB1D
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 15:16:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D603D20578
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 15:16:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LJPc9G2u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D603D20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDV0E-00040A-Rl
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 11:16:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40537)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jDUXk-0005a0-T3
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 10:47:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jDUXi-0002VP-Sa
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 10:47:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20167
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jDUXh-0002Ko-Dq
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 10:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584283622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g/fuCUJfqW2I7fyTxcYHrtgUBurZMH6OM/L5KWBXPBI=;
 b=LJPc9G2uzoBZ1JT13sdSX8/VUj1+jw5ykTGGmVDPPE8RHNTEPeZ7NMM09wdUPKXb7uZtPD
 fAyImtjvNgcMKGE0/i0tPJgM1pcGmmxukk4laYQEand5/YcUCkZ2nt5lyL+ax2vxdHkxvu
 dh8sUuwi5K3rMzILVZwO3E8OKmUUTUo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-_3svbWvRMLqtRfqhrR4JGA-1; Sun, 15 Mar 2020 10:47:00 -0400
X-MC-Unique: _3svbWvRMLqtRfqhrR4JGA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ADACF800D5E;
 Sun, 15 Mar 2020 14:46:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-49.ams2.redhat.com
 [10.36.116.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7D4482708B;
 Sun, 15 Mar 2020 14:46:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D593A113525D; Sun, 15 Mar 2020 15:46:53 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 30/34] qapi: Implement deprecated-output=hide for QMP event
 data
Date: Sun, 15 Mar 2020 15:46:49 +0100
Message-Id: <20200315144653.22660-31-armbru@redhat.com>
In-Reply-To: <20200315144653.22660-1-armbru@redhat.com>
References: <20200315144653.22660-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This policy suppresses deprecated bits in output, and thus permits
"testing the future".  Implement it for QMP event data: suppress
deprecated members.

No QMP event data is deprecated right now.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/test-qmp-event.c                  | 18 ++++++++++++++++++
 scripts/qapi/events.py                  |  6 ++++--
 tests/qapi-schema/qapi-schema-test.json |  3 +++
 tests/qapi-schema/qapi-schema-test.out  |  2 ++
 4 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/tests/test-qmp-event.c b/tests/test-qmp-event.c
index ae4913ceb3..be5a2433d0 100644
--- a/tests/test-qmp-event.c
+++ b/tests/test-qmp-event.c
@@ -158,6 +158,23 @@ static void test_event_deprecated(TestEventData *data,=
 const void *unused)
     qobject_unref(data->expect);
 }
=20
+static void test_event_deprecated_data(TestEventData *data, const void *un=
used)
+{
+    memset(&compat_policy, 0, sizeof(compat_policy));
+
+    data->expect =3D qdict_from_jsonf_nofail("{ 'event': 'TEST-EVENT-FEATU=
RES0',"
+                                           " 'data': { 'foo': 42 } }");
+    qapi_event_send_test_event_features0(42);
+    g_assert(data->emitted);
+
+    compat_policy.deprecated_output =3D COMPAT_POLICY_OUTPUT_HIDE;
+    data->expect =3D qdict_from_jsonf_nofail("{ 'event': 'TEST-EVENT-FEATU=
RES0' }");
+    qapi_event_send_test_event_features0(42);
+    g_assert(data->emitted);
+
+    qobject_unref(data->expect);
+}
+
 int main(int argc, char **argv)
 {
     g_test_init(&argc, &argv, NULL);
@@ -167,6 +184,7 @@ int main(int argc, char **argv)
     event_test_add("/event/event_c", test_event_c);
     event_test_add("/event/event_d", test_event_d);
     event_test_add("/event/deprecated", test_event_deprecated);
+    event_test_add("/event/deprecated_data", test_event_deprecated_data);
     g_test_run();
=20
     return 0;
diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index 95ca4b4753..78fa60aa8e 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -104,7 +104,7 @@ def gen_event_send(name, arg_type, features, boxed,
=20
     if have_args:
         ret +=3D mcgen('''
-    v =3D qobject_output_visitor_new(&obj);
+    v =3D qobject_output_visitor_new_qmp(&obj);
 ''')
         if not arg_type.is_implicit():
             ret +=3D mcgen('''
@@ -123,7 +123,9 @@ def gen_event_send(name, arg_type, features, boxed,
         ret +=3D mcgen('''
=20
     visit_complete(v, &obj);
-    qdict_put_obj(qmp, "data", obj);
+    if (qdict_size(qobject_to(QDict, obj))) {
+        qdict_put_obj(qmp, "data", obj);
+    }
 ''')
=20
     ret +=3D mcgen('''
diff --git a/tests/qapi-schema/qapi-schema-test.json b/tests/qapi-schema/qa=
pi-schema-test.json
index e4cce0d5b0..23f58b8724 100644
--- a/tests/qapi-schema/qapi-schema-test.json
+++ b/tests/qapi-schema/qapi-schema-test.json
@@ -322,5 +322,8 @@
   'features': [ { 'name': 'feature1', 'if': [ 'defined(TEST_IF_COND_1)',
                                               'defined(TEST_IF_COND_2)'] }=
 ] }
=20
+{ 'event': 'TEST-EVENT-FEATURES0',
+  'data': 'FeatureStruct1' }
+
 { 'event': 'TEST-EVENT-FEATURES1',
   'features': [ 'deprecated' ] }
diff --git a/tests/qapi-schema/qapi-schema-test.out b/tests/qapi-schema/qap=
i-schema-test.out
index cd53323abd..1a63d3bca7 100644
--- a/tests/qapi-schema/qapi-schema-test.out
+++ b/tests/qapi-schema/qapi-schema-test.out
@@ -438,6 +438,8 @@ command test-command-cond-features3 None -> None
     gen=3DTrue success_response=3DTrue boxed=3DFalse oob=3DFalse preconfig=
=3DFalse
     feature feature1
         if ['defined(TEST_IF_COND_1)', 'defined(TEST_IF_COND_2)']
+event TEST-EVENT-FEATURES0 FeatureStruct1
+    boxed=3DFalse
 event TEST-EVENT-FEATURES1 None
     boxed=3DFalse
     feature deprecated
--=20
2.21.1


