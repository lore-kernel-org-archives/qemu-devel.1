Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E20F0C54FD0
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 16:07:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A78420728
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 16:07:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QrkVYH9V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A78420728
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jReO8-00088N-Nt
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 12:07:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59964)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jReHq-00069b-Aa
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 12:01:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1jReHT-00026g-S2
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 12:01:14 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38729
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jReHS-00020t-3u
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 12:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587657643;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TRwX4dcdWCKyF0YHzid5/UZxgmyB7MTI5Hz9JbacchE=;
 b=QrkVYH9VQlO2DDjUo4p2M184gb1kYa/b2/QU8sXBflzZ8yRUM3VkeZk8J2W350sAFgs5pg
 qBNsXuuE+bf+C8aU0wgpUxKJGIyerin+5SpTENIJJtMO2HjrUwOv/duCQRAXODwvgrPbJh
 HXwzC05JftLhGCIi+/pyge5wAelIINs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-MUofmJqyPSSMZBD7A5tCjg-1; Thu, 23 Apr 2020 12:00:41 -0400
X-MC-Unique: MUofmJqyPSSMZBD7A5tCjg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 225838015CF;
 Thu, 23 Apr 2020 16:00:40 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-113-6.ams2.redhat.com [10.36.113.6])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8BEA91001B30;
 Thu, 23 Apr 2020 16:00:39 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7A3B911358C8; Thu, 23 Apr 2020 18:00:36 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 12/13] qapi: Only input visitors can actually fail
Date: Thu, 23 Apr 2020 18:00:35 +0200
Message-Id: <20200423160036.7048-13-armbru@redhat.com>
In-Reply-To: <20200423160036.7048-1-armbru@redhat.com>
References: <20200423160036.7048-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 03:23:21
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
Cc: mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The previous few commits have made this more obvious, and removed the
one exception.  Time to clarify the documentation, and drop dead error
checking.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/qapi/visitor-impl.h |  4 ++++
 include/qapi/visitor.h      | 40 ++++++++++++++++++++++---------------
 block.c                     |  9 +--------
 block/sheepdog.c            |  9 +--------
 blockdev.c                  | 16 ++-------------
 hw/core/machine-hmp-cmds.c  |  2 +-
 monitor/hmp-cmds.c          |  3 ++-
 7 files changed, 35 insertions(+), 48 deletions(-)

diff --git a/include/qapi/visitor-impl.h b/include/qapi/visitor-impl.h
index 252206dc0d..98dc533d39 100644
--- a/include/qapi/visitor-impl.h
+++ b/include/qapi/visitor-impl.h
@@ -43,6 +43,10 @@ typedef enum VisitorType {
=20
 struct Visitor
 {
+    /*
+     * Only input visitors may fail!
+     */
+
     /* Must be set to visit structs */
     void (*start_struct)(Visitor *v, const char *name, void **obj,
                          size_t size, Error **errp);
diff --git a/include/qapi/visitor.h b/include/qapi/visitor.h
index 2d40d2fe0f..5573906966 100644
--- a/include/qapi/visitor.h
+++ b/include/qapi/visitor.h
@@ -82,7 +82,7 @@
  * Each function also takes the customary @errp argument (see
  * qapi/error.h for details), for reporting any errors (such as if a
  * member @name is not present, or is present but not the specified
- * type).
+ * type).  Only input visitors can fail.
  *
  * If an error is detected during visit_type_FOO() with an input
  * visitor, then *@obj will be set to NULL for pointer types, and left
@@ -164,19 +164,14 @@
  *
  * <example>
  *  Foo *f =3D ...obtain populated object...
- *  Error *err =3D NULL;
  *  Visitor *v;
  *  Type *result;
  *
  *  v =3D FOO_visitor_new(..., &result);
- *  visit_type_Foo(v, NULL, &f, &err);
- *  if (err) {
- *      ...handle error...
- *  } else {
- *      visit_complete(v, &result);
- *      ...use result...
- *  }
+ *  visit_type_Foo(v, NULL, &f, &error_abort);
+ *  visit_complete(v, &result);
  *  visit_free(v);
+ *  ...use result...
  * </example>
  *
  * It is also possible to use the visitors to do a virtual walk, where
@@ -289,6 +284,7 @@ void visit_free(Visitor *v);
  * case @size is ignored.
  *
  * On failure, set *@obj to NULL and store an error through @errp.
+ * Can happen only when @v is an input visitor.
  *
  * After visit_start_struct() succeeds, the caller may visit its
  * members one after the other, passing the member's name and address
@@ -305,7 +301,8 @@ void visit_start_struct(Visitor *v, const char *name, v=
oid **obj,
 /*
  * Prepare for completing an object visit.
  *
- * On failure, store an error through @errp.
+ * On failure, store an error through @errp.  Can happen only when @v
+ * is an input visitor.
  *
  * Should be called prior to visit_end_struct() if all other
  * intermediate visit steps were successful, to allow the visitor one
@@ -342,6 +339,7 @@ void visit_end_struct(Visitor *v, void **obj);
  * ignored.
  *
  * On failure, set *@list to NULL and store an error through @errp.
+ * Can happen only when @v is an input visitor.
  *
  * After visit_start_list() succeeds, the caller may visit its members
  * one after the other.  A real visit (where @list is non-NULL) uses
@@ -375,7 +373,8 @@ GenericList *visit_next_list(Visitor *v, GenericList *t=
ail, size_t size);
 /*
  * Prepare for completing a list visit.
  *
- * On failure, store an error through @errp.
+ * On failure, store an error through @errp.  Can happen only when @v
+ * is an input visitor.
  *
  * Should be called prior to visit_end_list() if all other
  * intermediate visit steps were successful, to allow the visitor one
@@ -411,6 +410,7 @@ void visit_end_list(Visitor *v, void **list);
  * (*@obj)->type.  Other visitors leave @obj unchanged.
  *
  * On failure, set *@obj to NULL and store an error through @errp.
+ * Can happen only when @v is an input visitor.
  *
  * If successful, this must be paired with visit_end_alternate() with
  * the same @obj to clean up, even if visiting the contents of the
@@ -465,11 +465,13 @@ bool visit_optional(Visitor *v, const char *name, boo=
l *present);
  * visitors produce text output.  The mapping between enumeration
  * values and strings is done by the visitor core, using @lookup.
  *
- * On failure, store an error through @errp.
+ * On failure, store an error through @errp.  Can happen only when @v
+ * is an input visitor.
  *
  * May call visit_type_str() under the hood, and the enum visit may
  * fail even if the corresponding string visit succeeded; this implies
- * that visit_type_str() must have no unwelcome side effects.
+ * that an input visitor's visit_type_str() must have no unwelcome
+ * side effects.
  */
 void visit_type_enum(Visitor *v, const char *name, int *obj,
                      const QEnumLookup *lookup, Error **errp);
@@ -495,7 +497,8 @@ bool visit_is_dealloc(Visitor *v);
  * @obj must be non-NULL.  Input visitors set *@obj to the value;
  * other visitors will leave *@obj unchanged.
  *
- * On failure, store an error through @errp.
+ * On failure, store an error through @errp.  Can happen only when @v
+ * is an input visitor.
  */
 void visit_type_int(Visitor *v, const char *name, int64_t *obj, Error **er=
rp);
=20
@@ -573,7 +576,8 @@ void visit_type_size(Visitor *v, const char *name, uint=
64_t *obj,
  * @obj must be non-NULL.  Input visitors set *@obj to the value;
  * other visitors will leave *@obj unchanged.
  *
- * On failure, store an error through @errp.
+ * On failure, store an error through @errp.  Can happen only when @v
+ * is an input visitor.
  */
 void visit_type_bool(Visitor *v, const char *name, bool *obj, Error **errp=
);
=20
@@ -592,6 +596,7 @@ void visit_type_bool(Visitor *v, const char *name, bool=
 *obj, Error **errp);
  * into @obj for use by an output visitor.
  *
  * On failure, set *@obj to NULL and store an error through @errp.
+ * Can happen only when @v is an input visitor.
  *
  * FIXME: Callers that try to output NULL *obj should not be allowed.
  */
@@ -607,7 +612,8 @@ void visit_type_str(Visitor *v, const char *name, char =
**obj, Error **errp);
  * other visitors will leave *@obj unchanged.  Visitors should
  * document if infinity or NaN are not permitted.
  *
- * On failure, store an error through @errp.
+ * On failure, store an error through @errp.  Can happen only when @v
+ * is an input visitor.
  */
 void visit_type_number(Visitor *v, const char *name, double *obj,
                        Error **errp);
@@ -623,6 +629,7 @@ void visit_type_number(Visitor *v, const char *name, do=
uble *obj,
  * for output visitors.
  *
  * On failure, set *@obj to NULL and store an error through @errp.
+ * Can happen only when @v is an input visitor.
  *
  * Note that some kinds of input can't express arbitrary QObject.
  * E.g. the visitor returned by qobject_input_visitor_new_keyval()
@@ -640,6 +647,7 @@ void visit_type_any(Visitor *v, const char *name, QObje=
ct **obj, Error **errp);
  * other visitors ignore *@obj.
  *
  * On failure, set *@obj to NULL and store an error through @errp.
+ * Can happen only when @v is an input visitor.
  */
 void visit_type_null(Visitor *v, const char *name, QNull **obj,
                      Error **errp);
diff --git a/block.c b/block.c
index 2e3905c99e..c11385ae05 100644
--- a/block.c
+++ b/block.c
@@ -2982,7 +2982,6 @@ BdrvChild *bdrv_open_child(const char *filename,
 BlockDriverState *bdrv_open_blockdev_ref(BlockdevRef *ref, Error **errp)
 {
     BlockDriverState *bs =3D NULL;
-    Error *local_err =3D NULL;
     QObject *obj =3D NULL;
     QDict *qdict =3D NULL;
     const char *reference =3D NULL;
@@ -2995,11 +2994,7 @@ BlockDriverState *bdrv_open_blockdev_ref(BlockdevRef=
 *ref, Error **errp)
         assert(ref->type =3D=3D QTYPE_QDICT);
=20
         v =3D qobject_output_visitor_new(&obj);
-        visit_type_BlockdevOptions(v, NULL, &options, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
-            goto fail;
-        }
+        visit_type_BlockdevOptions(v, NULL, &options, &error_abort);
         visit_complete(v, &obj);
=20
         qdict =3D qobject_to(QDict, obj);
@@ -3017,8 +3012,6 @@ BlockDriverState *bdrv_open_blockdev_ref(BlockdevRef =
*ref, Error **errp)
=20
     bs =3D bdrv_open_inherit(NULL, reference, qdict, 0, NULL, NULL, errp);
     obj =3D NULL;
-
-fail:
     qobject_unref(obj);
     visit_free(v);
     return bs;
diff --git a/block/sheepdog.c b/block/sheepdog.c
index 59f7ebb171..5f3aead038 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -1854,19 +1854,12 @@ static int sd_create_prealloc(BlockdevOptionsSheepd=
og *location, int64_t size,
     Visitor *v;
     QObject *obj =3D NULL;
     QDict *qdict;
-    Error *local_err =3D NULL;
     int ret;
=20
     v =3D qobject_output_visitor_new(&obj);
-    visit_type_BlockdevOptionsSheepdog(v, NULL, &location, &local_err);
+    visit_type_BlockdevOptionsSheepdog(v, NULL, &location, &error_abort);
     visit_free(v);
=20
-    if (local_err) {
-        error_propagate(errp, local_err);
-        qobject_unref(obj);
-        return -EINVAL;
-    }
-
     qdict =3D qobject_to(QDict, obj);
     qdict_flatten(qdict);
=20
diff --git a/blockdev.c b/blockdev.c
index 5faddaa705..9da960b1e7 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3725,14 +3725,8 @@ void qmp_blockdev_add(BlockdevOptions *options, Erro=
r **errp)
     QObject *obj;
     Visitor *v =3D qobject_output_visitor_new(&obj);
     QDict *qdict;
-    Error *local_err =3D NULL;
-
-    visit_type_BlockdevOptions(v, NULL, &options, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        goto fail;
-    }
=20
+    visit_type_BlockdevOptions(v, NULL, &options, &error_abort);
     visit_complete(v, &obj);
     qdict =3D qobject_to(QDict, obj);
=20
@@ -3760,7 +3754,6 @@ void qmp_x_blockdev_reopen(BlockdevOptions *options, =
Error **errp)
     AioContext *ctx;
     QObject *obj;
     Visitor *v =3D qobject_output_visitor_new(&obj);
-    Error *local_err =3D NULL;
     BlockReopenQueue *queue;
     QDict *qdict;
=20
@@ -3777,12 +3770,7 @@ void qmp_x_blockdev_reopen(BlockdevOptions *options,=
 Error **errp)
     }
=20
     /* Put all options in a QDict and flatten it */
-    visit_type_BlockdevOptions(v, NULL, &options, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        goto fail;
-    }
-
+    visit_type_BlockdevOptions(v, NULL, &options, &error_abort);
     visit_complete(v, &obj);
     qdict =3D qobject_to(QDict, obj);
=20
diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
index b76f7223af..39999c47c5 100644
--- a/hw/core/machine-hmp-cmds.c
+++ b/hw/core/machine-hmp-cmds.c
@@ -113,7 +113,7 @@ void hmp_info_memdev(Monitor *mon, const QDict *qdict)
=20
     while (m) {
         v =3D string_output_visitor_new(false, &str);
-        visit_type_uint16List(v, NULL, &m->value->host_nodes, NULL);
+        visit_type_uint16List(v, NULL, &m->value->host_nodes, &error_abort=
);
         monitor_printf(mon, "memory backend: %s\n", m->value->id);
         monitor_printf(mon, "  size:  %" PRId64 "\n", m->value->size);
         monitor_printf(mon, "  merge: %s\n",
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 9b94e67879..7f6e982dc8 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -334,7 +334,8 @@ void hmp_info_migrate(Monitor *mon, const QDict *qdict)
         Visitor *v;
         char *str;
         v =3D string_output_visitor_new(false, &str);
-        visit_type_uint32List(v, NULL, &info->postcopy_vcpu_blocktime, NUL=
L);
+        visit_type_uint32List(v, NULL, &info->postcopy_vcpu_blocktime,
+                              &error_abort);
         visit_complete(v, &str);
         monitor_printf(mon, "postcopy vcpu blocktime: %s\n", str);
         g_free(str);
--=20
2.21.1


