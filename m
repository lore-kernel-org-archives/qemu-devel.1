Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AFC3C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 06:09:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F385F2075F
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 06:09:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dx1aAAjY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F385F2075F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZTXW-00030l-6o
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 02:09:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jZTST-00033v-MY
 for qemu-devel@nongnu.org; Fri, 15 May 2020 02:04:33 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:27468
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jZTSQ-0004Pz-M3
 for qemu-devel@nongnu.org; Fri, 15 May 2020 02:04:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589522670;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2n8dS7sLGB2XScMEWJFeWyufIB0Czfl8qq3wbGLcuPc=;
 b=dx1aAAjYjbXZAsaAt/RGYTbx6RiI2u6HHYXgdMiP15qMOsLcnDqh3F8PsjT6FJx+ZxSCfN
 TK7SayhehU+E7fy9fEPY1CGh1KXZmJYBZVZYa5HsdR2YKLCBRxyDpUNlWysroS6MdCnD/T
 +RUPClJeggNI5laq07jajT5UXU/DcYI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-68-RO575i-6M8SBr0GcpdlvaA-1; Fri, 15 May 2020 02:04:28 -0400
X-MC-Unique: RO575i-6M8SBr0GcpdlvaA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 649A918FE880
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 06:04:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 34BD55EE0E;
 Fri, 15 May 2020 06:04:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4171511358C4; Fri, 15 May 2020 08:04:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/21] tests/check-qom-proplist: Improve iterator coverage
Date: Fri, 15 May 2020 08:04:11 +0200
Message-Id: <20200515060424.18993-9-armbru@redhat.com>
In-Reply-To: <20200515060424.18993-1-armbru@redhat.com>
References: <20200515060424.18993-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The tests' "qemu-dummy" device has only class properties.  Turn one of
them into an instance property.  test_dummy_class_iterator() expects
one fewer property than test_dummy_iterator().  Rewrite
test_dummy_prop_iterator() to take expected properties as argument.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Message-Id: <20200505152926.18877-9-armbru@redhat.com>
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
 
 
-static void test_dummy_prop_iterator(ObjectPropertyIterator *iter)
+static void test_dummy_prop_iterator(ObjectPropertyIterator *iter,
+                                     const char *expected[], int n)
 {
-    bool seenbv = false, seensv = false, seenav = false, seentype = false;
     ObjectProperty *prop;
+    int i;
 
     while ((prop = object_property_iter_next(iter))) {
-        if (!seenbv && g_str_equal(prop->name, "bv")) {
-            seenbv = true;
-        } else if (!seensv && g_str_equal(prop->name, "sv")) {
-            seensv = true;
-        } else if (!seenav && g_str_equal(prop->name, "av")) {
-            seenav = true;
-        } else if (!seentype && g_str_equal(prop->name, "type")) {
-            /* This prop comes from the base Object class */
-            seentype = true;
-        } else {
-            g_printerr("Found prop '%s'\n", prop->name);
-            g_assert_not_reached();
+        for (i = 0; i < n; i++) {
+            if (!g_strcmp0(prop->name, expected[i])) {
+                break;
+            }
         }
+        g_assert(i < n);
+        expected[i] = NULL;
+    }
+
+    for (i = 0; i < n; i++) {
+        g_assert(!expected[i]);
     }
-    g_assert(seenbv);
-    g_assert(seenav);
-    g_assert(seensv);
-    g_assert(seentype);
 }
 
 static void test_dummy_iterator(void)
 {
+    const char *expected[] = {
+        "type",                 /* inherited from TYPE_OBJECT */
+        "sv", "av",             /* class properties */
+        "bv"};                  /* instance property */
     Object *parent = object_get_objects_root();
     DummyObject *dobj = DUMMY_OBJECT(
         object_new_with_props(TYPE_DUMMY,
@@ -561,17 +561,18 @@ static void test_dummy_iterator(void)
     ObjectPropertyIterator iter;
 
     object_property_iter_init(&iter, OBJECT(dobj));
-    test_dummy_prop_iterator(&iter);
+    test_dummy_prop_iterator(&iter, expected, ARRAY_SIZE(expected));
     object_unparent(OBJECT(dobj));
 }
 
 static void test_dummy_class_iterator(void)
 {
+    const char *expected[] = { "type", "av", "sv" };
     ObjectPropertyIterator iter;
     ObjectClass *klass = object_class_by_name(TYPE_DUMMY);
 
     object_class_property_iter_init(&iter, klass);
-    test_dummy_prop_iterator(&iter);
+    test_dummy_prop_iterator(&iter, expected, ARRAY_SIZE(expected));
 }
 
 static void test_dummy_delchild(void)
-- 
2.21.1


