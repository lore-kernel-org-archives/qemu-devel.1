Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6984FC10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:06:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32BCB20724
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 12:06:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AuX5yWNw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32BCB20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEAzA-0000mw-9m
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 08:06:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56814)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jEAoY-00089E-Kb
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jEAoW-0006eB-Ut
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:18 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:56675)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jEAoW-0006c3-PO
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 07:55:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584446116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CvOx35c4RmSVqE2C8Lo+PAWiSQ8b2GO0AA0lr3sVtLs=;
 b=AuX5yWNwsDQChUxMtzvteYcYzZWKZQYRxMN/1w/fso9CxwCaZ5Bv9gI8mRneqs91xGZY29
 U79QO9iWtjs0hsb0d2SawVOt5qLk/FkcJoUMDE50dwX+xmiBE8544oSQ4G1fkspy0trpXW
 3ogpzJJ30beVghNngI7Ra3oGS3aI7n8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-BAj-RO45PcqVY6HeXtGSFA-1; Tue, 17 Mar 2020 07:55:15 -0400
X-MC-Unique: BAj-RO45PcqVY6HeXtGSFA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC0E8805751;
 Tue, 17 Mar 2020 11:55:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-130.ams2.redhat.com
 [10.36.112.130])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A4C628980;
 Tue, 17 Mar 2020 11:55:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8EEC0113525D; Tue, 17 Mar 2020 12:55:00 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 30/34] qapi: Implement deprecated-output=hide for QMP event
 data
Date: Tue, 17 Mar 2020 12:54:55 +0100
Message-Id: <20200317115459.31821-31-armbru@redhat.com>
In-Reply-To: <20200317115459.31821-1-armbru@redhat.com>
References: <20200317115459.31821-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
 tests/test-qmp-event.c                  | 20 ++++++++++++++++++++
 scripts/qapi/events.py                  |  8 ++++++--
 tests/qapi-schema/qapi-schema-test.json |  3 +++
 tests/qapi-schema/qapi-schema-test.out  |  2 ++
 4 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/tests/test-qmp-event.c b/tests/test-qmp-event.c
index ae4913ceb3..8f77485454 100644
--- a/tests/test-qmp-event.c
+++ b/tests/test-qmp-event.c
@@ -158,6 +158,25 @@ static void test_event_deprecated(TestEventData *data,=
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
+    qobject_unref(data->expect);
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
@@ -167,6 +186,7 @@ int main(int argc, char **argv)
     event_test_add("/event/event_c", test_event_c);
     event_test_add("/event/event_d", test_event_d);
     event_test_add("/event/deprecated", test_event_deprecated);
+    event_test_add("/event/deprecated_data", test_event_deprecated_data);
     g_test_run();
=20
     return 0;
diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index 95ca4b4753..f03c825cc1 100644
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
@@ -123,7 +123,11 @@ def gen_event_send(name, arg_type, features, boxed,
         ret +=3D mcgen('''
=20
     visit_complete(v, &obj);
-    qdict_put_obj(qmp, "data", obj);
+    if (qdict_size(qobject_to(QDict, obj))) {
+        qdict_put_obj(qmp, "data", obj);
+    } else {
+        qobject_unref(obj);
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


