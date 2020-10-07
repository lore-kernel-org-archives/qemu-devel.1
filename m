Return-Path: <SRS0=37Ja=DO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C101EC41604
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:50:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BC1B206FC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2020 16:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y3tK1wYU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BC1B206FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQCeR-0002ag-2f
	for qemu-devel@archiver.kernel.org; Wed, 07 Oct 2020 12:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kQCcu-0000pz-VE
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:49:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54895)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kQCcs-0002Fs-UX
 for qemu-devel@nongnu.org; Wed, 07 Oct 2020 12:49:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602089354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S+8nF3sZPt7aCEn1DTgrZp8IqMGZff+FXI0y9kdjhjw=;
 b=Y3tK1wYUDGGkbrH9VYBCTZHAeyxVsvScV/vqUFKDVa+jNSL08kjrhkWiZ0yg7M4B9OYK5C
 62P1nOQ+mjB0auOvJ1rrQYwl5+2BbgaV8cIf8G8g14qCWMBOL8s/Z0D0zIag8Db+eNPemO
 aJYR1+l7vn2natI5JfEXUeSI9TeLg2M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-JOAnaPuUO1ilwKuDnpXZ5w-1; Wed, 07 Oct 2020 12:49:12 -0400
X-MC-Unique: JOAnaPuUO1ilwKuDnpXZ5w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84E411021208;
 Wed,  7 Oct 2020 16:49:11 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-113-169.ams2.redhat.com
 [10.36.113.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 678A05D9DD;
 Wed,  7 Oct 2020 16:49:10 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PATCH v3 2/4] qom: Factor out helpers from
 user_creatable_print_help()
Date: Wed,  7 Oct 2020 18:49:01 +0200
Message-Id: <20201007164903.282198-3-kwolf@redhat.com>
In-Reply-To: <20201007164903.282198-1-kwolf@redhat.com>
References: <20201007164903.282198-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/07 00:44:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.742,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: kwolf@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This creates separate helper functions for printing a list of user
creatable object types and for printing a list of properties of a given
type. This will allow using these parts without having a QemuOpts.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 qom/object_interfaces.c | 90 ++++++++++++++++++++++++-----------------
 1 file changed, 52 insertions(+), 38 deletions(-)

diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index e8e1523960..3fd1da157e 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -214,54 +214,68 @@ char *object_property_help(const char *name, const char *type,
     return g_string_free(str, false);
 }
 
-bool user_creatable_print_help(const char *type, QemuOpts *opts)
+static void user_creatable_print_types(void)
+{
+    GSList *l, *list;
+
+    printf("List of user creatable objects:\n");
+    list = object_class_get_list_sorted(TYPE_USER_CREATABLE, false);
+    for (l = list; l != NULL; l = l->next) {
+        ObjectClass *oc = OBJECT_CLASS(l->data);
+        printf("  %s\n", object_class_get_name(oc));
+    }
+    g_slist_free(list);
+}
+
+static bool user_creatable_print_type_properites(const char *type)
 {
     ObjectClass *klass;
+    ObjectPropertyIterator iter;
+    ObjectProperty *prop;
+    GPtrArray *array;
+    int i;
 
-    if (is_help_option(type)) {
-        GSList *l, *list;
+    klass = object_class_by_name(type);
+    if (!klass) {
+        return false;
+    }
 
-        printf("List of user creatable objects:\n");
-        list = object_class_get_list_sorted(TYPE_USER_CREATABLE, false);
-        for (l = list; l != NULL; l = l->next) {
-            ObjectClass *oc = OBJECT_CLASS(l->data);
-            printf("  %s\n", object_class_get_name(oc));
+    array = g_ptr_array_new();
+    object_class_property_iter_init(&iter, klass);
+    while ((prop = object_property_iter_next(&iter))) {
+        if (!prop->set) {
+            continue;
         }
-        g_slist_free(list);
-        return true;
+
+        g_ptr_array_add(array,
+                        object_property_help(prop->name, prop->type,
+                                             prop->defval, prop->description));
     }
+    g_ptr_array_sort(array, (GCompareFunc)qemu_pstrcmp0);
+    if (array->len > 0) {
+        printf("%s options:\n", type);
+    } else {
+        printf("There are no options for %s.\n", type);
+    }
+    for (i = 0; i < array->len; i++) {
+        printf("%s\n", (char *)array->pdata[i]);
+    }
+    g_ptr_array_set_free_func(array, g_free);
+    g_ptr_array_free(array, true);
+    return true;
+}
 
-    klass = object_class_by_name(type);
-    if (klass && qemu_opt_has_help_opt(opts)) {
-        ObjectPropertyIterator iter;
-        ObjectProperty *prop;
-        GPtrArray *array = g_ptr_array_new();
-        int i;
-
-        object_class_property_iter_init(&iter, klass);
-        while ((prop = object_property_iter_next(&iter))) {
-            if (!prop->set) {
-                continue;
-            }
-
-            g_ptr_array_add(array,
-                            object_property_help(prop->name, prop->type,
-                                                 prop->defval, prop->description));
-        }
-        g_ptr_array_sort(array, (GCompareFunc)qemu_pstrcmp0);
-        if (array->len > 0) {
-            printf("%s options:\n", type);
-        } else {
-            printf("There are no options for %s.\n", type);
-        }
-        for (i = 0; i < array->len; i++) {
-            printf("%s\n", (char *)array->pdata[i]);
-        }
-        g_ptr_array_set_free_func(array, g_free);
-        g_ptr_array_free(array, true);
+bool user_creatable_print_help(const char *type, QemuOpts *opts)
+{
+    if (is_help_option(type)) {
+        user_creatable_print_types();
         return true;
     }
 
+    if (qemu_opt_has_help_opt(opts)) {
+        return user_creatable_print_type_properites(type);
+    }
+
     return false;
 }
 
-- 
2.25.4


