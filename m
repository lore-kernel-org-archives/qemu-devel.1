Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CED4C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:44:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 66F7F2063A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O6SZNtjt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66F7F2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTTLi-00023u-Ck
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 12:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34386)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTTFE-0006iV-N8
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:38:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTTBm-0000t1-V5
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:38:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23464
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jTTBm-0000s3-Bv
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588091669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0RVxeOfjwQA17QUx70Pvu4YyioLTk9WXNYBcQ9CshsY=;
 b=O6SZNtjtofph8KvyWZujdyTTPVjiD34p4anHUUNjZvBXS3FF2MqAtxeeFuZ9iVX8cZp/EN
 1uxdaVBpSsicgC7HH2wPXa5EtjxlLmK8MtqyzreuyBugAgD1235eWyZ19w+mHwpMlRLq0A
 PgMJsxgSfZDR4ePrDURyH5sCdK6lDvA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-333-Q__xRBRGMqKlCHuxXITuUQ-1; Tue, 28 Apr 2020 12:34:27 -0400
X-MC-Unique: Q__xRBRGMqKlCHuxXITuUQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7DB18189595B
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 16:34:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9823467651;
 Tue, 28 Apr 2020 16:34:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1536911358C3; Tue, 28 Apr 2020 18:34:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 07/17] tests/check-qom-proplist: Improve iterator coverage
Date: Tue, 28 Apr 2020 18:34:09 +0200
Message-Id: <20200428163419.4483-8-armbru@redhat.com>
In-Reply-To: <20200428163419.4483-1-armbru@redhat.com>
References: <20200428163419.4483-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 04:15:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The tests' "qemu-dummy" device has only class properties.  Turn one of
them into an instance property.  test_dummy_class_iterator() expects
one fewer property than test_dummy_iterator().  Rewrite
test_dummy_prop_iterator() to take expected properties as argument.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 tests/check-qom-proplist.c | 51 +++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/tests/check-qom-proplist.c b/tests/check-qom-proplist.c
index a8b2958e6e..140d56439a 100644
--- a/tests/check-qom-proplist.c
+++ b/tests/check-qom-proplist.c
@@ -130,17 +130,18 @@ static void dummy_init(Object *obj)
     object_property_add_bool(obj, "bv",
                              dummy_get_bv,
                              dummy_set_bv,
-                             &err);
+                             NULL);
+    /* duplicate: */
+    object_property_add_str(obj, "sv",
+                            dummy_get_sv,
+                            dummy_set_sv,
+                            &err);
     error_free_or_abort(&err);
 }
=20
=20
 static void dummy_class_init(ObjectClass *cls, void *data)
 {
-    object_class_property_add_bool(cls, "bv",
-                                   dummy_get_bv,
-                                   dummy_set_bv,
-                                   NULL);
     object_class_property_add_str(cls, "sv",
                                   dummy_get_sv,
                                   dummy_set_sv,
@@ -520,34 +521,33 @@ static void test_dummy_getenum(void)
 }
=20
=20
-static void test_dummy_prop_iterator(ObjectPropertyIterator *iter)
+static void test_dummy_prop_iterator(ObjectPropertyIterator *iter,
+                                     const char *expected[], int n)
 {
-    bool seenbv =3D false, seensv =3D false, seenav =3D false, seentype =
=3D false;
     ObjectProperty *prop;
+    int i;
=20
     while ((prop =3D object_property_iter_next(iter))) {
-        if (!seenbv && g_str_equal(prop->name, "bv")) {
-            seenbv =3D true;
-        } else if (!seensv && g_str_equal(prop->name, "sv")) {
-            seensv =3D true;
-        } else if (!seenav && g_str_equal(prop->name, "av")) {
-            seenav =3D true;
-        } else if (!seentype && g_str_equal(prop->name, "type")) {
-            /* This prop comes from the base Object class */
-            seentype =3D true;
-        } else {
-            g_printerr("Found prop '%s'\n", prop->name);
-            g_assert_not_reached();
+        for (i =3D 0; i < n; i++) {
+            if (!g_strcmp0(prop->name, expected[i])) {
+                break;
+            }
         }
+        g_assert(i < n);
+        expected[i] =3D NULL;
+    }
+
+    for (i =3D 0; i < n; i++) {
+        g_assert(!expected[i]);
     }
-    g_assert(seenbv);
-    g_assert(seenav);
-    g_assert(seensv);
-    g_assert(seentype);
 }
=20
 static void test_dummy_iterator(void)
 {
+    const char *expected[] =3D {
+        "type",                 /* inherited from TYPE_OBJECT */
+        "sv", "av",             /* class properties */
+        "bv"};                  /* instance property */
     Object *parent =3D object_get_objects_root();
     DummyObject *dobj =3D DUMMY_OBJECT(
         object_new_with_props(TYPE_DUMMY,
@@ -561,17 +561,18 @@ static void test_dummy_iterator(void)
     ObjectPropertyIterator iter;
=20
     object_property_iter_init(&iter, OBJECT(dobj));
-    test_dummy_prop_iterator(&iter);
+    test_dummy_prop_iterator(&iter, expected, ARRAY_SIZE(expected));
     object_unparent(OBJECT(dobj));
 }
=20
 static void test_dummy_class_iterator(void)
 {
+    const char *expected[] =3D { "type", "av", "sv" };
     ObjectPropertyIterator iter;
     ObjectClass *klass =3D object_class_by_name(TYPE_DUMMY);
=20
     object_class_property_iter_init(&iter, klass);
-    test_dummy_prop_iterator(&iter);
+    test_dummy_prop_iterator(&iter, expected, ARRAY_SIZE(expected));
 }
=20
 static void test_dummy_delchild(void)
--=20
2.21.1


