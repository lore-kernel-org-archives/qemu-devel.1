Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E673C4CECE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 14:57:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BB77206B1
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 14:57:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b8AF6277"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BB77206B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDUhx-00067w-H4
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 10:57:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40343)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jDUXf-0005X0-Cg
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 10:47:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jDUXc-0002Bm-BV
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 10:47:03 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:31076
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jDUXc-00028O-2h
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 10:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584283619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=txscctFiVA2U4b7jVQ1yKyvWF3aho58FNzAJU1Evot4=;
 b=b8AF62773FTJgqjx9QURBFFBj9fGkhU5EBUyQWR5/aw8Z0qm8+646G4KjYb7f0Qr+hClCv
 0WFw5WlckCpMEcnFairCcubTlKLR9dWMnOZPTFJWgwvwnI/N/g4r5Lykg0P5gNaeK0/iZh
 SXG8843pmHyPhMdpI6wA5seKQSaBuj8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-_04A7dzwPSuD7bri3HoHjQ-1; Sun, 15 Mar 2020 10:46:57 -0400
X-MC-Unique: _04A7dzwPSuD7bri3HoHjQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D45B8189D6C1;
 Sun, 15 Mar 2020 14:46:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-49.ams2.redhat.com
 [10.36.116.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7EF6C9CA3;
 Sun, 15 Mar 2020 14:46:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8E32311366E6; Sun, 15 Mar 2020 15:46:53 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 08/34] tests/test-qmp-event: Simplify test data setup
Date: Sun, 15 Mar 2020 15:46:27 +0100
Message-Id: <20200315144653.22660-9-armbru@redhat.com>
In-Reply-To: <20200315144653.22660-1-armbru@redhat.com>
References: <20200315144653.22660-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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

Building expected data with qdict_put() & friends is tedious to write
and hard to read.  Parse them from string literals with
qdict_from_jsonf_nofail() instead.

While there, use initializers instead of assignments for initializing
aggregate event arguments.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/test-qmp-event.c | 93 ++++++++++++------------------------------
 1 file changed, 27 insertions(+), 66 deletions(-)

diff --git a/tests/test-qmp-event.c b/tests/test-qmp-event.c
index eee7e08ab6..430001e622 100644
--- a/tests/test-qmp-event.c
+++ b/tests/test-qmp-event.c
@@ -17,6 +17,7 @@
 #include "qapi/error.h"
 #include "qapi/qmp/qbool.h"
 #include "qapi/qmp/qdict.h"
+#include "qapi/qmp/qjson.h"
 #include "qapi/qmp/qnum.h"
 #include "qapi/qmp/qstring.h"
 #include "qapi/qmp-event.h"
@@ -124,17 +125,13 @@ static void event_prepare(TestEventData *data,
     /* Global variable test_event_data was used to pass the expectation, s=
o
        test cases can't be executed at same time. */
     g_mutex_lock(&test_event_lock);
-
-    data->expect =3D qdict_new();
     test_event_data =3D data;
 }
=20
 static void event_teardown(TestEventData *data,
                            const void *unused)
 {
-    qobject_unref(data->expect);
     test_event_data =3D NULL;
-
     g_mutex_unlock(&test_event_lock);
 }
=20
@@ -152,90 +149,54 @@ static void event_test_add(const char *testpath,
 static void test_event_a(TestEventData *data,
                          const void *unused)
 {
-    QDict *d;
-    d =3D data->expect;
-    qdict_put_str(d, "event", "EVENT_A");
+    data->expect =3D qdict_from_jsonf_nofail("{ 'event': 'EVENT_A' }");
     qapi_event_send_event_a();
+    qobject_unref(data->expect);
 }
=20
 static void test_event_b(TestEventData *data,
                          const void *unused)
 {
-    QDict *d;
-    d =3D data->expect;
-    qdict_put_str(d, "event", "EVENT_B");
+    data->expect =3D qdict_from_jsonf_nofail("{ 'event': 'EVENT_B' }");
     qapi_event_send_event_b();
+    qobject_unref(data->expect);
 }
=20
 static void test_event_c(TestEventData *data,
                          const void *unused)
 {
-    QDict *d, *d_data, *d_b;
-
-    UserDefOne b;
-    b.integer =3D 2;
-    b.string =3D g_strdup("test1");
-    b.has_enum1 =3D false;
-
-    d_b =3D qdict_new();
-    qdict_put_int(d_b, "integer", 2);
-    qdict_put_str(d_b, "string", "test1");
-
-    d_data =3D qdict_new();
-    qdict_put_int(d_data, "a", 1);
-    qdict_put(d_data, "b", d_b);
-    qdict_put_str(d_data, "c", "test2");
-
-    d =3D data->expect;
-    qdict_put_str(d, "event", "EVENT_C");
-    qdict_put(d, "data", d_data);
+    UserDefOne b =3D { .integer =3D 2, .string =3D (char *)"test1" };
=20
+    data->expect =3D qdict_from_jsonf_nofail(
+        "{ 'event': 'EVENT_C', 'data': {"
+        " 'a': 1, 'b': { 'integer': 2, 'string': 'test1' }, 'c': 'test2' }=
 }");
     qapi_event_send_event_c(true, 1, true, &b, "test2");
-
-    g_free(b.string);
+    qobject_unref(data->expect);
 }
=20
 /* Complex type */
 static void test_event_d(TestEventData *data,
                          const void *unused)
 {
-    UserDefOne struct1;
-    EventStructOne a;
-    QDict *d, *d_data, *d_a, *d_struct1;
-
-    struct1.integer =3D 2;
-    struct1.string =3D g_strdup("test1");
-    struct1.has_enum1 =3D true;
-    struct1.enum1 =3D ENUM_ONE_VALUE1;
-
-    a.struct1 =3D &struct1;
-    a.string =3D g_strdup("test2");
-    a.has_enum2 =3D true;
-    a.enum2 =3D ENUM_ONE_VALUE2;
-
-    d_struct1 =3D qdict_new();
-    qdict_put_int(d_struct1, "integer", 2);
-    qdict_put_str(d_struct1, "string", "test1");
-    qdict_put_str(d_struct1, "enum1", "value1");
-
-    d_a =3D qdict_new();
-    qdict_put(d_a, "struct1", d_struct1);
-    qdict_put_str(d_a, "string", "test2");
-    qdict_put_str(d_a, "enum2", "value2");
-
-    d_data =3D qdict_new();
-    qdict_put(d_data, "a", d_a);
-    qdict_put_str(d_data, "b", "test3");
-    qdict_put_str(d_data, "enum3", "value3");
-
-    d =3D data->expect;
-    qdict_put_str(d, "event", "EVENT_D");
-    qdict_put(d, "data", d_data);
+    UserDefOne struct1 =3D {
+        .integer =3D 2, .string =3D (char *)"test1",
+        .has_enum1 =3D true, .enum1 =3D ENUM_ONE_VALUE1,
+    };
+    EventStructOne a =3D {
+        .struct1 =3D &struct1,
+        .string =3D (char *)"test2",
+        .has_enum2 =3D true,
+        .enum2 =3D ENUM_ONE_VALUE2,
+    };
=20
+    data->expect =3D qdict_from_jsonf_nofail(
+        "{ 'event': 'EVENT_D', 'data': {"
+        " 'a': {"
+        "  'struct1': { 'integer': 2, 'string': 'test1', 'enum1': 'value1'=
 },"
+        "  'string': 'test2', 'enum2': 'value2' },"
+        " 'b': 'test3', 'enum3': 'value3' } }");
     qapi_event_send_event_d(&a, "test3", false, NULL, true, ENUM_ONE_VALUE=
3);
-
-    g_free(struct1.string);
-    g_free(a.string);
+    qobject_unref(data->expect);
 }
=20
 int main(int argc, char **argv)
--=20
2.21.1


