Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F4AC2BB1D
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 14:57:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A76BE206B1
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 14:57:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EyUpl//B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A76BE206B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDUiD-0006MT-Op
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 10:57:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40262)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jDUXd-0005Wi-GZ
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 10:47:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1jDUXc-0002Aw-6y
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 10:47:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20367
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1jDUXb-00028g-V8
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 10:47:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584283619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G/K2SKoqOnDjysN1i+Hx5allTxM687zxIdK14NsSRSU=;
 b=EyUpl//BkC+Ih38XlZaxkFyUx7pt1O3D31zydum0u31f2Nrp2wFrwMbrwUhxzwg8RQhhSI
 bGNs0gZ1nqjUVnhivzDomLfx/ukynFON2o4zOEk8C6ci2e9tB9fl+cI6LVn9jlXS/6h0Y1
 R7LN3JV060wACNZ1d27A9Wr2jF6g7lI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-243-qPZNLH-cOAmNE0uXjb4j5w-1; Sun, 15 Mar 2020 10:46:57 -0400
X-MC-Unique: qPZNLH-cOAmNE0uXjb4j5w-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1C3B800D53;
 Sun, 15 Mar 2020 14:46:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-49.ams2.redhat.com
 [10.36.116.49])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A13DE2708B;
 Sun, 15 Mar 2020 14:46:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9498F11366F1; Sun, 15 Mar 2020 15:46:53 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 10/34] tests/test-qmp-event: Check event is actually emitted
Date: Sun, 15 Mar 2020 15:46:29 +0100
Message-Id: <20200315144653.22660-11-armbru@redhat.com>
In-Reply-To: <20200315144653.22660-1-armbru@redhat.com>
References: <20200315144653.22660-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/test-qmp-event.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tests/test-qmp-event.c b/tests/test-qmp-event.c
index d64066139c..7dd0053190 100644
--- a/tests/test-qmp-event.c
+++ b/tests/test-qmp-event.c
@@ -26,6 +26,7 @@
=20
 typedef struct TestEventData {
     QDict *expect;
+    bool emitted;
 } TestEventData;
=20
 TestEventData *test_event_data;
@@ -52,7 +53,7 @@ void test_qapi_event_emit(test_QAPIEvent event, QDict *d)
     qdict_del(d, "timestamp");
=20
     g_assert(qobject_is_equal(QOBJECT(d), QOBJECT(test_event_data->expect)=
));
-
+    test_event_data->emitted =3D true;
 }
=20
 static void event_prepare(TestEventData *data,
@@ -87,6 +88,7 @@ static void test_event_a(TestEventData *data,
 {
     data->expect =3D qdict_from_jsonf_nofail("{ 'event': 'EVENT_A' }");
     qapi_event_send_event_a();
+    g_assert(data->emitted);
     qobject_unref(data->expect);
 }
=20
@@ -95,6 +97,7 @@ static void test_event_b(TestEventData *data,
 {
     data->expect =3D qdict_from_jsonf_nofail("{ 'event': 'EVENT_B' }");
     qapi_event_send_event_b();
+    g_assert(data->emitted);
     qobject_unref(data->expect);
 }
=20
@@ -107,6 +110,7 @@ static void test_event_c(TestEventData *data,
         "{ 'event': 'EVENT_C', 'data': {"
         " 'a': 1, 'b': { 'integer': 2, 'string': 'test1' }, 'c': 'test2' }=
 }");
     qapi_event_send_event_c(true, 1, true, &b, "test2");
+    g_assert(data->emitted);
     qobject_unref(data->expect);
 }
=20
@@ -132,6 +136,7 @@ static void test_event_d(TestEventData *data,
         "  'string': 'test2', 'enum2': 'value2' },"
         " 'b': 'test3', 'enum3': 'value3' } }");
     qapi_event_send_event_d(&a, "test3", false, NULL, true, ENUM_ONE_VALUE=
3);
+    g_assert(data->emitted);
     qobject_unref(data->expect);
 }
=20
--=20
2.21.1


