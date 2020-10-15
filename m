Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8774AC433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 14:53:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17DA321D7F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 14:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A7Mc68B+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17DA321D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT4cx-00080V-Va
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 10:53:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42290)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kT4a7-0004cs-NP
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 10:50:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49387)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kT4a5-0001i8-4A
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 10:50:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602773412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sYyqaW7pTGseV1pH/a101zWKPH2l94EMzBlNNFz+pOE=;
 b=A7Mc68B+tQnxIofHvGInE3Phr9h5N8tNhLW1tWagMYzz7nvvya/TQXnn622ZoDetDhUfE7
 s1pG+BlVTMSf42xovGsSSVt6kmPhaF/JSzhZF12uy9ZpHUaJHF0PWg44pNRNG0KP8y324B
 izWbr/BwLUVzUj///s5Lj3AQ8CfzNJY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-hKrlVgxiOdan66nSNfmkPA-1; Thu, 15 Oct 2020 10:50:08 -0400
X-MC-Unique: hKrlVgxiOdan66nSNfmkPA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D177ADC2D;
 Thu, 15 Oct 2020 14:50:07 +0000 (UTC)
Received: from merkur.redhat.com (ovpn-114-163.ams2.redhat.com [10.36.114.163])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 13837610F3;
 Thu, 15 Oct 2020 14:50:05 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 05/10] qom: Factor out helpers from user_creatable_print_help()
Date: Thu, 15 Oct 2020 16:49:47 +0200
Message-Id: <20201015144952.388043-6-kwolf@redhat.com>
In-Reply-To: <20201015144952.388043-1-kwolf@redhat.com>
References: <20201015144952.388043-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 02:38:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This creates separate helper functions for printing a list of user
creatable object types and for printing a list of properties of a given
type. This will allow using these parts without having a QemuOpts.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20201007164903.282198-3-kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
2.28.0


