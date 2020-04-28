Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA683C83000
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:48:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E41F2063A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 16:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N+yhruKv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E41F2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTTOs-0006m1-AN
	for qemu-devel@archiver.kernel.org; Tue, 28 Apr 2020 12:48:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34372)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTTFD-0006gl-HX
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:38:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jTTBm-0000sp-QN
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:38:03 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:57353
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jTTBm-0000sA-5b
 for qemu-devel@nongnu.org; Tue, 28 Apr 2020 12:34:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588091669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g7Z8Bpz+o6QBfvAeZB0OddicG3+uz1QIygnr8RDeDGo=;
 b=N+yhruKvqjZ8bm9w7Akz6tqCapsfzZTW7xeTaTY3yVPjS8t+Wuwzw+aHwvAtWa+MlOfV8m
 UL9nPsp/M/hrTl41msZbSQQtj06hJ47ks57XgLlUe/ZCkIYHngl5fi8KFWpIi1wE8JfaQA
 gRNcFTlOXQivpZDxkR27AB8zuvYpHts=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-XVAYkOi_Nkyo_1m3SOWCvA-1; Tue, 28 Apr 2020 12:34:27 -0400
X-MC-Unique: XVAYkOi_Nkyo_1m3SOWCvA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFE881895944
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2020 16:34:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A87B66083;
 Tue, 28 Apr 2020 16:34:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0DDD911358C1; Tue, 28 Apr 2020 18:34:20 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 05/17] qom: Make all the object_property_add_FOO() return the
 property
Date: Tue, 28 Apr 2020 18:34:07 +0200
Message-Id: <20200428163419.4483-6-armbru@redhat.com>
In-Reply-To: <20200428163419.4483-1-armbru@redhat.com>
References: <20200428163419.4483-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/28 02:06:42
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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

Some object_property_add_FOO() return the newly added property, some
don't.  Clean that up.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qom/object.h |  50 ++++++---
 qom/object.c         | 250 ++++++++++++++++++++++---------------------
 2 files changed, 164 insertions(+), 136 deletions(-)

diff --git a/include/qom/object.h b/include/qom/object.h
index 5d1ed672c3..26e9f13a17 100644
--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -1505,9 +1505,11 @@ Object *object_resolve_path_component(Object *parent=
, const char *part);
  * The value of a child property as a C string will be the child object's
  * canonical path. It can be retrieved using object_property_get_str().
  * The child object itself can be retrieved using object_property_get_link=
().
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
  */
-void object_property_add_child(Object *obj, const char *name,
-                               Object *child, Error **errp);
+ObjectProperty *object_property_add_child(Object *obj, const char *name,
+                                          Object *child, Error **errp);
=20
 typedef enum {
     /* Unref the link pointer when the property is deleted */
@@ -1556,8 +1558,10 @@ void object_property_allow_set_link(const Object *, =
const char *,
  * <code>@flags</code> <code>OBJ_PROP_LINK_STRONG</code> bit is set,
  * the reference count is decremented when the property is deleted or
  * modified.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
  */
-void object_property_add_link(Object *obj, const char *name,
+ObjectProperty *object_property_add_link(Object *obj, const char *name,
                               const char *type, Object **targetp,
                               void (*check)(const Object *obj, const char =
*name,
                                             Object *val, Error **errp),
@@ -1583,8 +1587,10 @@ ObjectProperty *object_class_property_add_link(Objec=
tClass *oc,
  *
  * Add a string property using getters/setters.  This function will add a
  * property of type 'string'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
  */
-void object_property_add_str(Object *obj, const char *name,
+ObjectProperty *object_property_add_str(Object *obj, const char *name,
                              char *(*get)(Object *, Error **),
                              void (*set)(Object *, const char *, Error **)=
,
                              Error **errp);
@@ -1606,8 +1612,10 @@ ObjectProperty *object_class_property_add_str(Object=
Class *klass,
  *
  * Add a bool property using getters/setters.  This function will add a
  * property of type 'bool'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
  */
-void object_property_add_bool(Object *obj, const char *name,
+ObjectProperty *object_property_add_bool(Object *obj, const char *name,
                               bool (*get)(Object *, Error **),
                               void (*set)(Object *, bool, Error **),
                               Error **errp);
@@ -1629,8 +1637,10 @@ ObjectProperty *object_class_property_add_bool(Objec=
tClass *klass,
  *
  * Add an enum property using getters/setters.  This function will add a
  * property of type '@typename'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
  */
-void object_property_add_enum(Object *obj, const char *name,
+ObjectProperty *object_property_add_enum(Object *obj, const char *name,
                               const char *typename,
                               const QEnumLookup *lookup,
                               int (*get)(Object *, Error **),
@@ -1654,8 +1664,10 @@ ObjectProperty *object_class_property_add_enum(Objec=
tClass *klass,
  *
  * Add a read-only struct tm valued property using a getter function.
  * This function will add a property of type 'struct tm'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
  */
-void object_property_add_tm(Object *obj, const char *name,
+ObjectProperty *object_property_add_tm(Object *obj, const char *name,
                             void (*get)(Object *, struct tm *, Error **),
                             Error **errp);
=20
@@ -1683,8 +1695,10 @@ typedef enum {
  *
  * Add an integer property in memory.  This function will add a
  * property of type 'uint8'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
  */
-void object_property_add_uint8_ptr(Object *obj, const char *name,
+ObjectProperty *object_property_add_uint8_ptr(Object *obj, const char *nam=
e,
                                    const uint8_t *v, ObjectPropertyFlags f=
lags,
                                    Error **errp);
=20
@@ -1704,8 +1718,10 @@ ObjectProperty *object_class_property_add_uint8_ptr(=
ObjectClass *klass,
  *
  * Add an integer property in memory.  This function will add a
  * property of type 'uint16'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
  */
-void object_property_add_uint16_ptr(Object *obj, const char *name,
+ObjectProperty *object_property_add_uint16_ptr(Object *obj, const char *na=
me,
                                     const uint16_t *v,
                                     ObjectPropertyFlags flags,
                                     Error **errp);
@@ -1726,8 +1742,10 @@ ObjectProperty *object_class_property_add_uint16_ptr=
(ObjectClass *klass,
  *
  * Add an integer property in memory.  This function will add a
  * property of type 'uint32'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
  */
-void object_property_add_uint32_ptr(Object *obj, const char *name,
+ObjectProperty *object_property_add_uint32_ptr(Object *obj, const char *na=
me,
                                     const uint32_t *v,
                                     ObjectPropertyFlags flags,
                                     Error **errp);
@@ -1748,8 +1766,10 @@ ObjectProperty *object_class_property_add_uint32_ptr=
(ObjectClass *klass,
  *
  * Add an integer property in memory.  This function will add a
  * property of type 'uint64'.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
  */
-void object_property_add_uint64_ptr(Object *obj, const char *name,
+ObjectProperty *object_property_add_uint64_ptr(Object *obj, const char *na=
me,
                                     const uint64_t *v,
                                     ObjectPropertyFlags flags,
                                     Error **Errp);
@@ -1775,8 +1795,10 @@ ObjectProperty *object_class_property_add_uint64_ptr=
(ObjectClass *klass,
  * this property exists.  In the case of a child object or an alias on the=
 same
  * object this will be the case.  For aliases to other objects the caller =
is
  * responsible for taking a reference.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
  */
-void object_property_add_alias(Object *obj, const char *name,
+ObjectProperty *object_property_add_alias(Object *obj, const char *name,
                                Object *target_obj, const char *target_name=
,
                                Error **errp);
=20
@@ -1794,8 +1816,10 @@ void object_property_add_alias(Object *obj, const ch=
ar *name,
  * this property exists.  In the case @target is a child of @obj,
  * this will be the case.  Otherwise, the caller is responsible for
  * taking a reference.
+ *
+ * Returns: The newly added property on success, or %NULL on failure.
  */
-void object_property_add_const_link(Object *obj, const char *name,
+ObjectProperty *object_property_add_const_link(Object *obj, const char *na=
me,
                                     Object *target, Error **errp);
=20
 /**
diff --git a/qom/object.c b/qom/object.c
index ddb021db21..067bb3186d 100644
--- a/qom/object.c
+++ b/qom/object.c
@@ -1679,33 +1679,30 @@ static void object_finalize_child_property(Object *=
obj, const char *name,
     object_unref(child);
 }
=20
-void object_property_add_child(Object *obj, const char *name,
-                               Object *child, Error **errp)
+ObjectProperty *
+object_property_add_child(Object *obj, const char *name,
+                          Object *child, Error **errp)
 {
-    Error *local_err =3D NULL;
-    char *type;
+    g_autofree char *type =3D NULL;
     ObjectProperty *op;
=20
     if (child->parent !=3D NULL) {
         error_setg(errp, "child object is already parented");
-        return;
+        return NULL;
     }
=20
     type =3D g_strdup_printf("child<%s>", object_get_typename(OBJECT(child=
)));
=20
     op =3D object_property_add(obj, name, type, object_get_child_property,=
 NULL,
-                             object_finalize_child_property, child, &local=
_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        goto out;
+                             object_finalize_child_property, child, errp);
+    if (!op) {
+        return NULL;
     }
=20
     op->resolve =3D object_resolve_child_property;
     object_ref(child);
     child->parent =3D obj;
-
-out:
-    g_free(type);
+    return op;
 }
=20
 void object_property_allow_set_link(const Object *obj, const char *name,
@@ -1852,16 +1849,16 @@ static void object_release_link_property(Object *ob=
j, const char *name,
     }
 }
=20
-static void object_add_link_prop(Object *obj, const char *name,
-                                 const char *type, void *ptr,
-                                 void (*check)(const Object *, const char =
*,
-                                               Object *, Error **),
-                                 ObjectPropertyLinkFlags flags,
-                                 Error **errp)
+static ObjectProperty *
+object_add_link_prop(Object *obj, const char *name,
+                     const char *type, void *ptr,
+                     void (*check)(const Object *, const char *,
+                                   Object *, Error **),
+                     ObjectPropertyLinkFlags flags,
+                     Error **errp)
 {
-    Error *local_err =3D NULL;
     LinkProperty *prop =3D g_malloc(sizeof(*prop));
-    char *full_type;
+    g_autofree char *full_type =3D NULL;
     ObjectProperty *op;
=20
     if (flags & OBJ_PROP_LINK_DIRECT) {
@@ -1879,27 +1876,26 @@ static void object_add_link_prop(Object *obj, const=
 char *name,
                              check ? object_set_link_property : NULL,
                              object_release_link_property,
                              prop,
-                             &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+                             errp);
+    if (!op) {
         g_free(prop);
-        goto out;
+        return NULL;
     }
=20
     op->resolve =3D object_resolve_link_property;
-
-out:
-    g_free(full_type);
+    return op;
 }
=20
-void object_property_add_link(Object *obj, const char *name,
-                              const char *type, Object **targetp,
-                              void (*check)(const Object *, const char *,
-                                            Object *, Error **),
-                              ObjectPropertyLinkFlags flags,
-                              Error **errp)
+ObjectProperty *
+object_property_add_link(Object *obj, const char *name,
+                         const char *type, Object **targetp,
+                         void (*check)(const Object *, const char *,
+                                       Object *, Error **),
+                         ObjectPropertyLinkFlags flags,
+                         Error **errp)
 {
-    object_add_link_prop(obj, name, type, targetp, check, flags, errp);
+    return object_add_link_prop(obj, name, type, targetp, check, flags,
+                                errp);
 }
=20
 ObjectProperty *
@@ -1941,11 +1937,13 @@ out:
     return op;
 }
=20
-void object_property_add_const_link(Object *obj, const char *name,
-                                    Object *target, Error **errp)
+ObjectProperty *
+object_property_add_const_link(Object *obj, const char *name,
+                               Object *target, Error **errp)
 {
-    object_add_link_prop(obj, name, object_get_typename(target), target,
-                         NULL, OBJ_PROP_LINK_DIRECT, errp);
+    return object_add_link_prop(obj, name,
+                                object_get_typename(target), target,
+                                NULL, OBJ_PROP_LINK_DIRECT, errp);
 }
=20
 char *object_get_canonical_path_component(Object *obj)
@@ -2154,26 +2152,27 @@ static void property_release_str(Object *obj, const=
 char *name,
     g_free(prop);
 }
=20
-void object_property_add_str(Object *obj, const char *name,
-                           char *(*get)(Object *, Error **),
-                           void (*set)(Object *, const char *, Error **),
-                           Error **errp)
+ObjectProperty *
+object_property_add_str(Object *obj, const char *name,
+                        char *(*get)(Object *, Error **),
+                        void (*set)(Object *, const char *, Error **),
+                        Error **errp)
 {
-    Error *local_err =3D NULL;
     StringProperty *prop =3D g_malloc0(sizeof(*prop));
+    ObjectProperty *op;
=20
     prop->get =3D get;
     prop->set =3D set;
=20
-    object_property_add(obj, name, "string",
-                        get ? property_get_str : NULL,
-                        set ? property_set_str : NULL,
-                        property_release_str,
-                        prop, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    op =3D object_property_add(obj, name, "string",
+                             get ? property_get_str : NULL,
+                             set ? property_set_str : NULL,
+                             property_release_str,
+                             prop, errp);
+    if (!op) {
         g_free(prop);
     }
+    return op;
 }
=20
 ObjectProperty *
@@ -2248,26 +2247,27 @@ static void property_release_bool(Object *obj, cons=
t char *name,
     g_free(prop);
 }
=20
-void object_property_add_bool(Object *obj, const char *name,
-                              bool (*get)(Object *, Error **),
-                              void (*set)(Object *, bool, Error **),
-                              Error **errp)
+ObjectProperty *
+object_property_add_bool(Object *obj, const char *name,
+                         bool (*get)(Object *, Error **),
+                         void (*set)(Object *, bool, Error **),
+                         Error **errp)
 {
-    Error *local_err =3D NULL;
     BoolProperty *prop =3D g_malloc0(sizeof(*prop));
+    ObjectProperty *op;
=20
     prop->get =3D get;
     prop->set =3D set;
=20
-    object_property_add(obj, name, "bool",
-                        get ? property_get_bool : NULL,
-                        set ? property_set_bool : NULL,
-                        property_release_bool,
-                        prop, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    op =3D object_property_add(obj, name, "bool",
+                             get ? property_get_bool : NULL,
+                             set ? property_set_bool : NULL,
+                             property_release_bool,
+                             prop, errp);
+    if (!op) {
         g_free(prop);
     }
+    return op;
 }
=20
 ObjectProperty *
@@ -2334,29 +2334,30 @@ static void property_release_enum(Object *obj, cons=
t char *name,
     g_free(prop);
 }
=20
-void object_property_add_enum(Object *obj, const char *name,
-                              const char *typename,
-                              const QEnumLookup *lookup,
-                              int (*get)(Object *, Error **),
-                              void (*set)(Object *, int, Error **),
-                              Error **errp)
+ObjectProperty *
+object_property_add_enum(Object *obj, const char *name,
+                         const char *typename,
+                         const QEnumLookup *lookup,
+                         int (*get)(Object *, Error **),
+                         void (*set)(Object *, int, Error **),
+                         Error **errp)
 {
-    Error *local_err =3D NULL;
     EnumProperty *prop =3D g_malloc(sizeof(*prop));
+    ObjectProperty *op;
=20
     prop->lookup =3D lookup;
     prop->get =3D get;
     prop->set =3D set;
=20
-    object_property_add(obj, name, typename,
-                        get ? property_get_enum : NULL,
-                        set ? property_set_enum : NULL,
-                        property_release_enum,
-                        prop, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    op =3D object_property_add(obj, name, typename,
+                             get ? property_get_enum : NULL,
+                             set ? property_set_enum : NULL,
+                             property_release_enum,
+                             prop, errp);
+    if (!op) {
         g_free(prop);
     }
+    return op;
 }
=20
 ObjectProperty *
@@ -2447,23 +2448,24 @@ static void property_release_tm(Object *obj, const =
char *name,
     g_free(prop);
 }
=20
-void object_property_add_tm(Object *obj, const char *name,
-                            void (*get)(Object *, struct tm *, Error **),
-                            Error **errp)
+ObjectProperty *
+object_property_add_tm(Object *obj, const char *name,
+                       void (*get)(Object *, struct tm *, Error **),
+                       Error **errp)
 {
-    Error *local_err =3D NULL;
     TMProperty *prop =3D g_malloc0(sizeof(*prop));
+    ObjectProperty *op;
=20
     prop->get =3D get;
=20
-    object_property_add(obj, name, "struct tm",
-                        get ? property_get_tm : NULL, NULL,
-                        property_release_tm,
-                        prop, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    op =3D object_property_add(obj, name, "struct tm",
+                             get ? property_get_tm : NULL, NULL,
+                             property_release_tm,
+                             prop, errp);
+    if (!op) {
         g_free(prop);
     }
+    return op;
 }
=20
 ObjectProperty *
@@ -2586,10 +2588,11 @@ static void property_set_uint64_ptr(Object *obj, Vi=
sitor *v, const char *name,
     *field =3D value;
 }
=20
-void object_property_add_uint8_ptr(Object *obj, const char *name,
-                                   const uint8_t *v,
-                                   ObjectPropertyFlags flags,
-                                   Error **errp)
+ObjectProperty *
+object_property_add_uint8_ptr(Object *obj, const char *name,
+                              const uint8_t *v,
+                              ObjectPropertyFlags flags,
+                              Error **errp)
 {
     ObjectPropertyAccessor *getter =3D NULL;
     ObjectPropertyAccessor *setter =3D NULL;
@@ -2602,8 +2605,8 @@ void object_property_add_uint8_ptr(Object *obj, const=
 char *name,
         setter =3D property_set_uint8_ptr;
     }
=20
-    object_property_add(obj, name, "uint8",
-                        getter, setter, NULL, (void *)v, errp);
+    return object_property_add(obj, name, "uint8",
+                               getter, setter, NULL, (void *)v, errp);
 }
=20
 ObjectProperty *
@@ -2627,10 +2630,11 @@ object_class_property_add_uint8_ptr(ObjectClass *kl=
ass, const char *name,
                                      getter, setter, NULL, (void *)v, errp=
);
 }
=20
-void object_property_add_uint16_ptr(Object *obj, const char *name,
-                                    const uint16_t *v,
-                                    ObjectPropertyFlags flags,
-                                    Error **errp)
+ObjectProperty *
+object_property_add_uint16_ptr(Object *obj, const char *name,
+                               const uint16_t *v,
+                               ObjectPropertyFlags flags,
+                               Error **errp)
 {
     ObjectPropertyAccessor *getter =3D NULL;
     ObjectPropertyAccessor *setter =3D NULL;
@@ -2643,8 +2647,8 @@ void object_property_add_uint16_ptr(Object *obj, cons=
t char *name,
         setter =3D property_set_uint16_ptr;
     }
=20
-    object_property_add(obj, name, "uint16",
-                        getter, setter, NULL, (void *)v, errp);
+    return object_property_add(obj, name, "uint16",
+                               getter, setter, NULL, (void *)v, errp);
 }
=20
 ObjectProperty *
@@ -2668,10 +2672,11 @@ object_class_property_add_uint16_ptr(ObjectClass *k=
lass, const char *name,
                                      getter, setter, NULL, (void *)v, errp=
);
 }
=20
-void object_property_add_uint32_ptr(Object *obj, const char *name,
-                                    const uint32_t *v,
-                                    ObjectPropertyFlags flags,
-                                    Error **errp)
+ObjectProperty *
+object_property_add_uint32_ptr(Object *obj, const char *name,
+                               const uint32_t *v,
+                               ObjectPropertyFlags flags,
+                               Error **errp)
 {
     ObjectPropertyAccessor *getter =3D NULL;
     ObjectPropertyAccessor *setter =3D NULL;
@@ -2684,8 +2689,8 @@ void object_property_add_uint32_ptr(Object *obj, cons=
t char *name,
         setter =3D property_set_uint32_ptr;
     }
=20
-    object_property_add(obj, name, "uint32",
-                        getter, setter, NULL, (void *)v, errp);
+    return object_property_add(obj, name, "uint32",
+                               getter, setter, NULL, (void *)v, errp);
 }
=20
 ObjectProperty *
@@ -2709,10 +2714,11 @@ object_class_property_add_uint32_ptr(ObjectClass *k=
lass, const char *name,
                                      getter, setter, NULL, (void *)v, errp=
);
 }
=20
-void object_property_add_uint64_ptr(Object *obj, const char *name,
-                                    const uint64_t *v,
-                                    ObjectPropertyFlags flags,
-                                    Error **errp)
+ObjectProperty *
+object_property_add_uint64_ptr(Object *obj, const char *name,
+                               const uint64_t *v,
+                               ObjectPropertyFlags flags,
+                               Error **errp)
 {
     ObjectPropertyAccessor *getter =3D NULL;
     ObjectPropertyAccessor *setter =3D NULL;
@@ -2725,8 +2731,8 @@ void object_property_add_uint64_ptr(Object *obj, cons=
t char *name,
         setter =3D property_set_uint64_ptr;
     }
=20
-    object_property_add(obj, name, "uint64",
-                        getter, setter, NULL, (void *)v, errp);
+    return object_property_add(obj, name, "uint64",
+                               getter, setter, NULL, (void *)v, errp);
 }
=20
 ObjectProperty *
@@ -2787,19 +2793,19 @@ static void property_release_alias(Object *obj, con=
st char *name, void *opaque)
     g_free(prop);
 }
=20
-void object_property_add_alias(Object *obj, const char *name,
-                               Object *target_obj, const char *target_name=
,
-                               Error **errp)
+ObjectProperty *
+object_property_add_alias(Object *obj, const char *name,
+                          Object *target_obj, const char *target_name,
+                          Error **errp)
 {
     AliasProperty *prop;
     ObjectProperty *op;
     ObjectProperty *target_prop;
-    char *prop_type;
-    Error *local_err =3D NULL;
+    g_autofree char *prop_type =3D NULL;
=20
     target_prop =3D object_property_find(target_obj, target_name, errp);
     if (!target_prop) {
-        return;
+        return NULL;
     }
=20
     if (object_property_is_child(target_prop)) {
@@ -2817,12 +2823,12 @@ void object_property_add_alias(Object *obj, const c=
har *name,
                              property_get_alias,
                              property_set_alias,
                              property_release_alias,
-                             prop, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+                             prop, errp);
+    if (!op) {
         g_free(prop);
-        goto out;
+        return NULL;
     }
+
     op->resolve =3D property_resolve_alias;
     if (target_prop->defval) {
         op->defval =3D qobject_ref(target_prop->defval);
@@ -2831,9 +2837,7 @@ void object_property_add_alias(Object *obj, const cha=
r *name,
     object_property_set_description(obj, op->name,
                                     target_prop->description,
                                     &error_abort);
-
-out:
-    g_free(prop_type);
+    return op;
 }
=20
 void object_property_set_description(Object *obj, const char *name,
--=20
2.21.1


