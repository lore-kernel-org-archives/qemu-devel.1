Return-Path: <SRS0=SHB2=AK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 184C0C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 19:36:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D974920672
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2020 19:36:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HQ9D+YL+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D974920672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpzZS-0002kv-5j
	for qemu-devel@archiver.kernel.org; Mon, 29 Jun 2020 15:36:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53132)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jpzY9-0001Wj-0S
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 15:34:41 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:55190
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1jpzY7-0003GQ-35
 for qemu-devel@nongnu.org; Mon, 29 Jun 2020 15:34:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593459277;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JxlH3jUzaEepf5LtvSndn0Zz0abjXTIM81hezRsiWa0=;
 b=HQ9D+YL+q5ajkntJNMNH4S50Zc/5k8PRvoV8LBL/Y3DU3qlls+D16YJrRuZzqKxY45qK2G
 7p+V08r3QKeJgNVkkoYmYWUzPPIV6BG/+x6QFwmQRduaC+bdVhqDzZMc2dy1RMMYCNgnAX
 AUsq0bpgmzLF2bTi1Lru0QJfPbEmigE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-220-b0QLuSAEPm6gimXcCk7iUg-1; Mon, 29 Jun 2020 15:34:36 -0400
X-MC-Unique: b0QLuSAEPm6gimXcCk7iUg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F3E41800D5C;
 Mon, 29 Jun 2020 19:34:34 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-114-197.ams2.redhat.com [10.36.114.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2048D5C220;
 Mon, 29 Jun 2020 19:34:32 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com,
 armbru@redhat.com
Subject: [PATCH v5 1/3] qom: Introduce object_property_try_add_child()
Date: Mon, 29 Jun 2020 21:34:22 +0200
Message-Id: <20200629193424.30280-2-eric.auger@redhat.com>
In-Reply-To: <20200629193424.30280-1-eric.auger@redhat.com>
References: <20200629193424.30280-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/29 01:06:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

object_property_add() does not allow object_property_try_add()
to gracefully fail as &error_abort is passed as an error handle.

However such failure can easily be triggered from the QMP shell when,
for instance, one attempts to create an object with an id that already
exists. This is achieved from the following call path:

qmp_object_add -> user_creatable_add_dict -> user_creatable_add_type ->
object_property_add_child -> object_property_add

For instance, from the qmp-shell, call twice:
object-add qom-type=memory-backend-ram id=mem1 props.size=1073741824
and QEMU aborts.

This behavior is undesired as a user/management application mistake
in reusing a property ID shouldn't result in loss of the VM and live
data within.

This patch introduces a new function, object_property_try_add_child()
which takes an error handle and turn object_property_try_add() into
a non-static one.

Now the call path becomes:

user_creatable_add_type -> object_property_try_add_child ->
object_property_try_add

and the error is returned gracefully to the QMP client.

(QEMU) object-add qom-type=memory-backend-ram id=mem2  props.size=4294967296
{"return": {}}
(QEMU) object-add qom-type=memory-backend-ram id=mem2  props.size=4294967296
{"error": {"class": "GenericError", "desc": "attempt to add duplicate property
'mem2' to object (type 'container')"}}

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Fixes: d2623129a7de ("qom: Drop parameter @errp of object_property_add() & friends")
Reviewed-by: Markus Armbruster <armbru@redhat.com>

---

v3 -> v4:
- Took into account Markus' style related comments

v2 -> v3:
- don't take the object reference on failure in
  object_property_try_add_child
---
 include/qom/object.h    | 26 ++++++++++++++++++++++++--
 qom/object.c            | 21 ++++++++++++++++-----
 qom/object_interfaces.c |  7 +++++--
 3 files changed, 45 insertions(+), 9 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 94a61ccc3f..1c5cdcd0e3 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1039,7 +1039,7 @@ Object *object_ref(Object *obj);
 void object_unref(Object *obj);
 
 /**
- * object_property_add:
+ * object_property_try_add:
  * @obj: the object to add a property to
  * @name: the name of the property.  This can contain any character except for
  *  a forward slash.  In general, you should use hyphens '-' instead of
@@ -1056,10 +1056,23 @@ void object_unref(Object *obj);
  *   meant to allow a property to free its opaque upon object
  *   destruction.  This may be NULL.
  * @opaque: an opaque pointer to pass to the callbacks for the property
+ * @errp: pointer to error object
  *
  * Returns: The #ObjectProperty; this can be used to set the @resolve
  * callback for child and link properties.
  */
+ObjectProperty *object_property_try_add(Object *obj, const char *name,
+                                        const char *type,
+                                        ObjectPropertyAccessor *get,
+                                        ObjectPropertyAccessor *set,
+                                        ObjectPropertyRelease *release,
+                                        void *opaque, Error **errp);
+
+/**
+ * object_property_add:
+ * Same as object_property_try_add() with @errp hardcoded to
+ * &error_abort.
+ */
 ObjectProperty *object_property_add(Object *obj, const char *name,
                                     const char *type,
                                     ObjectPropertyAccessor *get,
@@ -1495,10 +1508,11 @@ Object *object_resolve_path_type(const char *path, const char *typename,
 Object *object_resolve_path_component(Object *parent, const char *part);
 
 /**
- * object_property_add_child:
+ * object_property_try_add_child:
  * @obj: the object to add a property to
  * @name: the name of the property
  * @child: the child object
+ * @errp: pointer to error object
  *
  * Child properties form the composition tree.  All objects need to be a child
  * of another object.  Objects can only be a child of one object.
@@ -1512,6 +1526,14 @@ Object *object_resolve_path_component(Object *parent, const char *part);
  *
  * Returns: The newly added property on success, or %NULL on failure.
  */
+ObjectProperty *object_property_try_add_child(Object *obj, const char *name,
+                                              Object *child, Error **errp);
+
+/**
+ * object_property_add_child:
+ * Same as object_property_try_add_child() with @errp hardcoded to
+ * &error_abort
+ */
 ObjectProperty *object_property_add_child(Object *obj, const char *name,
                                           Object *child);
 
diff --git a/qom/object.c b/qom/object.c
index 6ece96bc2b..dc10bb1889 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1132,7 +1132,7 @@ void object_unref(Object *obj)
     }
 }
 
-static ObjectProperty *
+ObjectProperty *
 object_property_try_add(Object *obj, const char *name, const char *type,
                         ObjectPropertyAccessor *get,
                         ObjectPropertyAccessor *set,
@@ -1651,8 +1651,8 @@ static void object_finalize_child_property(Object *obj, const char *name,
 }
 
 ObjectProperty *
-object_property_add_child(Object *obj, const char *name,
-                          Object *child)
+object_property_try_add_child(Object *obj, const char *name,
+                              Object *child, Error **errp)
 {
     g_autofree char *type = NULL;
     ObjectProperty *op;
@@ -1661,14 +1661,25 @@ object_property_add_child(Object *obj, const char *name,
 
     type = g_strdup_printf("child<%s>", object_get_typename(child));
 
-    op = object_property_add(obj, name, type, object_get_child_property, NULL,
-                             object_finalize_child_property, child);
+    op = object_property_try_add(obj, name, type, object_get_child_property,
+                                 NULL, object_finalize_child_property,
+                                 child, errp);
+    if (!op) {
+        return NULL;
+    }
     op->resolve = object_resolve_child_property;
     object_ref(child);
     child->parent = obj;
     return op;
 }
 
+ObjectProperty *
+object_property_add_child(Object *obj, const char *name,
+                          Object *child)
+{
+    return object_property_try_add_child(obj, name, child, &error_abort);
+}
+
 void object_property_allow_set_link(const Object *obj, const char *name,
                                     Object *val, Error **errp)
 {
diff --git a/qom/object_interfaces.c b/qom/object_interfaces.c
index 7e26f86fa6..1e05e41d2f 100644
--- a/qom/object_interfaces.c
+++ b/qom/object_interfaces.c
@@ -82,8 +82,11 @@ Object *user_creatable_add_type(const char *type, const char *id,
     }
 
     if (id != NULL) {
-        object_property_add_child(object_get_objects_root(),
-                                  id, obj);
+        object_property_try_add_child(object_get_objects_root(),
+                                      id, obj, &local_err);
+        if (local_err) {
+            goto out;
+        }
     }
 
     user_creatable_complete(USER_CREATABLE(obj), &local_err);
-- 
2.20.1


